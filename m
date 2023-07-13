Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D31A752708
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGMP3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjGMP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE2330F9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:28:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so13451645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262133; x=1691854133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk7c3gz9VhsIx4qVgTGY12ilcIgctHPAd46AqzeX33s=;
        b=cvKVgzY0rvgm4OkvM4Iyp4VIJ+PMtQ0TtSrTsq3VM3ULcOvJcio8bd6Sm3OT8W5bSv
         ijBer0POVkuOR93O6WwiHa7TAwLdQXpWx7mykj/+4qZznjSfilLlZLzcxUOyPWK0YIe6
         A189xDDkFTFaE14+wZpmkUGOw2fw+10Od0z05HNnCGPj160YV/yl1DOqRKHwRTd5HeCz
         OKwhmrRDlCHqDeQsvvdUPxHL0mYQiKmTCni60oP/tyRSv9E910w/Fol7Js0dSeMlsyxb
         thgC0pLBIaIIIFh8BqSkeh+ETqabVWiRNwx8KV460nyLaQiACy5oWAyD+AoJNwFQJ6DK
         LHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262133; x=1691854133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk7c3gz9VhsIx4qVgTGY12ilcIgctHPAd46AqzeX33s=;
        b=ftl5qH5q3zlAyjoKaNQSMXHT0zIRgvrcO1dAX/bybXIr8ViQo9IBJCePxJOMLAKkDh
         qnNjY1Lv883WoWDbQT+OBNqqIo1fKtCBo+lxeVtitE2NnsGx6wQNE5MeHj6wzPm1hsCn
         uL1cZUIXBVGIm8+VTx6d9SC7xzKyBLUU9t2EwkxdedMtuG2QYdru++EpIX6OpaY7TV5V
         WErQzV6+0E5e9MKpYvdTa2jVGVTpd2g/lBOOsRX8MIKs3fZ21zT25qyO6knBuKVoXyc8
         PcJq59Ob09R8Prkuojr8T6md3b58eXLKqGD5MMheTtv3DWH2fneN8PtygNDyJzObUiLW
         igXQ==
X-Gm-Message-State: ABy/qLbMvYcBJ6hQTg/FAiUX0qsvzfN6D2jUPW0GYMThR99K+qPVwNkz
        HEAZVI3tv9c9Rlzfc19jNj9RVg==
X-Google-Smtp-Source: APBJJlEWUoeuf5dGWkDvdxMoAKsG/Z2DJAjtQ1HCUphj+qd1f83rh/PkeY7QfHENnfGc0LkAkETEIg==
X-Received: by 2002:a05:600c:3105:b0:3fa:9996:8e03 with SMTP id g5-20020a05600c310500b003fa99968e03mr14988wmo.10.1689262132820;
        Thu, 13 Jul 2023 08:28:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm18563121wmi.18.2023.07.13.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:28:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: net: davicom,dm9000: convert to DT schema
Date:   Thu, 13 Jul 2023 17:28:45 +0200
Message-Id: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Memory controller bindings have to be updated before we can convert
davicom,dm9000 to DT schema.

Please take it via net-next.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: memory-controllers: ingenic,nemc: reference peripheral
    properties
  dt-bindings: memory-controllers: reference TI GPMC peripheral
    properties
  dt-bindings: net: davicom,dm9000: convert to DT schema

 .../memory-controllers/ingenic,nemc.yaml      |  1 +
 .../mc-peripheral-props.yaml                  |  2 +
 .../bindings/net/davicom,dm9000.yaml          | 59 +++++++++++++++++++
 .../bindings/net/davicom-dm9000.txt           | 27 ---------
 4 files changed, 62 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/davicom,dm9000.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/davicom-dm9000.txt

-- 
2.34.1

