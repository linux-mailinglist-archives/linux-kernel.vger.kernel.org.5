Return-Path: <linux-kernel+bounces-52199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C12849543
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AF91F25020
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAA125A8;
	Mon,  5 Feb 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M26sS6Pi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDE11185;
	Mon,  5 Feb 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121234; cv=none; b=Vm0c0AMVylIlSDtR1iwmxSqCelGrXdGpwooB5j2FAUWDmaep3kV5Mr5U37p8cbN9M2tor22tw/akOLuKi+1Dwlk481X5BElvKhTnzUi93dl2P2hh26cDq3+PhPP6a+Kp05HHfBxLm424rlSXYI4m7+HEC2/0crQmGfcSjF5a9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121234; c=relaxed/simple;
	bh=p7VIl6MhCIqATnPphkUNjx22KAhNDEK+6bbzQyPLhPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqjuflvAarAdrPCkHHiZZg3LDFH7gFf8Q4lboiOikXmJzpR0aREtxBKsR6ROUis57v7GXUNbICzfiPQgYdMlBGDYaZzGORAWuIwSsw1mmXIMDR/Tc4Fk9F3iBU41qnGOvrWAPCacdT3ou6jB8utYW/3DpOu8PWpocoim72MF8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M26sS6Pi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707121234; x=1738657234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p7VIl6MhCIqATnPphkUNjx22KAhNDEK+6bbzQyPLhPQ=;
  b=M26sS6PiLtaeWB9+F4n6nNXW2tIfN9gF3OHGZyMocr1nk3NHQhzj24Vl
   phdvCu38+8yEXhE5JVtLQ5JI+5TGRQgM6QaDNRa9nFJlKkn0eVFfyXPpB
   N6AMhhEFAVPSPqe9zNYfgOmAhFL+HairrUZQCPAjTpqY97Sq9bLPX+324
   wokcQGQfbYTgrdVy34X+oknBJX4IfjFBGg3YkAjkgNH3P8COciKb3m8rl
   ShzBq1WKQJZbPBMIenUjDnh0pR8pp+u9XPKuUQ88u0umDoMrq/qlsYiHn
   x5ST5cb64kYMD+hTB92wHHm6PG9dXOyWnEMIH5QLW1q4gdH4sfx6EKx7X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11566172"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11566172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 00:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5401061"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 00:20:23 -0800
Message-ID: <2abb6c0b-ea66-4649-b205-bafe49340aee@linux.intel.com>
Date: Mon, 5 Feb 2024 09:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 20/53] ASoC: Add SOC USB APIs for adding an USB
 backend
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh+dt@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-21-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240203023645.31105-21-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/2024 3:36 AM, Wesley Cheng wrote:
> Some platforms may have support for offloading USB audio devices to a
> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> USB sound card and PCM devices enumerated by the USB SND class driver.
> This allows for the ASoC components to be aware of what USB devices are
> available for offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

..

> +
> +/**
> + * snd_soc_usb_add_port() - Add a USB backend port
> + * @dev: USB backend device
> + * @priv: private data
> + * @connection_cb: connection status callback
> + *
> + * Register a USB backend device to the SND USB SOC framework.  Memory is
> + * allocated as part of the USB backend device.
> + *
> + */
> +int snd_soc_usb_add_port(struct snd_soc_usb *usb)
> +{
> +
> +

Cosmetic, but why is there white space between start of function and 
body of function?

> +	mutex_lock(&ctx_mutex);
> +	list_add_tail(&usb->list, &usb_ctx_list);
> +	mutex_unlock(&ctx_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
> +


