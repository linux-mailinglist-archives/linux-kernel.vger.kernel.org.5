Return-Path: <linux-kernel+bounces-156880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874E8B09CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2B286138
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA6156C68;
	Wed, 24 Apr 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/qGcbEb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EC1422AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962144; cv=none; b=X6v3Ji7esiz5jWXqbVzPR7m9K0aV7lQb34bU+NUkegoaQucdpN5Ii0gov5cDWNS6KV7Z7/0WaLJgaOHW+Pld4AX/OsA5+7tnUnIbvE6Vg8dIf/bh/2N8gU80iAwgfluzZPqnrqFmvC2FJwSl731DugPKKVmMPig+CM4TGB9nCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962144; c=relaxed/simple;
	bh=tz7Oii86HfqXKdwoE4jn2iaMVvXTeikBn+Xn3ghijUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tkrp4NX6jKDe8CwEyuwHQjRgxFPPnZZJSAuCT/690j2LxZ0/jOYSO1KNdCsLlYKrJqk3KTHCn4/ZWph4lUt6hT0PVWs33Mm2Zy3n9kfX0rQLrhLJvR9kr8YkBCGmXPh98fuGupmW73PZeh9CkRo273pkc6Z1diYL0U2+sAXQK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/qGcbEb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e5c7d087e1so55405545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713962142; x=1714566942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5X7I2pd4YE3kiP0pgemZkKwYiW8XQQ/yrWjXfFYyKc=;
        b=H/qGcbEbN19xZL4OXU3zgktrE4MvuLKlfCyZrrO/bXiahI/DMoFL6RicsurevG36z9
         Secx688uFBjGYPPE72Md9/tELPWvN3Rcjq1aYDjz4jUj5+O4TQKveTyDIOmnuwJx0g6B
         Gc1AKajwu84X9aEbsaci0CAZkmeWAXVOVUxtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713962142; x=1714566942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5X7I2pd4YE3kiP0pgemZkKwYiW8XQQ/yrWjXfFYyKc=;
        b=CyMGQQQgNro8zK52yNzTsnG2fauRjf0HHe1mL4Isuf6Ep6oV4Iv24CYaoAAcFwdRln
         k5UBGX57Tv5RGjys25GDnr6d3fBSzpU1fDZi6/pRsnKynhFJIAf9/c81P/huauK4E/W4
         kbsIwfpfQQnxvb0t1Bbd+0dhMGbisc66Zh1KDIpjNnrD/XOiUnul57Kcc4g82YKE5MXL
         SA6+wno6nGAGzW4WykuuAQ6GSULy7ZyVm7ea9G9IoRk7raY2rqGMSdecqaV2l8nbh5ZX
         BlJLvhO4PiarUi8FQftfW15pPWHtveYskI3qA9VdS74qg6/FvbRrrtyeA9606ZmL+Oih
         JAVw==
X-Forwarded-Encrypted: i=1; AJvYcCVL2oSE+tyXgzjeQZkk/x3a7OkaWUtw3js3ip5WAs1gyu4fZhOqsa46RFKo2A50LuJzKBzsBq8yWJlnwyjSuLcAKe1fTWAGloMKUpqd
X-Gm-Message-State: AOJu0YwFJZicGWtJtriiPy6St4wASzWWtI/pKIwaXVHElfrv+QDUOtnQ
	C6gCa9VzGQsRZzvEG61rL6IXZvefIapaXVX0IXLx6vYG4OYWEMxXSBQr2rYsSQ==
X-Google-Smtp-Source: AGHT+IEuUAZNA/Wxz1q95leP9HcOFZM8mHKpCqv7tHCLZaCxrPO0Fns8nowhDeSKlbiYYDqIEIkIfQ==
X-Received: by 2002:a17:902:e889:b0:1e6:34f9:f730 with SMTP id w9-20020a170902e88900b001e634f9f730mr2468612plg.52.1713962142435;
        Wed, 24 Apr 2024 05:35:42 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:836:835b:e0f2:a3a0])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001e28d7329e6sm11826176plb.91.2024.04.24.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:35:42 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-kernel@vger.kernel.org,
	Al Cooper <alcooperx@comcast.net>,
	Archie Pusaka <apusaka@chromium.org>,
	KidmanLee <kidman@realtek.com>,
	Hilda Wu <hildawu@realtek.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup
Date: Wed, 24 Apr 2024 20:32:47 +0800
Message-ID: <20240424123331.2872272-1-treapking@chromium.org>
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

 drivers/tty/serial/8250/8250_mtk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c365a349421a..b7ed55eaf05b 100644
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
+		serial8250_set_mctrl(&up->port, TIOCM_RTS);
 }
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
-- 
2.44.0.769.g3c40516874-goog


