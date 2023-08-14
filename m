Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609B377B9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjHNNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHNNWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B93F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692019300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lrFQ1Piu7kOD9w6iKIQkZ8h3C5VVMWcr3aHpTSKZPi0=;
        b=TyxHk3EPLYb2xGFWR5URHCq7r3t6bPq+RlOJJqWOpWTbwpvTdam68y2lWZ9u+RJJut71Kn
        y4loUZ6E+UA4eEpB83bhh3iCa43SejhXi+cZcVnh3Tu5/seVzf2gWX46U2GSy2lcNfBSB5
        hfzbEE27w1lsHRLHEhFU1JMCfC3KaeU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-PXYjbQvYPpCo2pWxCD1h_A-1; Mon, 14 Aug 2023 09:21:35 -0400
X-MC-Unique: PXYjbQvYPpCo2pWxCD1h_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214F285CBEB;
        Mon, 14 Aug 2023 13:21:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53E9F2166B25;
        Mon, 14 Aug 2023 13:21:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Aug 2023 15:20:42 +0200 (CEST)
Date:   Mon, 14 Aug 2023 15:20:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Rheinsberg <david@readahead.eu>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Message-ID: <20230814132039.GA17738@redhat.com>
References: <20230807085203.819772-1-david@readahead.eu>
 <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
 <20230811112911.GA22566@redhat.com>
 <20230811-perplex-installieren-899f5925534d@brauner>
 <20230811115710.GA21779@redhat.com>
 <6feef7e0-ea72-412d-837e-34b6fdd3b869@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6feef7e0-ea72-412d-837e-34b6fdd3b869@app.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, David Rheinsberg wrote:
>
> Hi Oleg,
>
> On Fri, Aug 11, 2023, at 1:57 PM, Oleg Nesterov wrote:
> >> What code do we need to allow userspace to open a pidfd to a leader pid
> >> even if it has already been exited and reaped (without also accidently
> >> allowing to open non-lead pid pidfds)?
> >
> > I'll try to think more, but can you also explain why do we need this?
> >
> > See my another email. Can't we simply shift the pid_has_task(PIDTYPE_TGID)
> > check from pidfd_prepare() to pidfd_create() ? (and then we can kill
> > pidfd_prepare and rename __pidfd_prepare to pidfd_prepare).
>
> Yes, the easiest solution would be to use `__pidfd_prepare()` and ensure
> that the caller only ever calls this on tg-leaders. This would work just
> fine, imo. And this was my initial approach.

Great,

> I think Christian preferred an explicit assertion that ensures we do not
> accidentally hand out pidfds for non-tg-leaders. The question is thus whether
> there is an easy way to assert this even for reaped tasks?
> Or whether there is a simple way to flag a pid that was used as tg-leader?

I do not see how can we check if a detached pid was a leader pid, and I don't
think it makes sense to add a new member into struct pid...

> Or, ultimately, whether this has limited use and we should just use
> `__pidfd_prepare()`?

Well, if you confirm that sk->sk_peer_pid and scm->pid are always initialized with
task_tgid(current), I'd certainly prefer this approach unless Christian objects.

Oleg.

