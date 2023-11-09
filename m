Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74C7E6768
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjKIKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjKIKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:07:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78E3250
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:07:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc329ce84cso6282015ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699524428; x=1700129228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ireTpCfN0lAkDpS22SoHjbEWTJUzLlFEUnZESQj8kY=;
        b=V+U3PVkfF5uxOrXpN8BVULqi55XRpztj0ymrjnICLVyJmKd10JQNEw0fITvjirFT0S
         kik+ceQR3+ctMCdte0jR42wXZWRkoVmrmRqVtcCGiAdVfi/krDrfZC9zTyL2/U0yP2EW
         xRwymNhHUdCT7ZuaIklIrRPeOvpXWr5Vn05ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524428; x=1700129228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ireTpCfN0lAkDpS22SoHjbEWTJUzLlFEUnZESQj8kY=;
        b=HM0rBDNNaYGJP5cEwWqaXALCOuvbxQo08UwnAtAEhrYGFdnS5Jme1KtbqH51miDcEI
         gGdP+i3h7JCl7WjSOY6ZEUvRX+3uCNXctXrDOwzcBpE4g1mGkq16OByRELFPczjVNawx
         F1gQsou1fHg5zQXyv5xMHxqv/2kc/N78+SgwYp8o+6xTM/77WgcIclTDvAif3gTWz+wv
         bNWZWectUoXX8DDIZJzAZGSmUtj5ZJOzEDvfrVtHJD37XiA88Xz2T76dDTTABwLg0/vu
         HlrkVlgfhUcRaVEiEl26T+P8VKwsmBY4oefdhEv3cf+Wd2IO9uJpT4yHojqZuB3fhbQD
         0Rgw==
X-Gm-Message-State: AOJu0YycKy1KskkWaoxEORnAOOmN5+eMmhymx3v9vMPNyeQnpXBO1Cvn
        6X4afu0YwS/D8FhLsMViO+9m2Q==
X-Google-Smtp-Source: AGHT+IFYLvEMMUZ9GrbH908WNtQJvicj83HyjofOmfRWFZrCflNz7TaOuy+rHHNosFSsiJ8aNjo+JQ==
X-Received: by 2002:a17:902:ecc1:b0:1cc:2ed0:5ab1 with SMTP id a1-20020a170902ecc100b001cc2ed05ab1mr5039394plh.17.1699524428617;
        Thu, 09 Nov 2023 02:07:08 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f57:d4c:468c:5daf])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001c60ba709b7sm3127511plg.125.2023.11.09.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:07:08 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v2 6/7] dt-bindings: arm: mediatek: Remove SKU specific compatibles for Google Krane
Date:   Thu,  9 Nov 2023 18:06:03 +0800
Message-ID: <20231109100606.1245545-7-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231109100606.1245545-1-wenst@chromium.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where the same Chromebook model is manufactured with different
components (MIPI DSI panels, MIPI CSI camera sensors, or trackpad /
touchscreens with conflicting addresses), a different SKU ID is
allocated to each specific combination. This SKU ID is exported by the
bootloader into the device tree, and can be used to "discover" which
combination is present on the current machine. Thus we no longer have
to specify separate compatible strings for each of them.

Remove the SKU specific compatible strings for Google Krane.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a4541855a838..ef3dfb286814 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -186,9 +186,6 @@ properties:
           - const: mediatek,mt8183
       - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
         items:
-          - enum:
-              - google,krane-sku0
-              - google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
-- 
2.42.0.869.gea05f2083d-goog

