Return-Path: <linux-kernel+bounces-154038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B949F8AD676
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5040C1F21B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052951CABF;
	Mon, 22 Apr 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eITaOV40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936E18AED;
	Mon, 22 Apr 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820727; cv=none; b=r3RM7NhX1MalWv5Iehl/+P6PVbFAmzTsLcejBg4EkWmp96yKIRashDgA/vyjf7+rvf3OcU7KOKstWJUtesrZCf0t4k+i8cKS7Y5LadtafQGkOF68fmcTEYQ1GcPIU9oMQHHJYueJ5nZUOhliHU4H4Hw6igLUkt615mGx6TVwhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820727; c=relaxed/simple;
	bh=Z5BqwV8ZIk41Y+uHxvy26VgiNZxO6gbGO5GOBT3uXTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aML5Yk1F6aWz52eJhHK1xfat4z2zl2l8b0b1YR9LV069yGHZMo73sW1dOpIAgH5MZ9KvCS1qhVO3EMRTuDD/rZrxW8r8wukn6T/1M3ZGlR2L3j5kWjUY+BxVR+JbXLcRD8SFsMpK+7fNhbz8PQVpVx+U9uKMx6XntjTyAEw0lbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eITaOV40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F548C113CC;
	Mon, 22 Apr 2024 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713820726;
	bh=Z5BqwV8ZIk41Y+uHxvy26VgiNZxO6gbGO5GOBT3uXTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eITaOV40DGC5NxR4Bjq6ZcPh5jJqE4+18KcTMDfji+g+f2epu5eve2OYRCfrSCJjV
	 1L2vvNJe1N6Z5XcXmYF633k9GMRs5Pw2tjKr+vd141bzEUIkvSOglttIYdpndpwyT4
	 KEHbOorKU87S9XEg8WiDHLeQTUIDTrTRgCi2INe0tFkWWNLLrbv9RXWiCsvKX6ivOA
	 1aCbH0gm37+SCG9/0VFLzqdZCye+yDZdGpqyFI6X0JG/4EH7yyS38AdXiXRyElh3Yd
	 2i+siD+3heC4luIV+UNcI6ockeFuHWi4OfqPekRfruAiPuOsuZfGKMkJXmxZV69VCL
	 x9+mRkGRw3iEQ==
Date: Mon, 22 Apr 2024 14:18:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Message-ID: <20240422141845.108b9c87@kernel.org>
In-Reply-To: <20240418190031.1115865-1-saikrishnag@marvell.com>
References: <20240418190031.1115865-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 00:30:31 +0530 Sai Krishna wrote:
> +	DEVLINK_PARAM_DRIVER(OTX2_DEVLINK_PARAM_ID_UCAST_FLT_CNT,
> +			     "unicast_filter_count", DEVLINK_PARAM_TYPE_U8,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     otx2_dl_ucast_flt_cnt_get, otx2_dl_ucast_flt_cnt_set,
> +			     otx2_dl_ucast_flt_cnt_validate),

All devlink params must be documented (Documentation/networking/devlink)
including the explanation of the tradeoffs involved in changing the
setting.
-- 
pw-bot: cr

