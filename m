Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2077B7798
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjJDGEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:04:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFEBA7;
        Tue,  3 Oct 2023 23:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82613C433C7;
        Wed,  4 Oct 2023 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696399458;
        bh=cmdZvOlO4F4bJwZoOGl7Twox6gny/N+bJ3dvgzPEc7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnQ1AlpJ2UqLGSX5y5GOKhS6FixzEUuZB0J+oZhmKO80OSclGiKC5dUYBfXGuhtON
         q5dkDMhjI7wDD7c6S3WGE2FYLJSskf3DYz+EfjxNaeFJCz39WNY5bFK757Qwn21FeL
         2gFyEzRwvzRyFUHgTpJ+1+TYZVY4VSaPda39pu+g=
Date:   Wed, 4 Oct 2023 08:04:15 +0200
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
Message-ID: <2023100457-entail-freefall-06fd@gregkh>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <20231003185500.GD8453@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003185500.GD8453@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 07:55:00PM +0100, Lee Jones wrote:
> On Tue, 03 Oct 2023, Greg Kroah-Hartman wrote:
> 
> > On Tue, Oct 03, 2023 at 06:00:20PM +0100, Lee Jones wrote:
> > > The important part of the call stack being:
> > > 
> > >   gsmld_write()             # Takes a lock and disables IRQs
> > >     con_write()
> > >       console_lock()
> > 
> > Wait, why is the n_gsm line discipline being used for a console?
> > 
> > What hardware/protocol wants this to happen?
> > 
> > gsm I thought was for a very specific type of device, not a console.
> > 
> > As per:
> > 	https://www.kernel.org/doc/html/v5.9/driver-api/serial/n_gsm.html
> > this is a specific modem protocol, why is con_write() being called?
> 
> What it's meant for and what random users can make it do are likely to
> be quite separate questions.  This scenario is user driven and can be
> replicated simply by issuing a few syscalls (open, ioctl, write).

I would recommend that any distro/system that does not want to support
this specific hardware protocol, just disable it for now (it's marked as
experimental too), if they don't want to deal with the potential
sleep-while-atomic issue.

> > And Lee, you really don't have this hardware, right?  So why are you
> > dealing with bug reports for it?  :)
> 
> 'cos Syzkaller.

Ah, yeah, fake report, no real issue here then :)

thanks,

greg k-h
