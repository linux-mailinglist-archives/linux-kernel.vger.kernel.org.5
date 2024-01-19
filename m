Return-Path: <linux-kernel+bounces-31293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C494F832BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53898B21DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C525467D;
	Fri, 19 Jan 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saWR+B9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879835465D;
	Fri, 19 Jan 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676180; cv=none; b=fi9L+XotxtytZq+chlTr0aYHgDJri7VGiIR2IQnXW5ygLOmaNIcFCrjAWc4AbSyjA3VOZHYCK8RFFKRZFUUquktVCMmEEsJvAQsZbbtRvM59S4ociju5PtoPVCsLZDF6ByLJHb0YfABZ+1PDqwMJNXDMM6y0JLgel7dLfQlgrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676180; c=relaxed/simple;
	bh=qHs04bjtpQIRD5zTdGPu5IZXoDqL4hhRu+sEHgltQV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKohVH54xS4uWzVznVROXMRVc+qkvlc9KMn+Fiq8C8dmGJVuKTER/2MZiwBMxgWxtcS2DB3VaUcYx9fTantYC5Ze24y6SJO90arZAvvD9CgjETDJCWQiNOo3id1tMjB4nJhwVw7H2sRg6gJvdIIGkDcWyhE05/IN8MkOUxUtF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saWR+B9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FC9C433F1;
	Fri, 19 Jan 2024 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705676180;
	bh=qHs04bjtpQIRD5zTdGPu5IZXoDqL4hhRu+sEHgltQV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saWR+B9B9L6yDQk5YP+UwF5lhmfamU39f5eLZpY4n/aGzCzJoW/G8P2Fw5jVe5+g0
	 nap8LyzoALjJzxEj93SZWbo3LY0K+/LAvi6bNICEO8qmOHzARNK+3PXIe8rMRa8Lri
	 wekHJ1hP1AooS+spxD4UZXQiZdrYkgp/d5MoTvL5otdLzCT2H7DhpSgyfySb+wSNL7
	 FcZq/a2zhkoZ+dujiddJpkvWUdVF0wTRSOVtpJc15aToPSerSjDpbeUiv99XpPmIsc
	 AAdH4j/FftzPN30bzPfwuG8VJCsvTWf+S9L8707gM6uiA4dEZR3kH7gMgh91CEHe04
	 ZCbQSLwkJscqQ==
Date: Fri, 19 Jan 2024 14:56:14 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH v3] igb: Fix string truncation warnings in
 igb_set_fw_version
Message-ID: <20240119145614.GB89683@kernel.org>
References: <20240115082825.28343-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115082825.28343-1-chentao@kylinos.cn>

On Mon, Jan 15, 2024 at 04:28:25PM +0800, Kunwu Chan wrote:
> Commit 1978d3ead82c ("intel: fix string truncation warnings")
> fixes '-Wformat-truncation=' warnings in igb_main.c by using kasprintf.
> 
> drivers/net/ethernet/intel/igb/igb_main.c:3092:53: warning：‘%d’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 13 [-Wformat-truncation=]
>  3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
>       |                                                     ^~
> drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note：directive argument in the range [0, 65535]
>  3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note：directive argument in the range [0, 65535]
> drivers/net/ethernet/intel/igb/igb_main.c:3090:25: note：‘snprintf’ output between 23 and 43 bytes into a destination of size 32
> 
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fix this warning by using a larger space for adapter->fw_version,
> and then fall back and continue to use snprintf.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

