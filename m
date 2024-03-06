Return-Path: <linux-kernel+bounces-94079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1A873995
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547451C22C55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A913442A;
	Wed,  6 Mar 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="d6/6q03C"
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29780605
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.198.35.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736328; cv=none; b=I+e0Q4cPlFcvkXcs4b3M27R2G3z3Tp+4f5qmn58G5cHYJ4zgGnWTZUWCJ2uCdibOFqWFQTzdoeW+4lHymsMYfyA9rODIYa4utDn2UwOlc6EcDfPyF5zOEBGoFX6skTosaMfeE0gu/UPgFgBCvsdLpn8m2Av0IxI9tsrQqBpuVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736328; c=relaxed/simple;
	bh=TxpwDgRzQLK3lBYJgI5yYPm+twP4Ya6a07JXU1KkTFg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=F8/x0jqrnuDHGpt2qOD3xgTob1xfgNT7r2W+hIZG5DaUHMh+ddf/O/v3wN07y2fK+PGZHjOcI7/xms44O//p4XKxwKZP21HceRlsCBi8Ao5V5C6ax1nIj7PHOl4kep9xcxlvhSWCVugIIMuJH5qsnWefN1+AwNBGnLaVIPTZUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=d6/6q03C; arc=none smtp.client-ip=92.198.35.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Date: Wed, 6 Mar 2024 15:36:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
	t=1709735767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=7jCdvnKrinLLfLtx8TMEpiZHox5gBJf77z1PKz+bvrY=;
	b=d6/6q03CvvzyUSka3C4XlwHu/RNS/55OXwRb9mJjGJt7/POiqIpjeTLHh88hJA3losJf3A
	xU7eAy4X/6xNLKafzNq/48HPDXxJNMt3Y/OaXDV4ecXWp3BdHyt4Z2f769DEely3mIjA2g
	dpjTGksTmm0p9GPFhyyDfZQyj/MJcr8IQalifYToxtlslCcYp56mD9FhBT8mcsnSvKXjja
	Da8+fZpN2cnu4rZAZH6q04YcYVLR1IY6ng11Ryv833Podj6ZI05N59Koz+8moL7sDIg5Se
	CJdPZ4Ig3nNw2s9DRFKUXNWL4MAjGLOSHxpOJYdFs3wQMSDAq0zUSeXSQY4n8w==
From: Alexander Dahl <ada@thorsis.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
Mail-Followup-To: linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello everyone,

I think I found a bug in nand_onfi_detect() which was introduced with
commit c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page
read to constraint controllers") back in 2020.

Background on how I found this: I'm currently struggling getting raw
nand flash access to fly with an at91 sam9x60 SoC and a S34ML02G1
Spansion SLC raw NAND flash on a custom board.  The setup is
comparable to the sam9x60 curiosity board and can be reproduced with
that one.

NAND flash on sam9x60 curiosity board works fine with what is in
mainline Linux kernel.  However after removing the line 'rb-gpios =
<&pioD 5 GPIO_ACTIVE_HIGH>;' from at91-sam9x60_curiosity.dts all data
read from the flash appears to be zeros only.  (I did not add that
line to the dts of my custom board first, this is how I stumbled over
this.)

I have no explanation for that behaviour, it should work without R/B#
by reading the status register, maybe we investigate that
in depth later.  However those all zeros data reads happens when
reading the ONFI param page as well es data read from OOB/spare area
later and I bet it's the same with usual data.

This read error reveals a bug in nand_onfi_detect().  After setting
up some things there's this for loop:

    for (i = 0; i < ONFI_PARAM_PAGES; i++) {

For i = 0 nand_read_param_page_op() is called and in my case all zeros
are returned and thus the CRC calculated does not match the all zeros
CRC read.  So the usual break on successful reading the first page is
skipped and for reading the second page nand_change_read_column_op()
is called.  I think that one always fails on this line:

    if (offset_in_page + len > mtd->writesize + mtd->oobsize) {

Those variables contain the following values:

    offset_in_page: 256
    len: 256
    mtd->writesize: 0
    mtd->oobsize: 0

The condition is true and nand_change_read_column_op() returns with
-EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
that code path.  Those are probably initialized later, maybe with
parameters read from that ONFI param page?

Returning with error from nand_change_read_column_op() leads to
jumping out of nand_onfi_detect() early, and no ONFI param page is
evaluated at all, although the second or third page could be intact.

I guess this would also fail with any other reason for not matching
CRCs in the first page, but I have not faulty NAND flash chip to
confirm that.

Greets
Alex


