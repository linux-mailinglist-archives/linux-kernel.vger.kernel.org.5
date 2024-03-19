Return-Path: <linux-kernel+bounces-107569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D887FE40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062A31F2134D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32780623;
	Tue, 19 Mar 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AkyV0dCr"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0498002A;
	Tue, 19 Mar 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853774; cv=none; b=W679tqFepCSetbGeQJO4wMDdEAqqsCpcaMxLXZ55OChErigY5oKl/hdsQA5g9B5IlpbNbjioKczw5U4Rf2z/3C8de/BrlByhMFTgrErjFAke+gl+i9bV2uKETpTTW7HgbQy6yOJC1I1FEbWpxSQCWJx9O+E+rR13fxnTaVH71c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853774; c=relaxed/simple;
	bh=jl5LIVHTbgoOfLHubgBGwWwHndy0u8nCAeBqkZeMR8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOGX7nFZq+wBD/z8c7X7IkYwFskh8plCXgqGCgI74gKNmPAILFMd6OnMbOZPEMEqiqpMvXzFLn6Su5dz8552vWydi3qtvaLHU6CHd24uf9KZmZMATmNSwhr5kxj+/NpCxuOcRi1ala+WjJENKZALgpz+wYZhwqj9nmYKzmn1lIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AkyV0dCr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 397FFE0002;
	Tue, 19 Mar 2024 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710853767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/nxcDTUYi1MXeFeU8TRWO7c9qe7Uu/RNWXFdRywHJE=;
	b=AkyV0dCrSMZ5ix+ksfm7ahaR5LV1hr425kHRYfiYFD9E4NRgvOqZ2YXS8+33sUjznAkmU1
	p6C4vkY5NnTysIenRqOuW4YRr+eUrDnKE3CRgRrB/buDV18fY8aHGe94NNW6iqBzCJEOTX
	+krpiYxIwbS3gIHDHyOm+1FG3QXx+zwTKK8Aq8tUXDCVV+iqOGBxDAZWCRzUzjIgqoxYiI
	zkxE6+GygI5phLXHzRMx79MTdpqJEFnbxubGKrzfRSbA7gzhtZ5w3Vi5FEIeGf8nDlAEwe
	5RXvhLmnu5XJ+Riwypshhyt/72W2Vu6loM1/m6s2z78BsKfkjqTVwIAt+4Jeow==
Date: Tue, 19 Mar 2024 14:09:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <broonie@kernel.org>, <robh@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <richard@nod.at>, <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
 <neil.armstrong@linaro.org>, <daniel@makrotopia.org>, <arnd@arndb.de>,
 <chris.packham@alliedtelesis.co.nz>, <christophe.kerello@foss.st.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
 <quic_varada@quicinc.com>
Subject: Re: [PATCH v4 2/5] drivers: mtd: nand: Add qpic_common API file
Message-ID: <20240319140924.167f3063@xps-13>
In-Reply-To: <756ccc79-0077-5c23-73e3-bbb82fbfa8b0@quicinc.com>
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
	<20240308091752.16136-3-quic_mdalam@quicinc.com>
	<20240315124517.4a546ce9@xps-13>
	<93b08226-3297-2161-cc7d-d33d839c32f0@quicinc.com>
	<20240319114316.4b977d93@xps-13>
	<756ccc79-0077-5c23-73e3-bbb82fbfa8b0@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

quic_mdalam@quicinc.com wrote on Tue, 19 Mar 2024 17:46:05 +0530:

> On 3/19/2024 4:13 PM, Miquel Raynal wrote:
> > Hi,
> >  =20
> >>>> +/**
> >>>> + * qcom_offset_to_nandc_reg() - Get the actual offset
> >>>> + * @regs: pointer to nandc_reg structure
> >>>> + * @offset: register offset
> >>>> + *
> >>>> + * This function will reurn the actual offset for qpic controller r=
egister
> >>>> + */
> >>>> +__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offse=
t)
> >>>> +{
> >>>> +	switch (offset) {
> >>>> +	case NAND_FLASH_CMD:
> >>>> +		return &regs->cmd;
> >>>> +	case NAND_ADDR0:
> >>>> +		return &regs->addr0;
> >>>> +	case NAND_ADDR1:
> >>>> +		return &regs->addr1;
> >>>> +	case NAND_FLASH_CHIP_SELECT:
> >>>> +		return &regs->chip_sel;
> >>>> +	case NAND_EXEC_CMD:
> >>>> +		return &regs->exec;
> >>>> +	case NAND_FLASH_STATUS:
> >>>> +		return &regs->clrflashstatus;
> >>>> +	case NAND_DEV0_CFG0:
> >>>> +		return &regs->cfg0;
> >>>> +	case NAND_DEV0_CFG1:
> >>>> +		return &regs->cfg1;
> >>>> +	case NAND_DEV0_ECC_CFG:
> >>>> +		return &regs->ecc_bch_cfg;
> >>>> +	case NAND_READ_STATUS:
> >>>> +		return &regs->clrreadstatus;
> >>>> +	case NAND_DEV_CMD1:
> >>>> +		return &regs->cmd1;
> >>>> +	case NAND_DEV_CMD1_RESTORE:
> >>>> +		return &regs->orig_cmd1;
> >>>> +	case NAND_DEV_CMD_VLD:
> >>>> +		return &regs->vld;
> >>>> +	case NAND_DEV_CMD_VLD_RESTORE:
> >>>> +		return &regs->orig_vld;
> >>>> +	case NAND_EBI2_ECC_BUF_CFG:
> >>>> +		return &regs->ecc_buf_cfg;
> >>>> +	case NAND_READ_LOCATION_0:
> >>>> +		return &regs->read_location0;
> >>>> +	case NAND_READ_LOCATION_1:
> >>>> +		return &regs->read_location1;
> >>>> +	case NAND_READ_LOCATION_2:
> >>>> +		return &regs->read_location2;
> >>>> +	case NAND_READ_LOCATION_3:
> >>>> +		return &regs->read_location3;
> >>>> +	case NAND_READ_LOCATION_LAST_CW_0:
> >>>> +		return &regs->read_location_last0;
> >>>> +	case NAND_READ_LOCATION_LAST_CW_1:
> >>>> +		return &regs->read_location_last1;
> >>>> +	case NAND_READ_LOCATION_LAST_CW_2:
> >>>> +		return &regs->read_location_last2;
> >>>> +	case NAND_READ_LOCATION_LAST_CW_3:
> >>>> +		return &regs->read_location_last3; =20
> >>>
> >>> Why do you need this indirection? =20
> >>
> >> This indirection I believe is needed by the write_reg_dma function,
> >> wherein a bunch of registers are modified based on a starting register.
> >> Can I change this in a separate cleanup series as a follow up to this?=
 =20
> >=20
> > I think it would be cleaner to make the changes I requested first and
> > then make a copy. I understand it is more work on your side, so if you
> > really prefer you can (1) make the copy and then (2) clean it all. But
> > please do it all in this series. =20
> Ok
> >  =20
> >>>> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mt=
d/nand-qpic-common.h
> >>>> new file mode 100644
> >>>> index 000000000000..aced15866627
> >>>> --- /dev/null
> >>>> +++ b/include/linux/mtd/nand-qpic-common.h
> >>>> @@ -0,0 +1,486 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +/*
> >>>> + * QCOM QPIC common APIs header file
> >>>> + *
> >>>> + * Copyright (c) 2023 Qualcomm Inc.
> >>>> + * Authors:     Md sadre Alam           <quic_mdalam@quicinc.com>
> >>>> + *		Sricharan R             <quic_srichara@quicinc.com>
> >>>> + *		Varadarajan Narayanan   <quic_varada@quicinc.com>
> >>>> + *
> >>>> + */
> >>>> +#ifndef __MTD_NAND_QPIC_COMMON_H__
> >>>> +#define __MTD_NAND_QPIC_COMMON_H__
> >>>> +
> >>>> +#include <linux/bitops.h>
> >>>> +#include <linux/clk.h>
> >>>> +#include <linux/delay.h>
> >>>> +#include <linux/dmaengine.h>
> >>>> +#include <linux/dma-mapping.h>
> >>>> +#include <linux/dma/qcom_adm.h>
> >>>> +#include <linux/dma/qcom_bam_dma.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/mtd/partitions.h>
> >>>> +#include <linux/mtd/rawnand.h> =20
> >>>
> >>> You really need this? =20
> >> Yes , since some generic structure used here. =20
> >=20
> > Which ones? If this is a common file, you probably should not. =20
>   Since we are using this struct qcom_nand_controller { }
>   for both SPI nand as well as raw nand. In this we are having this
>   struct nand_controller controller member.

Maybe we should not expose qcom_nand_controller at all and just share
the minimum bits which are really common.

Thanks,
Miqu=C3=A8l

