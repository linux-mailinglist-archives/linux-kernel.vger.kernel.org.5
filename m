Return-Path: <linux-kernel+bounces-131224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E7E8984CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B761C20C51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE52C7602D;
	Thu,  4 Apr 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKH2h3jI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DF3D96B;
	Thu,  4 Apr 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225521; cv=none; b=jYAd99hdfaP256y+/c0ZNEkAlTVkWKsX79EvsmntBoKXnjm9gY/VCKeDDP1rEnPd86DJvZvgcM1hZCFZXXperdcQUL5upPk3jcDG49q/etKlqhwbfPclTsxH5+G6PNYdwW5rkiPnPV9O0W7dLr6HpK+avGzJENva0rwhWWwGKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225521; c=relaxed/simple;
	bh=+lFGWUK2A8+AE0BNEahXmc50uDsxFP64dSIEEtTABKk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MwpWOeb67In3lIGYsiMLd8D0aG1FCho3S8M/c2Vwt8vNH+qBkCi8rERNCOwqwohTtugD2KugborYxdBaM/SodUEu7vPG3+V0PItO1JN0VrzvTVV8t4aICFZNKVEsjkmTBBt4XuhTBZtvMSpy7/yffHy2rnLVctTYxBuim5bLWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKH2h3jI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D0BC433F1;
	Thu,  4 Apr 2024 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225520;
	bh=+lFGWUK2A8+AE0BNEahXmc50uDsxFP64dSIEEtTABKk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WKH2h3jITiaB4V+Poz2Io74wXrCiEo++JJk+Pu/qYTvn8UOART5NBdRtozL031SUj
	 3sV5pplFjGIMc5Car6Pk7k/3UysJI51GkeMJDfs3JwK5jK2FP8AAmeH052uHK/Ous4
	 BPGPqQMRn+LVmbmxS1VgY8PSQEKJ9eG/jvPgNC0+1DoIfmMXf3tlg6kH69wu1VIbE0
	 NULMcBqkYOMnJn4HEj5bVrhxCWxAFMzmtWjxq9DI085E7Gli8pkhTTzwQ1EktqfWTP
	 E4ZtMW//ZqSbpGGZ1Ar54DUhjTZnl1uMyTimNochYeJ5yKcCsD2+ng8cg5v+i5lYSb
	 Izb9GciaUYa6w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2][next] wifi: wil6210: cfg80211: Use __counted_by() in
 struct wmi_start_scan_cmd and avoid some -Wfamnae warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZgSP/CMSVfr68R2u@neat>
References: <ZgSP/CMSVfr68R2u@neat>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222551750.1806092.12183763425108574151.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:11:59 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/cfg80211.c:896:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

34c34c242a1b wifi: wil6210: cfg80211: Use __counted_by() in struct wmi_start_scan_cmd and avoid some -Wfamnae warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZgSP/CMSVfr68R2u@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


