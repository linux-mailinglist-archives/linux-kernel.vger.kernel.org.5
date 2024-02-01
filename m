Return-Path: <linux-kernel+bounces-48480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C7845CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F461F2C0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4D77A00;
	Thu,  1 Feb 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUGxfB0J"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CB626C5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803994; cv=none; b=miOBR+WHwGTHpj3NH5NtGj64KJhoMyZjqGx26ybf9ff+oBuZLnMqNJqDE73cllyMrX2O9C3iqxEVnzpRR3hrdqyDAxk2BW0uKDz7BDCbWGMuoKbPxlQcRc37VQvbBrogRJN17UoIZ7XhB74Iy2caJvb8E2XdnEetEz8wKzxuI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803994; c=relaxed/simple;
	bh=GP+X1ArMeG/tG2Y1s867iydFsyCr47gDA2fB2MdS+gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEma3vgSNf+mZrU7oL8zivK83JA4v+eZBM9NoGvcwdoWy/GSt9yQ7W3ja3Pk4ppvTwXYD47IkG1eZ988Hki5WsaSAW4uE9UU7WmFdjtCIq8Xff3/OMgFjtcgVGQKyn2SWqWzJkLaTtwqCP0ZduRx3JUy2knJUErpOVDtBd9OUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YUGxfB0J; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a35e65df2d8so143644666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706803991; x=1707408791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q34bmt6v/3YhSDrxvXW9WWNgkiR+qYi4pyj+IFIv9Uk=;
        b=YUGxfB0JxrM+BKdgIbC1XQkPCbJ2PzzX4nFdLwkMABjjggwNGn47k0YdFw1PjNY3HS
         dD06KFs2wdVA0hPPnqlHoqCKZ6tzQFIlehS2lwpzq0Fd1Ya6tGFkvehnpmJKT/M0TjHz
         Sq2oj6O372KHv74LAdkE5qbkvwGWl69X2id8+QWjsHkZExCPv1PwdRv87PRXFnwiW9e4
         OlMiI34zJJLKGkIt0+xYBQwgoSQY96WqgiploqS5ZFsvF+DoN2da1cj1ScOGql3aMg45
         p0+5fK1GzbdcW0mR4N6LAi6DjTnmdqnUDq/4+WsUobgb8U0wP4gmU2IoYunxlzV52bk/
         ILqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803991; x=1707408791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q34bmt6v/3YhSDrxvXW9WWNgkiR+qYi4pyj+IFIv9Uk=;
        b=SK7VDCRzvGPj9U8oeiJ9akpRJXRdN7GeDs+C6C4/7orzJHMTPdhBoQk/kq7jXyDyHX
         rnffyFU44jdBsXYuUZ80XU277nqPjCOhXpAsY8Iwd6KoTsZy1kYNw9RFbdGIXhJ84aIf
         z0EHZFsUWJ8ndQJ62gPdNONp6NCnAQqQeQni3HEIOxYt6dYnP8uHnbOhygbaXqNQBdEu
         oripoSbDXSk+kGckmxUTpA48wzTyPcFbqmwrq1qpLthmilK+2zZIpPaLSlVuz9p+uccr
         tQ9Ok5ehhFNsah+eU229wk0+egcwLqu7mJ5O522raIA1mMgRxRTsTDQaAJuPlci+ySze
         8M3Q==
X-Gm-Message-State: AOJu0YyCJpHTg+tw+1dQq0hCf8coJTo+MAL1327OrnKJKcPqkCYSfhF7
	WunfY1ZSC4wRUqVz4voA4J33DwY56neGRIxl2xCaqSivFLlTrunch/t6kcpENRM=
X-Google-Smtp-Source: AGHT+IE+I9fBEADVIjN7SDphyfBYn/i+b453SplfEkYPdBXJjOYKvhNQayV6lHRGw+nR+1rcKzfpFg==
X-Received: by 2002:a17:906:ccda:b0:a36:8431:6edf with SMTP id ot26-20020a170906ccda00b00a3684316edfmr3473176ejb.37.1706803991073;
        Thu, 01 Feb 2024 08:13:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUg2vdg4XPrKNhZSPv1wlhWejmWOxOAo8h9pzcN1Ibm7irEEC8b+0oQjBGbGEdfRla8CbuRZwXJmq+zYjaWSC0ElS2peyaYobN+x6jwNsSn5AHGRmsl4w1OvttfQJGTADOgnOXRr3Iyx+1A9yU/tfXW+z46K7kLVhG6Ut01dy9QeyLPNzzgTmsJKEcF5vdSRNEp5/Glk/Zn82lwrIsRPMFNzlBT2dmW4kV9031O/ponV0QuOKmaGoy4gvWMZl/Gh2Gi1RFZO9wPuL0PIpub875RkqLgShma8Fh7w0MspW10wHsY0pboS0+gtdwJK7WDb6iaNEiyowPjCcsWBbdcWUU5SKE356zUihgrj8FfWpU/52znOmpUoD0z19Dy58GQ/ShN0xsqlh5FXzIrLegPxENq7NxlE7R1AvX6ko+tAe3YRq5Kldj/wDJ5/iOn3oqMWlrdoAEUzftW8SM84/vVkwN7Zsiqg9mBg1Ixb3Tta2l9OE4wVzBa3gVVfdsMypad17vPvtrwQqmBit7xaOc45TW+cLudUHiufwkt5/6IEomTckDh4lJ6JUAjwFrjY6S87fAUyO9JVf4urSevABjoffglQdCRoZFS5psHo46BRNvKSdHwsvrmFD1Kd+AnKTF1nUMpeIvK2MQLt3dMBY5Vd6lF9HTe5d88AKlcFtmQq2lWivSEryUNxA==
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a3600d7c2fbsm3449288ejc.176.2024.02.01.08.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:13:10 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 1/7] clk: samsung: gs-101: drop extra empty line
Date: Thu,  1 Feb 2024 16:11:37 +0000
Message-ID: <20240201161258.1013664-2-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240201161258.1013664-1-andre.draszik@linaro.org>
References: <20240201161258.1013664-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is an extra empty line here which doesn't exist in any of the
other cmu code blocks in this file.

Drop it to align cmu_top with the rest of the file.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

---
v2: collect Reviewed-by: tags
---
 drivers/clk/samsung/clk-gs101.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 4a0520e825b6..27debbafdce4 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -25,7 +25,6 @@
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_TOP (0x1e080000) */
-
 #define PLL_LOCKTIME_PLL_SHARED0			0x0000
 #define PLL_LOCKTIME_PLL_SHARED1			0x0004
 #define PLL_LOCKTIME_PLL_SHARED2			0x0008
-- 
2.43.0.594.gd9cf4e227d-goog


