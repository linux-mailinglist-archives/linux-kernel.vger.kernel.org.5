Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B797CEB40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjJRW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3B95
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:28:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32FFC433C7;
        Wed, 18 Oct 2023 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697668112;
        bh=kOr6kBKVTsDGo/Ewz8kI8OgtxzzOHafK+KurBxJCfV4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hKer3voRhWWEcxhPtyOE+NLlGnF6jr3xISPAMNr4ybU/hA5S6CXivbUBZjcGHBxB6
         wuYohN9nefPMJfk4aJhNP/cR4rzEzuztuez/hfZL0pqRkkvoh6fcNb1iF4iqJvTdJt
         3+UjEiB3JaB1dpqP48RZrOT21dOxB1zJpi6sr5d/0sUKUGuNS4V0vh8vC8ouNFAaFN
         /awoxU/kLjfhQeT9YUfQ7pL2luEG0xvBJWFQGoNzQVjX9VZqrfnINzPbXxomD/Cenz
         Eh03ihOpiIAtcMo8YBvFv3yQVjW7F+zBXj3atJK8gHCmkpjxNv3DL+iezwHfjJ6B2D
         FnBUUduSXSBQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F028CE0BB0; Wed, 18 Oct 2023 15:28:32 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:28:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     bpf@vger.kernel.org
Cc:     David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] Fold smp_mb__before_atomic() into atomic_set_release()
Message-ID: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf: Fold smp_mb__before_atomic() into atomic_set_release()

The bpf_user_ringbuf_drain() BPF_CALL function uses an atomic_set()
immediately preceded by smp_mb__before_atomic() so as to order storing
of ring-buffer consumer and producer positions prior to the atomic_set()
call's clearing of the ->busy flag, as follows:

        smp_mb__before_atomic();
        atomic_set(&rb->busy, 0);

Although this works given current architectures and implementations, and
given that this only needs to order prior writes against a later write.
However, it does so by accident because the smp_mb__before_atomic()
is only guaranteed to work with read-modify-write atomic operations,
and not at all with things like atomic_set() and atomic_read().

Note especially that smp_mb__before_atomic() will not, repeat *not*,
order the prior write to "a" before the subsequent non-read-modify-write
atomic read from "b", even on strongly ordered systems such as x86:

        WRITE_ONCE(a, 1);
        smp_mb__before_atomic();
        r1 = atomic_read(&b);

Therefore, replace the smp_mb__before_atomic() and atomic_set() with
atomic_set_release() as follows:

        atomic_set_release(&rb->busy, 0);

This is no slower (and sometimes is faster) than the original, and also
provides a formal guarantee of ordering that the original lacks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: David Vernet <void@manifault.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <bpf@vger.kernel.org>

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index f045fde632e5..0ee653a936ea 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -770,8 +770,7 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 	/* Prevent the clearing of the busy-bit from being reordered before the
 	 * storing of any rb consumer or producer positions.
 	 */
-	smp_mb__before_atomic();
-	atomic_set(&rb->busy, 0);
+	atomic_set_release(&rb->busy, 0);
 
 	if (flags & BPF_RB_FORCE_WAKEUP)
 		irq_work_queue(&rb->work);
