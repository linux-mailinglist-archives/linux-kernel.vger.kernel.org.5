Return-Path: <linux-kernel+bounces-64955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AA85451E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD45E1C22CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392913AED;
	Wed, 14 Feb 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="K9+wPc5O"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70512B69
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902718; cv=none; b=HMPV5c9hUOZZtMFcyBt0QVwwoiwiCEljaNFHOOtqI9b3wZIimswc9X8xIAwkdMKSwcyhG4Dzj2HKTFZ1qt7GaPaIcT5i4IlUc/dPpcRWRmGBLpeFJETb/4N7u90VRghngzzFXOAOor+i2foJUT/71Iu3ySO6OnHStPLyDWZ7vgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902718; c=relaxed/simple;
	bh=TLbgnEAQe8QDK0qYRbwk6kDfqKEpbc9popgQQqa1quc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sB7u1HKNssoqg5Zrf1g+3qXurxQEcwzxWMenqI1VDINkfqwLtXUVF82vPwi317vnxPv+iLsYbx7SxjilU/DiuJ8qS/hpYANtzE/ABcBaPz4jHkQ3UySN4Bm6lUExMLrFeW4PGlYHvlPLGtxZslurrZkCuAZlQ56rvvZy3GcssaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=K9+wPc5O; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b401fd72bso3465903f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707902714; x=1708507514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y041iHqKwu8te/0ASvv6dCCwr8Scx9NdIC+ftOWbyRk=;
        b=K9+wPc5OG/5e5hKH+3L+NHXEIysK4FDawD86LzWMeGXdd/hVglUUyQC0qMdAVgeILC
         jy+iEMKChSBhYGpUUPQ+cXzYCdL7CPLgBepRmpqoNyOu7+aOzfW5c9v/mkH+TMxkOnEK
         p0Rzxyd2PmiQ7QJlmubY/N4x1uSYp0eHL1LyL51WULHCF8HAq0cos1/9DSAQ2ymdqAXu
         5UpQDSCVzmFXe6+ty6foSiPN1WyItALurOuzz87QGgEVuN1L1Vq1SUAzN9gvcfmPVG/i
         7aJnbsVJgFtsF0kX/+VOx25ed/piZJNk4tHl7d11oPeywPLso1fbM2fTlr/XTBMQd9tl
         zoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902714; x=1708507514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y041iHqKwu8te/0ASvv6dCCwr8Scx9NdIC+ftOWbyRk=;
        b=MwbEj2ovct7l/IvDhklnFthcwXpNMPz8yq9Q7odepneuh7FsxfBQp5Of/oniKBUFIC
         owLt+fHLYBOrNRORtX4dC1z3kDQBYxYEivSLEzgaaTssF6piEmZrfKywJwA+I1qjZ+k2
         vpxZva+R93qInUy1URSqu1Q/JDuNs1/3CNefTd142pviWD7aR86Xpl+oGf/fiTFlPMLe
         vdsQRStplbv9s4qrjBzC/kFFuXD+V1QHMdLgN6sJgaHqifrGrbD00Xh/UwCDqFRtWca4
         8EiVZ4AVrlpOlgfkKRo4j30JO2iLTCYaliINTmQziHVPI2KGSPo42RbjHFSXntEpOb6V
         aE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3MFVfT9dTZe+ceHJMT2sF3YHOcpYBKt5lRDAyLKeFVWxanlIm7bEawCeFEZiG2g+TxSPlCNqOG6TooXvwphe1X+JrKQst+EWNqCD2
X-Gm-Message-State: AOJu0YzgSpqoqnpJiiOvxk6Ygq8kC5ORnHC07920CpltcobAcKQ/nEed
	kPFqFhXm8LBLNKAj8anaik19wwXqGiH6vQQqXw5MU/NpyNXwtvlu3HpHeI3GGD4=
X-Google-Smtp-Source: AGHT+IEKJ1XboS81qrP+3LVVvBXCy+KpFsGJPMfWQvy5h2Q3RzLja7VykOaVmkjjZHC9fvSxpbnTGw==
X-Received: by 2002:a5d:51c7:0:b0:33b:5f40:323 with SMTP id n7-20020a5d51c7000000b0033b5f400323mr1101863wrv.51.1707902714217;
        Wed, 14 Feb 2024 01:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWFyWps/fHcpSSH0HQANSkGfvWsqyVSJ9Q7MtVLH+UpedJsKJn1mpMI8+0buoRgMBl5hkD/N7xMLb0c4pzRk7lFUl/rCu+SUXWJxAdIFR4qB9CWgrXvs6h/lwzlizPzUoVBX5gnE4er6oaiQnd/LwuJHLoFXY5W2af2mRwsGtMFDYFTxGJwelRur3m8E7ERQwdHPhZgApFJVakP8OpL7dI4wfzzaP5ZJUWOPw3zIG6AMNfNxe7VLTXv/grKY56+KDSxj/SR9tdXT94mmaSm6GB9mKJn/sjzUbPPTkhXpD/xfgrcwvOssDfwzjISs/XlW/d2ZoxofHEzHSRYXXd74BvWzwx
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033b7d9c14desm9114882wrb.5.2024.02.14.01.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:25:13 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: hwmon: tda38640: Add interrupt & regulator properties
Date: Wed, 14 Feb 2024 14:55:03 +0530
Message-ID: <20240214092504.1237402-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties for interrupt & regulator.
Also update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

---
Changes in v2:
1. Remove TEST=..
2. Update regulator subnode property as vout0
3. Restore commented line in example
4. blank line after interrupts property in example.
---
 .../hwmon/pmbus/infineon,tda38640.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
index ded1c115764b..a93b3f86ee87 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
@@ -30,6 +30,23 @@ properties:
       unconnected(has internal pull-down).
     type: boolean
 
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vout0:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -38,6 +55,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,5 +63,15 @@ examples:
         tda38640@40 {
             compatible = "infineon,tda38640";
             reg = <0x40>;
+
+            interrupt-parent = <&smb_pex_cpu0_event>;
+            interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+
+            regulators {
+                pvnn_main_cpu0: vout0 {
+                    regulator-name = "pvnn_main_cpu0";
+                    regulator-enable-ramp-delay = <200>;
+                };
+            };
         };
     };

base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
-- 
2.42.0


