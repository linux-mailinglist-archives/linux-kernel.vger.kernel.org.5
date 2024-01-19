Return-Path: <linux-kernel+bounces-31042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C548327FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972581C22A32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8A4C61C;
	Fri, 19 Jan 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQsE4ZIY"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC84EB46
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661144; cv=none; b=HjzS8GJMvmhoO7IMkQzqfP2qKzaVFwp85XzPgP7+t+nPJy2PHvzEk9mviDfQa/aqLb4XR9Jyyk5XTwHSE54cjmYJ996uLXWZJGDNL6+Wg2v835YXNZQyUegjuEaBYdtl/3uwhaFu8MXmMF5kxm3BEukNoQUC1D+gJvwdIgi5lOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661144; c=relaxed/simple;
	bh=Jz188uwP5LRaM+CsdGI2KPSSsJyfUc0rsQSvFPr5zcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO4gmJrN45jfLY4zQxFD7iREOASwbVcQcBqHMDaWytCVjeIRLVGOmVhN/11J1xHhb0SKTvOj7II8AFHROMbaX8hoV8m/Vs2vjx6VqeRrVNGgfC3GdLPoesC5WcoXZHjX8w6cNBwY9HrXv5qs06ventDpJL7Yx7bwLqy4LWuxuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQsE4ZIY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e76626170so6698275e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661140; x=1706265940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2lQIakjCIKG/8t5br1DwDXAqAW0N+QdSof5GZ/rHIk=;
        b=MQsE4ZIYVDNmVYjVenFQMZenm5kXZ7to+qH2HF24EioLR/eLeCwRFJV1nmPwf/6i3j
         +A78rR9mM6cxlp2rCAxRWoWBpM1KsXU94DyDbRd4qR/kbqxCSr/XyVgJ1jbXpXAofMmw
         Z3ztzeqfwPvVnhXJtBBC0bWwES2+uKoQ/LL1uVTa5p603VbTbN2nQhDyD4ELkWArP8PL
         xGOFeb9V0ts1hzWV3vn1xy90Uum6FDxrC3Q9eqmqx+bU5NKJczir+5NdMxz35vWLE35h
         zRQj/Y+1TQrVrB2BOuERtCigy+wZMYTzR5ars+0UdMXXjdr6hyOfbQUOjz3udaay5nR4
         GzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661140; x=1706265940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2lQIakjCIKG/8t5br1DwDXAqAW0N+QdSof5GZ/rHIk=;
        b=NKNEhqdZZ9Bfy31CRdHK5cyyafEtw+KKoI0KELSNTAzlT5yP93jYdHWO7YzPjG1vhe
         rQOTadQ66tD4k/hEq3DL1FWrviaHLUSZAD6uzVL+30Ac0RVKvshJMG/1lIlVzYn2z/7z
         y/1ICoVQ3i0ccOdgdvxjTIRN/fj5KynYKJIGR8gBjbZrLjpvbb7RrKT4gBI1FlzqRRqP
         8GpHTjIBkW+3aS4U5OnFz3V98oGTifgQM2EJ3j4WDUXKH5FTWDeVsxLQlg0Jx+nEtm6u
         66GwwaJ5o4yVWXvx6Rpw2qq2yVYoFn17VMQpRb3rSbOu9U+fqj2qaTqYucP7qw7UuTjb
         OBhQ==
X-Gm-Message-State: AOJu0YzDllF44kmP2THBv7dG52p45kwmNsBxjYmXDx1fN5CFz9YxPAW1
	p3qKfbCKoYPXQPZm3w67zvr03bsE1lB14a4twtTjm6OsP8uVOXfEI4GsYz1/FyA=
X-Google-Smtp-Source: AGHT+IHooBhyW3xlDtUtOrRtWsnJD3eWRLbdkXu0zI8InTcaCbu308wM5VwUc4M2ZuUJ65W1vn7Buw==
X-Received: by 2002:a05:600c:3b26:b0:40d:88c6:b9b with SMTP id m38-20020a05600c3b2600b0040d88c60b9bmr1315643wms.123.1705661140719;
        Fri, 19 Jan 2024 02:45:40 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:40 -0800 (PST)
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
Subject: [PATCH v2 12/19] tty: serial: samsung: make max_count unsigned int
Date: Fri, 19 Jan 2024 10:45:19 +0000
Message-ID: <20240119104526.1221243-13-tudor.ambarus@linaro.org>
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

``max_count`` negative values are not used. Since ``port->fifosize``
is an unsigned int, make ``max_count`` the same.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 4bb75b1eceef..f8a8b459a86b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
+	unsigned int max_count = port->fifosize;
 	unsigned int fifocnt = 0;
-	int max_count = port->fifosize;
 	u32 ufcon, ufstat, uerstat;
 	u8 ch, flag;
 
-- 
2.43.0.429.g432eaa2c6b-goog


