Return-Path: <linux-kernel+bounces-21017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFBC828894
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC871C246A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86739AEE;
	Tue,  9 Jan 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2USacYW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D31E532;
	Tue,  9 Jan 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33677fb38a3so3155624f8f.0;
        Tue, 09 Jan 2024 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704812264; x=1705417064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O/VFtkk/ucqnh99jzVnmo2J+UR5Re9UDBkOsyqDC/dE=;
        b=K2USacYW2pQ4FglTA7jJJPLbkv/MsNDhAJSLI6lXgPd7o6wv4+voTBGpe0cmymQlhN
         n4kdC62cJMMmsr0gXCuHzQ2X4Z6f8V/ODT7rb1u2cmuC2rqS9XhB8Nbi10mjXzUXKUU1
         q5kUHBK73RqPc1pNzp1gCzZlvY7O16+35l0YMeO7/Qd0Mo+4ZbgRW+1B40gEE14qOs23
         gmLE7O90L86jTS/qj4C8ue099nz5B3PI5Hrb0YMwcH+DCj0Io9oeizJAXFrMJWuWzJpN
         tqqMVxpyDYPIYJlPPh0bLwzpJQpyx5NFbDt4xmSMgBidiCr+8Hxr+BI8NYCVIz7ojIT2
         1y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704812264; x=1705417064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/VFtkk/ucqnh99jzVnmo2J+UR5Re9UDBkOsyqDC/dE=;
        b=XRxg469F3jqcykr+aMQ1GEtNofdaKm0m/9Z2UeK9R9lMsIZG4Pj3orMvYJahFbHZKa
         vyHFS7wuC03OAevTWsV7zWHJh2IL/4fl/TISUJwyDUEw1KyGGvl2xN7Mej8AQJb99rbQ
         P1RCr1Lv+H9dQgwfrkNsvopq3IvnB7vX2keU7IPrlAcqHe3/RU9/6LWutMCH4oer+dPu
         IB6RQEmMo5xJI2ftvw64dMZnA3CRA3DAolrRcHn5J14/yyW1ocC//lhxHw/KcdsoJupn
         1IE6ydCkjRwhfCXWr/j65syyyMXF6XNp1b04pwE90KJ9c/UDQ2H+VZfpg7WsjFrk+/y3
         oSZw==
X-Gm-Message-State: AOJu0YzVxETFiggMEulBv58WLIGg37VDmUzt8c3ZGXUd4izgL3wXatLU
	fpBuCxTaY0vMlhE1NA5mSKE=
X-Google-Smtp-Source: AGHT+IHvw+zUv0tbFrbcMHcF+359BznhxW6lojKfp1wWvoyVPlvRm1aoDo5+9dNMvPzBMZdkFdHVWA==
X-Received: by 2002:a5d:4911:0:b0:336:7d79:ee5b with SMTP id x17-20020a5d4911000000b003367d79ee5bmr555992wrq.59.1704812264091;
        Tue, 09 Jan 2024 06:57:44 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id y16-20020a056000109000b003365f5e87f4sm2614139wrw.95.2024.01.09.06.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:57:43 -0800 (PST)
Date: Tue, 9 Jan 2024 16:57:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <20240109145740.3vbtkuowiwedz5hx@skbuf>
References: <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
 <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>

On Sat, Jan 06, 2024 at 08:01:25PM +0200, Arınç ÜNAL wrote:
> I must be missing something.
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 7f9d63b61168..05ce3face47c 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2325,7 +2325,7 @@ mt7530_setup(struct dsa_switch *ds)
>  			if (phy_node->parent == priv->dev->of_node->parent) {
>  				ret = of_get_phy_mode(mac_np, &interface);
> -				if (ret && ret != -ENODEV) {
> +				if (ret) {
>  					of_node_put(mac_np);
>  					of_node_put(phy_node);
>  					return ret;
> 
> $ ../smatch/smatch_scripts/kchecker --spammy drivers/net/dsa/mt7530.c
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      drivers/net/dsa/mt7530.o
>   CHECK   drivers/net/dsa/mt7530.c
> drivers/net/dsa/mt7530.c:469 mt7530_pad_clk_setup() error: uninitialized symbol 'ncpo1'.
> drivers/net/dsa/mt7530.c:895 mt7530_set_ageing_time() error: uninitialized symbol 'age_count'.
> drivers/net/dsa/mt7530.c:895 mt7530_set_ageing_time() error: uninitialized symbol 'age_unit'.
> drivers/net/dsa/mt7530.c:2346 mt7530_setup() error: uninitialized symbol 'interface'.

Yes, well _now_ it is a false positive, probably because smatch cannot
determine that when priv->p5_intf_sel has been set to P5_INTF_SEL_PHY_P0
or P5_INTF_SEL_PHY_P4, "interface" should have been also initialized.
But it doesn't matter, you can ignore a false positive. I'm also seeing it.
Although you should check whether treating -ENODEV as a hard error is fine
and won't cause regressions.

> Just so you know, I intend to remove this whole PHY muxing feature once I
> bring changing DSA conduit support to this subdriver. I've got two strong
> reasons for this.
> - Changing the DSA conduit achieves the same result with the only overhead
>   being the DSA header included on every frame.
> 
> - There can't be proper dt-bindings for it as the nature of the feature
>   shows that it represents an optional way to operate the hardware, it does
>   not represent a hardware design. Overall, the implementation is a hack to
>   make it work for specific hardware (switch must be connected to gmac1 of
>   a MediaTek SoC, no PHY must be present at address 0 or 4 on the MDIO bus
>   of the SoC. It should rather be configurable on userspace. Which will
>   never happen as it is specific to this switch and the changing DSA
>   conduit feature is the perfect substitute for this.

Is PHY muxing a "true" switch bypass, or is it just a route through the
switch for all packets coming from GMAC5 to go to phy0 or phy4? If the
latter, I agree that dynamic conduit changing is a more flexible option,
not to mention the user space tooling is already there.

Are there existing systems that use PHY muxing? The possible problem I
see is breaking those boards which have a phy-handle on gmac5, if the
mt7530 driver is no longer going to modify its HWTRAP register.

> 
> Let me know if you've got any suggestions that can get rid of the warning
> without reworking the whole code block. Otherwise, I'm just going to ignore
> it until I get rid of the whole code block.

The obvious way would be to leave the initialization to PHY_INTERFACE_MODE_NA
there. Or to just ignore the warning.

