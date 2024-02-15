Return-Path: <linux-kernel+bounces-67355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08AE856A58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962ED282C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852E137C27;
	Thu, 15 Feb 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcXLgPJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF15135A75;
	Thu, 15 Feb 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016300; cv=none; b=sTUhWYQWc6XBiU0KkdWqT6eb4UAs34QeXaJn2F5GkM/Z99jBpC4pA76fti4GySFHlnjvrzc1VL6pP8/+b6HrH2SbGmNogubcW1pK0LByssnJIsVNQB5sWMeALwJovJeam+fAPCPhQETMVCgid+tMqaT2ie0i5j5SUMx63ORl1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016300; c=relaxed/simple;
	bh=tHaTc7mB5fC1U8nauAM8JVm9/GGEYLSsMESHBa5W6H0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=up+iTjMdEZ21DxfLpe1g+bKsrs+C+0SEbltk2Q5uXtFoFjxdmW7jiRbxWST5T7Gq8/9eehl2wyw26/x701UuaC6Q+xki+6pLfHAO7Pu+oRsOxFA4ePDNP01kJAFeC49KeJdMKk24YFRxi8XRvafe616Roh2L9PPwxqjlX2q9pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcXLgPJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD083C43390;
	Thu, 15 Feb 2024 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016299;
	bh=tHaTc7mB5fC1U8nauAM8JVm9/GGEYLSsMESHBa5W6H0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rcXLgPJytbnbK9h2e3K1BhIMHqEsPeuPz3Uw/tCTPnw5uB6L/as07LFmlF7DtuiX5
	 V2wiz9hTj3ZdJn0WpwSKK2Kt7r3CJnQBl7Vj5ujzxqEYQIsgkmjIFeTKe519DeUAai
	 w3AOvzDQLyk5MD5AGEdJ5XdN+sBAtO6/L6WZHdlwsxLGubG325xbExt2QMVVUmHmj5
	 1Sw3Fe07qnr26okcMNiw4XIs8z6wbmb3HRTA9a272iu3v2Ypp6DSDRmtGdDVj59dmg
	 siUD50QoG1rlBitXXy6kxF20hJxpnChBAIsXKua8stjZvdJaNlMBucSYLr5pU6y1/o
	 25RYruXj8gfEg==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Ajay Singh
 <ajay.kathat@microchip.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Igor Mitsyanko <imitsyanko@quantenna.com>,
  Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 1/2] wifi: nl80211: force WLAN_AKM_SUITE_SAE in big
 endian in NL80211_CMD_EXTERNAL_AUTH
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<20240215-nl80211_fix_akm_suites_endianness-v1-1-57e902632f9d@bootlin.com>
Date: Thu, 15 Feb 2024 18:58:15 +0200
In-Reply-To: <20240215-nl80211_fix_akm_suites_endianness-v1-1-57e902632f9d@bootlin.com>
	("Alexis =?utf-8?Q?Lothor=C3=A9=22's?= message of "Thu, 15 Feb 2024
 15:13:52 +0100")
Message-ID: <87cysxekbc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> User-space supplicant (observed at least on wpa_supplicant) historically
> parses the NL80211_ATTR_AKM_SUITES from the NL80211_CMD_EXTERNAL_AUTH
> message as big endian _only_ when its value is WLAN_AKM_SUITE_SAE, while
> processing anything else in host endian. This behavior makes any driver
> relying on SAE external auth to switch AKM suite to big endian if it is
> WLAN_AKM_SUITE_SAE. A fix bringing compatibility with both endianness
> has been brought into wpa_supplicant, however we must keep compatibility
> with older versions, while trying to reduce the occurences of this manual
> conversion in wireless drivers.
>
> Add the be32 conversion specifically on WLAN_AKM_SUITE_SAE in nl80211 lay=
er
> to keep compatibility with older wpa_supplicant versions.
>
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

A pointer to the discussion would be nice to have:

Link: https://lore.kernel.org/all/09eeb7d4-c922-45ee-a1ac-59942153dbce@boot=
lin.com/

I assume Johannes can add that.

Alexis, thanks so much for working on this! This has been bugging me for
long but never found the time to investigate it.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

