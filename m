Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C77FC492
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjK1UCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjK1UC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:02:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5719A7;
        Tue, 28 Nov 2023 12:02:34 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35cd70d7735so8746835ab.0;
        Tue, 28 Nov 2023 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701201754; x=1701806554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tnM12/4j0Y+uLQFwEGrW8QMTCft1ueWMRxbG+QvaFE=;
        b=HT8CvifQxw6LqAYcaiPSd1WbyhbcDY+krssLP3gErMemeNmJh+0/79y5ghhxMIcNml
         xbXaQNclKMDv8o1UJOF1prrc2LV07ABZL3f4086Tvb7jqQgZddig9pqQmIXEuyYiVNb/
         sMI5wdiWR+7CndZkvU7f2r4/DJX5TNhONh4l8nkTtkDJzO2AXSJduU9iQ9l2qqBOK51l
         HydK/mXTQBwOYZNPGTXh2YVedOKZM1jCZEElQzQWBh2yaCwl63NT0XzRPrVevMS3HEa9
         joQ5PfWmgJyO9yqeta+8m7DqKAjC7FyiSUVAjrJbvhFwcmkm8jcMciCU/x7H9sCs50ZK
         BcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701201754; x=1701806554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tnM12/4j0Y+uLQFwEGrW8QMTCft1ueWMRxbG+QvaFE=;
        b=CstHK5J0AHFlQ3cXvxtiReRkw1hc/9xmbffy7mH7TjeALcVzdEjIVHpaMV6OGGVcIi
         Rxl8L47bfrpSAfx2iGlzoeNuyFKmGJkf8wQkuKgSepzxf1CknM/lmlDHSPQ7/uTSQFyC
         +l6TRojuAf4MXBFWvCe8jZutgeByyERHNX5yEY0B5ECCp3W3JIH7HkCk3O1KseXHMQ+r
         za3UykWy4ROGejSIzNJ9DWN07WOJb4so/6M8tbsXF9GTIqdBhelPH0UJdICRgW0Um95R
         T3gkl201x2lkqxoffBXPKkP5lPEHTA8VP18Ef2Y2F/hfRxrnPQi0WCCJ9F1rhrucd9Er
         Yc1w==
X-Gm-Message-State: AOJu0YzXpgY5s8IInATYThkiiw6+gOgiMJvxPnc3L0N4YQTwaTaluOz+
        KcOupBheY74hSh3+xdy+I88=
X-Google-Smtp-Source: AGHT+IHgeNNuAfEhRJ3eVYTVUQa6XM8bmE4W2LGAdkFF6E4X78yV+YYvMT2WkHVR9HQXxIrgA0hD1A==
X-Received: by 2002:a92:ca0d:0:b0:35b:c7a:cdc5 with SMTP id j13-20020a92ca0d000000b0035b0c7acdc5mr26703331ils.26.1701201753991;
        Tue, 28 Nov 2023 12:02:33 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9cf:804b:3499:a67b])
        by smtp.gmail.com with ESMTPSA id bs12-20020a056e02240c00b0035d21e48d28sm323392ilb.8.2023.11.28.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:02:33 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx8mm-beacon: Enable overdrive mode
Date:   Tue, 28 Nov 2023 14:02:18 -0600
Message-Id: <20231128200219.226038-3-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128200219.226038-1-aford173@gmail.com>
References: <20231128200219.226038-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC runs at a high enough voltage to support overdrive
mode, so include the imx8mm-overdrive.dtsi file to increase
the VPU and GPU clocks to their overdrive speeds.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index f264102bdb27..62ed64663f49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2020 Compass Electronics Group, LLC
  */
 
+#include "imx8mm-overdrive.dtsi"
+
 / {
 	aliases {
 		rtc0 = &rtc;
-- 
2.40.1

