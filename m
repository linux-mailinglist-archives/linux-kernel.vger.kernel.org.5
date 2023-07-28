Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631F8767306
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjG1RNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjG1RNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:13:32 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42869B5;
        Fri, 28 Jul 2023 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U/2EyPB416bmgZjMBc22cLIVSGm2Qs6K0Mnk67OCU+4=; b=qtB/2PpD3Rqz3mmnxSUKwChUaH
        YAFcn+HpD1B8rWgqqylfHIcGDSGbFfRf3X5AZxYOLsbY3m5fQsdFlxkfHokcFtaK6aUGVRIi4mzGG
        Y2Otkk0F+ZFMiPmYR6lk7HOD5LSEiwk0sEe65WUQY8mL1LPhToxWHLiD742QuAKvVkrU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:42952 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qPR1o-0003Rm-8l; Fri, 28 Jul 2023 13:13:24 -0400
Date:   Fri, 28 Jul 2023 13:13:23 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230728131323.b869f999fc2481cd91c2954c@hugovil.com>
In-Reply-To: <169049136169.455096.838870858067077446.b4-ty@bootlin.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
        <169049136169.455096.838870858067077446.b4-ty@bootlin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 00/17] rtc: pcf2127: add PCF2131 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 22:57:41 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> 
> On Thu, 22 Jun 2023 10:57:43 -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Hello,
> > this patch series adds the driver for the PCF2131 real-time clock.
> > 
> > This RTC is very similar in functionality to the PCF2127/29 with the
> > following differences:
> >   -supports two new control registers at offsets 4 and 5
> >   -supports a new reset register
> >   -supports 4 tamper detection functions instead of 1
> >   -has no nvmem (like the PCF2129)
> >   -has two output interrupt pins instead of one
> >   -has 1/100th seconds capabilities (not supported in this driver)
> >   -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
> >    pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
> >   -watchdog value register cannot be read after being set
> > 
> > [...]
> 
> Applied, thanks!

Thank you :)
Hugo.


> [01/17] rtc: pcf2127: improve rtc_read_time() performance
>         commit: 31f077c374a8e7cf1960560c0c5e4065048557c0
> [02/17] rtc: pcf2127: improve timestamp reading performance
>         commit: 720fb4b83b565c7ae31059620e960ecbf5dc73a3
> [03/17] rtc: pcf2127: lower message severity if setting time fails
>         commit: 3d740c647ff8b77b2a560ebd95ac746c46f49ed4
> [04/17] rtc: pcf2127: remove superfluous comments
>         commit: 0476b6c8e8b1a6dfa3a259bc7e3c135145532c71
> [05/17] rtc: pcf2127: add variant-specific configuration structure
>         commit: fd28ceb4603f9541dcb4ed12b1365cff5af38203
> [06/17] rtc: pcf2127: adapt for time/date registers at any offset
>         commit: 6211acee8edf4af61f7745a92c4b4cb05a4340f9
> [07/17] rtc: pcf2127: adapt for alarm registers at any offset
>         commit: 7c6f0db41ab5fbd7ee3a2f9880ac23509a5d55d1
> [08/17] rtc: pcf2127: adapt for WD registers at any offset
>         commit: 6b57ec29e3fc31d43e672f6fede5d4a76140308b
> [09/17] rtc: pcf2127: adapt for CLKOUT register at any offset
>         commit: fc16599e0153e91ba12d856e40f6fc56906077f1
> [10/17] rtc: pcf2127: add support for multiple TS functions
>         commit: 420cc9e850dbc8e6ea7dd1e53d62d64cd8766354
> [11/17] rtc: pcf2127: add support for PCF2131 RTC
>         commit: afc505bf9039caf5a377d8b9705ef42f6d4ac7d4
> [12/17] rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
>         commit: e1849b8fcdfaa71f2e8f9376c9568877ff2bf52b
> [13/17] rtc: pcf2127: adapt time/date registers write sequence for PCF2131
>         commit: 3d715ebaf006bd5a495e9a717cf0fc5c260ee738
> [14/17] rtc: pcf2127: support generic watchdog timing configuration
>         commit: adb9675d74e403537150f025ed2b7a2e1ed0a7b4
> [15/17] rtc: pcf2127: add flag for watchdog register value read support
>         commit: 081602a1d85b1fd7ad9ea298cffb4e5ad5296952
> [16/17] rtc: pcf2127: add UIE support for PCF2131
>         commit: e9a5a1b418dd9a82d1de71e82ec64ad195b5300a
> [17/17] dt-bindings: rtc: pcf2127: add PCF2131
>         commit: 2080e08460c41c6d432575132868fdf076768c92
> 
> Best regards,
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
