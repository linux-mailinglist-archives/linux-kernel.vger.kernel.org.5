Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C07B203F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjI1O44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjI1O4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:56:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8A1A3;
        Thu, 28 Sep 2023 07:56:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so16580968a12.0;
        Thu, 28 Sep 2023 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695913010; x=1696517810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=kiu6Dmt2Zii0CkGXZkIqIhPptBiYWWKZWAICTri+geLezajApzSMNwK2/GuiJjkA3a
         bOUFSDQMJO7c22lWTDpx1Vo3+1rlZOvkXKBvmUxbre69NfrWqDnxKgDRMk/nOzEv2bsu
         5041v5PKuyvDq+zKSlDN5rFSQDg0B/RboWo7BeGP1eMC8W6VcC6VZKDApEBN44ctxPfM
         tOoD5fW+uustjWV4aOWKQ2PwP+0eimpqadne1YSjFCKnM3mPOEX0AzjLygHF14SvGiQt
         ERrFBI3aFN7VojF51wRU5U9tMl2Lx61RJDlnWPhWfdNCsTm8coQqgB2Fcar0gF59jX8e
         ol/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913010; x=1696517810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=g6nWK6MaUda7WeYqguJezp+mnT74HLh+HRzjoq54tS5/uL5E9JYUuGRMADuY4fXgos
         GIGg960+x7419c7CKvHfNYLpSkhuB3bDYB9Ka/UKaJYnIw8W7alhQ/IOXUCRktKG+0uc
         KFjl46mnP5il53bBBV1HoiNulbe067nReJlesrfjfXKTBbhofyeTgEoSryuVqQHB8HuY
         3O0v0Xieyz/c3d07+JLhlQxSklKe4NzrD4A4m6rL9nfZBPM6rxLpNIUzNvczpyErLuLO
         5PidXt++bK8DlBMSlb2lAitbsjlElW+w0TU9KUXnXYxNPyvLQ7h4npLX6qViTMG6jORK
         XAuA==
X-Gm-Message-State: AOJu0YzHWLBcY6kwrtj+gwjgViL9dVhlpR4/UHhBLC2Ew3riEnjxr4MV
        sMh44poWwV2OVUsMN8hMDZU=
X-Google-Smtp-Source: AGHT+IEVB4admZ3Mrg7ELXqYrob4Z2PMMwJFxHp4rkL/a1z3cEMYf6coSZiamcMIh3ORbWLY69XKxw==
X-Received: by 2002:aa7:cf92:0:b0:531:2b7c:513a with SMTP id z18-20020aa7cf92000000b005312b7c513amr1330608edx.17.1695913010440;
        Thu, 28 Sep 2023 07:56:50 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-54-79.cust.vodafonedsl.it. [188.217.54.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402068300b005256771db39sm9784459edy.58.2023.09.28.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:56:49 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Martin Hecht <martin.hecht@avnet.eu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, Icenowy Zheng <uwu@icenowy.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v9 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Thu, 28 Sep 2023 16:56:32 +0200
Message-Id: <20230928145638.2268331-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928145638.2268331-1-tomm.merciai@gmail.com>
References: <20230928145638.2268331-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Allied Vision Technologies GmbH
(https://www.alliedvision.com)

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v3:
 - Collected tags from LPinchart, CDooley, KKozlowski

Changes since v7:
 - Fix company legal entity from Inc. to GmbH

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..4763fbfcd936 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -77,6 +77,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^alliedvision,.*":
+    description: Allied Vision Technologies GmbH
   "^allo,.*":
     description: Allo.com
   "^allwinner,.*":
-- 
2.34.1

