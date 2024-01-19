Return-Path: <linux-kernel+bounces-31044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DE832807
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE662836DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D594F893;
	Fri, 19 Jan 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgrsbOfY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555F4CDEB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661147; cv=none; b=CyQ/WAx75HciFKdimJFKXWOE+GfQ3f47gfXC/zZMUlAD2juiSC6soJNscpIWUhSIfIm+jcfjrnKgAw2MfGfBNESZaAZJL6zQR1N6h0lhoz91eJIjgKdhzcRfIBJQazh1KcKNGe2IX5nG6yAVHtqVHsgzBqCXDOc2YgrhS3InCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661147; c=relaxed/simple;
	bh=PJRlGWR9ZTwdang5eUW69ySWLQO09PGgtwAiOHlslcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtfK211yL3mGjWlpgGQMXebr+xVeNFGkcVqHPXXta83XoB0613zkaYblkB1AAg/9ua1nqYQs48YeQcAhAd61bq59XzhOBC/GWU757myM4QUo0jF5ocgMoHWU3gk+JJwLkGY3IDrg5VFum8sMpKbHu5ssEDs4GA1NQ+qYVXfIkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgrsbOfY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e490c2115so10454145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661142; x=1706265942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNVrIVfmeLqNWh0q32FnE3SCbDOH2rJsoikX7ZaHXN8=;
        b=zgrsbOfYBPrTGC3LDVa2Q18oTeIHW7uzteY10Xs/Ew2aA66P1Rabe8xBEFL5DC/vSs
         Lg1IKIXUU91TzOqtO36LN1w0CMOzff0hp6iUhYtaRAndGRZcrvupK+yktsKgqCLqjH4V
         tQlG5agQqS3j+WWP0WyOfNSEuYeEDiNNexGu+VrWV2fGz0BZqiV6V7JOCQjarYJr//PS
         acDovLMq7T4Cz4WE1ZrUFCPeZ/Xzb8KIIHs43HTp7hkMUL6E3CqNaqtJQ3KrIBf2D6Jn
         UH9SkwBU2kR74oG1IH0oTnZOrEHd/rpxmnshkA0HueiOqdYeP1HmkapIQ03YfeVXpVNZ
         j/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661142; x=1706265942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNVrIVfmeLqNWh0q32FnE3SCbDOH2rJsoikX7ZaHXN8=;
        b=lZB6tBHrEy5c60j+4svnBlvB7wLkXPTDRDO6A5k8mIvnYa4s1Ii2R6dxQR8KIZk2Nd
         pRzJh0JegkDTbXycoqwIeL4xnq0BAuXBhWIPc5WJHAT8hWSMxoEEP2k25iueYSZO4KVs
         qmlopUC1uLkIskc/lwncl0Tbi46IrDzex6Je0t/iYko4xpZgwD9Wr2A2e/KM/OUkg6G0
         oRLpdZJGMGHD/EeSsBrLmnrqm2whCAadyG1QGlD4ql+DLhYyGq51pJBLQSfp3U4cozwy
         L5AwYUwGavCp+2wfXcfzWjpmqStrlRUytJ6NgS+rtGopDcdhbPi3UCcv7beXANfaFebI
         EGDA==
X-Gm-Message-State: AOJu0Ywc1QuUV4fJSd6o6D4sO093HDGjauWySOMrgmVpB7OGA9iuO38G
	d/QJsRl3Wez+gUPhqjyikVZ8bYsjARnoACWF9+jclFB/UJF5LAenTUi/FZlw1RQ=
X-Google-Smtp-Source: AGHT+IG1Zs80+jewlD9VzzkTPw9eOk7A/qP/u9l55zJeijZCyenfdFg/MX5eIVS2ZxYAe9I/6F6bSg==
X-Received: by 2002:a05:600c:1392:b0:40e:360b:e3e1 with SMTP id u18-20020a05600c139200b0040e360be3e1mr497918wmf.13.1705661142682;
        Fri, 19 Jan 2024 02:45:42 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:41 -0800 (PST)
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
Subject: [PATCH v2 14/19] tty: serial: samsung: return bool for s3c24xx_serial_txempty_nofifo()
Date: Fri, 19 Jan 2024 10:45:21 +0000
Message-ID: <20240119104526.1221243-15-tudor.ambarus@linaro.org>
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

s3c24xx_serial_txempty_nofifo() returned either 0 or BIT(2), which is
counterintuitive. Make the method return bool, and return true when TX
is empty and false otherwise.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 333ffa3a76a3..90d697def5c7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -236,7 +236,7 @@ static inline const char *s3c24xx_serial_portname(const struct uart_port *port)
 	return to_platform_device(port->dev)->name;
 }
 
-static int s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
+static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 {
 	return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
 }
@@ -782,7 +782,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		ch = rd_reg(port, S3C2410_URXH);
 
 		if (port->flags & UPF_CONS_FLOW) {
-			int txe = s3c24xx_serial_txempty_nofifo(port);
+			bool txe = s3c24xx_serial_txempty_nofifo(port);
 
 			if (ourport->rx_enabled) {
 				if (!txe) {
-- 
2.43.0.429.g432eaa2c6b-goog


