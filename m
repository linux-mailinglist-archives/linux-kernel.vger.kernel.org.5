Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8E801B86
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjLBIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:36:36 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711C196;
        Sat,  2 Dec 2023 00:36:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6476F240003;
        Sat,  2 Dec 2023 08:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1701506200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2wLMvIIVt4NNTdGsFG3SPBRcTEOfz3PdLa/GlA7GzU=;
        b=pCSuWAI9D8zF/hQO2V4ig9tFsgd/ew1diFvWU/0pjWH64JXKoxcouGA+Mzja+/yl4zDoov
        dZF4PpQQKhIXp3LNwFSJGwiHwdRNE7yZs8buTVxP+k7oTs/212WKhDvPKSFzNsn0ALf0oL
        q68fPW3eq2W9Db7kqa7QDVT6YQPyFgz7AstIXWbpDUCmHorRjocpPgjfmee9962uKVqPfn
        R9v1QZxORbOLzp1WoB71qxsDqJeFLkW2OYmpzw/YWXZvhxXoOBJ1PX/7dW+/B1ZIpoY+Jv
        mpVGOWeakcUTBSIRkNJA/4MjvH1fKxC0GmD4coHpvGPYI5Tb00JUT2hfNN4H+A==
Message-ID: <5e95a436-189f-412e-b409-89a003003292@arinc9.com>
Date:   Sat, 2 Dec 2023 11:36:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/15] net: dsa: mt7530: improve code path for
 setting up port 5
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-6-arinc.unal@arinc9.com>
 <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2023 17:41, Russell King (Oracle) wrote:
> On Sat, Nov 18, 2023 at 03:31:55PM +0300, Arınç ÜNAL wrote:
>> There're two code paths for setting up port 5:
>>
>> mt7530_setup()
>> -> mt7530_setup_port5()
>>
>> mt753x_phylink_mac_config()
>> -> mt753x_mac_config()
>>     -> mt7530_mac_config()
>>        -> mt7530_setup_port5()
>>
>> Currently mt7530_setup_port5() from mt7530_setup() always runs. If port 5
>> is used as a CPU, DSA, or user port, mt7530_setup_port5() from
>> mt753x_phylink_mac_config() won't run. That is because priv->p5_interface
>> set on mt7530_setup_port5() will match state->interface on
>> mt753x_phylink_mac_config() which will stop running mt7530_setup_port5()
>> again.
>>
>> Therefore, mt7530_setup_port5() will never run from
>> mt753x_phylink_mac_config().
>>
>> Address this by not running mt7530_setup_port5() from mt7530_setup() if
>> port 5 is used as a CPU, DSA, or user port. This driver isn't in the
>> dsa_switches_apply_workarounds[] array so phylink will always be present.
>>
>> For the cases of PHY muxing or the port being disabled, call
>> mt7530_setup_port5() from mt7530_setup(). mt7530_setup_port5() from
>> mt753x_phylink_mac_config() won't run when port 5 is disabled or used for
>> PHY muxing as port 5 won't be defined on the devicetree.
> 
> ... and this should state why this needs to happen - in other words,
> the commit message should state why is it critical that port 5 is
> always setup.

Actually, port 5 must not always be setup. With patch 7, I explain this
while preventing mt7530_setup_port5() from running if port 5 is disabled.

Arınç
