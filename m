Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF087D92BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbjJ0IyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjJ0IyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:54:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948111BFF;
        Fri, 27 Oct 2023 01:44:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51EEC433C8;
        Fri, 27 Oct 2023 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698396258;
        bh=wgzu0sG0HQO9abh+06GqmHlYhzIzgF0rR09STDXJa+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKC9uYsW/bygDHiEZEB5iEiorIx1ZqWEw279MJv5UJ5LmBxjcaf8XCdC9GazMUgp3
         CGtlsyVRIE08rrKs+xrLmXmChuAA2xh57s24KwBTpV8elZ5Jg0l96RZzjXYcV8SyRD
         a8Uxmqfu9WfdXSckJHEQAZbyeHHFUSnz/jIRfH5Y=
Date:   Fri, 27 Oct 2023 10:44:15 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] misc: rtsx: add to support new card reader rts5264
Message-ID: <2023102726-voucher-chimp-d798@gregkh>
References: <121ced554a9e4f4791018e8f6a72d586@realtek.com>
 <2023102153-paramedic-washboard-29e3@gregkh>
 <b31f74462ce240a18652643224e285dd@realtek.com>
 <2023102514-unleash-italics-37ae@gregkh>
 <ff32ebcd6a1b41d5bd23a028f1a3f88b@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff32ebcd6a1b41d5bd23a028f1a3f88b@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:25:06AM +0000, Ricky WU wrote:
> > On Mon, Oct 23, 2023 at 03:31:24AM +0000, Ricky WU wrote:
> > > > > In order to support new chip rts5264, the definitions of some
> > > > > internal registers and workflow have to be modified.
> > > >
> > > > That is fine, but that should be a single patch, right?
> > > >
> > >
> > > Sorry maybe about misunderstand, The modifications mentioned here, it
> > > talk about some judgment expressions add "PID 5264" to make judgement
> > > in rtsx_pcr.c, so only about 30 line modified in rtsx_pcr.c
> > >
> > > > > Added rts5264.c rts5264.h for independent functions of the new
> > > > > chip rts5264
> > > >
> > > > And then add new support in a new patch, this is still too big as
> > > > one patch to attempt to review it properly.  Would you like to
> > > > review this as-is?
> > > >
> > >
> > > Yes, thank you
> > > Because rts5264.c rts5264.h only for rts5264 (new chip).
> > > The past architecture of this driver was like this, and it will good
> > > for us to maintain the driver different chip maybe has different
> > > functions and register definitions we used to separate different .c .h
> > 
> > Sorry, I don't think I was clear, this needs to be broken up into smaller pieces to
> > be able for us to review it properly.  Please do so and resend a new version of
> > the patch series.
> > 
> 
> Hi Greg k-h，
> 
> I want to confirm with you first
> I will have a new version for this patch, separate it into:
> 1. 2 new file and Makefile for new chip function and definition 
> 2. rtsx_pcr.c and rtsx_pcr.h for driver judgement to call new chip function  
> 3. mmc part
> 
> It is ok for you?

That's a good start, try it and see what that looks like.

Again, create patch series that you yourself would like to be able to
review.  Take some time to think about the reviewer's side of this as
that's the most limited resource we currently have.

thanks,

greg k-h
