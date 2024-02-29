Return-Path: <linux-kernel+bounces-86369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F10686C482
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB704285B38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9357337;
	Thu, 29 Feb 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcR3IJE3"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB957304;
	Thu, 29 Feb 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197760; cv=none; b=XBUYErqXxUSljlbxFEx6dbGBLGiyfK1yiboPs5P+YgccgVHSOIVjGOABeh/iJ4Qw7IiwKXV95vPwzKxOpbIScq1r4GRJoxdS+XbH7I5C4HKz2rtJVpuHtswgWD5/5utTLYVMZVB75/M2WuGEETD6kQBNPzw0bvMT95KIVA5A+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197760; c=relaxed/simple;
	bh=pLcp/aPWuz6dVPZ0ClAp3zNEnHgyX8mxb9Yu5E5+fj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKcfCF/8D4oRKHRjB+SCZo02LpcppidbLXkO7VyI7kBMhypKUJ/+2+5wR0YyX99ZsN6iYIBQuIETsuBEzCpPB1ztsc4w0BjS9MZa0bQ5cnp5wCFY2IrzsAdx/FCx+bhf84f52hW0LMSi/lPjjta4HV0/nbr1WRIpZjtBdQQ3tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcR3IJE3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso529745b3a.1;
        Thu, 29 Feb 2024 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709197759; x=1709802559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3EH79m2zjg+0l2Fo/85HOfKEzKcJTEn64bTAoTpEgA=;
        b=OcR3IJE3um8/OOO2RWl6TleFQdf4A91KGNXZfxVi8RUiAdglP/lr9bH3iuks6feEFP
         AItnPTJ31grcGQ0rJ7LOgayi7KGGksTmxiBcVlKvexml+VTWhA1YK7JMW160eedRrU03
         Z+w/L2nCZNLXYQrBmm9p/uv+IWAsz3L6QKcD4Jbr3SmLr5Pf4bdHn/hWZtVcXsCFqyTS
         ZZrMAc1VQqZ1i9SBft1F64vA0WDunDCNeiWB7LeNwkImHj40UFMUHkmyPmHo4+TsiWJj
         +z9t+yUrlV8F0BmWjhwj5/KLz5twk2YPdGjL42nHGS6V8xRMTHIUkWp7JXbtRhbLuiST
         84+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197759; x=1709802559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3EH79m2zjg+0l2Fo/85HOfKEzKcJTEn64bTAoTpEgA=;
        b=B9F9o2N+FJ6buEX3o9Zvn2kOFzMFl3ln1fpM6L41kfZJAwoeD1wAsPdQ3lIPI2BGNI
         dwI5XE8GyoSwCDJQTv3Y33TgttuJU75RI98d7JPs55/aommdbJyzyaBdq6ezUQo9mA+i
         wS1hgYXGk8iNoHSN9BflZHKdEn84y6uPEmLU9CEbe2baKuknjB1VO17ahH0NbloslNbU
         6bmSr25VWpXNFZG8KuEKQY1otjky1Lmi5v6VCrL1IGQbNjAOE9n6bysYMivARm9yxF1i
         Udx0pCE0w2UJxTpyFcjWF2YH7KeO6UqOQLECpbqN8/GwrtGl+86+ALubd03e7ezHYnU1
         peXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV09CfaQH1b6D0SW3PlxnDlc/aCy49tdEQ59MEl7P55XRhtxuKmBM6DcvyHeK49D5XrkUfN5400oTf/SFJ9/hcEeh50INDRqj6Au/is16Ci1bYwtFtkPurQ1cDa+8toEJ8mStIp75Mypg==
X-Gm-Message-State: AOJu0Yzo5sA0TC575BsYyRH5WIl4TGbE5pTy4MvS+PmlkRw786KzNONp
	099xj+ZfIt9gzYpb9sQP8WtqsUSMPDFSXvUb+eJ4XnhzrMPrkcU5aq4BYs9rMIc=
X-Google-Smtp-Source: AGHT+IFxXPuQx2ANlQfZU8eDVwwYhTH173O/ISHyhBeYCFuuLoI0Y3/MzddDlU5+xfQcysXl6i6noQ==
X-Received: by 2002:a05:6a00:985:b0:6e5:584d:e511 with SMTP id u5-20020a056a00098500b006e5584de511mr1925870pfg.17.1709197758834;
        Thu, 29 Feb 2024 01:09:18 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id e6-20020aa78c46000000b006e0447d48b0sm805883pfd.23.2024.02.29.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:09:18 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Thu, 29 Feb 2024 17:09:12 +0800
Message-Id: <20240229090913.1892215-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>

---
Changes in v4:
- The new compatible is a BMC for a ASUS X4TF server which use a ast2600-a3 chip,
so correct string to asus,x4tf-bmc.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0047eb4ab 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


