Return-Path: <linux-kernel+bounces-156926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F858B0A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC2A1F24AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888F15B15A;
	Wed, 24 Apr 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McPBIgIf"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE115B14B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963994; cv=none; b=Vu6VR+KXzKrP03xQkDySlhco7kTrcx5qv9OPC10aErbWi9JdrVjEU7NsbOln4U/DW/q8DVtRW1ZbZSk/UzF/TR+soXY1mGyfZHsWc3bcp90hk/4Jv+LKJhm9JuSaDmBROhZ9jPN52k0M0wBTMHwTluaN2j0tB3KaSqElbi9WlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963994; c=relaxed/simple;
	bh=lvGq478npegdfe7X33ro4L3C4YXKBVJlBkfyJxEJbXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdMpmpI+cjKcNo0uBwVw4irMB1DPCZtRD2UmNRzZcDSPQ+jY1MnidGBt5FM168U1hnrRPv2hkKOirVbYnQxDhfVtcZzi7AUPfO5+foC3ECDkXAEgCePJ20HytUtXSv+Qbvu9utPSuCRuvIv0GAyPy0bY4sTt/RW7hYVNyS1arB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McPBIgIf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so5634879b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713963990; x=1714568790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWmvHblwyLfpV+rEC2PSqDTFbQMnE4MDRNUxWTIYKmE=;
        b=McPBIgIfkGSRkg6nVkKfnpiWJ72i3SZ6PIocpp0PgvijkzJ+L2JrlrVVGO8WWp9/Ko
         7HIZz0gNBSsAWkm3GzQy5UtULLMz2J4uEXvZVt8J7x1Pr0BnRsxRf9CqlRrxvzVU+H8X
         n43ZvyrPBXhvaigwVjMMFttxgWzH+bjK2wI+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963990; x=1714568790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWmvHblwyLfpV+rEC2PSqDTFbQMnE4MDRNUxWTIYKmE=;
        b=L0g3iS47CxTz2Rf7LdkBAf0m7fo8iqQcfcWAW9BG8NDTpfF+0k/K5CjVBemRGkoKGj
         uK0uL1ocJGE8UpLobJBUNMhMNLo2f/KEfYgCs2sl0/BTUAeLyF0nmxBoqQ5PflAqQrqk
         7sG5f3PzsGRBwCXnE8/ejOyiBhghKImgJb05b1mascYyXYZxPdy9ZeqEt0Gf492cJAJZ
         Lak900Iu3Mcw6xrBLcb9Zt3Lgu8OKASGSbyxHwBHHtNFfkVK1PLUBvpqfaWi8GK4eic9
         a5zFFB65ltcIJilDe6lufdk8mHjL9RgmNJllvM9gwBxjJoc954FHwvXkc82Y0QFhvg8O
         LeHg==
X-Gm-Message-State: AOJu0YyteSGrQmZs7M14F1pCAKGBxufVkybfIDXDxwqAGT52nD3fnJYZ
	x+J4RXl7TbGRGurujLudbxQ0/2fpLl72kK3GUqSE5oqEvaOA9rxbYiHKY71HQA==
X-Google-Smtp-Source: AGHT+IGxaNdfLyHIQirpTurMn+c1hdzjWlDQY5IRavD5VXu6cW703ROJBZd0shDax7VyQ2G08e/VqQ==
X-Received: by 2002:a05:6a20:c6cd:b0:1ad:7fd1:ee2e with SMTP id gw13-20020a056a20c6cd00b001ad7fd1ee2emr2131046pzb.13.1713963989985;
        Wed, 24 Apr 2024 06:06:29 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:836:835b:e0f2:a3a0])
        by smtp.gmail.com with ESMTPSA id y5-20020a637d05000000b005f3d2a9a91bsm9981158pgc.89.2024.04.24.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:06:29 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	Hilda Wu <hildawu@realtek.com>,
	Pin-yen Lin <treapking@chromium.org>,
	KidmanLee <kidman@realtek.com>,
	linux-mediatek@lists.infradead.org,
	Archie Pusaka <apusaka@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-serial@vger.kernel.org,
	Al Cooper <alcooperx@comcast.net>,
	linux-arm-kernel@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v2] serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup
Date: Wed, 24 Apr 2024 20:58:08 +0800
Message-ID: <20240424130619.2924456-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Rx in-band wakeup is enabled, set RTS to true in mtk8250_shutdown()
so the connected device can still send message and trigger IRQ when the
system is suspended.

Fixes: 18c9d4a3c249 ("serial: When UART is suspended, set RTS to false")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- Replase serial8250_set_mctrl() with serial8250_do_set_mctrl()

 drivers/tty/serial/8250/8250_mtk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c365a349421a..b9cca210e171 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -209,15 +209,19 @@ static int mtk8250_startup(struct uart_port *port)
 
 static void mtk8250_shutdown(struct uart_port *port)
 {
-#ifdef CONFIG_SERIAL_8250_DMA
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct mtk8250_data *data = port->private_data;
+	int irq = data->rx_wakeup_irq;
 
+#ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma)
 		data->rx_status = DMA_RX_SHUTDOWN;
 #endif
 
-	return serial8250_do_shutdown(port);
+	serial8250_do_shutdown(port);
+
+	if (irq >= 0)
+		serial8250_do_set_mctrl(&up->port, TIOCM_RTS);
 }
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
-- 
2.44.0.769.g3c40516874-goog


