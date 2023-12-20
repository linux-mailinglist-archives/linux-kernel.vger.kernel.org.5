Return-Path: <linux-kernel+bounces-6734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8413D819CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B75288157
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFEB20B05;
	Wed, 20 Dec 2023 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgMGJ/r+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29A208B4;
	Wed, 20 Dec 2023 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37A1C433C7;
	Wed, 20 Dec 2023 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703067644;
	bh=bW/b/0hw0/RgDQsFlHT7qOcIwfrCFuaN1XGGFdaSO18=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tgMGJ/r+Z9ylUBfDWwrovqFTFF7ucf9y12Q6UDdojt5DJb532vCqrLWHV2i6MBX/E
	 ICceZgL73fNu8Ur14HqoA+bG7H+nS1rg7Z7ugJD6M+/t2nfJBVuyj9KvxX38qruKGe
	 1i8mG+IySVL8pNQCL8OhjKX7Dp4YeJDLwFH9vyopd0OD76RHsAHvEwwjZe2qTBE8kb
	 g1hkGkWm3hUVuIpl/HKt02CRwkHx8kaL/d75FwaEkJ0vaugwIApUJkNqIgZ/2cMtTi
	 H4hcmuzbK0PELrqsM2ADVzNZgeI/ztKArcDS2pAA8scAQWydpvNdcPOVuLibXt3hja
	 V3lOnM6dOzFaQ==
From: Kalle Valo <kvalo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hector Martin <marcan@marcan.st>,  Daniel Berlin <dberlin@dberlin.org>,
  Arend van Spriel <arend.vanspriel@broadcom.com>,  Arend van Spriel
 <aspriel@gmail.com>,  Franky Lin <franky.lin@broadcom.com>,  Hante
 Meuleman <hante.meuleman@broadcom.com>,  SHA-cyfmac-dev-list@infineon.com,
  asahi@lists.linux.dev,  brcm80211-dev-list.pdl@broadcom.com,
  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  David
 Airlie <airlied@redhat.com>,  Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
	<170281231651.2255653.7498073085103487666.kvalo@kernel.org>
	<18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
	<c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
	<CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
	<87r0jiqmnx.fsf@kernel.org>
	<01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
	<CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
Date: Wed, 20 Dec 2023 12:20:39 +0200
In-Reply-To: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 19 Dec 2023 17:44:18 -0800")
Message-ID: <871qbhqio8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> Just recently a patch was posted to remove the Infineon list from
>> MAINTAINERS because that company cares so little they have literally
>> stopped accepting emails from us. Meanwhile they are telling their
>> customers that they do not recommend upstream brcmfmac and they should
>> use their downstream driver [1].
>
> Unquestionably broadcom is not helping maintain things, and I think it
> should matter.
>
> As Hector says, they point to their random driver dumps on their site
> that you can't even download unless you are a "Broadcom community
> member" or whatever, and hey - any company that works that way should
> be seen as pretty much hostile to any actual maintenance and proper
> development.

Sadly this is the normal in the wireless world. All vendors focus on the
latest generation, currently it's Wi-Fi 7, and lose interest on older
generations. And vendors lose focus on the upstream drivers even faster,
usually after a customer project ends.

So in practise what we try to do is keep the drivers working somehow on
our own, even after the vendors are long gone. If we would deliberately
allow breaking drivers because vendor/corporations don't support us, I
suspect we would have sevaral broken drivers in upstream.

> If Daniel and Hector are responsive to actual problem reports for the
> changes they cause, I do think that should count a lot.

Sure, but they could also respect to the review comments. I find Arend's
proposal is reasonable and that's what I would implement in v2. We
(linux-wireless) make abstractions to workaround firmware problems or
interface conflicts all the time, just look at ath10k for example. I
would not be surprised if we need to add even more abstractions to
brcmfmac in the future. And Arend is the expert here, he has best
knowledge of Broadcom devices and I trust him.

Has anyone even investigated what it would need to implement Arend's
proposal? At least I don't see any indication of that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

