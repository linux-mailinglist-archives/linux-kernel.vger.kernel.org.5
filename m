Return-Path: <linux-kernel+bounces-148037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6A8A7CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934561C20F87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1987581A;
	Wed, 17 Apr 2024 07:14:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43C6BB2F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338047; cv=none; b=nNyQoBdv9RbRsVTtjpBDI5WijW2iUenOuzjExklxWt2kJ7XBaMZIIE5+TNkZtsPLi+F/X7IdSVPrnwtgEoJFAHXdcLQJrxW9dRs3BVN7SurSnWBWxeB2VJYqLv04kz4KoEVe2tsXDmIJEjX4+rhENkmNjvI1gXvHVDj+xYi9WB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338047; c=relaxed/simple;
	bh=mhyVdZJDhRW00f5UtmFd6YKLacgNjSITB/zK1oRf0j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEjNoAYN/y1zKNOHOrft+uGfOM0MN6+/JSDLXUcQc2LmtSTYw3401+kWMjeqBFj1ZiPx92VLZCpO5u7CoSlkdvErgsUmElaITg/OizXtaxO56uz7lziZUDcxoDUfmXXMwx6ra/J5JJ9KXRFKIhs89YN4yibH/LXMnjbjF3TvF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUB-0003Vw-ES; Wed, 17 Apr 2024 09:13:39 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUA-00Ckam-Ab; Wed, 17 Apr 2024 09:13:38 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUA-004DbZ-0b;
	Wed, 17 Apr 2024 09:13:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Apr 2024 09:13:29 +0200
Subject: [PATCH 2/4] mtd: nand: mxc_nand: implement exec_op
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-mtd-nand-mxc-nand-exec-op-v1-2-d12564fe54e9@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
In-Reply-To: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713338018; l=17179;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=mhyVdZJDhRW00f5UtmFd6YKLacgNjSITB/zK1oRf0j8=;
 b=HXOSD7UL09Wsyc1G6K0W75K8ORwH75ndYLPXQPy7+WBabotQMYM+DMOUMwlRh0fekinB8rTqj
 e1N7keKtWDLB1LFLU2uVehKKLTrrbpsWfEOzkkgyhOxd2ou6/Vb0Dir
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This converts the driver to the more modern exec_op which gets us rid
of a bunch of legacy code. Tested on i.MX27 and i.MX25.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/mxc_nand.c | 423 ++++++++++++----------------------------
 1 file changed, 129 insertions(+), 294 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 3fe0b471f4a2d..fc70c65dea268 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -126,8 +126,7 @@ struct mxc_nand_host;
 
 struct mxc_nand_devtype_data {
 	void (*preset)(struct mtd_info *);
-	int (*read_page)(struct nand_chip *chip, void *buf, void *oob, bool ecc,
-			 int page);
+	int (*read_page)(struct nand_chip *chip);
 	void (*send_cmd)(struct mxc_nand_host *, uint16_t, int);
 	void (*send_addr)(struct mxc_nand_host *, uint16_t, int);
 	void (*send_page)(struct mtd_info *, unsigned int);
@@ -182,8 +181,7 @@ struct mxc_nand_host {
 
 	struct completion	op_completion;
 
-	uint8_t			*data_buf;
-	unsigned int		buf_start;
+	void			*data_buf;
 
 	const struct mxc_nand_devtype_data *devtype_data;
 };
@@ -285,63 +283,6 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom, void *buf)
 	}
 }
 
-/*
- * MXC NANDFC can only perform full page+spare or spare-only read/write.  When
- * the upper layers perform a read/write buf operation, the saved column address
- * is used to index into the full page. So usually this function is called with
- * column == 0 (unless no column cycle is needed indicated by column == -1)
- */
-static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
-{
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
-
-	/* Write out column address, if necessary */
-	if (column != -1) {
-		host->devtype_data->send_addr(host, column & 0xff,
-					      page_addr == -1);
-		if (mtd->writesize > 512)
-			/* another col addr cycle for 2k page */
-			host->devtype_data->send_addr(host,
-						      (column >> 8) & 0xff,
-						      false);
-	}
-
-	/* Write out page address, if necessary */
-	if (page_addr != -1) {
-		/* paddr_0 - p_addr_7 */
-		host->devtype_data->send_addr(host, (page_addr & 0xff), false);
-
-		if (mtd->writesize > 512) {
-			if (mtd->size >= 0x10000000) {
-				/* paddr_8 - paddr_15 */
-				host->devtype_data->send_addr(host,
-						(page_addr >> 8) & 0xff,
-						false);
-				host->devtype_data->send_addr(host,
-						(page_addr >> 16) & 0xff,
-						true);
-			} else
-				/* paddr_8 - paddr_15 */
-				host->devtype_data->send_addr(host,
-						(page_addr >> 8) & 0xff, true);
-		} else {
-			if (nand_chip->options & NAND_ROW_ADDR_3) {
-				/* paddr_8 - paddr_15 */
-				host->devtype_data->send_addr(host,
-						(page_addr >> 8) & 0xff,
-						false);
-				host->devtype_data->send_addr(host,
-						(page_addr >> 16) & 0xff,
-						true);
-			} else
-				/* paddr_8 - paddr_15 */
-				host->devtype_data->send_addr(host,
-						(page_addr >> 8) & 0xff, true);
-		}
-	}
-}
-
 static int check_int_v3(struct mxc_nand_host *host)
 {
 	uint32_t tmp;
@@ -763,18 +704,7 @@ static void mxc_nand_enable_hwecc_v3(struct nand_chip *chip, bool enable)
 	writel(config2, NFC_V3_CONFIG2);
 }
 
-/* This functions is used by upper layer to checks if device is ready */
-static int mxc_nand_dev_ready(struct nand_chip *chip)
-{
-	/*
-	 * NFC handles R/B internally. Therefore, this function
-	 * always returns status as ready.
-	 */
-	return 1;
-}
-
-static int mxc_nand_read_page_v1(struct nand_chip *chip, void *buf, void *oob,
-				 bool ecc, int page)
+static int mxc_nand_read_page_v1(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
@@ -782,14 +712,6 @@ static int mxc_nand_read_page_v1(struct nand_chip *chip, void *buf, void *oob,
 	int i;
 	unsigned int ecc_stats = 0;
 
-	host->devtype_data->enable_hwecc(chip, ecc);
-
-	host->devtype_data->send_cmd(host, NAND_CMD_READ0, false);
-	mxc_do_addr_cycle(mtd, 0, page);
-
-	if (mtd->writesize > 512)
-		host->devtype_data->send_cmd(host, NAND_CMD_READSTART, true);
-
 	no_subpages = mtd->writesize >> 9;
 
 	for (i = 0; i < no_subpages; i++) {
@@ -807,78 +729,72 @@ static int mxc_nand_read_page_v1(struct nand_chip *chip, void *buf, void *oob,
 
 	host->ecc_stats_v1 = ecc_stats;
 
-	if (buf)
-		memcpy32_fromio(buf, host->main_area0, mtd->writesize);
-	if (oob)
-		copy_spare(mtd, true, oob);
-
 	return 0;
 }
 
-static int mxc_nand_read_page_v2_v3(struct nand_chip *chip, void *buf,
-				    void *oob, bool ecc, int page)
+static int mxc_nand_read_page_v2_v3(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 
-	host->devtype_data->enable_hwecc(chip, ecc);
-
-	host->devtype_data->send_cmd(host, NAND_CMD_READ0, false);
-	mxc_do_addr_cycle(mtd, 0, page);
-
-	if (mtd->writesize > 512)
-		host->devtype_data->send_cmd(host,
-				NAND_CMD_READSTART, true);
-
 	host->devtype_data->send_page(mtd, NFC_OUTPUT);
 
-	if (buf)
-		memcpy32_fromio(buf, host->main_area0, mtd->writesize);
-	if (oob)
-		copy_spare(mtd, true, oob);
-
 	return 0;
 }
 
 static int mxc_nand_read_page(struct nand_chip *chip, uint8_t *buf,
 			      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
-	void *oob_buf;
 	int ret;
 
-	if (oob_required)
-		oob_buf = chip->oob_poi;
-	else
-		oob_buf = NULL;
+	host->devtype_data->enable_hwecc(chip, true);
 
-	ret = host->devtype_data->read_page(chip, buf, oob_buf, 1, page);
+	ret = nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (ret)
 		return ret;
 
+	if (oob_required)
+		copy_spare(mtd, true, chip->oob_poi);
+
 	return host->devtype_data->get_ecc_status(chip);
 }
 
 static int mxc_nand_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 				  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
-	void *oob_buf;
+	int ret;
+
+	host->devtype_data->enable_hwecc(chip, false);
+
+	ret = nand_read_page_op(chip, page, 0, buf, mtd->writesize);
+	if (ret)
+		return ret;
 
 	if (oob_required)
-		oob_buf = chip->oob_poi;
-	else
-		oob_buf = NULL;
+		copy_spare(mtd, true, chip->oob_poi);
 
-	return host->devtype_data->read_page(chip, buf, oob_buf, 0, page);
+	return 0;
 }
 
 static int mxc_nand_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
+	int ret;
+
+	host->devtype_data->enable_hwecc(chip, false);
+
+	ret = nand_read_page_op(chip, page, 0, host->data_buf, mtd->writesize);
+	if (ret)
+		return ret;
 
-	return host->devtype_data->read_page(chip, NULL, chip->oob_poi, 0,
-					     page);
+	copy_spare(mtd, true, chip->oob_poi);
+
+	return 0;
 }
 
 static int mxc_nand_write_page(struct nand_chip *chip, const uint8_t *buf,
@@ -889,17 +805,7 @@ static int mxc_nand_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	host->devtype_data->enable_hwecc(chip, ecc);
 
-	host->devtype_data->send_cmd(host, NAND_CMD_SEQIN, false);
-	mxc_do_addr_cycle(mtd, 0, page);
-
-	memcpy32_toio(host->main_area0, buf, mtd->writesize);
-	copy_spare(mtd, false, chip->oob_poi);
-
-	host->devtype_data->send_page(mtd, NFC_INPUT);
-	host->devtype_data->send_cmd(host, NAND_CMD_PAGEPROG, true);
-	mxc_do_addr_cycle(mtd, 0, page);
-
-	return 0;
+	return nand_prog_page_op(chip, page, 0, buf, mtd->writesize);
 }
 
 static int mxc_nand_write_page_ecc(struct nand_chip *chip, const uint8_t *buf,
@@ -924,66 +830,6 @@ static int mxc_nand_write_oob(struct nand_chip *chip, int page)
 	return mxc_nand_write_page(chip, host->data_buf, false, page);
 }
 
-static u_char mxc_nand_read_byte(struct nand_chip *nand_chip)
-{
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
-	uint8_t ret;
-
-	/* Check for status request */
-	if (host->status_request)
-		return host->devtype_data->get_dev_status(host) & 0xFF;
-
-	if (nand_chip->options & NAND_BUSWIDTH_16) {
-		/* only take the lower byte of each word */
-		ret = *(uint16_t *)(host->data_buf + host->buf_start);
-
-		host->buf_start += 2;
-	} else {
-		ret = *(uint8_t *)(host->data_buf + host->buf_start);
-		host->buf_start++;
-	}
-
-	dev_dbg(host->dev, "%s: ret=0x%hhx (start=%u)\n", __func__, ret, host->buf_start);
-	return ret;
-}
-
-/* Write data of length len to buffer buf. The data to be
- * written on NAND Flash is first copied to RAMbuffer. After the Data Input
- * Operation by the NFC, the data is written to NAND Flash */
-static void mxc_nand_write_buf(struct nand_chip *nand_chip, const u_char *buf,
-			       int len)
-{
-	struct mtd_info *mtd = nand_to_mtd(nand_chip);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
-	u16 col = host->buf_start;
-	int n = mtd->oobsize + mtd->writesize - col;
-
-	n = min(n, len);
-
-	memcpy(host->data_buf + col, buf, n);
-
-	host->buf_start += n;
-}
-
-/* Read the data buffer from the NAND Flash. To read the data from NAND
- * Flash first the data output cycle is initiated by the NFC, which copies
- * the data to RAMbuffer. This data of length len is then copied to buffer buf.
- */
-static void mxc_nand_read_buf(struct nand_chip *nand_chip, u_char *buf,
-			      int len)
-{
-	struct mtd_info *mtd = nand_to_mtd(nand_chip);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
-	u16 col = host->buf_start;
-	int n = mtd->oobsize + mtd->writesize - col;
-
-	n = min(n, len);
-
-	memcpy(buf, host->data_buf + col, n);
-
-	host->buf_start += n;
-}
-
 /* This function is used by upper layer for select and
  * deselect of the NAND chip */
 static void mxc_nand_select_chip_v1_v3(struct nand_chip *nand_chip, int chip)
@@ -1360,107 +1206,6 @@ static void preset_v3(struct mtd_info *mtd)
 	writel(0, NFC_V3_DELAY_LINE);
 }
 
-/* Used by the upper layer to write command to NAND Flash for
- * different operations to be carried out on NAND Flash */
-static void mxc_nand_command(struct nand_chip *nand_chip, unsigned command,
-			     int column, int page_addr)
-{
-	struct mtd_info *mtd = nand_to_mtd(nand_chip);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
-
-	dev_dbg(host->dev, "mxc_nand_command (cmd = 0x%x, col = 0x%x, page = 0x%x)\n",
-	      command, column, page_addr);
-
-	/* Reset command state information */
-	host->status_request = false;
-
-	/* Command pre-processing step */
-	switch (command) {
-	case NAND_CMD_RESET:
-		host->devtype_data->preset(mtd);
-		host->devtype_data->send_cmd(host, command, false);
-		break;
-
-	case NAND_CMD_STATUS:
-		host->buf_start = 0;
-		host->status_request = true;
-
-		host->devtype_data->send_cmd(host, command, true);
-		WARN_ONCE(column != -1 || page_addr != -1,
-			  "Unexpected column/row value (cmd=%u, col=%d, row=%d)\n",
-			  command, column, page_addr);
-		mxc_do_addr_cycle(mtd, column, page_addr);
-		break;
-
-	case NAND_CMD_READID:
-		host->devtype_data->send_cmd(host, command, true);
-		mxc_do_addr_cycle(mtd, column, page_addr);
-		host->devtype_data->send_read_id(host);
-		host->buf_start = 0;
-		break;
-
-	case NAND_CMD_ERASE1:
-	case NAND_CMD_ERASE2:
-		host->devtype_data->send_cmd(host, command, false);
-		WARN_ONCE(column != -1,
-			  "Unexpected column value (cmd=%u, col=%d)\n",
-			  command, column);
-		mxc_do_addr_cycle(mtd, column, page_addr);
-
-		break;
-	case NAND_CMD_PARAM:
-		host->devtype_data->send_cmd(host, command, false);
-		mxc_do_addr_cycle(mtd, column, page_addr);
-		host->devtype_data->send_page(mtd, NFC_OUTPUT);
-		memcpy32_fromio(host->data_buf, host->main_area0, 512);
-		host->buf_start = 0;
-		break;
-	default:
-		WARN_ONCE(1, "Unimplemented command (cmd=%u)\n",
-			  command);
-		break;
-	}
-}
-
-static int mxc_nand_set_features(struct nand_chip *chip, int addr,
-				 u8 *subfeature_param)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct mxc_nand_host *host = nand_get_controller_data(chip);
-	int i;
-
-	host->buf_start = 0;
-
-	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->legacy.write_byte(chip, subfeature_param[i]);
-
-	memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
-	host->devtype_data->send_cmd(host, NAND_CMD_SET_FEATURES, false);
-	mxc_do_addr_cycle(mtd, addr, -1);
-	host->devtype_data->send_page(mtd, NFC_INPUT);
-
-	return 0;
-}
-
-static int mxc_nand_get_features(struct nand_chip *chip, int addr,
-				 u8 *subfeature_param)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct mxc_nand_host *host = nand_get_controller_data(chip);
-	int i;
-
-	host->devtype_data->send_cmd(host, NAND_CMD_GET_FEATURES, false);
-	mxc_do_addr_cycle(mtd, addr, -1);
-	host->devtype_data->send_page(mtd, NFC_OUTPUT);
-	memcpy32_fromio(host->data_buf, host->main_area0, 512);
-	host->buf_start = 0;
-
-	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		*subfeature_param++ = chip->legacy.read_byte(chip);
-
-	return 0;
-}
-
 /*
  * The generic flash bbt descriptors overlap with our ecc
  * hardware, so define some i.MX specific ones.
@@ -1717,9 +1462,106 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
 	return host->devtype_data->setup_interface(chip, chipnr, conf);
 }
 
+static int mxcnd_exec_op(struct nand_chip *chip,
+			 const struct nand_operation *op,
+			 bool check_only)
+{
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int i, j, buf_len;
+	void *buf_read = NULL;
+	const void *buf_write = NULL;
+	const struct nand_op_instr *instr;
+	bool readid = false;
+	bool statusreq = false;
+
+	dev_dbg(host->dev, "%s: %d instructions\n", __func__, op->ninstrs);
+
+	for (i = 0; i < op->ninstrs; i++) {
+		instr = &op->instrs[i];
+
+		nand_op_trace("  ", instr);
+
+		switch (instr->type) {
+		case NAND_OP_WAITRDY_INSTR:
+			/*
+			 * NFC handles R/B internally. Therefore, this function
+			 * always returns status as ready.
+			 */
+			break;
+		case NAND_OP_CMD_INSTR:
+			host->devtype_data->send_cmd(host, instr->ctx.cmd.opcode, true);
+
+			if (instr->ctx.cmd.opcode == NAND_CMD_READID)
+				readid = true;
+			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
+				statusreq = true;
+
+			break;
+		case NAND_OP_ADDR_INSTR:
+			for (j = 0; j < instr->ctx.addr.naddrs; j++) {
+				bool islast = j == instr->ctx.addr.naddrs - 1;
+				host->devtype_data->send_addr(host, instr->ctx.addr.addrs[j], islast);
+			}
+			break;
+		case NAND_OP_DATA_OUT_INSTR:
+			buf_write = instr->ctx.data.buf.out;
+			buf_len = instr->ctx.data.len;
+
+			memcpy32_toio(host->main_area0, buf_write, buf_len);
+			copy_spare(mtd, false, chip->oob_poi);
+
+			host->devtype_data->send_page(mtd, NFC_INPUT);
+
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+
+			buf_read = instr->ctx.data.buf.in;
+			buf_len = instr->ctx.data.len;
+
+			if (readid) {
+				host->devtype_data->send_read_id(host);
+				readid = false;
+
+				memcpy32_fromio(host->data_buf, host->main_area0, buf_len * 2);
+
+				if (chip->options & NAND_BUSWIDTH_16) {
+					u8 *bufr = buf_read;
+					u16 *bufw = host->data_buf;
+					for (j = 0; j < buf_len; j++)
+						bufr[j] = bufw[j];
+				} else {
+					memcpy(buf_read, host->data_buf, buf_len);
+				}
+				break;
+			}
+
+			if (statusreq) {
+				*(u8*)buf_read = host->devtype_data->get_dev_status(host);
+				statusreq = false;
+				break;
+			}
+
+			host->devtype_data->read_page(chip);
+
+			if (IS_ALIGNED(buf_len, 4)) {
+				memcpy32_fromio(buf_read, host->main_area0, buf_len);
+			} else {
+				memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
+				memcpy(buf_read, host->data_buf, buf_len);
+			}
+
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static const struct nand_controller_ops mxcnd_controller_ops = {
 	.attach_chip = mxcnd_attach_chip,
 	.setup_interface = mxcnd_setup_interface,
+	.exec_op = mxcnd_exec_op,
 };
 
 static int mxcnd_probe(struct platform_device *pdev)
@@ -1752,13 +1594,6 @@ static int mxcnd_probe(struct platform_device *pdev)
 
 	nand_set_controller_data(this, host);
 	nand_set_flash_node(this, pdev->dev.of_node);
-	this->legacy.dev_ready = mxc_nand_dev_ready;
-	this->legacy.cmdfunc = mxc_nand_command;
-	this->legacy.read_byte = mxc_nand_read_byte;
-	this->legacy.write_buf = mxc_nand_write_buf;
-	this->legacy.read_buf = mxc_nand_read_buf;
-	this->legacy.set_features = mxc_nand_set_features;
-	this->legacy.get_features = mxc_nand_get_features;
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))

-- 
2.39.2


