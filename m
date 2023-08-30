Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5870F78DC53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbjH3Soe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbjH3Ng5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:36:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3911F;
        Wed, 30 Aug 2023 06:36:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so50797865e9.0;
        Wed, 30 Aug 2023 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402612; x=1694007412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+yYt261pz+/xgkSEVEKFRDXXydq1rLbWs9CkNiRFcE=;
        b=SkA2MQ0T3jHqj/Imwmt86BL42q36WabVeBWdSmOXo88rLz0HW4Q5tk6IZr95+SNoam
         52s8k0iq7/tuQ8D68fNFOdq6LLgOoQJhCd+Oxu/wrayGlQC+4cwLzs/4cNzQD1pbfwBp
         NCcxyrN3zDXVEHC6lzmWenVlbf8bKih27lMkr9KON0oIzbrKiKlF8KSRLG3rkKXylt33
         lrxRriznpTgNBE86Wapfegj7r+vKEO0ak854U27hSiWJPDFmI1GUPvOvwWx1W2cX+aOb
         h05/fRKQ7NT6oE/rQ8gAySDNpRpFT1KA4OkUl2Sws6HFmdy0u4eJDgzAaBsGLWMpHZzX
         84MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402612; x=1694007412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+yYt261pz+/xgkSEVEKFRDXXydq1rLbWs9CkNiRFcE=;
        b=BLi805SaZeghHbeeeEzG9pZnxTk1Nwv2ZHGbDcVLOEC+o2ghJ+21CQ7qY1nqm8F45e
         j0AaM43s/p+2raIDh3phliBFwhIcVnUR/LV0SL2OwYamcjEJrZxgWhKBff1+UrOM+Fnx
         1US11rq5JtMICg45C3YQ8FbiMbTOm7NL8wMuNpSiqcnIlJOdnTH7jcB1zI+BJsJ/dgAO
         c7Glss8JM1g0AsdzUW5MlI6r1EdVk9ueIFLyexOWHV3RUPaaz2G6eqDQuUq12exbq1mW
         t4ZDkGXguxPaFoO6/t4gyCiSAR3q3PlbpFw7huTuVUOyNPnllHfdSl9GB202yrwgKj0k
         QDzg==
X-Gm-Message-State: AOJu0YzIwOlMO1k1Tv+688w98ZZoU0DA9wv32PMiRhIJcDgSSGd0aD0M
        q66kaiOAzmCnaAsL0idBGQ==
X-Google-Smtp-Source: AGHT+IFHs2vmbKqXRIV/i344l7tlR+MJQTafcUypRW0zFptWbaKo0LC9bhGXq9FZrklPdlc/NpOn9Q==
X-Received: by 2002:a1c:7710:0:b0:401:bf87:989c with SMTP id t16-20020a1c7710000000b00401bf87989cmr1985691wmi.34.1693402611534;
        Wed, 30 Aug 2023 06:36:51 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:17bb:6f65:50d0:b82b])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c2a4e00b003fed70fb09dsm2326343wme.26.2023.08.30.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:36:51 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/5] Add USB support for RK3128
Date:   Wed, 30 Aug 2023 15:36:19 +0200
Message-ID: <20230830133623.83075-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While interestingly the dt-binding for the Innosilicon usb phy found in
RK3128 SoC exists already and it is exposed in the SoC DT, it has never
been added to the driver.
This patch-set adds support for this early version of the phy and does
some DT-fixups in order to make the 2-port host/otg phy and the respective
controllers work.

Please see commit messages of the individual patches for details.

These patches have been part of the pretty huge RK3128 bring-up/fix-up
series [0] which I've splitted-up now, as suggested.

[0] https://lore.kernel.org/linux-rockchip/20230829171647.187787-1-knaerzche@gmail.com

Alex Bee (5):
  phy: rockchip-inno-usb2: Split ID interrupt phy registers
  phy: phy-rockchip-inno-usb2: Add RK3128 support
  ARM: dts: rockchip: Add USB host clocks for RK3128
  ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK3128
  ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK3128

 arch/arm/boot/dts/rockchip/rk3128.dtsi        |   9 ++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 147 ++++++++++++++----
 2 files changed, 127 insertions(+), 29 deletions(-)

-- 
2.42.0

