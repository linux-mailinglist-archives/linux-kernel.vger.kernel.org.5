Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F67F25F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjKUGtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKUGtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:49:52 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EFA90
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:49:48 -0800 (PST)
Message-ID: <11bf3c0f-f78b-4dd3-97d3-c39b5b2ae7bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700549386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9BS9UBYsSndFAg/kFykIgLfKwkfc0tziM6o2ZmXP0yc=;
        b=qgqcvbKwWn9QXxkyQuD1VkO3P4AyGBcuxrKWDxsoKY9R187ET2HSTLU1/mpggl0ZFcCOSo
        J4HWCyhfEAj0QBgrQ9Otqfwl3Odl6dBAXBJfOD8Jn+f/+BDybL5NQDEZn7c5MB2AuPHU+4
        MZlYVZ0uuDvxw/O3hNk3Sj1YR8igVLc=
Date:   Mon, 20 Nov 2023 22:49:39 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: Update multiple prog_tests
 to use ASSERT_ macros
Content-Language: en-GB
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, sdf@google.com,
        shuah@kernel.org, song@kernel.org
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/20/23 7:03 PM, Yuran Pereira wrote:
> Multiple files/programs in `tools/testing/selftests/bpf/prog_tests/` still
> heavily use the `CHECK` macro, even when better `ASSERT_` alternatives are
> available.
>
> As it was already pointed out by Yonghong Song [1] in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
>
> This patchset replaces the usage of `CHECK(` macros to the equivalent `ASSERT_`
> family of macros in the following prog_tests:
> - bind_perm.c
> - bpf_obj_id.c
> - bpf_tcp_ca.c
> - vmlinux.c
>
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
>
> Changes in v3:
> - Addressed the following points mentioned by Yonghong Song
> - Improved `bpf_map_lookup_elem` assertion in bpf_tcp_ca.
> - Replaced assertion introduced in v2 with one that checks `thread_ret`
>    instead of `pthread_join`. This ensures that `server`'s return value
>    (thread_ret) is the one being checked, as oposed to `pthread_join`'s
>    return value, since the latter one is less likely to fail.
>
> Changes in v2:
> - Fixed pthread_join assertion that broke the previous test
>
> Previous version:
> v2 - https://lore.kernel.org/lkml/GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
> v1 - https://lore.kernel.org/lkml/GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
>
> Yuran Pereira (4):
>    Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
>    Replaces the usage of CHECK calls for ASSERTs in bind_perm
>    Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
>    selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in
>      vmlinux
>
>   .../selftests/bpf/prog_tests/bind_perm.c      |   6 +-
>   .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 ++---
>   .../selftests/bpf/prog_tests/vmlinux.c        |  16 +-
>   4 files changed, 105 insertions(+), 169 deletions(-)
>
Ack for the whole series:
Acked-by: Yonghong Song <yonghong.song@linux.dev>

Yuran, next time when you submit patches, you can carry 'Acked-by' tag
from previous revision if there are no significant changes. This will
reduce some of reviewers and maintainers' work.

