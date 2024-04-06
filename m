Return-Path: <linux-kernel+bounces-133799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0289A8DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D71F230A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D61BF31;
	Sat,  6 Apr 2024 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwJCrKVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7772CAB;
	Sat,  6 Apr 2024 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712377515; cv=none; b=qXF2154kskFy7KxgF3IKoOh/FrjDawTQ7MiEiJIWb3Qqp3bwL8RWsrXTrvUPSjnJv/NLPvZoLazu7s+tBkJ2fmLfXANuNdx6OLu20T1Ay6bfhnQYhN5qrC7vDEHCMYkMEDqqqcdzsDk82iLdUBPMgvACI26vB07V1GLxz+VtFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712377515; c=relaxed/simple;
	bh=ip8k07t7BfEvV53PYzakptukPEyy8283oi2ZC+w5ZEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQFXwqID7XZ7/C7QmJxxT2CkCvOX5974qaVZFWLWiX/t/6593tMpztVM2atYHYUX0dRAQDArKPKr88gTfvaaoQYhRWQ0MQnFzH5F4xKl7oqenzkmittprcnWbgPoid6D/fALc6abYbvZ5L9uRboEMo+BiXwnOlvJ7X7JCgQ2K7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwJCrKVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785DDC433F1;
	Sat,  6 Apr 2024 04:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712377515;
	bh=ip8k07t7BfEvV53PYzakptukPEyy8283oi2ZC+w5ZEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GwJCrKVk/BoRpIhUWtfsjbnVNUGzObkT8OxbFE/LMQTez+7rMQkGPMuqMHS1GkySM
	 UGacUaysy+K95swWj2+rio0sN5iJa4GbJacU2BfFKksb5oVoRGzODP/+e/aAvQ3VJT
	 nUmw61rqqQZkJ2Zo+nggYjT5rtG5SEOTx7DB+Hpyb8yj/MonmPNoFl8vY859WSSnSn
	 SL8BEAhwn69FaK4DKSAnkjSIAtS5HBWD2LudHMb1D3uhlkewDniU3PAdmKDr+RZ0Fk
	 3f01J0ykZNP3LU5ZIm8LV/HYKJzTfWeyUzuFL6KdmdMw5wB6kGVQsxrL1RQiRd/ciX
	 Pm8Xo2ZhTrlNQ==
Date: Fri, 5 Apr 2024 21:25:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Christoph Lameter <cl@linux.com>, Vlastimil
 Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 7/9] libeth: add Rx buffer management
Message-ID: <20240405212513.0d189968@kernel.org>
In-Reply-To: <20240404154402.3581254-8-aleksander.lobakin@intel.com>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
	<20240404154402.3581254-8-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 17:44:00 +0200 Alexander Lobakin wrote:
> +/**
> + * struct libeth_fq - structure representing a buffer queue
> + * @fp: hotpath part of the structure

Second time this happens this week, so maybe some tooling change in 6.9
but apparently kdoc does not want to know about the tagged struct:

include/net/libeth/rx.h:69: warning: Excess struct member 'fp' description in 'libeth_fq'

> + * @pp: &page_pool for buffer management
> + * @fqes: array of Rx buffers
> + * @truesize: size to allocate per buffer, w/overhead
> + * @count: number of descriptors/buffers the queue has
> + * @buf_len: HW-writeable length per each buffer
> + * @nid: ID of the closest NUMA node with memory
> + */
> +struct libeth_fq {
> +	struct_group_tagged(libeth_fq_fp, fp,
> +		struct page_pool	*pp;
> +		struct libeth_fqe	*fqes;
> +
> +		u32			truesize;
> +		u32			count;
> +	);
> +
> +	/* Cold fields */
> +	u32			buf_len;
> +	int			nid;
> +};

