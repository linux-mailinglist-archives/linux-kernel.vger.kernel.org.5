Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE17E4F07
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjKHCou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKHCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:44:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251D184;
        Tue,  7 Nov 2023 18:44:46 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c43f830566so1120052b3a.2;
        Tue, 07 Nov 2023 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699411486; x=1700016286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaWMuBZsE77+sJmzkMMfCx99qAMSCTeUv3FWDy05Y/4=;
        b=E/kDbkb5g9KLfaN4B+sN+5ndyodcKYCLHb/khydo1bGUMexCFfGLHdZaVQEqPr3aON
         KFpQHAfn5bH5jYtz9C/1jD/3vE89hNc7vosReT1beUaEwYXBwHtTt++hYoQOAuuWji1D
         K9H+daXgcTPTj62eRtqDNSCk2P8U4mbc9XnxyIRtmwGpk6QH2fFl5QxBCF67vnY18FeL
         4JCgimuW9O/r9WD0NoOIqAR5rDwaYzJhatZyMuaktkKvzBu13pbCMjm4UlBoT6naIE/n
         TtisD07ZqQVmN40Axoi4jLcvVWrlwyuuFGT1g51+6uUwhrD4AhXRX7fLAAKoYkmaFAzT
         ku/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411486; x=1700016286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaWMuBZsE77+sJmzkMMfCx99qAMSCTeUv3FWDy05Y/4=;
        b=WYklshAYonF0KojviWEU5n98O6TQp1latQL2zWoywRFKeTQ65JX8Vc6jXT7deN8H9f
         3VDttPyzRifn4Uzubvjh9RBI+62EGkfDkMHsc8Rsx+Ek/UYqTOCAW74DxqUr1/HAA/2C
         QKEbUguU1sbDCW3y3W/DBCidfg2AjEVgzGHFZOgCckUzrxK7UU94QO3kDgQJnXURVWFa
         joBH4npnOcjXc43BuberU7STUz7OOTFbAz2TQAyw9+zMN0B3fmslN/f3CLqBhOq/iBbn
         1yCrVBOqRLDap/FEIK7yCjjcqxjX5DjCCWnjkfh0YY792rSJJQMVeCO/dN0iwe3ZHMUj
         BnGg==
X-Gm-Message-State: AOJu0YyXmTOWjbYNTocHUTqNIxWvRMQip7hXcf8/s7W8kRQR+YKo3OSr
        PTnI6WzBv+T7xno4iwlw33g=
X-Google-Smtp-Source: AGHT+IGLMtlPMSTy5c8cTvFdPewxETTXsWBn2fW+mmDuiGwsHZY5LTVTvUB2UkgKOIEtHXCdQjf/8Q==
X-Received: by 2002:a05:6a20:7289:b0:180:1b3b:d560 with SMTP id o9-20020a056a20728900b001801b3bd560mr962670pzk.41.1699411485695;
        Tue, 07 Nov 2023 18:44:45 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027d8300b001c62e3e1286sm501681plm.166.2023.11.07.18.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:44:45 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
X-Google-Original-From: Peter Yin <peter.yin@quantatw.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: Add MP2856/MP2857 voltage regulator device
Date:   Wed,  8 Nov 2023 10:42:18 +0800
Message-Id: <20231108024222.2026546-2-peter.yin@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108024222.2026546-1-peter.yin@quantatw.com>
References: <20231108024222.2026546-1-peter.yin@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Yin <peteryin.openbmc@gmail.com>

Monolithic Power Systems, Inc. (MPS) MP2856/MP2857
dual-loop, digital, multi-phase controller.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7680c8a9b4ad..8dca0864709b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -117,6 +117,10 @@ properties:
           - fsl,mpl3115
             # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
+            # Monolithic Power Systems Inc. multi-phase controller mp2856
+          - mps,mp2856
+            # Monolithic Power Systems Inc. multi-phase controller mp2857
+          - mps,mp2857
             # Monolithic Power Systems Inc. multi-phase controller mp2888
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2971
-- 
2.25.1

