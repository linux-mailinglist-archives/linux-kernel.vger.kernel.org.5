Return-Path: <linux-kernel+bounces-160805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCF8B4312
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308A51C22999
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F878EAD7;
	Sat, 27 Apr 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="P+O2NaEv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC88820
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176660; cv=none; b=dXavSQB1gNAHagcj1Hx1TT9uHy3HjJwLzzEExALDn8caetjCx2QF1xNmkCyGH8SLotWnvq6ARMCdr3fAmvH2+q+dLmApU7Nv6Z2zvvfVLNifkFQ9lK7It87X+9ddY6aNhsP8aPHq1rUcW0h70yQzGjFio0N5xA9a8/1B950G9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176660; c=relaxed/simple;
	bh=WiDmXN+gE+Oj1XaVtmKA94ORr86HXlbvJPY4osUU3RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qO4ytKM0irSuXkF23ZKW22b50D75RP5YD3NvpkwxpuTWi1UxnCELErmE6TIVHG8Znq6yexhzHhud2TLZJeDwivqC1Id0EOe5orhbCN0BibpfblyOWN0ajvtkA4CP5bIS8EqKIrTKj8FC1rVTYq9jYWyQQEB+Xd1skBsYXyZzuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=P+O2NaEv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso2511548b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1714176658; x=1714781458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5ki95UEfr2z0VC3x180o/+jUI7myGNjHePyoD0A2y8=;
        b=P+O2NaEvucAdautkgsxIo6Jo5RBzeU4JcwmPAuYK1x5NrqZSbeoFzTxSKEn4/DkVws
         EJ95cwKtO/dMlSkZvpeQLhb71Wne+r5MA7fcTQ/4QnClEBxYfKkE6wRA7JHtFwu7nqlX
         qgLJoRY4emxSwOe2J8M3WuaKD1+RT7XLE+7TGupMUUqVbmBOHtBvpPKn5AZCQ5eC9QIS
         85TKCygJX76qtxw689rMZn+q2O3yQPmBJ7ZI/uvChqlxz2gPy5V1jt4aAnIarBaxKuOp
         568vvZ1TlWmSdtpxH/twA//afvRlg6kg0N69cRCXMOMZjFU/RDmatlH++G5EL9ce46E3
         71fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176658; x=1714781458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5ki95UEfr2z0VC3x180o/+jUI7myGNjHePyoD0A2y8=;
        b=SFSIJYsvzbeYeHhTEW+DyzrHD7y0UsRHS5coYrjS3fAj4XIy0McGgktExQLigkavML
         nBqS3e5VeL99qrD47nAz7nsLDTTymz8xc4toKNiEzN6G4ydUt+AOyC/+Dt7cuCV5tjsB
         W8uZyCqSiBo1oyrfjwFDzlhF4xjZLtaD0uePFaYQTiX5UCoG0PDHz0xQ/5xNgVrMfOkJ
         knTFtA64BI+u5USOdnDbo4CQc7Cegy2GqlgOl+9bdzy9HeUfjdye/4eKf3AUFZ9SSdSJ
         6I8Cbut/ImYA6rClTlWJdRDTa8HA3k9/eU2vY20MKmoUBgVQNDOPbZLfDGWozT6mxzDC
         1JNw==
X-Forwarded-Encrypted: i=1; AJvYcCUosX6vEBNAY/++KJLV1xsexTyE7JvM2bY0zODG4Wq1uREExFWTNl/tyeCAYdp+d7wlliCnrfbW7VaEzwgqW3Y5prirdNpPXtLB3UfK
X-Gm-Message-State: AOJu0YxUYM94Ik4ntA62zO2jjfj1cbcMcpyKd0tVoUEtl2S/B4s/DDex
	H4KZUg318TH+pexQ3MPr/k5M6GqnNln+QUlXeKNDoWz7c7nSrdXk1xrG9ceSnPg=
X-Google-Smtp-Source: AGHT+IFAgfIAI3/KuUTKpVzyvA9o5IQ/hm2YlS9fAPFKU/vAHWC7oo96mJ9J807N5OowZHBwaZ13Dw==
X-Received: by 2002:a05:6a20:918e:b0:1ac:6762:e62e with SMTP id v14-20020a056a20918e00b001ac6762e62emr5665000pzd.30.1714176658577;
        Fri, 26 Apr 2024 17:10:58 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:3569:7ce4:94b8:1691])
        by smtp.gmail.com with ESMTPSA id w1-20020a6556c1000000b005f3d54c0a57sm6061883pgs.49.2024.04.26.17.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:10:58 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Fri, 26 Apr 2024 17:10:36 -0700
Subject: [PATCH RFC v2 3/4] riscv: dts: thead: Add TH1520 AP_SUBSYS clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-th1520-clk-v2-v2-3-96b829e6fcee@tenstorrent.com>
References: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
In-Reply-To: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714176654; l=1160;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=WiDmXN+gE+Oj1XaVtmKA94ORr86HXlbvJPY4osUU3RM=;
 b=z+fbT5Gr7t67Rr88wnhdlVKhPZX1zS0AMbe6NxbQ9g3D2bhGOs+5SSpgPoUawGn7P+ESJzWYz
 lpFXBf7p6AYCVdX2h0+d+CLQ+0v9Pzv0a2iF2lJ15sroJqydTVVDZ+6
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Add node for the AP_SUBSYS clock controller on the T-Head TH1520 SoC.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 8b915e206f3a..6285cdf91bd6 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/thead,th1520-clk-ap.h>
 
 / {
 	compatible = "thead,th1520";
@@ -161,6 +162,14 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		clk: clock-controller@ffef010000 {
+			compatible = "thead,th1520-clk-ap";
+			reg = <0xff 0xef010000 0x0 0x1000>;
+			clocks = <&osc>;
+			clock-names = "osc";
+			#clock-cells = <1>;
+		};
+
 		plic: interrupt-controller@ffd8000000 {
 			compatible = "thead,th1520-plic", "thead,c900-plic";
 			reg = <0xff 0xd8000000 0x0 0x01000000>;

-- 
2.34.1


