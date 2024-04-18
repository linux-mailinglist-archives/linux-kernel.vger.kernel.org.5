Return-Path: <linux-kernel+bounces-150375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E28A9E28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B771F22985
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A016C6A1;
	Thu, 18 Apr 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIEUZqdX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BE6FC3;
	Thu, 18 Apr 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453635; cv=none; b=j/3TdAPC9pAUAQ/WIjZgpoybW+z0g+TgtqtSwy+B+VRMk/1fgy7ICfvt7s1H6cwv9yZtcnRqKCHa6OctFZmE8ssBMzJO7XkE9j7f7lVM1gMHJVnr0icZF02TmC4QDxWahWQmzNtjWNp7Orj7Tk/EuywLZ/RTfEJDUF0De81yWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453635; c=relaxed/simple;
	bh=/e1tInGkYUBdYm7yvZRxryugFAXscOsuzj1rVya6Oog=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Ds1MXgSF5EW/tpzBuwmC8wrixvXzp6WVrMxTtDf81gxNqzLidRghYYqXAPF/Ku1qXxqJeKTi/yaEeyat/8VfHSfHQUwK59zWGpdWkEsCoraJ/g1SFFiUs5XocmETV77mhgSbP6hia41jb0CzV3MQXNm0KpoVWc8N536QQ+egasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIEUZqdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB43BC113CC;
	Thu, 18 Apr 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453635;
	bh=/e1tInGkYUBdYm7yvZRxryugFAXscOsuzj1rVya6Oog=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OIEUZqdXtRzTWFAMtqknhihf1jrgD1+yPT4GM8WDLj0SbbYc83kKI9Rlp78TcqLVk
	 N12Zxn1R1Dut8YqZz5tZO/2+X057JjRZiJSlVMtEcVjMrT8tcdzpsGBXJtpIrG52Vp
	 U/1KK2sWteKaU+cb7FPUPclL5sAWYeVc+GO3OQPx1cgrY2m/GGgidb5iWOvhRH8Zi9
	 gq6XtMhy5TPBLyLYcld/rpjxVHbSRxCLrGRQx2eBfVg991lQ/yPvybPplhsUXIPiv1
	 fxKtHpFMuFFsOBAaEOQLDxV2RT11hox8dFUUY82WMIhLVzX/mtWbOOLX+B1Rh6wEjU
	 NF4PWBZNuVO+w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: Fix error handling in
 ath11k_wmi_p2p_noa_event()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <07f1fc75b2d5b4173ae1b7bb1da5be7f6fc608c8.1713212781.git.christophe.jaillet@wanadoo.fr>
References: 
 <07f1fc75b2d5b4173ae1b7bb1da5be7f6fc608c8.1713212781.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kang Yang <quic_kangyang@quicinc.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171345363078.934743.11630888726665265520.kvalo@kernel.org>
Date: Thu, 18 Apr 2024 15:20:32 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS), there is a mix of
> return and goto. In such a case, 'td' should be freed to avoid a memory
> leak.
> 
> While at it, change ath11k_wmi_p2p_noa_event() to return void.
> '0' was returned in all cases, even in case of error and the only caller
> does not handle the return value.
> This is also more consistent with most of functions called from
> ath11k_wmi_tlv_op_rx().
> 
> Fixes: 2408379f15a1 ("wifi: ath11k: implement handling of P2P NoA event")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6ef5b4c9598c wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/07f1fc75b2d5b4173ae1b7bb1da5be7f6fc608c8.1713212781.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


