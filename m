Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857827D0045
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjJSRK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjJSRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:10:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EECF;
        Thu, 19 Oct 2023 10:10:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so1352058766b.2;
        Thu, 19 Oct 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697735422; x=1698340222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3EG8voekuiDu8+1WrOXrX0b/udoq4F/afXtMElXqbE=;
        b=S6znQmKaaKY8rFw4hGY3y7As2MONtPbPGLYbZbOJfw5Zje4w+QiTTiVf5yjHi2Pd9M
         ABErBCeZe6SjvS4MVJmzRUP/Zz/DYxrHwRpjpmLEq91oX+px9gZY5tqRzDY257PBicBk
         WteJY4OcHDROx4RW4tFxcAFhcHwaU7cePpG895PAVf2IsP3ddStOHjo8SuJgoJ8OgLyr
         43Zv0iPL59yqz3wgIkHYVFP5ooxbWB2OmHclYXho7NIaA9D3FUNbWKMGOGZ1sXFWD+35
         Uh3jqFYcBY1ofHYomFZXvwwLlIaNQTprEmRH+6tXT3awoQecjMRkdOked2KAKRWBW7VG
         OXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735422; x=1698340222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3EG8voekuiDu8+1WrOXrX0b/udoq4F/afXtMElXqbE=;
        b=p0ecfXIPnUT+P8qyn8xMLgAkOqMKpIgDQ2SYr2zYmEkgmfChS7GLnKbZZN149hteh6
         +uam0AklZsHAAdapN2yl94MN6wsLbSvkoRt73163/VXRdGqYI/zGfCmHA5j2ub9ZHaON
         XdQKsut4FiqOS7KqQFRc3dp+GIPDYLyyjg2171tgR8NzDP5ZFgn6Fp2iRTQkHMZ4phoW
         6sF07eZ6SqMXTf0SaA0wdM8ZD+tYE8jyTiaw3eidzCTu52DyeQU4J6ya/okRaGN2iZrR
         Q5ZJTqnCil5ew1lYdbK3SLtq2GAKeHlFi4i/oTroR9FP4ck4wTQA8oLuB/1HCCi7i79n
         +zZQ==
X-Gm-Message-State: AOJu0YwPcK3oKqYzqwwIF0r3fJge/WfjUmqIiuGQexIs33WEr88KW8XW
        l4Vr4ZwBK9kUiJNQElHOses=
X-Google-Smtp-Source: AGHT+IGb+lVx1YdI/MeXvJ0XTmH9AvemAYqYeJu16szeci0NKpPRvdgw8ZLbOdJXBsSavccDYtT8Og==
X-Received: by 2002:a17:907:980c:b0:9c7:5186:de1a with SMTP id ji12-20020a170907980c00b009c75186de1amr2669932ejc.8.1697735422441;
        Thu, 19 Oct 2023 10:10:22 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170906a0cc00b0099bd7b26639sm3966785ejb.6.2023.10.19.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:10:22 -0700 (PDT)
Date:   Thu, 19 Oct 2023 20:10:19 +0300
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
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 6/9] net: dsa: microchip: Refactor comment
 for ksz_switch_macaddr_get() function
Message-ID: <20231019171019.h5er2mdarrjk43o5@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-7-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122850.1199821-7-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:28:47PM +0200, Oleksij Rempel wrote:
> Update the comment to follow kernel-doc format.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
