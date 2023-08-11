Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E3778DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjHKLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHKLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAAE64
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691753400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6As8VsciFTDkpVcVPkTjEGtya4JDLwfZ9bbFOKjEbw=;
        b=GJsTQSJFCD96FAOEqq1MQUV5PLAWRoEifpQeGId/5R9uAUbbTxRuTDmRnN5s5t05bCGgSv
        6fR1XKxOHy9bUTlXQZih0/xXcU8dOviAti3r9nuoD9kXdLzF6RYM9ebMgHu2u6b5B3rpb0
        VOJHXJcafbY4Hs7cLIX/Bncrp3bYf7k=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-6BwhzZh3Mw6vxYoHE--xqw-1; Fri, 11 Aug 2023 07:29:56 -0400
X-MC-Unique: 6BwhzZh3Mw6vxYoHE--xqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 721E12834769;
        Fri, 11 Aug 2023 11:29:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9498D40C6E8A;
        Fri, 11 Aug 2023 11:29:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 11 Aug 2023 13:29:13 +0200 (CEST)
Date:   Fri, 11 Aug 2023 13:29:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Rheinsberg <david@readahead.eu>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Message-ID: <20230811112911.GA22566@redhat.com>
References: <20230807085203.819772-1-david@readahead.eu>
 <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Sorry for delay, I've just returned from vacation and I am slowly
crawling my email backlog.



On 08/07, Christian Brauner wrote:
>
> >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> >  {
> > -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > +	if (!pid)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Non thread-group leaders cannot have pidfds, but we allow them for
> > +	 * reaped thread-group leaders.
> > +	 */
> > +	if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDTYPE_TGID))
> >  		return -EINVAL;
>
> TL;DR userspace wants to be able to get a pidfd to an already reaped
> thread-group leader. I don't see any issues with this.

I guess I need to read the whole thread carefully, but right now
I don't understand this patch and the problem...

OK, suppose we have a group leader L with pid 100 and its sub-thread
T with pid 101.

With this patch pidfd_open(101) can succeed if T exits right after
find_get_pid(101) because pid_has_task(pid, PIDTYPE_PID) above will
fail, right?

This looks wrong, 101 was never a leader pid...

Oleg.

