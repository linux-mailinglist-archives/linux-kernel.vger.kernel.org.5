Return-Path: <linux-kernel+bounces-93806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22238734F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A072888DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F4605DB;
	Wed,  6 Mar 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckLjFwAG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D75FBB7;
	Wed,  6 Mar 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722442; cv=none; b=C1nbh64Qn7qkyvqShIimQXlAK0B60xT14g65OJfC92zciH6uhkHQI1X2kjd8NAf+AgBjrQd/Lw7r0+kTDgRAEDyPoiDW+uLoRxRiASDJzbE1rbmySCBO1qkVPWA+v3V74+jN3+LYspKQiJ4TpVGnMNqXOTVQ9JaD6GaNpkfZ9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722442; c=relaxed/simple;
	bh=V9ulxqkvtjrXOF64TXsr5C+5Oyn26F+JRDAIJVyStmk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SDWmFgr/yBGh5lo7+G/sd3yg/XEkhHeX4fkiJZ4/m30Ng6Ecwg/t+IcxsH+UUf6zOGCPCZrHQUFZWhZ9uUzfVEuPOAbzry/4KbM1K4Yb2e3vIomBOF01aPUPaI0Ct7UK2Taw93xYLqFrgIslr1YD5r1eazWb9uX47ty2g/0mVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckLjFwAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0FCC433F1;
	Wed,  6 Mar 2024 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722442;
	bh=V9ulxqkvtjrXOF64TXsr5C+5Oyn26F+JRDAIJVyStmk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ckLjFwAGbZree5//Mk79opO8RFRXtxd3J1fmcNm7ysSEH9FaRS7m04lrP55Phgvss
	 2hoJWZWCgWvTo5CzhWJnxZJPgIwqrKP6m3KCbAzrSqMwZQNkQ2UzSQ7pRv4U4IknE9
	 R4DikOsiqr3WkLY4OC2M5TKRiWeC888z/DUVvA4YmToqgSvfd21V7P184gngZ/ZWlz
	 sVQth2oggNteEFDkGsPlbURiwxZcNu3zuKpDv/zpa+mdkJOwtBxI8mzbFMX6O39K85
	 TVjp+y274Gua4VSCErNLVCtWkWYUxLisA/eMRWLi5s1P0xyLvXKujRyUsaDDEbhHo5
	 BMWzfMkmPLKsA==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
    Arnd Bergmann <arnd@arndb.de>
Cc: Duoming Zhou <duoming@zju.edu.cn>,  linux-kernel@vger.kernel.org,
  konrad.dybcio@linaro.org,  hdegoede@redhat.com,  minipli@grsecurity.net,
  linux-wireless@vger.kernel.org,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] wifi: brcmfmac: pcie: handle randbuf allocation failure
References: <20240301135134.29577-1-duoming@zju.edu.cn>
	<fdaefac9-1d02-4424-b893-4306b97028ca@broadcom.com>
Date: Wed, 06 Mar 2024 12:53:57 +0200
In-Reply-To: <fdaefac9-1d02-4424-b893-4306b97028ca@broadcom.com> (Arend van
	Spriel's message of "Wed, 6 Mar 2024 10:19:58 +0100")
Message-ID: <87h6hjhbqy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 3/1/2024 2:51 PM, Duoming Zhou wrote:
>> The kzalloc() in brcmf_pcie_download_fw_nvram() will return
>> null if the physical memory has run out. As a result, if we
>> use get_random_bytes() to generate random bytes in the randbuf,
>> the null pointer dereference bug will happen.
>> Return -ENOMEM from brcmf_pcie_download_fw_nvram() if kzalloc()
>> fails for randbuf.
>> Fixes: 91918ce88d9f ("wifi: brcmfmac: pcie: Provide a buffer of
>> random bytes to the device")
>
> Looks good to me. Looking for kernel guideline about stack usage to
> determine whether it would be ok to just use buffer on stack. Does
> anyone know. This one is 256 bytes so I guess the allocation is
> warranted here.

Arnd, what do you suggest? Do we have any documentation or guidelines
anywhere?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

