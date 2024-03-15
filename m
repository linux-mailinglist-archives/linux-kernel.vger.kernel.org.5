Return-Path: <linux-kernel+bounces-104257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E133F87CB53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107351C2146C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096041864D;
	Fri, 15 Mar 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmhJrv8b"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337218059;
	Fri, 15 Mar 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498354; cv=none; b=TZVr5cQp7vVud2E+83tEo2W5tuVLHQueNH9KitG7Ow1a25SkBigHQzN4D8guxHYCREGNh1eWdtKv19vFVNCfxb2+WlL0T+ezhEhXukgN3vhYowCTnVchGZXAHJXkNBnPoeVxKJDyFgg6RDLcdQGz25mX+1aeDaxTFzz5kMFAcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498354; c=relaxed/simple;
	bh=g9frjLsPhPOVkDLN1ywx/DlP/UBD24zP1iPQUEjPk4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pPEZVAIAlB6NYKAZEwPwxkjbUB6M03dT62gBVjVoPnxOAMHsCUTxeXYECUlVTiDpN7aTbZemHzHxU4o7TJkbuoXlBxH+PidDiENtRYDAZbJWjWu3kjpBHVzIc4sDi1GWkSNkwVgakHWgzNz8D3ahhUk4YGpK5D5UowkyXsMsu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmhJrv8b; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d27fef509eso22513231fa.3;
        Fri, 15 Mar 2024 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710498351; x=1711103151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjEbXWwhsZ2V89MBAuuMPjIB1gZ4MYtJXZWbtz0OD68=;
        b=UmhJrv8bcY61weVLfdPrruwMGV2u8f4bI9j3eKBJPNcDjj2lii8MG9VPybvkIEhrXK
         wQG0TP7X+xCuwg+wlEptP7Jrb646Vb5HCNbpmSBwwWI/SfGN6WeffnDTTUkqJGlR++97
         485w0BWP4Ok5unLh/fRrjIeRZLeIllLAPja3IZdpdkAf/wterOc9qWMO7KYnzxR5TH8a
         Q8pdEAFXJNxaFOUX3IqtWs6qDJUFKDpjTTAkO7VMmzi/GqYPgKhwtvZ7WsefspJg2osC
         aw53gmbsPCMLo4FdKjwsnH3YSWaWz9fVjHAuEEpMfbzNpfGUEVOkquQXgkEGKXZ5sQhi
         YP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710498351; x=1711103151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjEbXWwhsZ2V89MBAuuMPjIB1gZ4MYtJXZWbtz0OD68=;
        b=a6KDUlOz8nbgj305oQtVdQ9jvywOn4VsWkNxtehVwjlWf1yH28ROT0XkRoQYgn/54e
         uziNLHculTyWGFWR721KqCFUNzfzOXeuX3fNMStHeANunTrTZ7shnUGFsUiHfY+1ZzEC
         rl815IJD9h5jmIWXkE2NxN8ef9zmRlxyKyzDF7QqjnHk5Tfeu4wSSGIOlevWjZjAxdV8
         P+f44jyo+i7zU/FFYuE6Zvw8CrjkpmNfuS75umvoyfaxZDReGFD9g2tldfWxOCSwWTWY
         fFJXc9nWJDDWkKwW4FUs+mXCK0XS6Xw3fBE796ZjGgtUdlE8k6AJfr/PfpbMPwuvyhM4
         qRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG0nnzdKknRKewI0JxMa5ZakbO8oYm6ehXl/onkQt1MRH3iCJ5gftEhxaYuF5KIE1joZ8Z9XIvjUw4hgu1TL0XxVop/ar2ysvKxGB1feRhTBSTRUQ+bHty4sMd0GXH+5HQkelf5kYZ7Q==
X-Gm-Message-State: AOJu0YwAn0Jg8g7a/HfRztfkchWStX6pbPcqSNV7fgr2dkceYXGXmNsh
	EI5iNowUuxegP5bPSDJMnZL84MgZg4sQtUy42ELCy9dj6KXc90W7PyLkkJJ9iKy+nQ==
X-Google-Smtp-Source: AGHT+IE1ClC0pNGFDbWQQwtGpf+6gWKX89DIDXjAJD9TSfZAkUeDdX8ldNVXLjIZW9H7jviSmyBUkA==
X-Received: by 2002:a2e:9357:0:b0:2d4:6852:f61f with SMTP id m23-20020a2e9357000000b002d46852f61fmr2795403ljh.24.1710498350337;
        Fri, 15 Mar 2024 03:25:50 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id jl20-20020a17090775d400b00a46497c74a0sm1579231ejc.93.2024.03.15.03.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 03:25:49 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Jai Luthra <j-luthra@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Nishanth Menon <nm@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1] arm64: dts: ti: verdin-am62: dahlia: fix audio clock
Date: Fri, 15 Mar 2024 11:25:00 +0100
Message-Id: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

In current configuration, wm8904 codec on Dahlia carrier board provides
distorted audio output. This happens due to reference clock is fixed to
25MHz and no FLL is enabled. During playback following parameters are set:

44100Hz:

[  310.276924] wm8904 1-001a: Target BCLK is 1411200Hz
[  310.276990] wm8904 1-001a: Using 25000000Hz MCLK
[  310.277001] wm8904 1-001a: CLK_SYS is 12500000Hz
[  310.277018] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
[  310.277026] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
[  310.277034] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
[  310.277044] wm8904 1-001a: LRCLK_RATE is 35

Deviation = 1411200 vs 1562500 = 10.721%
Also, LRCLK_RATE is 35, should be 32.

48000Hz:

[  302.449970] wm8904 1-001a: Target BCLK is 1536000Hz
[  302.450037] wm8904 1-001a: Using 25000000Hz MCLK
[  302.450049] wm8904 1-001a: CLK_SYS is 12500000Hz
[  302.450065] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
[  302.450074] wm8904 1-001a: Selected SAMPLE_RATE of 48000Hz
[  302.450083] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
[  302.450092] wm8904 1-001a: LRCLK_RATE is 32

Deviation = 1536000 vs 1562500 = 1.725%

Enabling wm8904 FLL via providing mclk-fs property to simple-audio-card
configures clocks properly, but also adjusts audio reference clock
(mclk), which in case of TI AM62 should be avoided, as it only
supports 25MHz output [1][2].

This change enables FLL on wm8904 by providing mclk-fs, and drops
audio reference clock out of DAI configuration, which prevents
simple-audio-card to adjust it before every playback [3].

41000Hz:

[  111.820533] wm8904 1-001a: FLL configured for 25000000Hz->11289600Hz
[  111.820597] wm8904 1-001a: Clock source is 0 at 11289600Hz
[  111.820651] wm8904 1-001a: Using 11289600Hz FLL clock
[  111.820703] wm8904 1-001a: CLK_SYS is 11289600Hz
[  111.820798] wm8904 1-001a: Target BCLK is 1411200Hz
[  111.820847] wm8904 1-001a: Using 11289600Hz FLL clock
[  111.820894] wm8904 1-001a: CLK_SYS is 11289600Hz
[  111.820933] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
[  111.820971] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
[  111.821009] wm8904 1-001a: Selected BCLK_DIV of 80 for 1411200Hz BCLK
[  111.821051] wm8904 1-001a: LRCLK_RATE is 32

48000Hz:

[  144.119254] wm8904 1-001a: FLL configured for 25000000Hz->12288000Hz
[  144.119309] wm8904 1-001a: Clock source is 0 at 12288000Hz
[  144.119364] wm8904 1-001a: Using 12288000Hz FLL clock
[  144.119413] wm8904 1-001a: CLK_SYS is 12288000Hz
[  144.119512] wm8904 1-001a: Target BCLK is 1536000Hz
[  144.119561] wm8904 1-001a: Using 12288000Hz FLL clock
[  144.119608] wm8904 1-001a: CLK_SYS is 12288000Hz
[  144.119646] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
[  144.119685] wm8904 1-001a: Selected SAMPLE_RATE of 48000Hz
[  144.119723] wm8904 1-001a: Selected BCLK_DIV of 80 for 1536000Hz BCLK
[  144.119764] wm8904 1-001a: LRCLK_RATE is 32

[1]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1175479/processor-sdk-am62x-output-audio_ext_refclk0-as-mclk-for-codec-and-mcbsp/4444986#4444986
[2]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1188051/am625-audio_ext_refclk1-clock-output---dts-support/4476322#4476322
[3]: sound/soc/generic/simple-card-utils.c#L441

Fixes: f5bf894c865b ("arm64: dts: ti: verdin-am62: dahlia: add sound card")
Suggested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index bf6d27e70bc48..2b12a626d0e4d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -22,6 +22,7 @@ sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&codec_dai>;
 		simple-audio-card,name = "verdin-wm8904";
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,routing =
 			"Headphone Jack", "HPOUTL",
 			"Headphone Jack", "HPOUTR",
@@ -35,7 +36,6 @@ sound {
 			"Line", "Line In Jack";
 
 		codec_dai: simple-audio-card,codec {
-			clocks = <&audio_refclk1>;
 			sound-dai = <&wm8904_1a>;
 		};
 
-- 
2.34.1


