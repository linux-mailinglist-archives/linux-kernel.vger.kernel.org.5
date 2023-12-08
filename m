Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACD80A62D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574220AbjLHOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574084AbjLHOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:40 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF81BC6;
        Fri,  8 Dec 2023 06:51:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBE8524000C;
        Fri,  8 Dec 2023 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702047081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOA4z6r+6Tw9VE2/Ykzr/TDzoWZUyODcnTrVc7hxXhE=;
        b=Nz7RuFjJzuOae6pn3HjyKDKpoZWHo8YWlgtv7SMma0uV3151+Q1FgTsjczMHQG9memeizl
        4KoefwHeD1WWlsWwpaukBGgjg1wgiQ6B3ZkbfkX60WWD90enBmYY2/weOWtafL1CUoS85Y
        SSXcdanHGGIAvFLKwgoRhHLDaYokxvLxikGvZQ+H9IeIQOggm32d2tjVU6XGpaSab5nsqr
        XIhbdz+of9BvnNfp0obfhicqMzDNasuh1x3Wev3KucI6Zuq+YRQyUs5If2hIHzDF41OjkV
        aBsMXb54oMhz0pJn4VBXeChyGWx0OmZqp4SyfquEU5SbyeH0GiIxdJAFn1FMww==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sjoerd Simons <sjoerd@collabora.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        kernel@collabora.com, Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Moxtet bus fixes
In-Reply-To: <20231128213536.3764212-1-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
Date:   Fri, 08 Dec 2023 15:51:20 +0100
Message-ID: <87fs0ceoif.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek and Sjoerd,

> It seems the moxtet bus support was broken since 21aad8ba615e ("arm64:
> dts: armada-3720-turris-mox: Add missing interrupt for RTC") for two
> reasons:
> * The moxtet irq isn't marked as shared so the driver fails to load if
>   the rtc driver gets set up first.
> * The dts change didn't set the IRQ type, so in case the rtc driver got
>   probed first irq setup ended up wrong (rising instead of falling edge).
>
> On top of that the moxtet module isn't auto-loading due to a missing spi
> table
>
> Changes in v2:
> - Add cover letter
> - Add patch to set the irq type
>
> Sjoerd Simons (3):
>   bus: moxtet: Mark the irq as shared
>   bus: moxtet: Add spi device table
>   arm64: dts: armada-3720-turris-mox: set irq type for RTC

I only received the previous patch in my inbox, I plan to apply it. But
what about the 2 other patches ? Marek will you do a pull request with
these 2 patches or do you expect that I take them also ?

Regards,

Gregory


>
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
>  drivers/bus/moxtet.c                                   | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> -- 
> 2.43.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
