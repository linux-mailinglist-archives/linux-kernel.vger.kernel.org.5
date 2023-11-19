Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19327F06F2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKSOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:50:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A248F11D;
        Sun, 19 Nov 2023 06:50:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso2741947f8f.3;
        Sun, 19 Nov 2023 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700405423; x=1701010223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZBy2FynzJySNwoFbdoLCjlxvv36qfeTMfoj03QNsxyo=;
        b=N/sTR+mGLrN3YyOkshGHeb7Z4R8mW1Mzq3GPp0oKhmTNwKpsUX+Y0cRrjJYdO5unkB
         quTHmKrvnPP5nEzxTTPZk1jztZ/hLvcSXXoUmw51VviOh6BuLJK4n+bC96drvemafXJw
         FrqUYpEzxnNfqFKWssXFB8FHRMjFW7t5b7UfzUQ0lcbPqtQQDSdG25rDbgsirhgvl6nx
         LMvbKPtdH+QxsScJJyotCqj0gVMxozqB2ESLpSARebhl9gNTpvySTwkW92j1RICLx+4G
         SXZxV+68w1YAc8W+4I6qgzQTXWdPuwzxAwbSiBtguvDTGrBuXG09CmPEs51bCJBw5lv3
         xbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700405423; x=1701010223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBy2FynzJySNwoFbdoLCjlxvv36qfeTMfoj03QNsxyo=;
        b=MQLQGd3YE+inesUUUTsPJdDfqDDxkuEBQnxQ1HlG7VIJOf2bqt8I/X8/A1WyFLvAM8
         RaWMleZYtxIajgw8L/zSAaANZFdAByA3T3XSg46hnVgyhi+21rl26rMSK4xy+MSVo2Pr
         wj62ts2HH/6jwwBiWZ7+6ZRrC+K6zg7tjTEnDApBZ/kVPV7+/+IgbdhwJ2A8tE1lxCeC
         couhX88dnidoKTIkWxgT+lcGTvEyHYTdCcoy/Z9nmnKu0flb9WnaYxZedKri4feim0Oi
         mftbJXY+2Gc1QOfwNJIfP2PUWTwb1ywOWX6tjcUWS07UBMhzR7sDUvRlhPXHsZ6CDQDP
         je+g==
X-Gm-Message-State: AOJu0YzUsw47081SzXGmwhUkdku/TJOsxEGsBqGhm05GY1Plua39Bkfp
        Tpb8dFvEPBpZnxalEaLjfH5dsApDZyg=
X-Google-Smtp-Source: AGHT+IFhNrGV/AQm0viGUiqf/wW1h6qaQk1NwH4o8i5PU8ncxwa2CSxnIhrNxRFvNQ0LPFzLDJDNnQ==
X-Received: by 2002:a5d:5f49:0:b0:32f:7d67:baf1 with SMTP id cm9-20020a5d5f49000000b0032f7d67baf1mr3589905wrb.35.1700405422767;
        Sun, 19 Nov 2023 06:50:22 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm6885022wrq.78.2023.11.19.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 06:50:22 -0800 (PST)
Date:   Sun, 19 Nov 2023 16:50:19 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 03/15] net: dsa: mt7530: store port 5 SGMII
 capability of MT7531
Message-ID: <20231119145019.6gz4j4crwgyp46bf@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-4-arinc.unal@arinc9.com>
 <20231118123205.266819-4-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-4-arinc.unal@arinc9.com>
 <20231118123205.266819-4-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 03:31:53PM +0300, Arınç ÜNAL wrote:
> Introduce the p5_sgmii field to store the information for whether port 5
> has got SGMII or not. Instead of reading the MT7531_TOP_SIG_SR register
> multiple times, the register will be read once and the value will be
> stored on the p5_sgmii field. This saves unnecessary reads of the
> register.
> 
> Move the comment about MT7531AE and MT7531BE to mt7531_setup(), where the
> switch is identified.
> 
> Get rid of mt7531_dual_sgmii_supported() now that priv->p5_sgmii stores the
> information. Address the code where mt7531_dual_sgmii_supported() is used.
> 
> Get rid of mt7531_is_rgmii_port() which just prints the opposite of
> priv->p5_sgmii.
> 
> Instead of calling mt7531_pll_setup() then returning, do not call it if
> port 5 is SGMII.
> 
> Remove P5_INTF_SEL_GMAC5_SGMII. The p5_interface_select enum is supposed to
> represent the mode that port 5 is being used in, not the hardware
> information of port 5. Set p5_intf_sel to P5_INTF_SEL_GMAC5 instead, if
> port 5 is not dsa_is_unused_port().
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
