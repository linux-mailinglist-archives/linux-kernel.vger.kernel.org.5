Return-Path: <linux-kernel+bounces-75334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28185E6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEC7B23656
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318E85941;
	Wed, 21 Feb 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX0oeWJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9283CCE;
	Wed, 21 Feb 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541684; cv=none; b=IVEv30orgwj2xsEmj1PuPhYOssptTanTFC9gZY0F92hVi/81ltCLY7ZGJQYxFkSAyU2ikJhMOVkoqcn1dMEifSCRjotzF9bO9osO/4RkXvOidhly1kx/gz0grT8iEyMnMiA9Eg+tbUPIlMmwfTHW5ekIdGJPG76KEha/bmAiFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541684; c=relaxed/simple;
	bh=b/p+fxSCKAw7wiBKITe2X7yTKmf+xbNvYQZ58i6OmbQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=btf/rr0WZkbb5yISwXkEAdG4lL3SdUI/wD19HQqwoE5YAJfJ8O6OZlclkOIax5WERGEheP/fCw+EelGxU0fpgUeuYiq2FeKKx8SsL5U3IFsNMIVjvYMQKLGja9rIqMVztsxRKzzI5mm/fJlmsnulor1cIwM8mRNrivtXEyvbbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX0oeWJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5354DC433C7;
	Wed, 21 Feb 2024 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541683;
	bh=b/p+fxSCKAw7wiBKITe2X7yTKmf+xbNvYQZ58i6OmbQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=YX0oeWJzVn5Uva2Oc3cKr/Mp8sWYNfTnMZrzYfPemrGbaPTJGUK/6NpWLd3pb7LK2
	 r4yKiA4ASt0AigwCJ42VuKy7UtuR8i2Gud8R+/rwFWkL5TyS91060BKaoeC7/sGfDI
	 idxfcCy/bBi2rkGQ9ufRa6j+JDcLQeG3ZQxr+nlihh6KNwtLHFOQFUM9c9WkTxrZQd
	 P2XlOQq+oFPHJFlvka9fTNnGWGvVn+PKb7z2iXOSOzzGx0Nu7AX2Oama4tgqRXK/54
	 rY57mtwj8OryjoAznRy6yuNZSKyV6goWm/sUdTD1+lAr0t+fuIMkPlFn67ic/Shcra
	 QdgQdTzImS5Kw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/2] wifi: wilc1000: remove AKM suite be32 conversion for
 external auth request
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240215-nl80211_fix_akm_suites_endianness-v1-2-57e902632f9d@bootlin.com>
References: 
 <20240215-nl80211_fix_akm_suites_endianness-v1-2-57e902632f9d@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854167959.1918455.695828297472841721.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:54:41 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> The driver currently raises the following sparse warning:
> [...] cfg80211.c:360:42: warning: incorrect type in assignment (different
> base types)
> [...] cfg80211.c:360:42:    expected unsigned int key_mgmt_suite
> [...] cfg80211.c:360:42:    got restricted __be32 [usertype]
>   CHECK   drivers/net/wireless/microchip/wilc1000/netdev.c
> 
> This conversion was needed because historically the external supplicant
> (observed with wpa_supplicant) expects AKM suite as big endian in
> NL80211_CMD_EXTERNAL_AUTH message when the AKM suite is WLAN_AKM_SUITE_SAE.
> This is not needed anymore:
> - new (to be released) versions of wpa_supplicant now reads it in host
>   endian _while_ keeping compatibility for older drivers
> - for new drivers used with current/old wpa_supplicant, this conversion has
>   been added to nl80211 to force big endian when the AKM suite is
>   WLAN_AKM_SUITE_SAE
> 
> Remove this not-needed-anymore conversion to fix the sparse warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308290615.lUTIgqUl-lkp@intel.com/
> Tested-on: WILC1000 hwB SPI WILC_WIFI_FW_REL_16_1-13452
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

00413dd36414 wifi: wilc1000: remove AKM suite be32 conversion for external auth request

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240215-nl80211_fix_akm_suites_endianness-v1-2-57e902632f9d@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


