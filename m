Return-Path: <linux-kernel+bounces-77862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E243F860B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B6B1C2251F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADEF13FEF;
	Fri, 23 Feb 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iwwqeyI9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A64414;
	Fri, 23 Feb 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672185; cv=none; b=sBctHtSs6UFbM2dZtCa4NZcUfXrMoXlRpmO/Euwc1m/NyA+gXTBmEMjyRQ6j2YdNnHk+iqAtYir58fhj5aPFJvbiArwV9c0JZJB4DMwG8cKRLFHktMELTraqDAee6CGhPkoAS2aVs7OYwCOyb6Gy4SUOL3NSOYt7b6vcTeppWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672185; c=relaxed/simple;
	bh=Zz70VcC6ec8uW9MYAOTjf18dTlcTTAeDita2hNGYrmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZBDAt3NpKM9xe0xlGSL2XVIv24W/JwcUAZCVCog82JR1vSPCe6gmgrDaNe1xEZ6ZA4gppJihCkHISLixtTtK3BW87cF0MlMsncu8zeCbmZjLrxzuqM5sBZsPVRPi+eDqufCTRC8ge8fvnxvBX8SNxQRUpxESBK9hCC0M8r3WAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iwwqeyI9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m+Owkp1rvs3wqHimfEH8BwiCegvG2RGz55AKhwheUbg=; b=iwwqeyI9c3+8e3/yCE9TC/w5CH
	+apLO/tqnHj5OoEfskS2+ieWWgT6wYzNDVHvLRUwZCrkIRWwHo0xJ1V7anDQ2Z2tcXnO5OkeyDwlB
	OYvrcCpFFGqai+oPl73PV76BDln7Vcb8zlKN3VhzOYCOZ1ju0MawnKpEf/NFKZxR0Van91cOu2bbx
	7yMT2BVLFcJE5nNV9q6xK60ppA8eZzGA5zDW2AkwKAregxIwBLSQT6mfq6dkikHwvD0kk8yGu3M0b
	evY+e5fafMmBj4yVCqPfcV9bHRRMBY26AF9b5bihcdFFw1bGbqxouM33wVdEeNI2goEITiCuBSog3
	fApTjHIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPgi-00000008G7y-2lsb;
	Fri, 23 Feb 2024 07:09:40 +0000
Date: Thu, 22 Feb 2024 23:09:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Alex Elder <elder@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Murali Nalajal <quic_mnalajal@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Carl van Schaik <quic_cvanscha@quicinc.com>,
	Philip Derrin <quic_pderrin@quicinc.com>,
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Message-ID: <ZdhEtH7xzbzdhS2j@infradead.org>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 22, 2024 at 03:16:42PM -0800, Elliot Berman wrote:
> Firmware and hypervisor drivers can donate system heap memory to their
> respective firmware/hypervisor entities. Those drivers should unmap the
> pages from the kernel's logical map before doing so.
> 
> Export can_set_direct_map, set_direct_map_invalid_noflush, and
> set_direct_map_default_noflush.

Err, not they should not.  And not using such super low-level interfaces
from modular code.

