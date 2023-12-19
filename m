Return-Path: <linux-kernel+bounces-5057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3D81860D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA261C23A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E73154B8;
	Tue, 19 Dec 2023 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="EmhvUoL1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686741548E;
	Tue, 19 Dec 2023 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 82ED647326;
	Tue, 19 Dec 2023 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1702983707; bh=mZHa/PlWUTBOSVq8chMFTuSNQbSxKM92GV2NvSK0zF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EmhvUoL1tIGeLq2pn9Dvyg+n1e5zqt/RFDtFPkLDe59K0/mG/pEDvdop2h66UahQa
	 0iY/dc2b1tIJ3MKTxla/+VdNfcCPqMtyDeC1eRNKYLlS4s8t0QvESt5ZEgzAOmKGW5
	 FdiyYoSPwwdFHKGqSpfkDxYDK4yrAvwKH5GBz0zRxa1TUioPgIfTbtriNYYyeJId+d
	 Vd3IWEPkJO99Czk+oFbW5fFpNVuEQcMatqKZ4VXnx4R8bpL2AHrK/SD+5pPjqBoH1J
	 lqW58x8/dZDlZWa1/ALuuWhAMLIvNPkqSJe9n1mWSUsf6CO9JVoqmgjrj8Q5EGYqn7
	 6O47tUAAVKGDg==
Message-ID: <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
Date: Tue, 19 Dec 2023 20:01:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Arend van Spriel <aspriel@gmail.com>, Franky Lin
 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>,
 Daniel Berlin <dberlin@dberlin.org>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/19 17:52, Arend Van Spriel wrote:
> On December 17, 2023 12:25:23 PM Kalle Valo <kvalo@kernel.org> wrote:
> 
>> Hector Martin <marcan@marcan.st> wrote:
>>
>>> Using the WSEC command instead of sae_password seems to be the supported
>>> mechanism on newer firmware, and also how the brcmdhd driver does it.
>>>
>>> According to user reports [1], the sae_password codepath doesn't actually
>>> work on machines with Cypress chips anyway, so no harm in removing it.
>>>
>>> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
>>> patchset [2].
>>>
>>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>>> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>>
>> Arend, what do you think?
>>
>> We recently talked about people testing brcmfmac patches, has anyone else
>> tested this?
> 
> Not sure I already replied so maybe I am repeating myself. I would prefer 
> to keep the Cypress sae_password path as well although it reportedly does 
> not work. The vendor support in the driver can be used to accommodate for 
> that. The other option would be to have people with Cypress chipset test 
> this patch. If that works for both we can consider dropping the 
> sae_password path.
> 
> Regards,
> Arend

So, if nobody from Cypress chimes in ever, and nobody cares nor tests
Cypress chipsets, are we keeping any and all existing Cypress code-paths
as bitrotting code forever and adding gratuitous conditionals every time
any functionality needs to change "just in case it breaks Cypress" even
though it has been tested compatible on Broadcom chipsets/firmware?

Because that's not sustainable long term.

- Hector

