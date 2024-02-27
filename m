Return-Path: <linux-kernel+bounces-82664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C18687F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB52CB21C60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4514F61C;
	Tue, 27 Feb 2024 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjdHLj94"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C64EB5C;
	Tue, 27 Feb 2024 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005568; cv=none; b=h9OQuv88c1UkrHbW7pO4qf82vdkoghV7OmKZqkbpdBvbhqLAmQZ00ojTNuUU3+WiuO1s4lzSexwe/FOc35qx9KzWP2T6Y5QNy4P4idq0dE04BEOJkDkVNgRlW96vJ2m1WUy5ZbmzzMGrXBW9ao66ICU2uQt5kyVnAZAn3VZDK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005568; c=relaxed/simple;
	bh=4M7fRzFAX7nsSVTFE3AoHpe9tjXohZEDZe/P1TQ0vy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzVCG31gwuDkxwHJ+Sl2HjzSDVXh3tUTf2M/IsX6hA8+/okdeldla3e4hBVOQeu3+cRjsMiBhhn9g/PdGk1cagYyabfuu+Ij4mhAD41OYeJt7jD7ECJQr+YVvBtmDhX6kaQnSdCASUthXA2jKHH12rUN0bteiqFcRTSxpHzDCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjdHLj94; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c794deb6cdso176570539f.0;
        Mon, 26 Feb 2024 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005565; x=1709610365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3StZ/L4nuFpFQDzbrXKyCvxa0NGv/xoSnCZP+Jf5BgY=;
        b=PjdHLj94bBv71SFx7xihotRWoHh/3G8tQ89oXfVmNt5r/+nFYozZVcjXFfHj20ep3T
         nZ1om7r3YiujMly1cHXCzALM1UZmgD764sOrDwjQiAkNTqm3XLAxsRVzSN4iA+9FHy4u
         Y8pM25V5rJy5vyp7oEwGcZuWjMlKHGtYZXWjczrChtFfCQm60OS2aPMKMD/xtwMW0RDn
         6zkdiK1aLAVWwUyzkoX3xPujc8Zbrz9fxJlBPRfqpGZdJBKVw/BXWXWywpJiPfkEN1m+
         4noo+729mRhjquWUl27BIUn+ARCFd0pgZMbn5yappyE06oUIYzAacpcqb13wyqOPlqN2
         lpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005565; x=1709610365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3StZ/L4nuFpFQDzbrXKyCvxa0NGv/xoSnCZP+Jf5BgY=;
        b=TMxxSHzURdacmVCbFk9oq9eCmIYAwe/gcGOagKIX343hqZgS4KndlDxhxmRBK8NBVc
         CrclnUhKATcd++h3rAOy0sgpgocRGBjVNt5woFtAtn5bFfT2eIvQl1KcKuk2LxV1DETS
         cgQFMKhIzuUekDTkMqaQrfsJxc1SzzIAzzRp10TUne9X80siT2GIz1O9swVZjrV011xy
         5j63S6rwxFSWZMqrZk+9Ho7dHYMtB9rYqjxyci/ARKFQdj6EKDoJxVdivMM53bfM5kXU
         hSaKvwRAneaU1CwJtEdjMOej7gukSS0gtQSdu65ZUhmDAyPl3nVtD7bMsz2fl3rZ9FVZ
         DwRw==
X-Forwarded-Encrypted: i=1; AJvYcCWGOPtbE4ukDA0n1x9LoZAuZLSVi0qcqdn4oxGgIwdXkSCjcuA81blQAXMmWBGW1Nei08KeF15cmH81jCs6GyBO/BqX/3N5ocLo9itTG+hENxDu641ZbcgcgwFY9PbVn5NRNWh9wkveolod4YOWW2asnosjK6aRWojf/sbejwrfGWbFP+HYcptKmCl+
X-Gm-Message-State: AOJu0YwyMrmrb45Smh2oFAYZ2KXFHKAQHLEv89NQ6DlFl9kRjve5tU/Z
	OyISWZnUfjKJb/iSvTBef6vhIJ0qOWhEwcdS6k0ehhUcPboKac/0
X-Google-Smtp-Source: AGHT+IGknTA/wjq0GgL2gXiP0e5BIWFd6q9cFl4c3fjpz3qCOZ+8Z0cNOWFM54PRsvcU7URA2vl92A==
X-Received: by 2002:a92:4a03:0:b0:363:b95a:b55a with SMTP id m3-20020a924a03000000b00363b95ab55amr10583339ilf.16.1709005565596;
        Mon, 26 Feb 2024 19:46:05 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:46:05 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: renesas: r8a77960: Enable GPU
Date: Mon, 26 Feb 2024 21:45:35 -0600
Message-ID: <20240227034539.193573-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227034539.193573-1-aford173@gmail.com>
References: <20240227034539.193573-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU on the R-Car M3-W is a Rogue GX6250 which uses firmware
rogue_4.45.2.58_v1.fw available from Imagination.

When enumerated, it appears as:
powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.fw
powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a77960.dtsi b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
index 7846fea8e40d..0f17bc3f2d9a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77960.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
@@ -2558,6 +2558,16 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu: gpu@fd000000 {
+			compatible = "renesas,r8a77960-gpu", "img,img-axe";
+			reg = <0 0xfd000000 0 0x20000>;
+			clocks = <&cpg CPG_MOD 112>;
+			clock-names = "core";
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A7796_PD_3DG_B>;
+			resets = <&cpg 112>;
+		};
+
 		pciec0: pcie@fe000000 {
 			compatible = "renesas,pcie-r8a7796",
 				     "renesas,pcie-rcar-gen3";
-- 
2.43.0


