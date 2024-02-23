Return-Path: <linux-kernel+bounces-77982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF9860DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2111C2144C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87DC25775;
	Fri, 23 Feb 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahvgVy80"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC121B95F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679490; cv=none; b=U9wdoL8zOYrnSCJ/ikLWPObI+PJUt27opaAgjLMrlwtNM6hqaCEu2jPBL5T85UTUgCrtInoGF41ZDifIkSoyh9g6m7pcS5JnRt2cCfU7DR0Zy6CNtbSfwrax1B0qvjJkUZ1WZYKgIRsXrBoOcjiNfMSSo0R9ERxh9lLMucfW3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679490; c=relaxed/simple;
	bh=IpkfMNeyeLubIoGLauI2jl0iOwiP1kjt0u3vJSlNrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4UvJUOFrNKRQLUG7Hd2DHWVE3OuUrR4aHtSJPp4xUYzxqJc9xzX8FSJdfRRWp9/M8+X5wXilUX5t1vpCPD7H5U4jATer7YwvX1HP9Hppyox2uQLs5Rk6DYHgVPbpzDsUfdFhQlpoPqP3f8P83YrNi5CoZm8zc1ZjbHR5yW0J6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ahvgVy80; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so567657a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708679486; x=1709284286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXXgc5ooBuiJ0rd83JBNXgx7wSQOERYhBcUIH8zsNHg=;
        b=ahvgVy80FzqZM2b1pxq+iPu1krgJidruwPGDCV00aAOXT2SSm4fWttjq9Q8ixCX4NQ
         jZqBKZPwVmQIXKrcodzEanZCLHjftFUyBsUPaMQZVIJ/w3wYvwyOZLECzsEHNccW4+wk
         MD7Xu2ggsfJZK3w8VwR3Cyh4mq8yP+N3mxMCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679486; x=1709284286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXXgc5ooBuiJ0rd83JBNXgx7wSQOERYhBcUIH8zsNHg=;
        b=pwSyEm+al2EXi60A/cX/kibnk3ECm0ZZFiXHfjluoJACqN2fHUEWFJVuzX56VPwJfM
         41m+4Xh3EAVLuYmibzWBF8ZCr9jjFwTpv07uJklLuoSWva0wz0ZqrMHF5+vpujICtVUx
         aE3o5oxpG2KL8u0DvdvbYoRRpS7RWRIhfmIpWjzsTtDwR0YypF6LlfnkRNsW/CwV/9pK
         R6exxXv3WMH0hGy+W1lujj8rbgQH1q4w2h7pHMDglIYsfh6p+RMG7UQOnarRBFrvHfKN
         J8E9xIyvtUjosV2lO/w23DEByXKx/8HNhmLiDsorln1JUJSP4tc4hpOha4aT1SoQnazL
         iuFA==
X-Forwarded-Encrypted: i=1; AJvYcCWX8oL67qfhIm88fBD/xo2kihOe5Pg37gacjp9qog1+moF7Dv0uY/fOm5xx9CYJV2HIK7FwlPORHVXjLf7xjKl73D6AHMGojzcDpfAn
X-Gm-Message-State: AOJu0YzaO1khDS7vSqiJ1ExQ/vJwngMcWguiCbLv6sWq8qB4QUUUngbK
	h6hK1p6Pd0WhLeNWfpto8XGzIR5uGmEoC0iFXcUzPxOcIQaJ87qiEeRkyoix+A==
X-Google-Smtp-Source: AGHT+IFM39/h0EdoH38mYvLsCTE5nkHkOj5XRH9crL4wqF6Cl8jNvanWO7s0CrDHOhySEbflpAoyvQ==
X-Received: by 2002:a05:6a20:244e:b0:19b:673d:824d with SMTP id t14-20020a056a20244e00b0019b673d824dmr1490319pzc.46.1708679486692;
        Fri, 23 Feb 2024 01:11:26 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e0c9:81eb:a87f:e8e7])
        by smtp.gmail.com with ESMTPSA id y15-20020a170902b48f00b001dc05535632sm7800365plr.170.2024.02.23.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:11:26 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Ikjoon Jang <ikjn@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
Date: Fri, 23 Feb 2024 17:11:21 +0800
Message-ID: <20240223091122.2430037-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ikjoon Jang <ikjn@chromium.org>

mfgcfg clock is under MFG_ASYNC power domain.

Fixes: e526c9bc11f8 ("arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile")
Fixes: 37fb78b9aeb7 ("arm64: dts: mediatek: Add mt8183 power domains controller")
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This patch is long overdue. Could we merge it for fixes for this or the
next release?

Changes since v2:
- Rebased onto current tree
- Added Fixes tags
- Fix up subject prefix

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 93dfbf130231..774ae5d9143f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1637,6 +1637,7 @@ mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
 		};
 
 		gpu: gpu@13040000 {
-- 
2.44.0.rc0.258.g7320e95886-goog


