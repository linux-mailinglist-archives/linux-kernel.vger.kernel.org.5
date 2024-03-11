Return-Path: <linux-kernel+bounces-99323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE287869C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0594B1C20FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587953E27;
	Mon, 11 Mar 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9bYxrq3"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38E53E00
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179286; cv=none; b=uTFWjO10fm3gQ1h43t2+u4Z0kZzMyhIOe4CF3AnxtGd+Qg5mUpHz682Kf3NXrYxkHwSUZ2IJIN6fLcO7/khQIrcWDBmU/90zptbtWsXQvNVREuk6OvLnnEOpiRW03fRWEsqr5QEFi3yUt5vDD4Ly9of0stPShIviVz3ogAX7bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179286; c=relaxed/simple;
	bh=imBPUSGabX5HBFgzKPX5esrERwd3Fx6o9pGvNyZ4AbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJSpEiydDbd4Is6An2iPnqI2OyPL37XsaT+akzTKDNBx7iWK3jd1GtRwgdRgeE3m2PuIvSsh3reAK+XepYc7dICx8pwRp+hw0aMEzEZes2eAT83d07F3cVU4KL18sFfD0iwW18lp/Fg2tVk3BEbVHXLbsytrGhSpKl82IO+tt2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9bYxrq3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so2549910a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179283; x=1710784083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecbBCBCe15Y100JmWAWGOrkx0ptRHMQJFdIhslePcMo=;
        b=X9bYxrq37D/+46bdPS3dC8zTRF7jPmKxZ4LSJor0cObzEfyGlsElBXaRuqa9b+9K7U
         a/vWwqvlno/LFBBa1koIZ2JOPg9r+VcdgEufQVvu/oaXaLuVTq32hDj2CBGq5oDr7Jsr
         zQ1s4tMxaMy2PKWwQQ5i2xD2Nc9hHMBlTf17iWId7FqulHuX8FtASouflJ0Tp0JUZIXG
         AIFlH+MFt2M5ct58V8auKmPsAm+C70WSiYspmJmYU1EIcLN4iC3dSHvrEeWmw0aD1ebM
         5NoatPQlNw06MG8w/KzQcXSVXjasbbU8D57blRRkpEf8n8rvEDtO11pUa6XTMEdCZ8Sg
         BCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179283; x=1710784083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecbBCBCe15Y100JmWAWGOrkx0ptRHMQJFdIhslePcMo=;
        b=JZhXAKJj4BpAHm7iNiMTHJgQKjwGOTkWBOAFtereCzdlef6n+33wqCVQzNixcCq+4f
         ujT6FUQhFtJ7JufQn/Di5OZCanhT0CkTSKPtfUPhWP/ld5n9xzEwSjs/xdiWxIGvmqc/
         WM3KpTxkYJlL9tjJGSDbhVebydcWqREauaAVD5CyfLmG0n+dtsf3bluAIgvP8g1I887x
         +uU6QBaQbvgzYJ2ZeagwhEjDIP7hjZOse2D2/BnDwyVbuLgJhkssGVP35+GsPtbwEoOX
         1w+qAo2Lsn1Eigo62B95VuU5P2OI+5LG5GvSjLEojLUgXB/MkrygtpiH5YntYJVFR5to
         V5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVy4Z/JQHVghpDnv+ZU+hzUE/rbfDJSd6RzeS8xDdGvCqwkbBRg4crqzW+JGCJFoxY2zDUwMFZDo8HVOOUKESgED8LkLbJc15b3MR/Z
X-Gm-Message-State: AOJu0YzqpT9Ogv2vnov+ic8Q3KQSaza3IKBI697ZEfSZQVTt0vv16Iia
	HnRBDIb1AgFg9yzfcWweIJWX3K8s2E7491T0Yu2rY4ZyG6s7QX7D
X-Google-Smtp-Source: AGHT+IGO67PecI1sgFey0dTacs9DhW/y+oL7j9v6XDu7UhBwavGchYeiuRmbSt9P4nJkX+FcQLQWew==
X-Received: by 2002:a50:d483:0:b0:567:e812:e44e with SMTP id s3-20020a50d483000000b00567e812e44emr4840330edi.18.1710179282652;
        Mon, 11 Mar 2024 10:48:02 -0700 (PDT)
Received: from localhost.localdomain (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7d158000000b00568525ab2e8sm1757060edo.55.2024.03.11.10.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:48:02 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
To: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH 0/3] dts: arm64: sunxi: add initial support for t95 tv box
Date: Mon, 11 Mar 2024 18:47:47 +0100
Message-Id: <20240311174750.6428-1-ressetkk@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T95 is a most commonly known for being a box with a pre-installed malware.
It uses Allwinner H616 and comes with eMMC and DDR3 memory.
This device comes with two versions - one with AXP305 PMIC and another with AXP313 PMIC.

Kamil Kasperski (3):
  dt-bindings: vendor-prefixes: sunxi: add T95 to vendor-prefixes
  dt-bindings: arm: sunxi: add t95 compatible string to list of known
    boards
  dts: arm64: sunxi: add initial support for T95 AXP313 tv box

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts

-- 
2.34.1


