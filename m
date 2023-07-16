Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E35755166
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGPTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGPTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580671B4;
        Sun, 16 Jul 2023 12:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD48160E65;
        Sun, 16 Jul 2023 19:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F7BC433CA;
        Sun, 16 Jul 2023 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689537355;
        bh=OlHIRb9EEX4HA1YaUzoZt1I4N9tkP745+c1gKGo4Ejo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CIK8gDWCLhRgACDQqEY2nn863Z/pljigo94yC4p/GgMLPIoB4arnPBq7/g10apYtk
         63lXLDoaVdQJqG9cuN1Lt8ugNIDzuujw/FuT/dF1KKhlz2UkyKzrnf40+ycbYqG2ts
         d7LOiezjsBmT93KlNA63/aSuYog8Ln1HrF1nKk6AUZT4UB0JZD4CdP3rvsK+0VJ0kY
         483SdRWjJi35qChYXZp1bhK4A8V595DnQGksmnt9enNQEx/G1HUYLuFkG45vyYtM2c
         VuFxF08Teir/NBhON9nybNHBMh/imM0PcV3UHoGj2h0L4m+QjVs6qPKHqSphYtUHLP
         JURVeKBiKOktg==
Received: by pali.im (Postfix)
        id 4A14C70C; Sun, 16 Jul 2023 21:55:52 +0200 (CEST)
Date:   Sun, 16 Jul 2023 21:55:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backporting commits for generating rpi dtb symbols to stable
Message-ID: <20230716195552.kcvjhowowxdbhyyt@pali>
References: <20230716162444.zzvkm4rh7s7lu37x@pali>
 <ZLRJaiIfPtqEB9Vb@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLRJaiIfPtqEB9Vb@aurel32.net>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 July 2023 21:47:54 Aurelien Jarno wrote:
> Hi,
> 
> On 2023-07-16 18:24, Pali Rohár wrote:
> > Hello,
> > 
> > I see that raspberry pi bootloader throws ton of warnings when supplied
> > DTB file does not contain /__symbols__/ node.
> > 
> > On RPI 1B rev1 it looks like this:
> > 
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> > dterror: no symbols found
> 
> Do you have those errors with the default configuration? On a RPI 4,
> this only happens when setting uart_2ndstage to 1 in config.txt.
> According to the documentation, this option enables diagnostic
> information from the main firmware.

Yes, I have it with default configuration. And I really do not know why
it is happening, I just described observations and that dtc -@ fixes
this issue. Note that this is about 1b rev1 (the first revision); so the
older HW, so maybe this can be a reason?

> Unless this is different on RPI 1B, this means we are talking about a
> warning that happens when enabling diagnostic information, so I am not
> sure it warrants a change to stable kernels.

Well, that is why I asked, if it is something for stable or not.

> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
