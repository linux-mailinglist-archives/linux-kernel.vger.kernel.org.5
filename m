Return-Path: <linux-kernel+bounces-48566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C27845DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E563B295B87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACDB2C1BE;
	Thu,  1 Feb 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBzWKH+j"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A71110
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806881; cv=none; b=V/e25M8I1YcvaZyvEHFsrMxsvo77LtGK09bhBWIVFLORHPpqz4lvK39QrzsowMIfv9etQKzXebBjLBBbcmCORa6jmCdcrH0SNCfyVY0rGfBuIIkBNz9OZoN9ygelrWzKKRAalgpiF35qA5V7yKr7f49KfN7HZOs6tyaKVizKLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806881; c=relaxed/simple;
	bh=DrHAC7RkwfDqc1oxkpOVbqt6yhn3e+LTvd+7kqDxTig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d7K1Thumv/5jXE9qv0PO+oxTfluTMxLKyzpBz+jIc2UN1oxIfgqSK4pfsavIXQyAm/NL85AxHXyuYOTXAO9TrR7zp6rglNI6nQjO7pObC7qsQzK+9+kClM24JalNe0GfmDSV6Uww3ayvMoVN9DaDSpAMnu/5BabMaByXoq2uT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vBzWKH+j; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso4389725a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706806877; x=1707411677; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAMYZ29lBsdGPxUL1irjwjWU2FkHld0iTyl+2jdjiP0=;
        b=vBzWKH+jf6k/N2zE6ec9QeWcNo6g7Nc/T3u8uqJ+FlTV/3ElHKxneN9Nok6fMG4NW/
         rggEkLne8nrotpnAEJTo0H8EpF8CkwR5OhNxSK6hYIIDEOFUXPUdgcHTu/s4zB+69uUe
         o0enTeayH/mrVjBtrHRsiP24rsZsGfCJ3HOqW8r+xQqNgbxm8jQcY08trJJ+IkbnpR+H
         tJsyC+ZF+1juSSBbhkjOt/yellwlHoqFU9TRS8FdqOsWWW4EPTLtzLXL1bTC8jN4a1Xn
         plDL3WW0+DKwI5EgP+pGgGk/95EmEpboYkskRkWr3dgngYXBE8Fa79niWv5Oma4LV+8t
         rYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806877; x=1707411677;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAMYZ29lBsdGPxUL1irjwjWU2FkHld0iTyl+2jdjiP0=;
        b=lACR6lEngQ54LCptom/HITfa7CGEzaGACWTqtYAyUK5VTXYmtqX4LXDPkrJjIqWNaM
         icqMgwAF0VmJpX0pKdfC0464ioNWwky+xrY+McLriTTktT1ul2NJh9PRho6RYMqtQ3we
         T+C5Hopwzr/6GFq0jGs2F+vH6eo9KXkdtkxDMPjKCs9BQ9dfjDShXkMJcmbjXCadQNdn
         tHR0z9oYyzUYixdN+fcDPd463YxMA+z2pAYqO2/VfV0PocxC59UBwXZfGl5IwSXM6gRX
         iWXOftb7aooEdLKGMqAOWCzxgxwxKJouZv11plM2fTUWlT5BjcPjsNdi1/IisU+5rdUZ
         WJhg==
X-Gm-Message-State: AOJu0YzwChhvTO7U+9oE40ZhIk7siLoazoxcLOP+gHB2CuspJAUUhLH7
	n780DmmLIXUue3cmRZReh8PO6GXUT2Nuk6ReEdPt0MNyaQsAsXAu0wLZhrBpJhM=
X-Google-Smtp-Source: AGHT+IFhXue5FO8rhEQL+Q+eQXWCKNdhL+u2R6afGtHd3FCWoJ3cju3h5V99Aj+V8SR7NPCOHaPa0A==
X-Received: by 2002:a17:906:5298:b0:a35:eeed:4885 with SMTP id c24-20020a170906529800b00a35eeed4885mr6798009ejm.20.1706806877114;
        Thu, 01 Feb 2024 09:01:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVDgBT+miQVjNb2PwyZDSCul5527s2GGTOeuZFJngfQ5PKPuJHb/hBpB/gwEUVJIWAbaiWhjNGzpruofn53uRqEbtGAfdZoRMLKDFj2auB4On9CkRSfI8i7le/3GqN12/hKMSE2nauCiE/n1IVBVB3tuUVNfsNygrG7kdPZ5I67GMNWSxb8egsjjQxKsZLc3vKoCXbo99GAmjy115rvEkqxjh+8hQvbdSj12125eQOaH8c3SLXQvX85U3jP2RJmos5+Z6qwKCwoDDn/YbD0T1N9SZ50wlZ24e1cGntAwXMkORXHCP0=
Received: from [10.167.154.1] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id st14-20020a170907c08e00b00a35c5491b58sm4398302ejc.174.2024.02.01.09.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:01:16 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 01 Feb 2024 18:01:12 +0100
Subject: [PATCH] Revert "tty: serial: amba-pl011: Remove QDF2xxx
 workarounds"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-topic-qdf24xx_is_back_apparently-v1-1-edb112a2ef90@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFfOu2UC/x2NQQ7CIBAAv9LsWRJA5OBXjCELXexGQhGqwTT9u
 8TjzGFmh0aVqcF12qHShxuveYA6TRAWzA8SPA8GLbWRWiqxrYWDeM1Rm94dN+cxPB2WgpXylr5
 CGRuDlYbO9gIj47GR8BVzWEYov1MaslSK3P/f2/04fmLFqQiHAAAA
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mark Brown <broonie@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706806875; l=4997;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DrHAC7RkwfDqc1oxkpOVbqt6yhn3e+LTvd+7kqDxTig=;
 b=0UcS/RkYdVykbj35TccJqM/MK9PJcRzWbx0/tHCHm4DyicyJDxFp1+d3PPpathJ5UNgD0b+wz
 F5JaLYFlLYTAd0Cr/Hb65kDgoI5mKBTxY5U9RuKSJRzwSu0ZNnjbrff
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The original commit assumed this hardware is long rotting in the
junkyards, but apparently Qualcomm is still using some of these old
servers internally and the thing can still run upstream.

Adding insult to injury, I apparently managed to overdelete code and broke
non-QDF2xxx platforms [1].

Revert the removal to keep things going, at least for now.

This reverts commit 196f34af2bf4c87ac4299a9775503d81b446980c.

[1] https://lore.kernel.org/lkml/20240131213543.958051-1-m.szyprowski@samsung.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 82 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4df9cbc264b..fccec1698a54 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -152,6 +152,23 @@ static const struct vendor_data vendor_sbsa = {
 	.fixed_options		= true,
 };
 
+#ifdef CONFIG_ACPI_SPCR_TABLE
+static const struct vendor_data vendor_qdt_qdf2400_e44 = {
+	.reg_offset		= pl011_std_offsets,
+	.fr_busy		= UART011_FR_TXFE,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
+	.inv_fr			= UART011_FR_TXFE,
+	.access_32b		= true,
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= true,
+	.fixed_options		= true,
+};
+#endif
+
 static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
 	[REG_ST_DMAWM] = ST_UART011_DMAWM,
@@ -2451,6 +2468,15 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 	resource_size_t addr;
 	int i;
 
+	/*
+	 * Systems affected by the Qualcomm Technologies QDF2400 E44 erratum
+	 * have a distinct console name, so make sure we check for that.
+	 * The actual implementation of the erratum occurs in the probe
+	 * function.
+	 */
+	if ((strcmp(name, "qdf2400_e44") != 0) && (strcmp(name, "pl011") != 0))
+		return -ENODEV;
+
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
 
@@ -2491,6 +2517,22 @@ static struct console amba_console = {
 
 #define AMBA_CONSOLE	(&amba_console)
 
+static void qdf2400_e44_putc(struct uart_port *port, unsigned char c)
+{
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		cpu_relax();
+	writel(c, port->membase + UART01x_DR);
+	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
+		cpu_relax();
+}
+
+static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
+}
+
 static void pl011_putc(struct uart_port *port, unsigned char c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2569,6 +2611,29 @@ OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
 
+/*
+ * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
+ * Erratum 44, traditional earlycon can be enabled by specifying
+ * "earlycon=qdf2400_e44,<address>".  Any options are ignored.
+ *
+ * Alternatively, you can just specify "earlycon", and the early console
+ * will be enabled with the information from the SPCR table.  In this
+ * case, the SPCR code will detect the need for the E44 work-around,
+ * and set the console name to "qdf2400_e44".
+ */
+static int __init
+qdf2400_e44_early_console_setup(struct earlycon_device *device,
+				const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = qdf2400_e44_early_write;
+	return 0;
+}
+
+EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
+
 #else
 #define AMBA_CONSOLE	NULL
 #endif
@@ -2804,6 +2869,22 @@ static int pl011_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
 
+#ifdef CONFIG_ACPI_SPCR_TABLE
+static void qpdf2400_erratum44_workaround(struct device *dev,
+					  struct uart_amba_port *uap)
+{
+	if (!qdf2400_e44_present)
+		return;
+
+	dev_info(dev, "working around QDF2400 SoC erratum 44\n");
+	uap->vendor = &vendor_qdt_qdf2400_e44;
+}
+#else
+static void qpdf2400_erratum44_workaround(struct device *dev,
+					  struct uart_amba_port *uap)
+{ /* empty */ }
+#endif
+
 static int sbsa_uart_probe(struct platform_device *pdev)
 {
 	struct uart_amba_port *uap;
@@ -2840,6 +2921,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	uap->port.irq	= ret;
 
 	uap->vendor = &vendor_sbsa;
+	qpdf2400_erratum44_workaround(&pdev->dev, uap);
 
 	uap->reg_offset	= uap->vendor->reg_offset;
 	uap->fifosize	= 32;

---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240201-topic-qdf24xx_is_back_apparently-146fc604e365

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


