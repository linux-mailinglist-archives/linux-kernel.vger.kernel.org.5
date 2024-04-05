Return-Path: <linux-kernel+bounces-133249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3189A136
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39572287D5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2716FF52;
	Fri,  5 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JwApyqAr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DC16F901;
	Fri,  5 Apr 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330979; cv=none; b=lRXrXagryPJfxIoNyT/m3LTU/jh/B85c9bkqizYgiPVJPlcPYVVB7FVsQAgjTAg1Nc42CHMHpRN8UrHUo+prJLi8HYegzAJVVTIBKIp0lkLYu6SEsYdPOHgJ7QUO3YBEnlgfAFpZefItTyMupUGMs9iqkPqTCJtyDtg+Bms9htg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330979; c=relaxed/simple;
	bh=IIIGyyKI8lm6kXF2niRXOMx7x/z9Oko3GrEMChdxSLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS2FjjsvhA2Y//CMUj6XMia93Lhd5TkgIAyV0W5I39pyvRSMJSo0D8NVOt5fiwjOzVaQj8B9ZiUDBrPn0DzcnnDROq9mJI67UmNMibLd0g7oM3dO4UXBv/pGToqz2S6fkO1ZP6JUkQaJpoWj8W4T2LsLYZ0mQzqQNv6f3eR/WJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JwApyqAr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435ExGMv000633;
	Fri, 5 Apr 2024 15:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=fED7YOucqyq7kAdONELemolGAxqI5jBK0vP+KgDdOAM=;
 b=JwApyqArFDJFgO11mONK2HZBfmiMPS5DpP2DofBx8CBjWIKSTajhf6FoU7OSvRJ+CkE7
 FP+RI2B7KzTklUv07eyz0cieGOTsoOcHcjJ+z6GpfL+4QPgfo3b7U6iIgPI0/QUDeyCN
 1T3iXi1SOoQWPmvg7NX5tB8qsH5/LUAv/Nfi14fKZQx6yfaC5wMT7rk2l9Uh5kR+ZtO9
 /63jDCtkdEsEV0lkCRT/yFKBxASDb70PMe2ERVlfe7oerbZL4YJHJhGjcGqakTaZyp7q
 /1zd9+lrwawDCcq1fIZPRlNINZaSZeYX31xQxV+2yj2cIqsN3Ol/pTLJuys/vrZnY2ZU pQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xak2rr7mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:29:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 435DUqUw009116;
	Fri, 5 Apr 2024 15:29:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epy36nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:29:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435FTO0K3735920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 15:29:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF9E320071;
	Fri,  5 Apr 2024 15:29:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97C6E2006E;
	Fri,  5 Apr 2024 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 15:29:24 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Date: Fri,  5 Apr 2024 17:29:24 +0200
Message-Id: <20240405152924.252598-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405152924.252598-1-schnelle@linux.ibm.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X0T8dfEzTbnk5qGofqdhM2G4MNJPPapu
X-Proofpoint-ORIG-GUID: X0T8dfEzTbnk5qGofqdhM2G4MNJPPapu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050111

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them unconditionally. For 8250 based drivers some support
MMIO only use so fence only the parts requiring I/O ports.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

Note 2: This was previously acked here:
https://lore.kernel.org/all/2023053050-prodigal-shine-4d1c@gregkh/
Given this was almost a year ago and didn't apply then I didn't
carry the Ack over though.

 drivers/tty/Kconfig                  |  4 +--
 drivers/tty/serial/8250/8250_early.c |  4 +++
 drivers/tty/serial/8250/8250_pci.c   | 14 ++++++++++
 drivers/tty/serial/8250/8250_port.c  | 42 +++++++++++++++++++++++-----
 drivers/tty/serial/8250/Kconfig      |  7 ++---
 drivers/tty/serial/Kconfig           |  2 +-
 6 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index a45d423ad10f..63a494d36a1f 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -220,7 +220,7 @@ config MOXA_INTELLIO
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && PCI
+	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
@@ -302,7 +302,7 @@ config GOLDFISH_TTY_EARLY_CONSOLE
 
 config IPWIRELESS
 	tristate "IPWireless 3G UMTS PCMCIA card support"
-	depends on PCMCIA && NETDEVICES
+	depends on PCMCIA && NETDEVICES && HAS_IOPORT
 	select PPP
 	help
 	  This is a driver for 3G UMTS PCMCIA card from IPWireless company. In
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index e3f482fd3de4..8f9aec2e7c7d 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -46,8 +46,10 @@ static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 		return readl(port->membase + offset);
 	case UPIO_MEM32BE:
 		return ioread32be(port->membase + offset);
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
+#endif
 	default:
 		return 0;
 	}
@@ -70,9 +72,11 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 	case UPIO_MEM32BE:
 		iowrite32be(value, port->membase + offset);
 		break;
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
+#endif
 	}
 }
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0d35c77fad9e..38ac5236d2ea 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -928,6 +928,7 @@ static int pci_netmos_init(struct pci_dev *dev)
 	return num_serial;
 }
 
+#ifdef CONFIG_HAS_IOPORT
 /*
  * These chips are available with optionally one parallel port and up to
  * two serial ports. Unfortunately they all have the same product id.
@@ -1054,6 +1055,7 @@ static void pci_ite887x_exit(struct pci_dev *dev)
 	ioport &= 0xffff;
 	release_region(ioport, ITE_887x_IOSIZE);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 /*
  * Oxford Semiconductor Inc.
@@ -1328,6 +1330,7 @@ static int pci_oxsemi_tornado_setup(struct serial_private *priv,
 #define QOPR_CLOCK_X8		0x0003
 #define QOPR_CLOCK_RATE_MASK	0x0003
 
+#ifdef CONFIG_HAS_IOPORT
 /* Quatech devices have their own extra interface features */
 static struct pci_device_id quatech_cards[] = {
 	{ PCI_DEVICE_DATA(QUATECH, QSC100,   1) },
@@ -1547,6 +1550,7 @@ static int pci_quatech_setup(struct serial_private *priv,
 		pci_warn(priv->dev, "software control of RS422 features not currently supported.\n");
 	return pci_default_setup(priv, board, port, idx);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static int pci_default_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
@@ -1826,6 +1830,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static void kt_handle_break(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
@@ -1869,6 +1874,7 @@ static int kt_serial_setup(struct serial_private *priv,
 	port->port.handle_break = kt_handle_break;
 	return skip_tx_en_setup(priv, board, port, idx);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static int pci_eg20t_init(struct pci_dev *dev)
 {
@@ -1913,6 +1919,7 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define CH384_XINT_ENABLE_REG   0xEB
 #define CH384_XINT_ENABLE_BIT   0x02
 
+#ifdef CONFIG_HAS_IOPORT
 static int pci_wch_ch38x_init(struct pci_dev *dev)
 {
 	int max_port;
@@ -1940,6 +1947,7 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
 	iobase = pci_resource_start(dev, 0);
 	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 
 static int
@@ -2171,6 +2179,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= ce4100_serial_setup,
 	},
+#ifdef CONFIG_HAS_IOPORT
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_PATSBURG_KT,
@@ -2190,6 +2199,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.setup		= pci_default_setup,
 		.exit		= pci_ite887x_exit,
 	},
+#endif
 	/*
 	 * National Instruments
 	 */
@@ -2311,6 +2321,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.exit		= pci_ni8430_exit,
 	},
 	/* Quatech */
+#ifdef CONFIG_HAS_IOPORT
 	{
 		.vendor		= PCI_VENDOR_ID_QUATECH,
 		.device		= PCI_ANY_ID,
@@ -2319,6 +2330,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_quatech_init,
 		.setup		= pci_quatech_setup,
 	},
+#endif
 	/*
 	 * Panacom
 	 */
@@ -2836,6 +2848,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
+#ifdef CONFIG_HAS_IOPORT
 	/* WCH CH384 8S card (16850 clone) */
 	{
 		.vendor         = PCIE_VENDOR_ID_WCH,
@@ -2846,6 +2859,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.exit		= pci_wch_ch38x_exit,
 		.setup          = pci_wch_ch38x_setup,
 	},
+#endif
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fc9dd5d45295..1c5e39c1a469 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -338,6 +338,7 @@ static void default_serial_dl_write(struct uart_8250_port *up, u32 value)
 	serial_out(up, UART_DLM, value >> 8 & 0xff);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -351,6 +352,7 @@ static void hub6_serial_out(struct uart_port *p, int offset, int value)
 	outb(p->hub6 - 1 + offset, p->iobase);
 	outb(value, p->iobase + 1);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
@@ -400,6 +402,7 @@ static unsigned int mem32be_serial_in(struct uart_port *p, int offset)
 	return ioread32be(p->membase + offset);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -411,6 +414,24 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 	offset = offset << p->regshift;
 	outb(value, p->iobase + offset);
 }
+#endif
+static unsigned int no_serial_in(struct uart_port *p, int offset)
+{
+	return (unsigned int)-1;
+}
+
+static void no_serial_out(struct uart_port *p, int offset, int value)
+{
+}
+
+#ifdef CONFIG_HAS_IOPORT
+static inline bool is_upf_fourport(struct uart_port *port)
+{
+	return port->flags & UPF_FOURPORT;
+}
+#else
+#define is_upf_fourport(x)	false
+#endif
 
 static int serial8250_default_handle_irq(struct uart_port *port);
 
@@ -422,10 +443,12 @@ static void set_io_from_upio(struct uart_port *p)
 	up->dl_write = default_serial_dl_write;
 
 	switch (p->iotype) {
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_HUB6:
 		p->serial_in = hub6_serial_in;
 		p->serial_out = hub6_serial_out;
 		break;
+#endif
 
 	case UPIO_MEM:
 		p->serial_in = mem_serial_in;
@@ -446,11 +469,16 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_in = mem32be_serial_in;
 		p->serial_out = mem32be_serial_out;
 		break;
-
-	default:
+#ifdef CONFIG_HAS_IOPORT
+	case UPIO_PORT:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
 		break;
+#endif
+	default:
+		WARN(1, "Unsupported UART type %x\n", p->iotype);
+		p->serial_in = no_serial_in;
+		p->serial_out = no_serial_out;
 	}
 	/* Remember loaded iotype */
 	up->cur_iotype = p->iotype;
@@ -1318,7 +1346,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	unsigned long irqs;
 	int irq;
 
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		ICP = (port->iobase & 0xfe0) | 0x1f;
 		save_ICP = inb_p(ICP);
 		outb_p(0x80, ICP);
@@ -1337,7 +1365,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	irqs = probe_irq_on();
 	serial8250_out_MCR(up, 0);
 	udelay(10);
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
 	} else {
 		serial8250_out_MCR(up,
@@ -1361,7 +1389,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	serial_out(up, UART_IER, save_ier);
 	uart_port_unlock_irq(port);
 
-	if (port->flags & UPF_FOURPORT)
+	if (is_upf_fourport(port))
 		outb_p(save_ICP, ICP);
 
 	port->irq = (irq > 0) ? irq : 0;
@@ -2438,7 +2466,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		unsigned int icp;
 		/*
 		 * Enable interrupts on the AST Fourport board
@@ -2483,7 +2511,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		serial8250_release_dma(up);
 
 	uart_port_lock_irqsave(port, &flags);
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
 		port->mctrl |= TIOCM_OUT1;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 47ff50763c04..54bf98869abf 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -6,7 +6,6 @@
 
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
-	depends on !S390
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
@@ -72,7 +71,7 @@ config SERIAL_8250_16550A_VARIANTS
 
 config SERIAL_8250_FINTEK
 	bool "Support for Fintek variants"
-	depends on SERIAL_8250
+	depends on SERIAL_8250 && HAS_IOPORT
 	help
 	  Selecting this option will add support for the RS232 and RS485
 	  capabilities of the Fintek F81216A LPC to 4 UART as well similar
@@ -136,7 +135,7 @@ config SERIAL_8250_PCILIB
 
 config SERIAL_8250_PCI
 	tristate "8250/16550 PCI device support"
-	depends on SERIAL_8250 && PCI
+	depends on SERIAL_8250 && PCI && HAS_IOPORT
 	select SERIAL_8250_PCILIB
 	default SERIAL_8250
 	help
@@ -163,7 +162,7 @@ config SERIAL_8250_HP300
 
 config SERIAL_8250_CS
 	tristate "8250/16550 PCMCIA device support"
-	depends on PCMCIA && SERIAL_8250
+	depends on PCMCIA && SERIAL_8250 && HAS_IOPORT
 	help
 	  Say Y here to enable support for 16-bit PCMCIA serial devices,
 	  including serial port cards, modems, and the modem functions of
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ffcf4882b25f..92c85e805c2a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -874,7 +874,7 @@ config SERIAL_TXX9_STDSERIAL
 
 config SERIAL_JSM
 	tristate "Digi International NEO and Classic PCI Support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select SERIAL_CORE
 	help
 	  This is a driver for Digi International's Neo and Classic series
-- 
2.40.1


