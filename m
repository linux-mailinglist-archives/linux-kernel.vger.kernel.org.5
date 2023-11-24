Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED37F78AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjKXQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:11:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BA19A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:11:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED18DC433C7;
        Fri, 24 Nov 2023 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700842297;
        bh=dJSDLgF1ETBLHdgapdUQqr7W+2GHFxTIN1LSwAqVspg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxpshLMNbgBo+zf0EEVWtwlzwlDDJS8GI5vOpggbBc/4eGORnPz9ml/oppewA7Td7
         e0maD+CCVcnC6AF5S3tqdFUrOQtUeViomwCQvryMArVneUAizDUVvDBndcbRSKUP6B
         RvQirFT0Z6LVpidAvmBw87tTwgJ0yLAjxn1z16SI=
Date:   Fri, 24 Nov 2023 16:11:35 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.201-rt98
Message-ID: <2023112455-anytime-unmapped-ed7d@gregkh>
References: <ZV1S4yDcPKwj5_N1@uudg.org>
 <ZV4D1yBGSOE-OVUF@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4D1yBGSOE-OVUF@uudg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:36:23AM -0300, Luis Claudio R. Goncalves wrote:
> On Tue, Nov 21, 2023 at 10:01:25PM -0300, Luis Claudio R. Goncalves wrote:
> > Hello RT-list!
> > 
> > I'm pleased to announce the 5.10.201-rt98 stable release.
> > 
> > This release is just an update to the new stable 5.10.201
> > version and no RT changes have been made.
> > 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > 
> >   branch: v5.10-rt
> >   Head SHA1: 3a93f0a0d49dd0db4c6876ca9a7369350e64320e
> 
> Greg KH,
> 
> While testing v5.10.201-rt98 I stumbled over this warning:
> 
>     [ 1000.312397] run blktests nvme/005 at 2023-11-21 21:46:30
>     ...
>     [ 1000.500478] workqueue: WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp] is flushing !WQ_MEM_RECLAIM events:0x0
>     [ 1000.500490] WARNING: CPU: 0 PID: 6 at kernel/workqueue.c:2620 check_flush_dependency+0x11f/0x140
> 
> That seems to be fixed by:
> 
>     533d2e8b4d5e4 nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
>         (and depending on what else is backported)
>         ddd2b8de9f85b nvmet: fix workqueue MEM_RECLAIM flushing dependency
> 
> Is this something that can be added to your v5.10 queue or should I carry
> this fix on v5.10-rt in the meantime?

That's odd, as this commit is already in the 5.10.138 release, so how
can we apply it again?

confused,

greg k-h
