Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14208754F21
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGPO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGPO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303561B7;
        Sun, 16 Jul 2023 07:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FEB60D27;
        Sun, 16 Jul 2023 14:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA81C433C7;
        Sun, 16 Jul 2023 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689519559;
        bh=BcbGvIMw7IzFmFTJrFkd9Hfe38MZzNMEsk3MFlGVA74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcNz99QuVZYxxcw2U2cGSpcGjD43YIx+H5GX6BO7uJ21wLImuVdfTxhCVP01TpHl7
         KUmqbjUFBlnTAstJIFBF8eFWEdvwCgQ3AxvUVklqLxD8hqBDuTG0xdkfEU8dQvhSMA
         kROvTdrVCGB5LCsch8I48YqKtsLl1xDO25EYQBGw=
Date:   Sun, 16 Jul 2023 16:58:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sasha Levin <sashal@kernel.org>,
        Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Fwd: dwc3: regression in USB DWC3 driver in kernel 5.15 branch
Message-ID: <2023071638-extrovert-batting-1f93@gregkh>
References: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 06:03:06PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a stable-specific regression on Bugzilla [1]. Quoting from it:
> 
> > The backport commit to 5.15 branch:
> > 9d4f84a15f9c9727bc07f59d9dafc89e65aadb34 "arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes"  (from upstream commit 5c3d5ecf48ab06c709c012bf1e8f0c91e1fcd7ad)
> > switched from "snps,dis-u2-freeclk-exists-quirk" to "snps,gfladj-refclk-lpm-sel-quirk".
> > 
> > The problem is that the gfladj-refclk-lpm-sel-quirk quirk is not implemented / backported to 5.15 branch.
> > 
> > This commit should be either reverted, or the commit introducing gfladj-refclk-lpm-sel-quirk needs to be merged to 5.15 kernel branch.
> > 
> > As a result of this patch, on Gateworks Venice GW7400 revB board the USB 3.x devices which are connected to the USB Type C port does not enumerate and the following errors are generated:
> > 
> > [   14.906302] xhci-hcd xhci-hcd.0.auto: Timeout while waiting for setup device command
> > [   15.122383] usb 2-1: device not accepting address 2, error -62
> > [   25.282195] xhci-hcd xhci-hcd.0.auto: Abort failed to stop command ring: -110
> > [   25.297408] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
> > [   25.305345] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
> > [   25.311058] xhci-hcd xhci-hcd.0.auto: Timeout while waiting for stop endpoint command
> > [   25.334361] usb usb2-port1: couldn't allocate usb_device
> > 
> > When the commit is reverted the USB 3.x drives works fine.
> 
> See Bugzilla for the full thread and attach dmesgs.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: 9d4f84a15f9c97 https://bugzilla.kernel.org/show_bug.cgi?id=217670
> #regzbot title: regression in USB DWC3 driver due to missing gfladj-refclk-lpm-sel-quirk quirk

This isn't helpful as I don't know what commit eactly this missing
quirk is :(
