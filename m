Return-Path: <linux-kernel+bounces-31039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D08327F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AF71F251C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927E4EB4F;
	Fri, 19 Jan 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcswlJwa"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5B4D5B3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661141; cv=none; b=QKMyTB8G0tSYWUpLvRIpERvLgpc/8dDhYGJV/Y7N3Jj4WZHbmuoTej/dYD4Kyaxz69g6NkPY6KpVEnFAh0WDEjmUEc2KqvE+2NEqdzMLU4WddNXdeniGV8J/fqpqFpx33zK7Fit8K205VzLueqfuH/9Phgjx+Ykyiaxi4exdGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661141; c=relaxed/simple;
	bh=9bJVEIeoTaJjZ61pXNxm06VhyRFtHsguVO+YA5dDTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVuaTgjBcXwUohaph/xmtSh5Kv4vDVXeB4D5N0je04SmqcqRwiXMAqe0zTvvVbBq2xEPQFT6DfV2drJinviKnQ2V0evB75rMEG8tvxHsgTK7DAm2tPE2FiU5ZiVdz0M5cWVWjHa0k6+QdolqqTxowQ8jqF5MGJj3b0WB3x+AyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UcswlJwa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e490c2115so10453765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661138; x=1706265938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ40aSkF8Aok0dVvTVGIVu4hOfQge6DrOyhL11J8cEA=;
        b=UcswlJwaiFT3zrykl1Bu9Lwuas2/c9fMlRJaid0u9KnPLpMflbyR+YeEe9Up9d2+qY
         BbbZl2msg6jDCjMjd58e6Ef8Kdyt3bEVFEqkvdIHn268s9hGyFxfNTmpDZqrtlOADHU9
         8tWWvBGQSyFNGjGqpTdzEuuYVv8al/EIGJXQZa+rEIrbHY28UYIOl7rWTogaI8cM2ogT
         TUiydUQtVyRXbUMXy4HvyxdPF6il4m+xpsVdYENap9g6KH/KqARQYC9pJ4CD7rSEQUBZ
         jN7MvtiqcCxPzpMqZcy5iXOADdj4lJTDWijHD4QBFZxzTsnXlfJpJH5ntvAiM/AE5Ld4
         4iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661138; x=1706265938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ40aSkF8Aok0dVvTVGIVu4hOfQge6DrOyhL11J8cEA=;
        b=Tk+/XBQRnKAgZuYJD9SCZbNi5g+vpvcGV1vaVXfc+GK/8Q8FoTFwSnQllyY6fxP/FP
         AXWJzFIkCRd1hlRtHpk4QM+MyDz70ebmJvsrpIuAGc6DlGuiarAA+Bq6GSmwP5f7EhDn
         vrGj7OJHaOciQUPYuBQcQXMFALliZbSizt4DNq4v4HmZwI74gCcuvrXCVI2WIacA2xH8
         Vgs1KxSybKejAZltFMlv4oWOQu0uftrxygF3cfrF5m7EUk6GPJfUMA+88vDyuoAZPne2
         ENhpVrqZlswYc/sJtbmJGlJBlsbRjTd5gjpPhLnn8FNk8lE+Nnm709ZrihxRKHYFCEXF
         kp+w==
X-Gm-Message-State: AOJu0Yzi5ODBNQA2gdbSOZRIeS7vY4uHGgnXpF5gjc4yrsr/WspbYfJg
	mtprgXGQmWkWeF8/OLUmRF79ps/qt8CpEWLmcBMUi8RaOhGkRKQkhF+AI+vKI68=
X-Google-Smtp-Source: AGHT+IFB56z75wwv61vkNgNKZ52ys1BI0PMljalI5CjTRNffvDMu2NmbxLRBYtutQlkZKDjxtS4Jcg==
X-Received: by 2002:a7b:c8d3:0:b0:40e:873b:cf73 with SMTP id f19-20020a7bc8d3000000b0040e873bcf73mr452698wml.54.1705661138275;
        Fri, 19 Jan 2024 02:45:38 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:37 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 09/19] tty: serial: samsung: remove braces on single statement block
Date: Fri, 19 Jan 2024 10:45:16 +0000
Message-ID: <20240119104526.1221243-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Braces {} are not necessary for single statement blocks.
Remove braces on single statement block.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 8b396c950933..303b67498c65 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2061,9 +2061,8 @@ static void s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
-	if (port) {
+	if (port)
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
-	}
 
 	uart_unregister_driver(&s3c24xx_uart_drv);
 }
-- 
2.43.0.429.g432eaa2c6b-goog


