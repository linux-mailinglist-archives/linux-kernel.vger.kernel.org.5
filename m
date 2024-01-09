Return-Path: <linux-kernel+bounces-21467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAB828FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B42E283DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B283EA7A;
	Tue,  9 Jan 2024 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MigYeagr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F53EA70;
	Tue,  9 Jan 2024 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NaBJI87kmZwj1A1768OX50wF93eEIepNo9i7EX/STyA=; b=MigYeagrU9ip9KoGMNB3FGYHBS
	xlp8NXzrVG6PlViS6B9NZsidjsSz35kXejfWfTO4gONlFMR0A/nFohgtD1vtp3iWdSzJ9XGZoKJ+n
	Uvwsry+vuyps3ftFUWHr0HIeTm5FLxMllUFNkIi3/LMoFHdTL4Guk+ACA5ied5pNNplEh7i0TWlLz
	jkU4H0PvCa/SLj+aHBntsuuE3prZnuediHam5PQrGvXyWDMB88SgvaUrJ4vwR/xKyhQflg43VQeAt
	53rAXnSg+TxJ7muzFDmHduaYupEVOGzFHQxV5rF3QaYPC9MzmdxIEapjQRHxaYCbQ4hKL+Ytl+Zzd
	fPfbiy3A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKQ5-009gmK-0R;
	Tue, 09 Jan 2024 22:18:02 +0000
Message-ID: <63d9d1b9-6c2a-4d8a-9bf6-9973d76ae97d@infradead.org>
Date: Tue, 9 Jan 2024 14:18:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] soc: qcom: Add Qualcomm APSS minidump kernel
 driver
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 mathieu.poirier@linaro.org, vigneshr@ti.com, nm@ti.com,
 matthias.bgg@gmail.com, kgene@kernel.org, alim.akhtar@samsung.com,
 bmasney@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
 <20240109153200.12848-7-quic_mojha@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240109153200.12848-7-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 1/9/24 07:31, Mukesh Ojha wrote:
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 1f81746131fc..56bc0c8a19f9 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -278,4 +278,17 @@ config QCOM_RPROC_MINIDUMP
>  	  query predefined minidump segments associated with the remote processor
>  	  and check its validity and end up collecting the dump on remote processor
>  	  crash during its recovery.
> +
> +config QCOM_MINIDUMP
> +	tristate "QCOM APSS Minidump driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on QCOM_SMEM
> +	help
> +	  This config enables linux core infrastructure for Application

	                      Linux
same as 2 lines below.

> +	  processor subsystem (APSS) minidump collection i.e, it enables

	                                      collection, i.e., it enables

> +	  Linux clients drivers to register their internal data structures

	        client drivers

> +	  and debug messages as part of the apss minidump table and when

	                                    APSS
as above and in Subject.

> +	  the SoC is crashed, these selective regions will be dumped

	          has

> +	  instead of the entire DDR dump. This saves significant amount

	                                  This saves a significant amount

Does it have to be DDR?


> +	  of time and/or storage space.
>  endmenu

-- 
#Randy

