Return-Path: <linux-kernel+bounces-43768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989838418AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9441C23509
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC95364A5;
	Tue, 30 Jan 2024 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU+l7o52"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A53612A;
	Tue, 30 Jan 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579445; cv=none; b=tYPG/PPv2pKQPXCTjDuxigkXmgCi68jKyopF0AT51oN1XWfSHeQkscbnTgCYle89m0L4UwqKVsd8T1KFHGI5niaq3ti9yoUQ/WUpVu4WQrSVTCl4qhSXsvX+E0j9aq+ajQgBzoEcDxP5JqQsONum8kMwPhVM8cnHEO/z8STkjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579445; c=relaxed/simple;
	bh=zghYfK+w+D8Pe5hwIYifI6tHc1B7dxbQQsfOEPj2Qjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKYOcMaXOPetNx93facf2/YC6S54rExHUkBJHaE0QaEkaLV41IhCj28jpqve4OBbX8N0SptPnQBcKHVPhDZcRzjsUVtZxf7DJYG/3G9OZIMsuM0LfktdShnqO4NoxlBNum+0lkdkgjxTZLP3DaEMyqoY+5wKc/O4bG6pwoQU1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU+l7o52; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2144c37f3d3so1238283fac.0;
        Mon, 29 Jan 2024 17:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706579442; x=1707184242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pES1Be8lnleSkC5ZTbu9K0AiFC/pOlb++5x2f9+FMkw=;
        b=LU+l7o52KTpezACM2vwqMRPNAHLb0BOoLADDXrHmSKsqLIk193zEpp6XjBkQ1HQThR
         st90BRQf65Z4oFpBwocAQBXev08oYWTxOww0w1mPgta+yj8Uj7YLSxj4PfB0jd03rn0z
         KUUtWLg+/tz/00qQBBuo0uIL8K8yiYyGQWlCe0RLQj70aSb3wX0qntRsr57dcvvVImjN
         MZ+fCQfxLdSIAmjYQvxX5vZJtkAxPbjzQStAEhFLBxxc2j3FVKk/0+GDJugPGrSCcq2B
         7riZUKuL70/J/YsopqCSakZt97Lkv9ONldjAMQD8qdgT6ouztwsfBAMlFe7L1S2a6Nds
         yfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579442; x=1707184242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pES1Be8lnleSkC5ZTbu9K0AiFC/pOlb++5x2f9+FMkw=;
        b=Q5twjAYO4+KHjn3z4SHpveflgBSbyBTb8NzCa2rxizm4MgYNQnSh47Pm6a2Z3GIBhO
         bOLAV76SoajNvrquhvfNPE8GonYctPJ+UWYlav3ZVwjimI9n3Mlsc/8DRof5R2jFaB4C
         th0/83c8bXDqOqwljMvj5Dw8tvsAK3JiMdP1nhEJCVcOUJEpUsOq9fsfzKFJxVhsr7/z
         9dT20jGVPbW+mzCSyZz+uwZhKZOXRdwi1ezfZ/HKxpynu7I6kBpJ0yxgdYx7C+ZyyQDR
         7VG4fDOM1Nkg7oYGNEt0Gv5LfV6FD1hz7sJB6BCw0Y9ft3AgujS3G2j+43vwRQz7Qkgn
         AtNQ==
X-Gm-Message-State: AOJu0Ywayx9mcHrVcFV3PSNliK2rSr2XyaHkA4HWcqFQhPCXp7h7cGr6
	+Shj96hk7yQrb/8ugTfHRSxFcObWVS32lQnkRHwBxL0ojBlnmdhl
X-Google-Smtp-Source: AGHT+IGio/t2XsWrOwzRM9pFgzBhPyxcBq77pykVY6hy8s3dWZl1ypoMVNAtpSg4J8UbdBCL7VCC+w==
X-Received: by 2002:a05:6871:6ac:b0:210:ad08:8f47 with SMTP id l44-20020a05687106ac00b00210ad088f47mr3292623oao.36.1706579442391;
        Mon, 29 Jan 2024 17:50:42 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id e12-20020a056870450c00b00218496d80b7sm1894855oao.29.2024.01.29.17.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:50:42 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 3/4] riscv: dts: add reset generator for Sophgo SG2042 SoC
Date: Tue, 30 Jan 2024 09:50:32 +0800
Message-Id: <b2f5d7cd2d3fccfc00cf4563d2dd7363b0fa2fca.1706577450.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add reset generator node to device tree for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index ead1cc35d88b..eeb341e16bfd 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -6,6 +6,8 @@
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
 
+#include <dt-bindings/reset/sophgo,sg2042-reset.h>
+
 #include "sg2042-cpus.dtsi"
 
 / {
@@ -327,6 +329,12 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		rstgen: reset-controller@7030013000 {
+			compatible = "sophgo,sg2042-reset";
+			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@7040000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
-- 
2.25.1


