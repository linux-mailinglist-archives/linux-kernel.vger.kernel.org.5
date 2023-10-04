Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1667B8064
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbjJDNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbjJDNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96286B0;
        Wed,  4 Oct 2023 06:13:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4D5C433CA;
        Wed,  4 Oct 2023 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696425215;
        bh=AtR3jS8UHoPaRMGlNzzPwqxBetaAOpzmhjBTKMuRs1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5dGZ5FqhPN0NLS42MlP7ZTzAfg1JqRm6d9pexc8zXOyVcw1I5JhLqTO2ghKqeeT9
         sXXkZqKXnQLqubrYK3rcsRnW9dlKJCjgCt4akVNqDu7kSpfKOe1mCMCJ+LMjvP5DPL
         iNrS1nqTKtwimiGSQ1+bDS9ufwpPwEgoRu06XGKU=
Date:   Wed, 4 Oct 2023 15:13:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <2023100409-brethren-gauntlet-965e@gregkh>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <20231003185500.GD8453@google.com>
 <2023100457-entail-freefall-06fd@gregkh>
 <20231004090918.GB9374@google.com>
 <2023100425-unwieldy-reaffirm-2a1b@gregkh>
 <20231004125758.GB83257@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004125758.GB83257@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:57:58PM +0100, Lee Jones wrote:
> On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> 
> > On Wed, Oct 04, 2023 at 10:09:18AM +0100, Lee Jones wrote:
> > > On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> > > 
> > > > On Tue, Oct 03, 2023 at 07:55:00PM +0100, Lee Jones wrote:
> > > > > On Tue, 03 Oct 2023, Greg Kroah-Hartman wrote:
> > > > > 
> > > > > > On Tue, Oct 03, 2023 at 06:00:20PM +0100, Lee Jones wrote:
> > > > > > > The important part of the call stack being:
> > > > > > > 
> > > > > > >   gsmld_write()             # Takes a lock and disables IRQs
> > > > > > >     con_write()
> > > > > > >       console_lock()
> > > > > > 
> > > > > > Wait, why is the n_gsm line discipline being used for a console?
> > > > > > 
> > > > > > What hardware/protocol wants this to happen?
> > > > > > 
> > > > > > gsm I thought was for a very specific type of device, not a console.
> > > > > > 
> > > > > > As per:
> > > > > > 	https://www.kernel.org/doc/html/v5.9/driver-api/serial/n_gsm.html
> > > > > > this is a specific modem protocol, why is con_write() being called?
> > > > > 
> > > > > What it's meant for and what random users can make it do are likely to
> > > > > be quite separate questions.  This scenario is user driven and can be
> > > > > replicated simply by issuing a few syscalls (open, ioctl, write).
> > > > 
> > > > I would recommend that any distro/system that does not want to support
> > > > this specific hardware protocol, just disable it for now (it's marked as
> > > > experimental too), if they don't want to deal with the potential
> > > > sleep-while-atomic issue.
> > > 
> > > n_gsm is available on all the systems I have available.  The mention of
> > > 'EXPERIMENTAL' in the module description appears to have zero effect on
> > > whether distros choose to make it available or not.  If you're saying
> > > that we know this module is BROKEN however, then perhaps we should mark
> > > it as such.
> > 
> > Also, I think this requires root to set this line discipline to the
> > console, right?  A normal user can't do that, or am I missing a code
> > path here?
> 
> I haven't been testing long, but yes, early indications show that root
> is required.

Oh good, then this really isn't that high of a priority to get fixed as
root can do much worse things :)

thanks,

greg k-h
