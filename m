Return-Path: <linux-kernel+bounces-4928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12618183EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35421C23999
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D6A125CE;
	Tue, 19 Dec 2023 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DousJW5s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87713FE3;
	Tue, 19 Dec 2023 08:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F1C433C7;
	Tue, 19 Dec 2023 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702976241;
	bh=uFQlqLQP1G7wjfdANmp5BLEZwEILv8d1iFYDF7MRx6I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DousJW5sjM7HJvwYXPYiinIAEyL5QyeWPfBccOPDbCW9/vX6nAuGHK8CYUk92nNCr
	 WVvnmY7iNQAXEyVd0FGlNlwBSFhyPA10aY+f9fEL3jatPPRT2zHJUNfbWHnhH3EQan
	 wEJ8M3i4AF5vXnFdOxVdQPCcSAcnYlUbthzzkclg8btFNWh+fnsgXZuhplku7n/kZF
	 WHHLO/DYbF/MnNgm1uDsaGt2DhJ9txxWy3+DDwR1uVKQflE1+sWs8vkkCfpjFZKj6a
	 /G8dcSSrNWlHFDBSG8FthDg8VyyHeEHi1EOSg8AtmrH2s4evGToRVDJOdX6hl9vWP8
	 l7LJlbtqdEzCg==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Hector Martin <marcan@marcan.st>,  Arend van Spriel <aspriel@gmail.com>,
  Franky Lin <franky.lin@broadcom.com>,  Hante Meuleman
 <hante.meuleman@broadcom.com>,  Daniel Berlin <dberlin@dberlin.org>,
  <linux-wireless@vger.kernel.org>,  <brcm80211-dev-list.pdl@broadcom.com>,
  <SHA-cyfmac-dev-list@infineon.com>,  <linux-kernel@vger.kernel.org>,
  <asahi@lists.linux.dev>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
	<170281231651.2255653.7498073085103487666.kvalo@kernel.org>
	<18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Tue, 19 Dec 2023 10:57:17 +0200
In-Reply-To: <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Tue, 19 Dec 2023 09:52:23 +0100")
Message-ID: <877clash76.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

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
> Not sure I already replied so maybe I am repeating myself. I would
> prefer to keep the Cypress sae_password path as well although it
> reportedly does not work. The vendor support in the driver can be used
> to accommodate for that. The other option would be to have people with
> Cypress chipset test this patch. If that works for both we can
> consider dropping the sae_password path.

Ok, thanks for checking.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

