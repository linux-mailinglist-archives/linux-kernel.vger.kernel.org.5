Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770D977EB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbjHPVI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346435AbjHPVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795832716
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692220047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sc41mux7W77w9DhlYaEuRV3bL1PCeNbUY4vG3x+OqX8=;
        b=hYz2LwyLF4rUK2hNUVvSMfJ11TjufXQGF+E2B6tNhjj6dXQ7BwSvaug4N8vx1xsmgYG+GQ
        7XSIm3CYgBVVLAwNXE7t5kPC04QJ1GuEBK5fckqCi7wbjl6KbVhyVTQfEMHwHJV3dG60HH
        r4ZzfRVCFMXscCc1+BFHJr7ByfntiQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-PTm-dZNWNYmjH3EuE_gsDg-1; Wed, 16 Aug 2023 17:07:21 -0400
X-MC-Unique: PTm-dZNWNYmjH3EuE_gsDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E72CD85CCE0;
        Wed, 16 Aug 2023 21:07:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id D877A1121314;
        Wed, 16 Aug 2023 21:07:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 16 Aug 2023 23:06:37 +0200 (CEST)
Date:   Wed, 16 Aug 2023 23:06:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Petr Skocik <pskocik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: Fix the error return of kill -1
Message-ID: <20230816210634.GA10130@redhat.com>
References: <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
 <878rai7u0l.fsf@email.froward.int.ebiederm.org>
 <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
 <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
 <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
 <20230814140652.GA30596@redhat.com>
 <20230814154351.GA4203@redhat.com>
 <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
 <20230815151149.GA29072@redhat.com>
 <87fs4ig23p.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs4ig23p.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 08/15, David Laight wrote:
> >>
> >> or maybe even:
> >> 	} else {
> >> 		struct task_struct * p;
> >> 		int err;
> >> 		ret = -ESRCH;
> >>
> >> 		for_each_process(p) {
> >> 			if (task_pid_vnr(p) > 1 &&
> >> 					!same_thread_group(p, current)) {
> >> 				err = group_send_sig_info(sig, info, p,
> >> 							  PIDTYPE_MAX);
> >> 				if (ret)
> >> 					ret = err;
> >
> > Hmm, indeed ;)
> >
> > and "err" can be declared inside the loop.
>
> We can't remove the success case, from my posted patch.
>
> A signal is considered as successfully delivered if at least
> one process receives it.

Yes.

Initially ret = -ESRCH.

Once group_send_sig_info() succeeds at least once (returns zero)
ret becomes 0.

After that

	if (ret)
		ret = err;

has no effect.

So if a signal is successfully delivered at least once the code
above returns zero.

Oleg.

