Return-Path: <linux-kernel+bounces-23434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864C82ACB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D0C1F23055
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DC15495;
	Thu, 11 Jan 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8FOHZFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBBD14F60;
	Thu, 11 Jan 2024 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E76BC433B2;
	Thu, 11 Jan 2024 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970691;
	bh=b4kPg7Dlhoh2Ylgd7Rl0rO+8xy+oTw1hAq/n9H5lbHY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=f8FOHZFumJgkdpbXCpfREugTvA1/PkK+qa0y+iiwCNQkl5H1QzCshaHj38k7PZCfO
	 FLAKNEMdDZyibSA+/u1dw3K1+MbiNrAZDzIIhIpdD4YvbW4UvHdegjKuHwhnTc4vqx
	 RuqSA5bBZtZUk5LKIklpEnPT9qNEBwNsCMB2o2h+8IWuj03Rg9vRs4aMS5aGDgUQ+D
	 ii6s3LLrj1FLv1SiGxA0otdb2eHs0KugWkm4+qpTuga8/tY4GYMT7VD6KiDtsxUSs4
	 oKRGMeEvoqy7gIRBM05HMRlnbcCUANxUdIhjWxIoo7nrsDCDmAp4IuFzuwGgR2UEV/
	 4r61du8RAVmTQ==
From: Kalle Valo <kvalo@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Ma, Jun" <majun@amd.com>,  Johannes Berg <johannes@sipsolutions.net>,
  "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  "open list:MAC80211"
 <linux-wireless@vger.kernel.org>,  "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>,  open list <linux-kernel@vger.kernel.org>,  Jun
 Ma <Jun.ma2@amd.com>
Subject: Re: [PATCH] wifi: mac80211: Use subsystem appropriate debug call
References: <20231215145439.57286-1-mario.limonciello@amd.com>
	<87frzzsfoi.fsf@kernel.org>
	<46bf6ed5-31f6-48f4-b63d-f532e163204e@amd.com>
	<87cyv0oyaf.fsf@kernel.org>
	<0ad78e88-05d5-483f-83fa-87d5f1d80ca5@amd.com>
Date: Thu, 11 Jan 2024 12:58:07 +0200
In-Reply-To: <0ad78e88-05d5-483f-83fa-87d5f1d80ca5@amd.com> (Mario
	Limonciello's message of "Fri, 29 Dec 2023 20:42:10 -0600")
Message-ID: <87bk9sb0hs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 12/21/2023 00:38, Kalle Valo wrote:
>
>> "Ma, Jun" <majun@amd.com> writes:
>> 
>>> Hi,
>>>
>>> On 12/18/2023 11:17 PM, Kalle Valo wrote:
>>>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>>>
>>>>> mac80211 doesn't use dev_dbg() but instead various macros from
>>>>> net/mac80211/debug.h. Adjust wbrf code to use wiphy_dbg() instead.
>>>>>
>>>>> Cc: Jun Ma <Jun.ma2@amd.com>
>>>>> Reported-by: kvalo@kernel.org
>>>>> Closes:
>>>>> https://lore.kernel.org/amd-gfx/8bd60010-7534-4c22-9337-c4219946d8d6@amd.com/T/#mfe2f29372c45130d27745912faf33d9f7ce50118
>>>>> Fixes: d34be4310cbe ("wifi: mac80211: Add support for WBRF features")
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>   net/mac80211/wbrf.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
>>>>> index a05c5b971789..12c23e14f884 100644
>>>>> --- a/net/mac80211/wbrf.c
>>>>> +++ b/net/mac80211/wbrf.c
>>>>> @@ -23,8 +23,8 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
>>>>>   		return;
>>>>>     	local->wbrf_supported =
>>>>> acpi_amd_wbrf_supported_producer(dev);
>>>>> -	dev_dbg(dev, "WBRF is %s supported\n",
>>>>> -		local->wbrf_supported ? "" : "not");
>>>>> +	wiphy_dbg(wiphy, "WBRF is %s supported\n",
>>>>> +		  local->wbrf_supported ? "" : "not");
>>>>>   }
>>>>
>>>> This won't work, I still see the debug message:
>>>>
>>>> [  333.765867] ieee80211 phy0: WBRF is not supported
>>>>
>>>> The issue seems to be that mac80211 defines DEBUG in
>>>> net/mac80211/Makefile:
>>>>
>>>> ccflags-y += -DDEBUG
>>>>
>>>> That -DDEBUG should be cleaned up, but I think separately. It's just
>>>> that I cannot come up with any good proposal, all the macros in
>>>> net/mac80211/debug.h require sdata and we don't have that in this stage.
>>>> Any ideas?
>>>
>>> I will submit a patch that only compiles wbrf.c when CONFIG_AMD_WBRF=y
>> But does this mean that the debug is still printed when
>> CONFIG_AMD_WBRF
>> is enabled? And I would assume all distros enable that, right?
>> 
>
> Maybe just discard the debug message instead of have to deal with this.
>
> We'll be able to tell from the consumer (amdgpu right now) when WBRF
> is being used and if we need to debug an issue knowing that it's
> supported or not supported from the producer side is the least of our
> worries.

Yeah, removing the message for now is the best solution. It can be added
later after we have improved mac80211 logging.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

