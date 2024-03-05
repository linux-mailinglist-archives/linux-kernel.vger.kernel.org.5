Return-Path: <linux-kernel+bounces-92862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4792F872712
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9221F295A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD901C28B;
	Tue,  5 Mar 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd/ZLRij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1301B26E;
	Tue,  5 Mar 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664985; cv=none; b=N5cpIuPFZW1UVfo69jnSuIqBQ1AP9sjOHXNjZBGbMyr4UocsFUXH8TqFbTt1hYft6le1zfwMrl6moBlJ9IIp5D/UUPx2sQXxRdfN+DhmqP6Ax7asgk1InS6Y3pKpPJ52q0irGUZJRilZAaw54zn5Uo32zmIxQyTQNhrEWN5qKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664985; c=relaxed/simple;
	bh=pTOiKNw8kRBoqvH5vAPiz3p6O7+BEgqHronxns/y2/I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uIkU6juTNVpbS66mOCtmgGKps8Hr4IKrAY8oKBKZhEPuHoValA7W9Utz1zjtHBgT+GEAYmKuGBMT7g6hHCk0D0rwk6kVSyy+ZVNNI1IJR7EhO9YpxTexebATzBgKiP2Jwd0yHpVae8b0/Agu0bJqwUUX3X+OcfNHMdM4jzi3mBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd/ZLRij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93248C433F1;
	Tue,  5 Mar 2024 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664984;
	bh=pTOiKNw8kRBoqvH5vAPiz3p6O7+BEgqHronxns/y2/I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qd/ZLRij92a9SdWrQ39F/HOqSmUUE+lPW/oueSAnG4Rpv+GlcW33LZrpUk+dEpzNX
	 ngDKtlUy5U9HJlk7NBYnKa5uMCGbpjdut3n9BpsHaXzHFl+7CNdy76vGp2I9jXByX2
	 EvQVf7QikayPDpBWfMqIp177ZZ9r/6tJN/Pg3tJBV3miQ6u0F1HN4Bx24f3SEGxAsf
	 Cui7dN+zB1E6IEf1pRqaQVg3lyTmpQ1YtHgCntVSLlLspQwKj6bXAvJN+9hNx5RSN6
	 SvX7IMX7KY107aCrKjmY2j7UyG87An9Qwa46fZPSJvLg32PbT8+f/luUmxaOCGGvgX
	 fO14YpJEb8xwQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: brcm80211: handle pmk_op allocation failure
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240229103153.18533-1-duoming@zju.edu.cn>
References: <20240229103153.18533-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 justinstitt@google.com, quic_alokad@quicinc.com, jisoo.jang@yonsei.ac.kr,
 petr.tesarik.ext@huawei.com, hdegoede@redhat.com, keescook@chromium.org,
 johannes.berg@intel.com, arend.vanspriel@broadcom.com,
 Duoming Zhou <duoming@zju.edu.cn>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966497987.424347.4050351610859400431.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:56:21 +0000 (UTC)

Duoming Zhou <duoming@zju.edu.cn> wrote:

> The kzalloc() in brcmf_pmksa_v3_op() will return null if the
> physical memory has run out. As a result, if we dereference
> the null value, the null pointer dereference bug will happen.
> 
> Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
> for pmk_op.
> 
> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

b4152222e04c wifi: brcm80211: handle pmk_op allocation failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240229103153.18533-1-duoming@zju.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


