Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4475E763217
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjGZJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjGZJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F751BC8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690363657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CD423ngnFhs1Ys1W6GXmpNI8GFlt4nmPDuatVVp+QCE=;
        b=IvXoQ/Y+iEy+oVZyg1VyMkZtrzT7arr4VtZFqN1YgBgpbZ68nSSRZaYkTk1wDIM5G2S7tt
        7Lz/iaATyUOjB/hpYdf3FvpkMiWi8qSe5EQCdCQHBY03ebeRob66Mbf13oJa7FRsGlMLVm
        TRDTqfjsP0OWtiHUJ3+Q7mNcyzHGvBc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-Zum8lK-hNsOVSkF38OwIvg-1; Wed, 26 Jul 2023 05:27:35 -0400
X-MC-Unique: Zum8lK-hNsOVSkF38OwIvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08F811C09043;
        Wed, 26 Jul 2023 09:27:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.116])
        by smtp.corp.redhat.com (Postfix) with SMTP id 126852166B26;
        Wed, 26 Jul 2023 09:27:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 26 Jul 2023 11:26:56 +0200 (CEST)
Date:   Wed, 26 Jul 2023 11:26:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fiona Ebner <f.ebner@proxmox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        akpm@linux-foundation.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: segfaults of processes while being killed after commit "mm: make
 the page fault mmap locking killable"
Message-ID: <20230726092652.GA7943@redhat.com>
References: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
 <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25, Linus Torvalds wrote:
>
> What exactly made you notice? Is it just the logging from
> 'show_unhandled_signals' being set?
>
> Because the actual signal itself, from the
>
>         force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>
> in __bad_area_nosemaphore() should be overridden by the fact that a
> lethal signal was already pending.

Yes, SIGSEGV won't be even delivered, prepare_signal() returns F if
SIGNAL_GROUP_EXIT is set.

> But let's add a couple of signal people rather than the mm people to
> the participants. Eric, Oleg - would not an existing fatal signal take
> precedence over a new SIGSEGV? I obviously thought it did, but looking
> at 'get_signal()' and the signal delivery, I don't actually see any
> code to that effect.

See

		/* Has this task already been marked for death? */
		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
		     signal->group_exec_task) {
			clear_siginfo(&ksig->info);
			ksig->info.si_signo = signr = SIGKILL;
			sigdelset(&current->pending.signal, SIGKILL);
			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
				&sighand->action[SIGKILL - 1]);
			recalc_sigpending();
			goto fatal;
		}

in get_signal().

So yes, get_signal() returns SIGKILL if fatal_signal_pending() == T which
implies SIGNAL_GROUP_EXIT.

I think your patch is fine.

Oleg.

