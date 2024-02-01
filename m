Return-Path: <linux-kernel+bounces-48280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9B84598F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F8E28D0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEB5D47D;
	Thu,  1 Feb 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOu2A/5Z"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C35D47F;
	Thu,  1 Feb 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796228; cv=none; b=bn5gOoAB7tYsiYnilJqezBqYnoDdn+KNiquJ86ydAe1g1J34Fuk99tEzDr61De7cnvYmd8FeDrQrgpOwXK67ztw4ETfvO82fVTRhcfMHHLc3tJh88LJYF6A54g7uoISWv22b5Z+tZqI8fxTJjNjTEq2H6oVilf7uZSImaCRxBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796228; c=relaxed/simple;
	bh=jo0lrXCr+ByQjN7lNIgf3/5HMNYXX9RLoXwcL4UFG68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsZS98wTZJrF5M3Ylsx+mtz12Zmrxczdqv5cGWjMmQFZxNfKKx7/wX+91JHbwimsUkTjwCTMgigNB8r8wGYCFaqygVeQYZOIHGHK2+SOK3FwyNlwSOfk4qYYFz4M09xgDQWqSZ3s4F3PvGPDND1aWz9Ow0ofbgBFCqtV9xxc928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOu2A/5Z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dddee3ba13so645251b3a.1;
        Thu, 01 Feb 2024 06:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796225; x=1707401025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RiE5Onayz6cyE5+MyLfFrdqfq7HqpeSLCHp3c1TdnJ4=;
        b=LOu2A/5ZTD7qUurQ9Frp3pfBg9rTB2WpbaVf9Bf4OY5qTe7Lb+6hxLn1CebWPFuk8z
         +DNsjANNNLb0NaG6Adgf3/Z6H1ugS7y6ilxLVcAhhXB6sfPHa1WI3zUOZBe4t4JVtFfq
         JQ6fjz2uYdWLq1DWBgFsqwiEfKWKvbS2Aez1d+YE5vtx9rzYewWZj3NBBaWASBWw7srL
         Okq1uqA5z20uk4WeuuywO89Al85fsL5J7bvzHINVwx8bv57ghgh58ZIV9YOuBKDXyfvl
         Ja/x4CJS1xWKPBRjd5NKkLzp9MRnUoWqb5jMkjwI7lA8HkTpyDDfMt/AKabt4+SYLaxT
         LWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796225; x=1707401025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiE5Onayz6cyE5+MyLfFrdqfq7HqpeSLCHp3c1TdnJ4=;
        b=Cyt7eoxkc+FFzLyaBa5V4Cgdpws7HrBna269doqj2MPFrEE1o9XkPn8U52F6kk6F/L
         5P2KcGpEJB3mY1NEUjDn6LZf12r0ncYR2zorhSX98C4IGRJ3B0OInUFatBHnyad2qM9i
         xk7W2KhD2vt7IG8ZkBHXU8niYKzY+3mfjqgi6UIZloOrUBzh+qJXtAiyWZ2Rj8BkinbS
         YJabDml2iM4iC6ZDkofmc5dpooVh/lbpLcRGFB9l6qfWm1uF/6H5HMRh/Dwsr7kVtn+b
         2nxUlxqJsvaD5QFoGkokMYZvrc6rkPvqkXdIkM7RKZ+A7ArTQWdhRj9yt2mNedhgUBze
         8MRQ==
X-Gm-Message-State: AOJu0Yz3oWbrPcRoUcs656VaQr2lmHVG5ICqcRxM2zRCUXmkKf0gkniS
	jYsMKxbyeeB9r/KvQaMsvMpBdM6HGywP9F9JJbOB87GppwiAECUoGV2vqrlUAOQ=
X-Google-Smtp-Source: AGHT+IEXOMtth7Vcaoi9vKZ25QuQJIIReWzUToo5//Tpyww2+VbtLIAH6lnQ8JReO/6qUxJ+gEgkDg==
X-Received: by 2002:a05:6a00:1ca1:b0:6dd:da40:948d with SMTP id y33-20020a056a001ca100b006ddda40948dmr5448587pfw.25.1706796225384;
        Thu, 01 Feb 2024 06:03:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYdMpnY2InEs7uHYKz+la0wznH/ZEKH9EFQHr5pJyjvybbtBC/TjiPBcLBatTAjHeq0TKWpMXUCC4k7QU2hYUzsJf6+PX0qechE0OozEIoM05UpaMuRxTCrX0Zde7U59YIjF8V42Cf6Z38xASMnJdbRh3e3OAVyhZKDqo5iy1ofmbLXESjpdeXbRbEMCTauxnwOklavH2b1/jm+A/nVsfs62jBOX0MWZqPibm3EHVwqPLPrzPx6J8FSEi7+9sToFn/cPcTM9nSK3LLD42KjI9+FQ==
Received: from penguin.lxd (133-32-135-143.east.xps.vectant.ne.jp. [133.32.135.143])
        by smtp.gmail.com with ESMTPSA id l23-20020a62be17000000b006dfebfd0481sm1169171pff.7.2024.02.01.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:03:44 -0800 (PST)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
	linux-kernel@vger.kernel.org (open list),
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove Tomasz from Samsung clock and pinctrl entries
Date: Thu,  1 Feb 2024 23:01:34 +0900
Message-Id: <20240201140134.4345-1-tomasz.figa@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been no longer at Samsung for a long time, the platforms
that I am knowledgable about (S3C24xx, S3C64xx, Exynos 4) are no longer
relevant and we have people with better capabilities as maintainers
already, so let me remove myself. Thanks for the nice collaboration
everyone!

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61117c3afa80..7f550edab68e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17343,7 +17343,6 @@ F:	Documentation/devicetree/bindings/pinctrl/renesas,*
 F:	drivers/pinctrl/renesas/
 
 PIN CONTROLLER - SAMSUNG
-M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 R:	Alim Akhtar <alim.akhtar@samsung.com>
@@ -19392,7 +19391,6 @@ F:	drivers/media/platform/samsung/exynos4-is/
 SAMSUNG SOC CLOCK DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
-M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
-- 
2.39.2


