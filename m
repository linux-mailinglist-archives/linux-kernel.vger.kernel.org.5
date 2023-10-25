Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF07D64D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjJYIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJYIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:22:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2EB0;
        Wed, 25 Oct 2023 01:22:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b44befac59so486620b3a.0;
        Wed, 25 Oct 2023 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698222120; x=1698826920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvpdJed8NCe/yTREqi/Xqq5XpahV3XtayL2qO/vF1bc=;
        b=hKaPJB6rUJ/OPCFcqGLTD6z8QY89YzvYem+rL0ZyLov/qiaQlOQScd7OBLjvM//ACW
         dQ63D+Ry1ncSTH/trgi9prplJuba7yjn78GmybjeCY7APNEDvsrK9AhCME0CRLQt6NyZ
         UbeeARe5+HO5yaZ0oec7RZO47QLVSOrFBdECBlbJA8i8dct+wkV1E4uSN5F1SwlgSDTb
         45TFlQ+x63ykWTvxkq5NI3LCL3XyrzR1V/Vdx+qPDRqmL8ddu5iUCN/sIfNkICjjG/dh
         sXdiK06WuYb+06bvoQYz8NkilE5ocWk3njilX03VZR/d/FlC2PpfFT4ubSrh4j+qxaoH
         fQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222120; x=1698826920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvpdJed8NCe/yTREqi/Xqq5XpahV3XtayL2qO/vF1bc=;
        b=Afk2c1DqSwxi6dgUS6UwIWF1MksHgeT5x0H/mZluMCZD949tOSPySfFPv/JmYjNfvI
         0YdSrBBuu32r4R5I/jmw/QWrOKTdtcooE7U0t1gXgwZXTJgRaTOokATuFc1JTjnrvDix
         /RX/hWQQDNAK+ahpnjkWNg7fOLX3qFNRAfgPD1ggHpEVlwXejJixxESMSaS72YfbQIIV
         uK835mQlxKdO3gXvmIjPJbotBBVfyNiwtonL2+ex7FTSO31w0SSfQmpMdPHsggECA5eS
         4dBqiV2A/pMsONr4JjmEz82DhrMVXdwcDuMBY0okLwjq2hvsU/useA5Gqj/CfUhTalXr
         2BKQ==
X-Gm-Message-State: AOJu0Yxluw0kQHpjI+PElidUUTqNB8ZclbTV5MxLfpraYGjUToqP4LLI
        SzOdBhAvOBM5Ozmj9nBlLsoFPv0hOt3njCh/
X-Google-Smtp-Source: AGHT+IGxHaO21Y7We44VFn56IIIjQpblfIOHyJnAwflJ2icjvRi5bnX2MikIvWC7cwv6ba89Al9keA==
X-Received: by 2002:a05:6a21:6d89:b0:159:c07d:66f0 with SMTP id wl9-20020a056a216d8900b00159c07d66f0mr6177544pzb.6.1698222120380;
        Wed, 25 Oct 2023 01:22:00 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e38c-defd-6dc9-16c9-6f6d-2997.emome-ip6.hinet.net. [2001:b400:e38c:defd:6dc9:16c9:6f6d:2997])
        by smtp.gmail.com with ESMTPSA id y66-20020a62ce45000000b00690ca4356f1sm9255860pfg.198.2023.10.25.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:21:59 -0700 (PDT)
From:   Wei-Shih Lin <frank101417@gmail.com>
X-Google-Original-From: Wei-Shih Lin <Weishih_Lin@novatek.com.tw>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Novatek NT519XX touchcreen driver
Date:   Wed, 25 Oct 2023 16:20:52 +0800
Message-ID: <20231025082054.1190-1-Weishih_Lin@novatek.com.tw>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver for Novatek TDDI NT519XX which mainly used in 
automotive display products. This driver is different from the existing 
driver named as novatek-nvt-ts.c in the path drivers/input/touchscreen/. 
The existing driver supports another Novatek IC NT11205 used in Acer 
Iconia One 7 B1-750 tablet.

Wei-Shih Lin (2):
  dt-bindings: touchscreen: Add Novatek NT519XX series bindings
  Input: Add driver for Novatek NT519XX series touchscreen devices

 .../input/touchscreen/novatek,nt519xx.yaml    |  60 ++
 MAINTAINERS                                   |   9 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/nt519xx.c           | 995 ++++++++++++++++++
 drivers/input/touchscreen/nt519xx.h           | 130 +++
 drivers/input/touchscreen/nt519xx_mem_map.h   | 262 +++++
 7 files changed, 1469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/novatek,nt519xx.yaml
 create mode 100644 drivers/input/touchscreen/nt519xx.c
 create mode 100644 drivers/input/touchscreen/nt519xx.h
 create mode 100644 drivers/input/touchscreen/nt519xx_mem_map.h

-- 
2.26.1

