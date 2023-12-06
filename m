Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4B80759A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378778AbjLFQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378367AbjLFQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:46:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C5D3;
        Wed,  6 Dec 2023 08:46:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1cee2c1620so141557966b.2;
        Wed, 06 Dec 2023 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881201; x=1702486001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QwJmoDP7/rLy9hDhj5qWhLLbFCrWOxFl2C6kKd4gBI=;
        b=lkr0L8/pSK/6RL1zWrAyCRsQjlQrjEJa0Y80vHQNZIiEoVJCVqxbe+s1zlFZQ5Xf2j
         ZrDKt8VdYl08nd4xqoOEub3NiNRVbIprYFkRF1l0eBs+g551GFpTYRSkNieSi5/Qgs2X
         jq+WW3og1jlPF07Ukn30fUXu0+SfGbBhqQL3v6dl+MqXNzbyrGo/AIFHP6dBlyodQGFY
         Hq85CDQQia4QlHyfHkR6wHoxTxXjNpgHNYyHE/Nu0RKyF9kDJxYPgWpD/nMuKlcJ9d05
         Ek7mUeknj3ZgpPQlw2rL6GOOD9j7W4Gsqv+4bR+3z5kvIbGKeZNOi/C2cQBkwg0iWDKI
         2QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881201; x=1702486001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QwJmoDP7/rLy9hDhj5qWhLLbFCrWOxFl2C6kKd4gBI=;
        b=L40EJKdsNgB9U7I82NwAcdnn6rDcVoqN22yQTM6gWrhMOxk+PBSdaJbnUozgqHNvki
         IFiSrUK4HrcfvAS8P/CrBDiSvk3CQ1LvUDVeH1v5ITO/lkpq56Tx2Xb1EPjcNoUooZmY
         w+87l+RXIa4/rXmTLDSH5sRlZeZT+BBAxFIXMDHlcIXIxo0yzRL4xjMPPZzcemLgIYA4
         2wFI+i8Om7Ym7UwXAKjdRjjVgpbyoZ5SJxf2d5zFyhUe94JjklW6VlzgjY4JbMR6CNU+
         qXGnUq+nlC1xOlxWkFk09z/pd2I2xtYybggcs2pleD/Vg/MY5TAtBKSV95aeXw9B7CFk
         gTCA==
X-Gm-Message-State: AOJu0YxP77v+T6bV7+uE4qfnUkiZqPQN2XGWYfNQzhgIAhfGDYpj9s6g
        z30/kdA5tI2lpw/pVn01SISOIY6anDRzHq6s
X-Google-Smtp-Source: AGHT+IECTT/0X+/zDYxURdYW+z13BzfSniEDH9msFja4V03SypYu4m/a7tHO6Fy7o7GJfk4diH/uZQ==
X-Received: by 2002:a17:906:739c:b0:a1d:ef9f:6ba2 with SMTP id f28-20020a170906739c00b00a1def9f6ba2mr323825ejl.285.1701881200826;
        Wed, 06 Dec 2023 08:46:40 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id lj12-20020a170906f9cc00b00a1b6d503e7esm146930ejb.157.2023.12.06.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:46:40 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:46:38 +0200
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
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/3] net: dsa: microchip: ksz8: move BMCR
 specific code to separate function
Message-ID: <20231206164638.sizbc664kxv3enks@skbuf>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:24:24PM +0100, Oleksij Rempel wrote:
> Isolate the Basic Mode Control Register (BMCR) operations in the ksz8795
> driver by moving the BMCR-related code segments from the ksz8_r_phy()
> and ksz8_w_phy() functions to newly created ksz8_r_phy_bmcr() and
> ksz8_w_phy_bmcr() functions.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Let's see if this does anything:

pw-bot: under-review
