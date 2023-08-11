Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0139F7794F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjHKQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbjHKQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:45:01 -0400
Received: from out-114.mta1.migadu.com (out-114.mta1.migadu.com [IPv6:2001:41d0:203:375::72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB672D7D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:45:01 -0700 (PDT)
Message-ID: <03763b62-8d49-6fbf-5ce9-21c334c9aac2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691772299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=admShfSykcaAtbel+tfZWUdxGTiA82izBewytBKFlQ8=;
        b=RIok6yu/Auqn0MWP4OKNMvm04myfUt1AS598KaVNv0crBmVGWPuLF/VrUoacz0fJcmspTE
        b6+9STyNuUxLP6a2PcQyjSNhMw68Tj+mCkXjOXWNIrpY5VI3s/I8u0LCmV1y6s5N3znJ0x
        hYMMwEvvVarUEoJ8BNStd3ucIvWQ2Qs=
Date:   Fri, 11 Aug 2023 17:44:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: mediatek-ge-soc: support PHY LEDs
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
 <ac6a4318-3a47-2c77-6b81-b5f04765c04e@linux.dev>
 <ed096dfe-6a42-4838-972b-7a28afaf2f6e@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ed096dfe-6a42-4838-972b-7a28afaf2f6e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 17:39, Andrew Lunn wrote:
>>> +	/* Only now setup pinctrl to avoid bogus blinking */
>>> +	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
>>
>> This function gets reference on phydev->mdio.dev, but there is no code
>> to release it. It looks like a leak which will prevent module unload,
>> but I don't have hardware now to prove it.
> 
> Since it is a devm_ function, it should get released when the device
> is destroyed. Or am i missing something?
> 

Oh, got it. Yeah, resource managed code needs no explicit *put() calls.
Thanks for the clarification.

