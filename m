Return-Path: <linux-kernel+bounces-3871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4C817478
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B4D1F24446
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB513A1C1;
	Mon, 18 Dec 2023 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB2bklC7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFB22088;
	Mon, 18 Dec 2023 14:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA42CC433C7;
	Mon, 18 Dec 2023 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702911546;
	bh=j87jRYCDb0lryskWckm01CmOmZHH/yU/DZt9Eohvopc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FB2bklC7bgMwydcNe05LbcKSrZQkpwU3XM7a4FBsc4CwXCXqoZTJ2xpb3d/KNKaUR
	 s8uBjmxMXBlgPkCqFgYT1BFwBQMBOudZnE8VDB1WDYgNVGK1xLneO0Klcewxx6M3aY
	 leC550vsP7nom003KJ+i5j+KieIfcqb9CV0NrRh+LqhShsmBidzqb3LiIpSPD2LPqq
	 x22BCQm9hAH3cbZOvx/stEsxLYxrj5NHPHoexwVP0wmmwNmXWutEmMj61pVv+YfSXT
	 LilzcFIpXt+DD3yGOF8Q9pdrpzwfp+zsS7amRP0FvCVWbeQRvOvmCHRKqhOzY+Anct
	 6LApnitldUI+g==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>,  =?utf-8?Q?Rafa=C5=82_Mi?=
 =?utf-8?Q?=C5=82ecki?=
 <zajec5@gmail.com>,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Larry Finger <Larry.Finger@lwfinger.net>,
  Arend van Spriel <aspriel@gmail.com>,  Franky Lin
 <franky.lin@broadcom.com>,  Hante Meuleman <hante.meuleman@broadcom.com>,
  Michael Buesch <m@bues.ch>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  b43-dev@lists.infradead.org,
  brcm80211-dev-list.pdl@broadcom.com,  SHA-cyfmac-dev-list@infineon.com,
  kernel-janitors@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcma,ssb: simplify dependency handling for bcma and ssb
 drivers
References: <20231218115802.15859-1-lukas.bulwahn@gmail.com>
	<26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net>
Date: Mon, 18 Dec 2023 16:59:00 +0200
In-Reply-To: <26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net>
	(Johannes Berg's message of "Mon, 18 Dec 2023 14:17:59 +0100")
Message-ID: <87o7ensgjv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2023-12-18 at 12:58 +0100, Lukas Bulwahn wrote:
>
> Dunno, I'm not super involved with this but ...
>
>> +++ b/drivers/bcma/Kconfig
>> @@ -1,12 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -config BCMA_POSSIBLE
>> -	bool
>> -	depends on HAS_IOMEM && HAS_DMA
>> -	default y
>> -
>>  menuconfig BCMA
>>  	tristate "Broadcom specific AMBA"
>> -	depends on BCMA_POSSIBLE
>> +	depends on HAS_IOMEM && HAS_DMA
>
> [...]
>>  config BRCMSMAC
>>  	tristate "Broadcom IEEE802.11n PCIe SoftMAC WLAN driver"
>> -	depends on MAC80211
>> -	depends on BCMA_POSSIBLE
>> +	depends on HAS_IOMEM && HAS_DMA && MAC80211
>>  	select BCMA
>
> to me it kind of seems more obvious for example in this case to say
> "depend on BCMA_POSSIBLE and select BCMA" rather than open-coding the
> BCMA dependencies both here and in BCMA? Now granted, they're rather
> unlikely to _change_, but it still seems more obvious?

I was thinking the same. Lukas, is there a specific reason why you want
to change this or this just something you noticed by chance?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

