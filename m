Return-Path: <linux-kernel+bounces-65118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975D85482F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A622811E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C25199BE;
	Wed, 14 Feb 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RdFfgECC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arQXjg4W"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26C1946B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909799; cv=none; b=QnrqHBy8sxTAUMT75gG3L/sMYGJGlHoKTzbhEskjUExTZXTWlHDSiSf2Q++lwkE0aiY6TuZu8Mg63JJVurMsNpUrEgIL3CBX20nWNvRX4ZoPt8Jrau3lQJDxbGPgAORRRiDC8LXhPBNebh35pmVfd721FeLX18MoaPlEC5Pwha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909799; c=relaxed/simple;
	bh=aNjYCTOTHhRmSRZFRYqfmCVM93esw7nPSRqBG2xTjts=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Fzf1J5xmpD4Y+5Naq5JRspnjGRcfvZ4hTffPBFa22B/kqUk/dAFzPdAEKNAAUgQrZyviriGU3v6PYpOlz7nYB4GA/u1mTbR4A4t0xqZbKRNUpDdhRw/I9mPXt/dAcmMp0j/W1xs1hPxToshas+S2MvuvhZKCm8wIcbFyWa8BaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RdFfgECC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arQXjg4W; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A8C893200A0A;
	Wed, 14 Feb 2024 06:23:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 06:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707909795; x=1707996195; bh=bNyMKCwVt1
	3/eR+EwpIRTRHK69mX0eVQLKEM2trCPPA=; b=RdFfgECCdp6wlwUXICQNsf5Rb+
	ZQ2Oz5IxXDVRtHyV9dlmC/0010T/LMbJWOfHuPq+fPaa3J0S3j9d8Pbn7WURsVRZ
	SWDKk/7JIiWE+b1Qz6k3N8lono89jxvnWfAxbWsqalMMmHcB7k5/qSFz1E3L6ALP
	czWrjxLqfvW7Kb4L3ZM1QAvtu8Pstprnhe+dW1Rlwv5Iq1SyUW+dFY0D/g2SEpSR
	SpuWxy5l8GEiuVx+cwGwLo5XaI9PnrkP5niLE3D+VdtkxjxGplgb3N1JWRboHGJZ
	fkKsViqi1QOyiE3Jd0BW5b7bV+wXqSCDd6UO7ACt5r8mO7wvGZ8Pt8sCaV3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707909795; x=1707996195; bh=bNyMKCwVt13/eR+EwpIRTRHK69mX
	0eVQLKEM2trCPPA=; b=arQXjg4WnBwUbbnGKQu9ploOH8aLj5cSGhOWocdqhzp1
	f3rSf+l+tgTIMInXVhqYdZgMV507SYg9+I1gNodQgL/qvOYfD7sHej0M9+id+hfS
	uU53s6/XqeYona+xESj0goIpO79T0r4tpT5B78GgxHZCgDP5W8Fu6k3MLCEyO7sl
	IcU1lUzm01PTmxtfC7tK2eBqNCZFF7ynGvOPEcRSZKqn2UE1A3YEJ9YN25PNpepN
	4/vhZNyH1GXrWduckGNU7UdyYG5JI36wy6f5Aa8XACDwZJhy1i+7MSJb2C5yA0bZ
	sHOPMVF1HcGRn/iPBeT7Vnz+yk6tqo1hWEutlAiIgg==
X-ME-Sender: <xms:oqLMZdhE68pYGR_vlxD4ea7B9HxzQu_HELQn_oWh8E5XZxIyuuStag>
    <xme:oqLMZSB8HNUi30chAHzTSuOY_SejeHBqTH47n__J-O35kKPSi_wwoKCtFJBrAB1G-
    ZMRHykr3z2mm0E7dN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oqLMZdHxhXnfkJ7SffIkVOwCKWmoqP0CPcBV6DWcE2fkpcQwladHzw>
    <xmx:oqLMZSQo2YR-b2URX6V0CDBKOSTNV_8wzmjkeygTDlEWYkhdIqq_HA>
    <xmx:oqLMZawz-h8SjXbLLVX50MoQGcvrjLdl958yYYTNLuT1OCpDT_TePA>
    <xmx:o6LMZfqTd0RGOokDcVbiSN7nehRxs6FbXLHlEoP6Qvhc90phK0E8FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C8C21B6008F; Wed, 14 Feb 2024 06:23:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <165cec24-680e-4d3e-883e-56fccbb4d7d9@app.fastmail.com>
In-Reply-To: <20240214035524.1245615-1-vattunuru@marvell.com>
References: <20240214035524.1245615-1-vattunuru@marvell.com>
Date: Wed, 14 Feb 2024 12:22:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Content-Type: text/plain

On Wed, Feb 14, 2024, at 04:55, Vamsi Attunuru wrote:
> Adds PCIe PF driver for OcteonTx3 DPI PF device which initializes DPI
> DMA hardware's global configuration and enables PF-VF mbox channels
> which can be used by it's VF devices. This DPI PF driver handles only
> the resource configuration requests from VFs and it does not have any
> data movement functionality.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>

This looks incomplete, as there is no apparent interface to
actually use the driver from either userspace or kernel. I
understand that you want to merge this one step at a time,
but please try to at least point out how this is intended
to be used, or post it together with an (in-kernel) user
if you plan to upstream that.

Is this used for anything other than networking? If not,
maybe it should be part of drivers/net/ instead of
drivers/misc.

A few more things that Greg hasn't already commented on:

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..3142fdb1b4c0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -574,6 +574,16 @@ config NSM
>  	  To compile this driver as a module, choose M here.
>  	  The module will be called nsm.
> 
> +config MARVELL_OCTEONTX3_DPI
> +	tristate "OcteonTX3 DPI driver"

Is OcteonTX3 an actual product name? I thought the follow-up
to OcteonTX2 (cn9[268]xx) was the OCTEON 10 line. Or is
this a follow-up to the Marvell Armada (cn91xx) line?

> +static void dpi_poll_pfvf_mbox(struct dpipf *dpi)
> +{
> +	u64 reg;
> +	u32 vf;
> +
> +	reg = dpi_reg_read(dpi, DPI_MBOX_VF_PF_INT);
> +	if (reg) {
> +		for (vf = 0; vf < DPI_MAX_VFS; vf++) {
> +			if (!(reg & (0x1UL << vf)))
> +				continue;
> +
> +			if (!dpi->mbox[vf]) {
> +				dev_err(&dpi->pdev->dev, "bad mbox vf %d\n", vf);
> +				continue;
> +			}
> +
> +			schedule_work(&dpi->mbox[vf]->wk.work);
> +		}
> +
> +		if (reg)
> +			dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT, reg);
> +	}
> +}
> +
> +static irqreturn_t dpi_mbox_intr_handler(int irq, void *data)
> +{
> +	struct dpipf *dpi = data;
> +
> +	dpi_poll_pfvf_mbox(dpi);
> +
> +	return IRQ_HANDLED;
> +}

Have you considered using the drivers/mailbox framework for
the mailbox portion?


> +static void dpi_pfvf_mbox_work(struct work_struct *work)
> +{
> +	struct dpi_pfvf_mbox_wk *wk = container_of(work, struct 
> dpi_pfvf_mbox_wk, work);
> +	union dpi_mbox_message_t msg = { 0 };
> +	struct dpi_mbox *mbox = NULL;
> +	struct dpipf_vf *dpivf;
> +	struct dpipf *dpi;
> +	int vf_id;
> +
> +	mbox = (struct dpi_mbox *)wk->ctxptr;
> +	dpi = (struct dpipf *)mbox->pf;

Can these pointers be strictly typed instead of casting
from a void*?

> +static int dpi_pfvf_mbox_setup(struct dpipf *dpi)
> +{
> +	int vf;
> +
> +	for (vf = 0; vf < DPI_MAX_VFS; vf++) {
> +		dpi->mbox[vf] = vzalloc(sizeof(*dpi->mbox[vf]));
> +

dpi->mbox[vf] does not look excessively large, so I think
kzalloc() is better than vzalloc() here.

> +module_init(dpi_init_module);
> +module_exit(dpi_cleanup_module);
> +MODULE_DEVICE_TABLE(pci, dpi_id_table);
> +MODULE_AUTHOR("Marvell International Ltd.");
> +MODULE_DESCRIPTION(DPI_DRV_STRING);
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DPI_DRV_VERSION);

Please remove the DPI_DRV_STRING and DPI_DRV_VERSION macros,
they prevent grepping for the strings.

> diff --git a/drivers/misc/mrvl-dpi/dpi.h b/drivers/misc/mrvl-dpi/dpi.h
> new file mode 100644
> index 000000000000..99ebe6bbe577
> --- /dev/null
> +++ b/drivers/misc/mrvl-dpi/dpi.h
> @@ -0,0 +1,232 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell OcteonTx3 DPI driver
> + *
> + * Copyright (C) 2024 Marvell International Ltd.
> + */
> +
> +#ifndef __DPI_H__
> +#define __DPI_H__

I see no need for a separate header file if there is no other
driver including it, so just merge this all into the .c file.

> +union dpi_mbox_message_t {
> +	uint64_t u[2];
> +	struct dpi_mbox_message_s {
> +		/* VF ID to configure */
> +		uint64_t vfid           :8;
> +		/* Command code */
> +		uint64_t cmd            :4;
> +		/* Command buffer size in 8-byte words */
> +		uint64_t csize          :14;
> +		/* aura of the command buffer */
> +		uint64_t aura           :20;
> +		/* SSO PF function */
> +		uint64_t sso_pf_func    :16;
> +		/* NPA PF function */
> +		uint64_t npa_pf_func    :16;
> +		/* Work queue completion status enable */
> +		uint64_t wqecs		:1;
> +		/* Work queue completion status byte offset */
> +		uint64_t wqecsoff	:7;
> +	} s __packed;
> +};

Is this a hardware structure? If it is, you probably don't
want to use bit fields here, even in the best case that
is a bug that prevents you from using the driver in
big-endian mode.

I also see that there are only 86 bits defined, and one
field crosses a 64-bit boundary, which feels odd.

    Arnd

