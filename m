Return-Path: <linux-kernel+bounces-152806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B68AC483
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC78D1C20C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A64AED1;
	Mon, 22 Apr 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cui0MaRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB23BBCC;
	Mon, 22 Apr 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768811; cv=none; b=KcJlMJCu1LsocF2HiDdtAkBHMSw+lJuutQq9qCNI6GBuQGwrUovvqfcgrDxrxCIEUyp6FJuKrYeHkZusyx3Iz5TFZbs7GoPTLER3MnPxql6edtAKGGbjfBU7/ocFAFs20ul8z75xGT15oCGUgUW+hruowuKSgb/m/ytzMh9n+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768811; c=relaxed/simple;
	bh=BQ5lv0ySOhngt6oiBldECYAUh+70HIqFEVh7ZrhT2SU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J1D5ORC2uPtrk8PDmBcgBUYh4mEtKiyag31WWD38JhllUdzcLyumqSEAUdeb6PJ5jkkyFCp8CLEBAMaDMetkSJO1iz5PLWd4VQ8jiwcE1FD8atXDlrMDnrzQwKpZdIPgDkqRGHdjtgrLA4yzXdw8dNRzTLw9gmwR2ze7SE3+cpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cui0MaRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF79BC116B1;
	Mon, 22 Apr 2024 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713768810;
	bh=BQ5lv0ySOhngt6oiBldECYAUh+70HIqFEVh7ZrhT2SU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Cui0MaRtDe2xqQ3NEwHoiaqNEPh9QZrdEiUYskHiBgjzUxclmHsmCP6ag5nGU84bM
	 3b5x6NxZdfPeMvegaO7mkU3QgMxZobmAm2oln8xkQM/Oy8/+Oucf2IgnmG/TyB/Wn7
	 iQdcRWT2PJLWTmUDU6bWMGk2/fV7G6TSzKe1IoWdNnlo3yMEBweewQVG1KrgHX1Sf7
	 td471aBOw8drLYvbX6PKTOaVitHwsw9ADZoAa5l91FQdSWkWxrU3MP5yynDhnSBkIW
	 O8yLZoEwnTC68ASfkWblx7Spb7MGUF+NSjqs1Yv/Qw45PpGMdE8ky27RWo8/FkcZUT
	 on4t2PTh/wcSQ==
From: Kalle Valo <kvalo@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: quic_jjohnson@quicinc.com,  jjohnson@kernel.org,  nathan@kernel.org,
  ndesaulniers@google.com,  morbo@google.com,  justinstitt@google.com,
  c_mkenna@qti.qualcomm.com,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  llvm@lists.linux.dev,  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless v2] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
References: <20240422034243.938962-1-suhui@nfschina.com>
Date: Mon, 22 Apr 2024 09:53:26 +0300
In-Reply-To: <20240422034243.938962-1-suhui@nfschina.com> (Su Hui's message of
	"Mon, 22 Apr 2024 11:42:44 +0800")
Message-ID: <878r15j3bt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Su Hui <suhui@nfschina.com> writes:

> Clang Static Checker (scan-build) Warning:
> drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
> Value stored to 'ret' is never read.
>
> Return 'ret' rather than 'count' when 'ret' stores an error code.
> By the way, remove some useless code.
>
> Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2:
>  - remove the initializer change.
>
>  drivers/net/wireless/ath/ath10k/debugfs_sta.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
> index 394bf3c32abf..c1198e9027ae 100644
> --- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
> +++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
> @@ -432,14 +432,12 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
>  
>  	ret = ath10k_wmi_peer_set_param(ar, arsta->arvif->vdev_id, sta->addr,
>  					ar->wmi.peer_param->debug, peer_debug_trigger);
> -	if (ret) {
> +	if (ret)
>  		ath10k_warn(ar, "failed to set param to trigger peer tid logs for station ret: %d\n",
>  			    ret);
> -		goto out;
> -	}

Minimal changes with one logical change per patch, please. I'll remove
this part in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

