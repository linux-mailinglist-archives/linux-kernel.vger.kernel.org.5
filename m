Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773647CA5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjJPKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:47:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155CAC;
        Mon, 16 Oct 2023 03:47:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53d82bea507so7559137a12.2;
        Mon, 16 Oct 2023 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697453236; x=1698058036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+48sY2mCt5Sm/YpA0tYQ1OglqW65/llPrp6rg7x088=;
        b=WJPN3yVxJmiR2VKG8a5NRrm9epYm9MYy7G8ROAt5caw/7/8ba1dffqbZblVZvLe4ru
         D3nC2HT1ohDN11aIkkah+QmnN5Gt3jKEctm8d+hbKYHr+J8f6xAGjF5XLUUY9Iz9cp2m
         7gs7UkUQcNTeNDcCLM3ScXyhM4pEIr3N+WyYma1/p+n/akFMDsv3BWrr9g3plHsA3uXv
         ibllHldWQ9hsofAvPIQP4flVkA2/lAZ6NXZx1IG2sSGYqf5NbkJfrlalmSk4fiQ7fMke
         kOT2OpzcFOulvDfViu0qDGXNroVnSOi7ym6lG67EqcisMVHPvxVvTAUy38YarmrGnRmK
         0Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697453236; x=1698058036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+48sY2mCt5Sm/YpA0tYQ1OglqW65/llPrp6rg7x088=;
        b=UPvorveIbg99xnsjXbcWRc14womkBQtdlSpsF6nlbV8HN5tQ6YzpPnO4IT0GCS8929
         2gxU+DNh966p86XWKZ9Yremz05N8P1IrWoqTCf+rstUTubkPlgR3HWRSHIEjL8wAnCeo
         6+yLyX2sFqb52pqF8GwAANyRwGbCznNOK6rN8Y4DOLoRIObx4R3woIxoftKjJTQPflYf
         dteJfpKsXCZxaJTBjkj/ov4nNYi4s+HUMYj0D9q46QIasIqST2c8p/sqXy2AkZG+dAus
         NOEvaTMP2zY3J4tsjjF0zZCxU0T5wGRjPZ5r12VZ3d1fjEWWtURvuJ5wNYin+iPnX6LG
         RUDQ==
X-Gm-Message-State: AOJu0YysPlScLYYe54hKG1A3vYfh+Hd5B1RcIKChsLLs5B7TOAZWlu5s
        I0CmVj7k8C9wrq7VLPJmEIs=
X-Google-Smtp-Source: AGHT+IHXT/aLR/uxanC19FG7JSmsoYwhws3oyMnBrRVQL3gX1VwuZn90b9rQj8kM3/dozhmTVdcCcw==
X-Received: by 2002:a05:6402:388b:b0:53d:ff30:921 with SMTP id fd11-20020a056402388b00b0053dff300921mr11388615edb.18.1697453235779;
        Mon, 16 Oct 2023 03:47:15 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id l16-20020a056402125000b00536159c6c45sm15095756edw.15.2023.10.16.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:47:15 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:47:13 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231016104713.pg33afclsd56tavq@skbuf>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-6-38cd449dfb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-6-38cd449dfb15@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:12:59AM +0200, Linus Walleij wrote:
> - port@a is not normal port naming, use decimal port@10.

What is the basis on which you are claiming this? How do you explain
"ethernet@30000" for "reg = <0x30000 0x4000>"?
