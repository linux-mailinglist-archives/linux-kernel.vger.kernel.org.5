Return-Path: <linux-kernel+bounces-7370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5581A6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25571C2402A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86035482C9;
	Wed, 20 Dec 2023 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="n0i8NiFS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778A482C2;
	Wed, 20 Dec 2023 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 2C6633FA0B;
	Wed, 20 Dec 2023 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703095328; bh=ok7tGtfGC3218MMeZ/9Y2l59vDssFzzr7dIjcG3mv5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n0i8NiFSqhklOpoUjIcF8grNRe3qmU8/3YErV/YMDxhQassoDRjOF5+XNth8jWEXm
	 tQ/t5ZPTEiXkPDVPY0wmDYIYVj88AT/B3elGaowFu5lpWywjOMleAla0Z7O7saRYAO
	 dEekf64sAACXdkcyfmuBoEMwPUdAgbGexzrnURO8wPammM+HMLqDt1YQTn5ylesLon
	 RvFu+mYqFv4jxd56SfmqvANt0FK75clE6vQpgGCmh4sLBqdKukUuwiRsNyIVVD/nDf
	 14fkaCV/Si7rarm1C6OBgH+h4fQgth07Jmmdge9qH3uqpkF3xqL+l1TV9leBNq6TPR
	 gAJu/9LOyS/SQ==
Message-ID: <3e7f9763-a481-40d1-a5aa-9d71ebe13d98@marcan.st>
Date: Thu, 21 Dec 2023 03:02:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Paul Fertser <fercerpav@gmail.com>
Cc: Arend van Spriel <aspriel@gmail.com>, Franky Lin
 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <ZYK/C3LzK8LMOjER@home.paul.comp>
Content-Language: en-US
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <ZYK/C3LzK8LMOjER@home.paul.comp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/20 19:16, Paul Fertser wrote:
> Hey Hector,
> 
> On Tue, Nov 07, 2023 at 03:05:31PM +0900, Hector Martin wrote:
>> Using the WSEC command instead of sae_password seems to be the supported
>> mechanism on newer firmware, and also how the brcmdhd driver does it.
>>
>> According to user reports [1], the sae_password codepath doesn't actually
>> work on machines with Cypress chips anyway, so no harm in removing it.
> 
> I'm sorry to disappoint you but I've just tested this patch on a
> "Pinebook Pro" which has AP6255 module and it broke WPA3 Personal.
> 
> No error messages are emitted to the kernel log, just iwctl saying it
> can't establish connection.
> 
> This is using "Cypress" firmware from the Linux firmware tree [0]
> renamed to "brcmfmac43455-sdio.bin" which has the following features
> (extracted from last two lines):
> 
> 43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-wowlpf-idsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-roamprof-txbf-ve-sae-dpp-sr-okc-bpd Version: 7.45.234 (4ca95bb CY) CRC: 212e223d Date: Thu 2021-04-15 03:06:00 PDT Ucode Ver: 1043.2161 FWID 01-996384e2
> DVID 01-1fda2915
> 
> 
> This module is used on many SBCs, including some RaspberryPi
> boards. The reason RaspberryPi owners complain about lack of WPA3
> Personal support is that most of them are using obscure downstream
> distros which ship brcmfmac firmware from somewhere else rather than
> the Linux firmware tree, so they lack the "sae" feature. Another is
> that it only works with iwd while default is wpa_supplicant.
> 
> So far all known reports of those who tried the right firmware on
> RaspberryPi boards confirm WPA3 Personal was working with iwd [1].
> 
> 
> I'll be happy to do more testing if needed. Thank you very much for
> your hard and insightful work!

Thank you for being the first person to actually test any of this :)

Now we actually have a reason to keep the code. The next thing I wonder
is whether any of the *other* Cypress chips will respond to WSEC (in
addition to or instead of sae_password)...

Are you willing to test all the other wifi stuff we have queued up
downstream? There's a whole pile of changes here:

https://github.com/AsahiLinux/linux/commits/bits/080-wifi/

If things break it would be very helpful if you could bisect it down to
the specific commit. This patch is also in there of course, feel free to
revert/rebase it out.

- Hector

