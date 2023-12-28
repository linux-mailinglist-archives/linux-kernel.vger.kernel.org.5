Return-Path: <linux-kernel+bounces-12571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9681F6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A341F233C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393A6FA3;
	Thu, 28 Dec 2023 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XagBvT/Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CE63DA;
	Thu, 28 Dec 2023 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703760175; x=1735296175;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WY3yN9WgNfUdqLLgZpbcv5qQY5jc6G9ySIJZSYYAyew=;
  b=XagBvT/Zcui/Hv08FxxDnnSbRbaRiAx8ZKC31a09SMgyz694KI5VLcjQ
   1Orw2ZhInIzknv4vkfCN+edd4PpqMuSGpGcxdluy7z8/12QA/UZq981IC
   YL9UTY+ltxyahVaSQM1ZdZc7UOFjioZsET4lKJ3ggUCeeTzPdt3WrseWq
   ahA8zv+u3Vi1U5JzNb+gV2jHewnoKDbvWCQodVC/3IChTS9Z0Y0/B0e4L
   ziJsUbK3ZeOWZYotCB0HHQMXgckgIPjRJd6wdEjTbFU6bIvCX/Pu1hAri
   bWE/veS3WFZunJ7GuzyIsigmHTdNCbYNFQWXKERV2z2hr5rFFtwoDyBfi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="400345434"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="400345434"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 02:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="897169005"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="897169005"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2023 02:42:50 -0800
Message-ID: <1718f25d-3274-3e4d-0cdf-72fda8788e39@linux.intel.com>
Date: Thu, 28 Dec 2023 12:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eddie Hung <eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
References: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
In-Reply-To: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 27.12.2023 8.03, Chunfeng Yun wrote:
> For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
> still send out unexpected ACK after receiving a short packet in burst
> transfer, this will cause an exception on connected device, specially for
> a 4k camera.
> Add a quirk property "rx-fifo-depth" to work around this hardware issue,
> prefer to use 3k bytes;
> The side-effect is that may cause performance drop about 10%, including
> bulk transfer.

Is it be possible to detect those Mediatek xHC versions that need this
workaround in the xhci-mtk driver directly?

This way we could avoid passing a new "rx-fifo-depth" property to it.

Thanks
Mathias


