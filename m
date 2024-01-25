Return-Path: <linux-kernel+bounces-37999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95883B977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98AE1C2376B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E610A1A;
	Thu, 25 Jan 2024 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKdbC+nu"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88010A09;
	Thu, 25 Jan 2024 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163127; cv=none; b=PnufPzyXf5weMGqMsdnfr6Qis7xQCh0ePwDxpvkFI1IuwXHssDUmKmVS8bZwe9GIK1rlG0GnUmoffhJRhwrGaghgzTTANeoNRV5j7qxfxXscTvpsEyRyfuTYl2WOCysTWtLtTwJLWIzU9S7NYNUQvHXGs8WtVObLHYsQy13INPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163127; c=relaxed/simple;
	bh=gBN6dsC7JrG35nDtROsz36zMkg6LSDC1EzUbwrqlDUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RR94DZutKCXJEak9ggXoCT5OMa9mmCr0ieZrwxKJxv2/RK4r4nG39OfNRVNwOOI+76xcLli7cAbTdVOW4WAusd8ywbD/zi8MQIGgeRDP2MPjXy8if5/joDt7Njo7yYJupfnOpo18WD/lWO8Z6eHpZd1tEccQjDBbbYehcuAk43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKdbC+nu; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21432e87455so2479279fac.1;
        Wed, 24 Jan 2024 22:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706163125; x=1706767925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H81WNcgEuRcj9vRkVpM+pIQnKvMNYSKJ0QdzyPMV5tY=;
        b=UKdbC+nu4XmeTpKMzXHv6WGLPfjgZgoudR1gGp9KUSIwBqyTv5NLox679+yTcX7AEn
         lNkNONr+6ND3wtXp8uP+bId9OKYLFPwPvSORiZ4hjlOhtIC+l02ZZ+IDM9Fsu5dGpdgq
         qY9A162cBkQxRJRbpg8su28HTJg+NsViXdVYm4MwlV661ju+3vyJ0I5waXCr9gwhFHSF
         G4lGxLrfTVNbFpnkjuwZDKYl6VEFERxk6ddbLwJjAdvD+LxvErQpi5T+V9Blxs82xhva
         1E1hPG/C/X7VzvHlkA5gwESU034SwxBKHdUNogCpCFAOZdrpTeuPq94z8aNhVS30CSP3
         TlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163125; x=1706767925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H81WNcgEuRcj9vRkVpM+pIQnKvMNYSKJ0QdzyPMV5tY=;
        b=UOKf+FsCPlAUeksS9CnwzUuHkEqFBtHk5B+5C1U8l4acHvv5RxsGay0vN6r8oKyxaT
         TAJKY2eMMi1QGTZ63JgPxLuoQTn+d/urrQdqBQwDLDdb5uI7umAx+lp6xoAnGaFMZ6mk
         g0Al+HSLIRU2s/JfwY132FeSS9U43YoZAWoOU8ae/VofnzgipcjC/BWhCs3GrjUcIOoA
         jkUymGYPii6FL9B4eM8mld1DKPKg5GMzesKVn7eiDL2IsyltKnPjPYlfFFgXpGFy9NIl
         NaFMaEFX3xNtpMpOoxfv11X5Jmod4Jas11XUSuC50VE3MD0mEwwmv2b4BL2KX77NuSft
         7cfA==
X-Gm-Message-State: AOJu0YylhfIgyZSt3S/oA0thS6cxxegWsOPNGIl4kIjQ3E/8gVdyi+6M
	4tbeJRDtYz5L6FcWhCJEYaYrmJQa/vNfiFMcd+9W9pZrj+9uZPmW
X-Google-Smtp-Source: AGHT+IFPAbDHMb1RVDBOGKQTTme4ARS/WDZd+tSOVRZYGMKOHH2zF50aLIbedrsXEpPlEeMYn1zKBQ==
X-Received: by 2002:a05:6871:73a9:b0:210:d251:8180 with SMTP id na41-20020a05687173a900b00210d2518180mr417453oac.9.1706163125441;
        Wed, 24 Jan 2024 22:12:05 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id w4-20020a056870a2c400b0021453296524sm2006054oak.41.2024.01.24.22.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:12:04 -0800 (PST)
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
Subject: [PATCH v2 4/4] riscv: dts: add resets property for uart node
Date: Thu, 25 Jan 2024 14:11:58 +0800
Message-Id: <685eeea20960d96ac2c37eb8990e1f7112ee4178.1706161530.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706161530.git.unicorn_wang@outlook.com>
References: <cover.1706161530.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add resets property for uart0 for completeness, although it is
deasserted by default.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index f59081d4f0ee..03266f216021 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -327,6 +327,7 @@ uart0: serial@7040000000 {
 			clock-frequency = <500000000>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rstgen RST_UART0>;
 			status = "disabled";
 		};
 	};
-- 
2.25.1


