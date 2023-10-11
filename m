Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69207C60B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjJKW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjJKW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:58:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC9C4;
        Wed, 11 Oct 2023 15:58:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa891b645so16176439f.0;
        Wed, 11 Oct 2023 15:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697065106; x=1697669906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLch9HsfoI9cTA2tQiy71eRcGUZJUOwHvkzXf3I64H4=;
        b=OpjjQ1eRggnBJZIIzcQ5/BIzqKHpczftOC/qErvGPGOSiXODr+LceE7j0AbRBdaBBD
         FZhpM4wsIdEOSjF5R7A4Nj+roNtOcrhdEcq9ILm5UToZDGLeIDrXkEFlKMduD9+DtuUp
         HxnS/+yXx3+4ZiS106SV4p8Ws0IpDY6SSmTy4afOPqt9EdpSYaKWVDO6eiRANp7Jf96y
         wqYnHTvEDeXTXiLMoWTpbsBUIStVQ8jo0M9Dalj01bOMP3sYqrZl7ZbTy9rLf0h8zKsK
         py8k4rmSuwZ12EJRMQI93gnxGSY2MbJnBeI6QF7NHDC51UmjbARGBLtgE7FiKrKGWWs1
         R8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065106; x=1697669906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLch9HsfoI9cTA2tQiy71eRcGUZJUOwHvkzXf3I64H4=;
        b=rvxxiTAOlHeRG5ZvWVop1ANIQxhLUAaAWCkJxAnBLeo1LKRFaxA5+VBeXs+YiwHSQ1
         T3AAwcxeEfweKxevd9YlYy2d5Z1ZUrV43VyBH2DefWrmKp85ws9i71rLh1bgwV4c/BAx
         YrCQZ5qG6HlGWyDlLUxq5EpnQqA63sVmp37QaifUw6NbRpp1IY/rO7U14uVn1BEh0H9y
         4m52PX58x64Kr4swn9NKLFNJgdmjbEaFzfbJ27hgCkycZDmUVx5OFkyjjVx9PK5/dpe8
         BMhLVOvO/HNYUGM67z963nSr44Q2FQB0OSCMAqPdMRgEeMQobi0cxOhfpCg/kOG/v4LL
         FhSA==
X-Gm-Message-State: AOJu0YwNGkvgZJwRCq/D8xt4luRxQ71SM40Ds6BaN4sZIUun9b03FE0Q
        wSLzXl+KnsoqkOnJAM2uQWo=
X-Google-Smtp-Source: AGHT+IHnvROW82y1Tnccr6trK2U7/loU8oQJJ9IHEHJ2pzI6iAuI2skprA9wZANbac6bLcZIhGT2Mg==
X-Received: by 2002:a5d:9c1a:0:b0:7a1:a22:e664 with SMTP id 26-20020a5d9c1a000000b007a10a22e664mr25863002ioe.17.1697065106696;
        Wed, 11 Oct 2023 15:58:26 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:fcdc:5119:7b2f:72b3])
        by smtp.gmail.com with ESMTPSA id dq15-20020a0566384d0f00b0043a1f6dc8d4sm3632691jab.4.2023.10.11.15.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:58:26 -0700 (PDT)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add turing
Date:   Wed, 11 Oct 2023 16:58:21 -0600
Message-ID: <20231011225823.2542262-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011225823.2542262-1-CFSworks@gmail.com>
References: <20231011225823.2542262-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Turing Machines, Inc.
(https://turingpi.com)

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..07f164e1ca2e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1420,6 +1420,8 @@ patternProperties:
     description: Truly Semiconductors Limited
   "^tsd,.*":
     description: Theobroma Systems Design und Consulting GmbH
+  "^turing,.*":
+    description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
   "^u-blox,.*":
-- 
2.41.0

