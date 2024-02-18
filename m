Return-Path: <linux-kernel+bounces-70366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C168596A4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7F11F214BC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC7612CD;
	Sun, 18 Feb 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mr8/TtfT"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FA605C1;
	Sun, 18 Feb 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708255214; cv=none; b=fgVWsnSRiTSIZRrIfe97gEeD4deALoh7eKpdOqOQcNR0rzAtyrwhWBYgaYnmVW7SDs1Xtc0uFkfSlbp/93d/V2/+frCqRJW0F3GCUUWOkj20cdlyeBmCi8x8+i0hMkMOcz66rbJdfleQ4JucMrV5+dkC8iKaI+lXaFe36eqETlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708255214; c=relaxed/simple;
	bh=01uEamBCavFydbAcBggySOmM7cLkRDbHtkRxbsPIoAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSKi5r/s3oLEKCyE1NMan42WglHIoc8EmyP09gtw8u8PJQFb0xbpUVT3TBvSoX9V3KzrF9F/L0cp/g8lYd0MyjuY0QajXZkvJPoeYGO54kZmE/iAzFBlFPucYnx/FZ6N+vlWCWFCOp5BDkZv+DRmIQ6TUe6iKOAPqfb+HIKIWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mr8/TtfT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511976c126dso4165427e87.1;
        Sun, 18 Feb 2024 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708255211; x=1708860011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc+9ufaRqp/U0tG3njMbdgBMjcqe6JIFtCG+eSPdHpA=;
        b=mr8/TtfTGYFszkDfTL/hdmoWCZYs5rxzcBsowKOzN4rO4vbFVPyERrWZJS8suv8uXf
         hKjT5tu3iBA5Y/C7yGstuNTcuPoXne3NnY8Xtvq2GEscD/PEn6szO2uM22pPokDwPbJB
         LXB3JtkVpukiiOKdDzCAO5VA8WaTQOSgPF9nJ9QP0uOKs4i4TSZNw5B1KYbdzky819nY
         G/fz5qwlNlpKafXCjco8kkkiJLZusP9BrEFLsRjIse90d6lj01SOhfVNke5VwV2KSl9r
         TOzN4QlqIV/o0/5DOq1WfBi6nXNVfYcnS2rj8IdhRUmFZ2xrEtbR6jO+/CJVhYfA4N6K
         +ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708255211; x=1708860011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc+9ufaRqp/U0tG3njMbdgBMjcqe6JIFtCG+eSPdHpA=;
        b=Kbm9EjqweM9RmhlzZLUqwUKxuGJvDFWtQejbcj+IiWZUtAus0Sr4UiOkeNWWq9HD5e
         w1gkyCfVuLdu6E7HoiNW3fXmsVFH0CrJCgtsPv74a9559BIxXeuPntIwME1TEF3JP7LQ
         1mc0jn383eZtvEoffZBhvAPOz1CogJRY2xnYrMxQj9RRJ+FBxjJ+vf4ucWwAMn255mTh
         9ZvGuuz1kr+/3LhWs13eqRfGLBBYcGqVeiv7K5k+oQaW0V1IXnFS3RQm8UW7EEybzBOy
         BfGja82mDy5SmE1ixmnd/l3igpaDpkk2BgT+O8pHy9H5/blN8t6BvffOb6ssyC32G87x
         FGSA==
X-Forwarded-Encrypted: i=1; AJvYcCXzgN99ty5dSwU9HioFyEUFygfxkPy1+zIp7beNdVO8EzlwWQC5YM2DPg5ENg407n1AMqQ6tfgCuU+7B1U10l2i5y26OrL+U2jgYIsV
X-Gm-Message-State: AOJu0YxOvpHHrBJXWtYkdflmteOXdVgqaoo25TwNakyzXbUH62vftiU2
	VjekAkaEpjyMot7IsflD5r1NsXlT9c2jR67fZC43Jsk5wEext7Y07hT8EPPK
X-Google-Smtp-Source: AGHT+IFuy/qa407pwFZKRQiucbHr+xagmur1IutAT5SBIpOLHQI1PyAMGH3dBUK4Gjlr6DUAZlU8IQ==
X-Received: by 2002:ac2:464f:0:b0:512:9f9b:ec50 with SMTP id s15-20020ac2464f000000b005129f9bec50mr2683699lfo.38.1708255211380;
        Sun, 18 Feb 2024 03:20:11 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id di25-20020a056402319900b0056401eb3766sm1675190edb.29.2024.02.18.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 03:20:10 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/3] ARM: dts: meson: fix bus node names
Date: Sun, 18 Feb 2024 12:19:57 +0100
Message-ID: <20240218111959.1811676-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
References: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a few binding check errors as the node name of a bus should
be "bus".

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/amlogic/meson.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
index 8e3860d5d916..8cb0fc78b2af 100644
--- a/arch/arm/boot/dts/amlogic/meson.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson.dtsi
@@ -23,7 +23,7 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
-		cbus: cbus@c1100000 {
+		cbus: bus@c1100000 {
 			compatible = "simple-bus";
 			reg = <0xc1100000 0x200000>;
 			#address-cells = <1>;
@@ -206,7 +206,7 @@ gic: interrupt-controller@1000 {
 			};
 		};
 
-		aobus: aobus@c8100000 {
+		aobus: bus@c8100000 {
 			compatible = "simple-bus";
 			reg = <0xc8100000 0x100000>;
 			#address-cells = <1>;
@@ -302,7 +302,7 @@ bootrom: bootrom@d9040000 {
 			reg = <0xd9040000 0x10000>;
 		};
 
-		secbus: secbus@da000000 {
+		secbus: bus@da000000 {
 			compatible = "simple-bus";
 			reg = <0xda000000 0x6000>;
 			#address-cells = <1>;
-- 
2.43.2


