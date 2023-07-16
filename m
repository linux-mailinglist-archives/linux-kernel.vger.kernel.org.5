Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA7755124
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGPTv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2F116;
        Sun, 16 Jul 2023 12:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D2660EAA;
        Sun, 16 Jul 2023 19:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D1AC433C7;
        Sun, 16 Jul 2023 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689537113;
        bh=QdXpkPclnK4lAqXxNcl60QtzTf94NQuVLe8JOwaCt6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxAZwT70NVGlbZwQfXs3bRxY95QOyNb56ICJHT63Ik/34d1A11athkHOPz1rJPaK9
         rstt+VVVi58wSaEN6phoRt7kp1/3OX3JRRbqt8AnKdDybNqwG/PXsudab/5ZNhSWvU
         Eco80gOdIg6oZzLZYaqLBWQIvDPnjgFDEa1/P+KmFYaDJxXFSGeMathB2cWyGq964Q
         cCM0oJaH6fGCBh5przmwdRWODurk63sOAT1UVfh6zoXTfi00mPl/qK0d6+/g+YZVsn
         UOr3COFNiHaG9jbE8fVJaI2yVBG4NxcWfhjkoF0LqGs4ZpGF8bS1+WOpDkoBvyLMpx
         PDl1ITKjsvn4g==
Received: by pali.im (Postfix)
        id A645C70C; Sun, 16 Jul 2023 21:51:50 +0200 (CEST)
Date:   Sun, 16 Jul 2023 21:51:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backporting commits for generating rpi dtb symbols to stable
Message-ID: <20230716195150.ppa6vdjogjevlzgq@pali>
References: <20230716162444.zzvkm4rh7s7lu37x@pali>
 <2023071644-earflap-amazingly-3989@gregkh>
 <20230716163852.jnd4u4ylvifgmpby@pali>
 <2023071611-lustiness-rename-8b47@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023071611-lustiness-rename-8b47@gregkh>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 July 2023 21:08:38 Greg KH wrote:
> On Sun, Jul 16, 2023 at 06:38:52PM +0200, Pali Rohár wrote:
> > On Sunday 16 July 2023 18:32:42 Greg KH wrote:
> > > On Sun, Jul 16, 2023 at 06:24:44PM +0200, Pali Rohár wrote:
> > > > Hello,
> > > > 
> > > > I see that raspberry pi bootloader throws ton of warnings when supplied
> > > > DTB file does not contain /__symbols__/ node.
> > > > 
> > > > On RPI 1B rev1 it looks like this:
> > > > 
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > dterror: no symbols found
> > > > 
> > > > Bootloader also propagates these warnings to kernel via dtb property
> > > > chosen/user-warnings and they can be read by simple command:
> > > > 
> > > > $ cat /sys/firmware/devicetree/base/chosen/user-warnings
> > > > ...
> > > > 
> > > > Upstream Linux kernel build process by default does not generate
> > > > /__symbols__/ node for DTB files, but DTB files provided by raspberrypi
> > > > foundation have them for a longer time.
> > > > 
> > > > I wanted to look at this issue, but I figured out that it is already
> > > > solved by just recent Aurelien's patches:
> > > > 
> > > > e925743edc0d ("arm: dts: bcm: Enable device-tree overlay support for RPi devices")
> > > > 3cdba279c5e9 ("arm64: dts: broadcom: Enable device-tree overlay support for RPi devices")
> > > > 
> > > > My testing showed that /__symbols__/ node is required by rpi bootloader
> > > > for overlay support even when overlayed DTB file does not use any DTB
> > > > symbol (and reference everything via full node path). So seems that
> > > > /__symbols__/ node is crucial for rpi bootloader even when symbols from
> > > > them are not used at all.
> > > > 
> > > > So I would like to ask, would you consider backporting these two
> > > > raspberry pi specific patches to stable kernel trees? Upstream kernel
> > > > would get rid of those bootloader warnings and also allow users to use
> > > > overlayed dtbs...
> > > 
> > > What kernel tree(s) should these be applied to?  What trees did you test
> > > them for?
> > > 
> > > Also, adding dt-overlay support does not seem like a stable kernel fix,
> > > as this isn't a bugfix from what I can tell, right?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > I wanted to discuss what do you think about it. As I wrote my motivation
> > was to understood and get rid of those warnings "dterror: no symbols
> > found" from bootloader when using DTB files from mainline kernel (as
> > opposite of the DTB files from rpi foundation). And fix for it was just
> > to generate DTB files from kernel via dtc's -@ parameter, same what are
> > doing those mentioned patches (but they describe different problem for
> > which is same fix). I thought that fixing those bootloader warnings is a
> > bugfix.
> 
> Why not just use the next kernel version instead?  What's forcing you to
> use an older stable kernel that didn't have dt-overlay support?
> 
> thanks,
> 
> greg k-h

Why not use the next kernel? It is pretty simple, next is the
development tree, not for production. And as I wrote in previous email,
I do not need here dt-overlay support. I wanted to get rid off that
warning messages.
