Return-Path: <linux-kernel+bounces-166985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61EA8BA2A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D201F23EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD557C97;
	Thu,  2 May 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWkWY2F+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E57C88;
	Thu,  2 May 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687107; cv=none; b=g3ICiR6OUZR5m/s4txwF9EBlA0dkE7wgrOclI5p1S0Z9UPo+9Hyz6Nt2bFuJbHJ9sPOqXLaItMHNI81tnKc8IBQkRuaYck6wfRg44S1sOc0bS1yS6pMoBHZtM9wxbuuNT3PU8hD6fHbw8jM29iCXLLEGjN7CSyru8+CVA1GNEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687107; c=relaxed/simple;
	bh=TN1W5KMMesyLRD7x7xDanKQRJfXjkWhpRfRA82DncpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1lKzjHyv/Bd7lw+0R0/53TmG5GLP7/o719PK4EBffIWc4ogG65HzE5+WeOanxhBn55BekZLFy+bBfio7POYFZyKl4Ju33cJUnlk7ddJB0wV9oeMdS5E9CN45/jh5Lykhb8az9jvezSWXfI+gmjOac4jWnZYtzM7d7sdi8YP0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWkWY2F+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a587831809eso1066254066b.1;
        Thu, 02 May 2024 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714687104; x=1715291904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGLfA1Ru+uwY6jsvAbh0LYGZzce9SwyCjBrAIvzc7yw=;
        b=XWkWY2F+yV+5HEaLkVfR9IeLBKYB2rjmbR2rzdZr8ygcyCFyUVjCA/iuvskZKh6hWJ
         kJQdx8bLgxxqiqu4/442AiDwghibfxu58WJIVxP+VN4SwlDRqwzFZx+rPnkC6hiYn9qw
         97B86ma9j+fdx9RwCT+da841k3s1HbNe5DkHY9ix6K3/yFwp5hjtjpv86V4NUHTxha2Z
         X6DCdwHuffGeIW8D8VyrzkoY8ySrHVMx4HYIGU0vwBYdJ1dmFRk5WNFzazlMDXAZjv0W
         XlZ4/TdbXhdjDSevxLCLCNDNNHjOUXs0gcaXBIw37En/njxnhuy8HdE1nZo1vu/RgeWH
         D/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714687104; x=1715291904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGLfA1Ru+uwY6jsvAbh0LYGZzce9SwyCjBrAIvzc7yw=;
        b=Z3SKXipgkOH2/u6y65XHDjGQtWe/oLMfv9luU9Xydbp48j70Ws3JXBHprcY5b9swhE
         /7GWnoCmllBtoBIrAf4igKqvJ1w79Oee1NehsZUWR1RFAylXGkyvvLe8CYlVR+gTpwaB
         Xsq3fbQHMX8IybdLYsKR7a2gG5O5N1iCUAwVhExy6WZBlov1kbwCfw04Gs6AAmkkRNO6
         J59ExM5mVNguDT6tWffBoL42Rp/zbYItvZ/LACOBL7Wu2VR10K8fI1501IiVDmr73oHJ
         2IGllIlPSh6395naLwF6VdPVqcFucihisBEtqzuHBY7/qs188KJAqDgd2sG4+bCLvqN/
         MEEA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8t7mxsKB+P/Ct5ZDSDInJjECGDavpOaz+0iCoxpcHqj2wg+NQAV9yLjjEY0eMeUkEvhzh8Qb03e0yfxpH/0doJiWxPAVqY+bfU09/P5q6CwOdqW8UUr5B2b8X5iNJk/JYlXmb4QUcg==
X-Gm-Message-State: AOJu0YwpC6ZSrBqaadQ9bppB8MKJBxSLRIbFu1/AXm1lBLreny1kQ2HS
	oZevNXnQEDbzj/LAuWhBarpqCmYQmMJCpamlKI6kStlxLzLKOZ8V
X-Google-Smtp-Source: AGHT+IFrUy3JSgdbaGiFGnJ6dFWw4SGywBWdOs7k/nVZzVBYx8ICA7jbSUKdVJTUeMa0SuR0abTjzw==
X-Received: by 2002:a50:a6d1:0:b0:56e:966:be7c with SMTP id f17-20020a50a6d1000000b0056e0966be7cmr419430edc.2.1714687104010;
        Thu, 02 May 2024 14:58:24 -0700 (PDT)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b005727bdb1eafsm926722edy.40.2024.05.02.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:58:23 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8qm: Add GPU nodes
Date: Thu,  2 May 2024 23:57:46 +0200
Message-ID: <20240502215747.2832126-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

Add the DT node for the GPU core found on the i.MX8QM.

etnaviv-gpu 53100000.gpu: model: GC7000, revision: 6009
[drm] Initialized etnaviv 1.4.0 20151214 for etnaviv on minor 0

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index b3d01677b70c..54879ae1d7d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -467,6 +467,7 @@ drc_crit0: trip1 {
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-lsio.dtsi"
+	#include "imx8-ss-gpu0.dtsi"
 };
 
 #include "imx8qm-ss-img.dtsi"
-- 
2.44.0


