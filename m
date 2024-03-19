Return-Path: <linux-kernel+bounces-107579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E128387FE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBBB28426B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB980020;
	Tue, 19 Mar 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="SJdGJMfS"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F35A782;
	Tue, 19 Mar 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854300; cv=none; b=f55MNtyrAN2JW+DBqQOjhfzNrsgCIv9y0rkqlFlMGgbThLpyisasfwx/nW4EDPbc0uTi3FNI3PjDzDheRfmRuy9+c/3mBw4vSZZ/nHYwCMWBm52nxKdonWThGLXpcQEuu+1xLcnRHgrikCswTEHLwaqVX5waujDQCfAqWACcQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854300; c=relaxed/simple;
	bh=RR0UkwWsm9OdmDGh3lOnlD7zBWisNdtOai4hXsNHFOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dEegX4EVuG8hW9ZfAVWWlJpA99xFf0+w6sGvbgH0391oGBhHTWlf3JhLBESdwtLY2yecHzX3L67eXi1q9BcJlwNd9j0LAR2Z9XRigoKFWvPnikaXFf4DgYgD2EkrhvFjy5XqO/3nvs3wBHYFkdjORpUT0vDxa8ppJRelO0RK8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=SJdGJMfS; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 777579C0760;
	Tue, 19 Mar 2024 09:18:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id a_6GA9s-CbIi; Tue, 19 Mar 2024 09:18:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B99AD9C2CD7;
	Tue, 19 Mar 2024 09:18:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B99AD9C2CD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1710854294; bh=5NKRHP1QMpxeSgJzCg5KTSkhGY8m7eqimBDOmXZzCLo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=SJdGJMfSRh5WdHCGswWdQRFF4PVrxtImtEsTGzei+w/QPMSKnvQqCoGuZWzXzR2Fe
	 fB+QURY728WBm53LR19tDhwhESEa3MstokJ546DyRtbFAtw4bVSz/ZWwlo6GqJcx3Q
	 OAJnT1s2NJ+K/JlT3rVsbPtgp2bS+ffKXP68acObQbMRA6Jj4++mhhwDzCIjDkFftH
	 V6NlKRaEaSq78ob2fOkyTmsnzFwTAuUUON1iJ8FHTu/GyteR9ANqTGXqLcCgOZRF+k
	 gPtxQpaTxg9stn8zuIVjsm8ZdEMyDvyhRlW0ibNTXO1uFRaAVRCpjNkm09hjnKkWYp
	 qhhMDJF0r1nqQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id heRr1KKMJ06R; Tue, 19 Mar 2024 09:18:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8891C9C0760;
	Tue, 19 Mar 2024 09:18:14 -0400 (EDT)
Date: Tue, 19 Mar 2024 09:18:14 -0400 (EDT)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <2023855820.1872598.1710854294497.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <ZfkSf6QG5nIY0zpx@yilunxu-OptiPlex-7050>
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com> <20240313225746.489253-2-charles.perry@savoirfairelinux.com> <ZfkSf6QG5nIY0zpx@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v5 1/3] fpga: xilinx-spi: extract a common driver core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: fpga: xilinx-spi: extract a common driver core
Thread-Index: tkWcNpo3mWp8g/EUE0xd2oh6sbVbuw==


On Mar 19, 2024, at 12:20 AM, Xu Yilun yilun.xu@linux.intel.com wrote:
>> +/**
>> + * struct xilinx_fpga_core - interface between the driver and the core manager
>> + *                           of Xilinx 7 Series FPGA manager
>> + * @dev:       device node
>> + * @write:     write callback of the driver
>> + * @prog_b:    PROGRAM_B gpio descriptor
>> + * @init_b:    INIT_B gpio descriptor
>> + * @done:      DONE gpio descriptor
> 
> Please re-check the Documentation again:
> "Structure fields that are inside a private: area are not listed in the
> generated output documentation"
> 

I did generate the documentation for that struct and saw that the
private fields are indeed removed. This hinted me into thinking that
I should keep the private kernel-doc, because it's the generator job
to remove those. Looking again at the kernel-doc.rst example on that
topic, I understand that this is not the case, will fix.

>> + */
>> +struct xilinx_fpga_core {
>> +/* public: */
>> +	struct device *dev;
>> +	int (*write)(struct xilinx_fpga_core *core, const char *buf,
>> +		     size_t count);
>> +/* private: handled by xilinx-core */
>> +	struct gpio_desc *prog_b;
>> +	struct gpio_desc *init_b;
>> +	struct gpio_desc *done;
>> +};
>> +
> [...]
>> -
>>  static int xilinx_spi_probe(struct spi_device *spi)
>>  {
>> -	struct xilinx_spi_conf *conf;
>> -	struct fpga_manager *mgr;
>> +	struct xilinx_fpga_core *conf;
> 
> Why do you name it conf? Maybe "core" is better?
> 
> Thanks,
> Yilun

Yes, I changed the type but not the name.

Thank you for the review,
Charles




