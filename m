Return-Path: <linux-kernel+bounces-132735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15555899969
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EACD1C20BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2415FD14;
	Fri,  5 Apr 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1MUvb4v"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832F15FD08
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309305; cv=none; b=Ymm8JHDxjYQiB/U0t7ELHomLooBYK+ilVfpu8sd8hkSnpKNmxUbqrDnMI0ep4kOs7KlVHyt6PoWlZeXRlz/Hy9titsXE2WjovkqMzbId5SLHAYUz4hqaDPSqILbbCse+UjSQ+S01KXKUz0iM6cFNtYWS07fFtLD//KAs86nZxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309305; c=relaxed/simple;
	bh=2cAmqcIHyrbHhGybTCFdHS/3brV/c7gmFnh2geGe/QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPOJmbYyoI00Vfh0Z7oL0x6uBwAskNqPuCNOzjwlbNoeaZ6676DNKRtJwsxXKb2eSzAJNYoQLV2fV8HzkvV967WvFnEAcPjQH2NA8+sj0QpbZNS1MDVSj8o5ne1IyABx3AL5jvuH4rSKB32t/3IpYZ9qsrQn5kXYPIr5i+BAkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1MUvb4v; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2371930a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712309302; x=1712914102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYhVWsiKKRdx7jYs05D0WEroCMJY9Qd94N0BcccLXcU=;
        b=M1MUvb4vy5jnbWIuJu8h7+8UPYHQOyGM9LdnyZ02+lSRPyimnourV0216ccEnRIDJz
         7USZ0oXsmgZ21oM7ekSRs8WOkPLIA6kPSNWqwafAEtN+P/xoG5iSJna5A38WbTiN7xsC
         KBu6uX35WNyr678+Nd34CNMvtFAY9VOaX/psrI5uUXMocMly81CJ7JiKs8JPkMlvy4/y
         4VHGXasFyRpOniJP7NMJZwMenOEbSNIoJewUeiCuRo0c4xSxue181QO/rHGEQK7ziKKs
         I0wDAJVk1osuyZNSPFVj4STGRuzlJEkyLYh65prIwKGO1X8AeiEcbwKCrzWiezlWoUiS
         8pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309302; x=1712914102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYhVWsiKKRdx7jYs05D0WEroCMJY9Qd94N0BcccLXcU=;
        b=MmHQZFgyDo9qpKvvXWD1jAi27LK/MCGfYZBNMxLCl8P0PSBcql1sQlyJBYIrUH3XoA
         5Q5vQSRdHY825ahyF4e1gII3Zsi7BsR0U9YgCl/gCbBE8SXxMXT3dXRasrj6s6dP0L+p
         Uqp0HKIzTpwub1UK3KY+iU3fycfrRF1WA3eJg9HjrPrwLOK28wJlN3RP0fjpuVRot1oM
         sG2mwTwWRh5WgdgrtteEU6PFwe5gPbWV7RqualknNjwr5IWIJo2yz6yekVN992C2n9w6
         y9S3Q1pRDmpOAs5IinmisRbIzs4UsnNEPNl0LLn79bquRwaGMf9brIh80arfZkKuZ7ao
         uoqw==
X-Forwarded-Encrypted: i=1; AJvYcCXgsns4NbEpJurLJUX0+DBq7cy/pBZq66QkGS2g/SPLnkP8k7GbMHtGal5jOf2PDnThL6N79AXkXU8oZl4A0LKS33NQszt5+aTNiTpp
X-Gm-Message-State: AOJu0YyOzTUxqeriZMqwoNhkGWU1qmxKMq/DyhZVkV4m+EPTgCfodhD6
	9nuq64D/Fag9D6ZicgAcSSEhorYvC7BsTG0BsLnjxN0TJ3Egbl48lLKaCIlGvmI=
X-Google-Smtp-Source: AGHT+IFkfahotwq8cHOkal6qSEvAwTkdlqinu+jVeTN/KjeYhmM03EB06dwZOWx3FQkSAjd3MFhAYA==
X-Received: by 2002:a50:d6da:0:b0:566:d333:45e8 with SMTP id l26-20020a50d6da000000b00566d33345e8mr664518edj.20.1712309302296;
        Fri, 05 Apr 2024 02:28:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id a1-20020a508581000000b0056e2432d10bsm587750edh.70.2024.04.05.02.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 02:28:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: imx8mm-var-som-symphony: drop redundant status from typec
Date: Fri,  5 Apr 2024 11:28:18 +0200
Message-Id: <20240405092819.40994-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"okay" is the default status, so drop redundant property from the typec
node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index d643381417f1..affbc67c2ef6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -117,7 +117,6 @@ extcon_usbotg1: typec@3d {
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ptn5150>;
-		status = "okay";
 	};
 };
 
-- 
2.34.1


