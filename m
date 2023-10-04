Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC897B8000
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbjJDM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbjJDM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:58:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D1DC;
        Wed,  4 Oct 2023 05:58:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B91CC433C8;
        Wed,  4 Oct 2023 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696424283;
        bh=sWP2Ntp9DcBxpiuxS4XRjZnJcYZJ+LQRso0hX8SK6OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7sT6GWXNBxb7Txv/otjKxL6J9JMmbE7bWzzXKFrD7kvj39jdbrM41xvR/ta+oRSm
         4bFrbL2PW2+Q5cnajaUwJOEtogybJeKBv9gMLzrvO3s0U4Iriv6lXyxfcbm8qNNT+L
         0eRc6vobJX+tpFesBEOlNMBk5/IZx0kZwf6hXBUuorTQ9JV16tfSVWFS9bcZMpV4Ad
         kxl61vqu/Wi7s5qltq0VoLjAWRjQNX3S6h64vE675VyFuGQqrdjahbGYV3GC4gslsi
         iIwCDyoapuQjxUAFz49DY4e1sooGW1euSwAjTSy16d5GDcVq+ArxlSLB92knD3woHc
         3xoU7UEH1xAiQ==
Date:   Wed, 4 Oct 2023 13:57:58 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <20231004125758.GB83257@google.com>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <20231003185500.GD8453@google.com>
 <2023100457-entail-freefall-06fd@gregkh>
 <20231004090918.GB9374@google.com>
 <2023100425-unwieldy-reaffirm-2a1b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100425-unwieldy-reaffirm-2a1b@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:

> On Wed, Oct 04, 2023 at 10:09:18AM +0100, Lee Jones wrote:
> > On Wed, 04 Oct 2023, Greg Kroah-Hartman wrote:
> > 
> > > On Tue, Oct 03, 2023 at 07:55:00PM +0100, Lee Jones wrote:
> > > > On Tue, 03 Oct 2023, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Tue, Oct 03, 2023 at 06:00:20PM +0100, Lee Jones wrote:
> > > > > > The important part of the call stack being:
> > > > > > 
> > > > > >   gsmld_write()             # Takes a lock and disables IRQs
> > > > > >     con_write()
> > > > > >       console_lock()
> > > > > 
> > > > > Wait, why is the n_gsm line discipline being used for a console?
> > > > > 
> > > > > What hardware/protocol wants this to happen?
> > > > > 
> > > > > gsm I thought was for a very specific type of device, not a console.
> > > > > 
> > > > > As per:
> > > > > 	https://www.kernel.org/doc/html/v5.9/driver-api/serial/n_gsm.html
> > > > > this is a specific modem protocol, why is con_write() being called?
> > > > 
> > > > What it's meant for and what random users can make it do are likely to
> > > > be quite separate questions.  This scenario is user driven and can be
> > > > replicated simply by issuing a few syscalls (open, ioctl, write).
> > > 
> > > I would recommend that any distro/system that does not want to support
> > > this specific hardware protocol, just disable it for now (it's marked as
> > > experimental too), if they don't want to deal with the potential
> > > sleep-while-atomic issue.
> > 
> > n_gsm is available on all the systems I have available.  The mention of
> > 'EXPERIMENTAL' in the module description appears to have zero effect on
> > whether distros choose to make it available or not.  If you're saying
> > that we know this module is BROKEN however, then perhaps we should mark
> > it as such.
> 
> Also, I think this requires root to set this line discipline to the
> console, right?  A normal user can't do that, or am I missing a code
> path here?

I haven't been testing long, but yes, early indications show that root
is required.

> Is there a reproducer somewhere for this issue that runs as a normal
> user?  I couldn't find one in the syzbot listings but I might have been
> not looking deep enough.

https://syzkaller.appspot.com/text?tag=ReproC&x=15578d8fa80000

-- 
Lee Jones [李琼斯]
