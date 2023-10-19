Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719C7D006D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbjJSRYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346209AbjJSRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:24:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B886106;
        Thu, 19 Oct 2023 10:24:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5071165d5so7635461fa.0;
        Thu, 19 Oct 2023 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697736249; x=1698341049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/zqeOQkV5Ij2D5zPpymnUDq7SB+Oj23OhQ/qVXUG5o=;
        b=jp0TaNsYaanqqSYgxyoxLbb3Cz/oYop/lzkS+pGFFjpNWfMpJ3TsbDtNzelNKjxAMr
         wlLUALMrQaZnV1UnxjcSfeHFB1Zz6iLWYe/Qem1iM26NoCxzxcFH4rVsJ9yo1XCHeh4S
         xO1OZljuLcEncCT58j2MuQqMIYUmVPAOtuj0o/VDdVMP3sFtLlDlzZi0aayPT3qXS+Vx
         SzNqC97FK6syGjshPX/xDcDkVQSUghzAb6YmcmngVoJ1zDBGqmZTwclLcwS4iQyXfbMe
         szRttu8+BaaC/Ekn2pLOJ4UAxstVng7lPZyO4gaOmepEAVMbymyZ9Mz2fxGL89NANA5F
         PwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736249; x=1698341049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/zqeOQkV5Ij2D5zPpymnUDq7SB+Oj23OhQ/qVXUG5o=;
        b=JyImvssAM6NYg80pJNXQG1W86OdWUZw4g55Pv3d/lfFIkGnRpZPrE3vVytEcWoWhPv
         X5aQpQ5DLA9DRQHa4stRI9EeTKdYod7MQ08mfR1WoF5U5ACH0lNxrXSFDg36ZqEtCw+L
         dRZlPgAt2fSaWBBYk6mbEvOzhpV+2bBV4ygoJiQzXLguXOkClSOtTMr9iuU6thLo8bSY
         shOHdGgClMNkifZqyRgD3txbcZ2nXYtTQdp6XvSkuX4BbvaXm7TYgCloI3fNOXJbO4e/
         5oCZOH9KwtTRARjqM3p1nTMoWMKD8KkeJvU49tcMAEdIkCFYco6WmS05YZx/9AAN8OvL
         iYgQ==
X-Gm-Message-State: AOJu0Ywx+aT3zgsRQ2jcgnUde3qhISb/roO7wqc9FHv7LEZlFZ6KIyVd
        XynNGSwFLL2lDhrfSxXgoQs=
X-Google-Smtp-Source: AGHT+IFOw+G0mFtRzGo+CK3VwZVyhV10AQqo65SjRE5z51eHuvhIQ3ZPah4D1An/d8rNjzTfFagkaA==
X-Received: by 2002:a05:6512:41a:b0:507:96e5:2ff4 with SMTP id u26-20020a056512041a00b0050796e52ff4mr1927887lfk.52.1697736249056;
        Thu, 19 Oct 2023 10:24:09 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id cn27-20020a0564020cbb00b0053eec17c889sm4761807edb.23.2023.10.19.10.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:24:08 -0700 (PDT)
Date:   Thu, 19 Oct 2023 20:24:06 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 9/9] net: dsa: microchip: Ensure Stable PME
 Pin State for Wake-on-LAN
Message-ID: <20231019172406.7gxe3quzt6cldd3u@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-10-o.rempel@pengutronix.de>
 <20231019122850.1199821-10-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122850.1199821-10-o.rempel@pengutronix.de>
 <20231019122850.1199821-10-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:28:50PM +0200, Oleksij Rempel wrote:
> Ensures a stable PME (Power Management Event) pin state by disabling PME
> on system start and enabling it on shutdown only if WoL (Wake-on-LAN) is
> configured. This is needed to avoid issues with some PMICs (Power
> Management ICs).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> index fa8d0318b437..9e6f1e4b57b7 100644
> --- a/drivers/net/dsa/microchip/ksz9477.h
> +++ b/drivers/net/dsa/microchip/ksz9477.h
> @@ -62,6 +62,7 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
>  		     struct ethtool_wolinfo *wol);
>  int ksz9477_set_wol(struct ksz_device *dev, int port,
>  		    struct ethtool_wolinfo *wol);
> +void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_is_on);

nitpick: Please synchronize the prototype definition with the
declaration (the name of the "wol_is_on" argument differs).

>  
>  int ksz9477_port_acl_init(struct ksz_device *dev, int port);
>  void ksz9477_port_acl_free(struct ksz_device *dev, int port);

Otherwise:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
