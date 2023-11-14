Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8A7EAC63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjKNJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjKNJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:02:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02BD41;
        Tue, 14 Nov 2023 01:02:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso800283766b.1;
        Tue, 14 Nov 2023 01:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699952553; x=1700557353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LNIN39+Aj7M4A6YQfAnOhGmOC2b8wD5dyMrtu281XE=;
        b=M4UyFwmxZR0t4oueRq050W7YLwiI4wMs0ewLREIFIMucWk4pzAtRy7nD5/ohgtFKY7
         iDtjD3qHUQQhciUHKwDQXRWROK4ycxCBBjLMIEQj7+1PWWOYNz44RS9vSIh0Swc5QJ9W
         ifnXl4IXC6KCT980PMtzROtXiv+J4laEI8zuk5r0G9RTDp/9M/ZYpVhLf260fA1olUWC
         XScuDY44ELjrTVJMNxFnF8/PdKpiwkWOTYXjFJywR8p43C1+eKWadhAAKV4oI3tJoay4
         Csja62rFis5ZewmqcVORHeFjUPchkQqqG+a7mC2vOJFUgDswNWdIven1K9QCHtZdnjjG
         jC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952553; x=1700557353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LNIN39+Aj7M4A6YQfAnOhGmOC2b8wD5dyMrtu281XE=;
        b=wdg3l6ZvOLxxtvZ/7AZ0R4Wbj5wl2CaZbFL/Vf76PfWSR2CJvqUJhUN0x+nkqknwOe
         tkg5ab67OorV8QutScCcLoPAMrWs680hqu8XI11nlgoo/byftVdQlBu9vuyUbB45I/NL
         dBzoOuPKSKk9k72FAsutt2IaGqZf5h2ZmsH7yLB6nx8QHjbgO1F1UuGf1LUm66vT2QnD
         4+B94hswQ8veBf5Q1kwTHNiBjOG4FoDQZ/0hW2gT9le1vDJkApQReCI5o8jKXNGNmToY
         Zrh+ymOqIYKP8bjEbuuoi4u9AMJ8TxQ94TxQvyoGaGB3c6PRFVlbwM1B2uRRDFkbrJDm
         hbig==
X-Gm-Message-State: AOJu0YxSR39YwuOIvbtwAvO9ARO8hvUblYmOSig2ILolnMDSlNqGKbWM
        WRh82UBoqOVA1XMCjmOtM9A=
X-Google-Smtp-Source: AGHT+IGdYabMGBjjkjrwaRkLDSGjP6nnC0Vyrvo7t3c0RnrJMI5FN/lqu/h4HYIOf/pvlksxJJLb6g==
X-Received: by 2002:a17:906:6b97:b0:9d2:e2f6:45b2 with SMTP id l23-20020a1709066b9700b009d2e2f645b2mr6820576ejr.71.1699952553024;
        Tue, 14 Nov 2023 01:02:33 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090652cb00b00992f2befcbcsm5241185ejn.180.2023.11.14.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:02:32 -0800 (PST)
Date:   Tue, 14 Nov 2023 11:02:30 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: tag_rtl4_a: Use existing
 ETH_P_REALTEK constant
Message-ID: <20231114090230.sp73rajibhmhrl3l@skbuf>
References: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:50:30AM -0800, Florian Fainelli wrote:
> No functional change, uses the existing ETH_P_REALTEK constant already
> defined in if_ether.h.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
