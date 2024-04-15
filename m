Return-Path: <linux-kernel+bounces-145356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5778A53C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA691C217A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147C82877;
	Mon, 15 Apr 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVoYqzxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0478C75;
	Mon, 15 Apr 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191316; cv=none; b=oJRv9SFyfKP99PRrbmLMhXG6laYjVBmsdi8hGHJ2EDSpPub24eyzhDkIT5HLtnWrZGM0Sjcit+/0r6QKDM7uGYTfFw6Q3VbTqnEpYCjmZLkgmBqgY1r/byE+FTiJjf3onYvkegdgi/agnuLuKiqbAwBUfar2z7aSclaCi98xaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191316; c=relaxed/simple;
	bh=apPf5YxAYqe7YNBX6Cyef/BfXebvMrMHj5etULK04HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT2vHQbxjkU04u1UjZ+cuuI+Ot6C9JRQnJ1xF1ITRHZF4/MsG7K9/BX/YkDc1Gdo6nvEnCCiUocQDVO1DZmxZWg/c0EIhn2ylGudAuYwtM/tx+NKHXjo6UQ1pSlixwpfl+zVY8dF2dYrHeeRwwHMgqUlSdJwR8/r6Wop2fkgLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVoYqzxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DAEC2BD11;
	Mon, 15 Apr 2024 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191315;
	bh=apPf5YxAYqe7YNBX6Cyef/BfXebvMrMHj5etULK04HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVoYqzxV6FYz2QdGdPUrtfj/AviX3PbD+lIC58voYZbHaWIlbDiQtx/QSrLGh9Cxu
	 fxtbAFLtLOAcIFaOofyfd/B88GcuceWzI3sgWI3yE1kraBv1gt4sapwjenC+87Z9XJ
	 9hFGKoZvIZ79nhAd2P+8ut4HoqUxCA2LtFZHjenRtpzkbsR9SW5Zq33JaF1HL+mZ9+
	 UQD3tLk1yOAu0n8Xgh1OssQookLWj2d2RW5zOmxwjkqUjHIt5Hi5mNJeOEtZCZbOCN
	 d4jVOfgZ0kZYTKBL7pSx3JTCoMaxVzKVt+mGUPOlAxwf5160v3sVcSl6ealmyvOZ9E
	 inKWtr9TQffoQ==
Date: Mon, 15 Apr 2024 15:28:27 +0100
From: Simon Horman <horms@kernel.org>
To: Yi-De Wu <yi-de.wu@mediatek.com>
Cc: Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
	Ze-Yu Wang <ze-yu.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <peilun.suei@mediatek.com>,
	Liju Chen <liju-clr.chen@mediatek.com>,
	Willix Yeh <chi-shen.yeh@mediatek.com>,
	Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v10 04/21] virt: geniezone: Add GenieZone hypervisor
 driver
Message-ID: <20240415142827.GA2320920@kernel.org>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
 <20240412065718.29105-5-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412065718.29105-5-yi-de.wu@mediatek.com>

On Fri, Apr 12, 2024 at 02:57:01PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various
> virtual machine types and provides security features such as TEE-like
> scenarios and secure boot. It can create guest VMs for security use
> cases and has virtualization capabilities for both platform and
> interrupt. Although the hypervisor can be booted independently, it
> requires the assistance of GenieZone hypervisor kernel driver(gzvm-ko)
> to leverage the ability of Linux kernel for vCPU scheduling, memory
> management, inter-VM communication and virtio backend support.
> 
> Add the basic hypervisor driver. Subsequent patches will add more
> supported features to this driver.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

..

> +static struct platform_driver gzvm_driver = {
> +	.probe = gzvm_drv_probe,
> +	.remove = gzvm_drv_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.owner = THIS_MODULE,

Hi Yi-De Wu,

A minor nit from my side:

There is no need to set owner here as
owner is set (overridden) by module_platform_driver().

Flagged by Coccinelle.

> +		.of_match_table = gzvm_of_match,
> +	},
> +};
> +
> +module_platform_driver(gzvm_driver);
> +
> +MODULE_DEVICE_TABLE(of, gzvm_of_match);
> +MODULE_AUTHOR("MediaTek");
> +MODULE_DESCRIPTION("GenieZone interface for VMM");
> +MODULE_LICENSE("GPL");

..

