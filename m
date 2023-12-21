Return-Path: <linux-kernel+bounces-7898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9AA81AEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1849E28662D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC8125DA;
	Thu, 21 Dec 2023 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBtKBo2Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5B11733;
	Thu, 21 Dec 2023 06:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9343DC433C8;
	Thu, 21 Dec 2023 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703140716;
	bh=Yhl/ykyxVA6LA1kDZOxQMgUP3Z7vfjny1ZSJoKucqog=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jBtKBo2ZiBpDcT422t0EOms8MP/5gNWYSaAN1ggNe2OggUvouJznOezeC94w6b1Z6
	 cTAX5Rrnp/va+W1GfKitWezNesm2EIoqYKPnvu3vIdjaTTgEiJr58GuXy1Oc3CZXX8
	 KK5lDh23OJ6Vj1fHORrGFO7wWF8ZjKASNFD2//xaAjVwp0lu1KPO1TqVgpKvSmANOq
	 veWV8V6Fndry8QbjxQkrO1LIM9K5eVkZbu3uQ2cb6Sy3VAcnohMYZlsKq6cNomkKM7
	 Cz0u9b+SIwnDAo/oLZzh5fiv29mgP6wX2hJeVDCVRb9BE7fnU/ychZW+Yrv9DsR9zl
	 RdooDQ6blXDIw==
From: Kalle Valo <kvalo@kernel.org>
To: "Ma, Jun" <majun@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  "open list:MAC80211"
 <linux-wireless@vger.kernel.org>,  "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>,  open list <linux-kernel@vger.kernel.org>,  Jun
 Ma <Jun.ma2@amd.com>
Subject: Re: [PATCH] wifi: mac80211: Use subsystem appropriate debug call
References: <20231215145439.57286-1-mario.limonciello@amd.com>
	<87frzzsfoi.fsf@kernel.org>
	<46bf6ed5-31f6-48f4-b63d-f532e163204e@amd.com>
Date: Thu, 21 Dec 2023 08:38:32 +0200
In-Reply-To: <46bf6ed5-31f6-48f4-b63d-f532e163204e@amd.com> (Jun Ma's message
	of "Thu, 21 Dec 2023 13:57:50 +0800")
Message-ID: <87cyv0oyaf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ma, Jun" <majun@amd.com> writes:

> Hi,
>
> On 12/18/2023 11:17 PM, Kalle Valo wrote:
>> Mario Limonciello <mario.limonciello@amd.com> writes:
>> 
>>> mac80211 doesn't use dev_dbg() but instead various macros from
>>> net/mac80211/debug.h. Adjust wbrf code to use wiphy_dbg() instead.
>>>
>>> Cc: Jun Ma <Jun.ma2@amd.com>
>>> Reported-by: kvalo@kernel.org
>>> Closes:
>>> https://lore.kernel.org/amd-gfx/8bd60010-7534-4c22-9337-c4219946d8d6@amd.com/T/#mfe2f29372c45130d27745912faf33d9f7ce50118
>>> Fixes: d34be4310cbe ("wifi: mac80211: Add support for WBRF features")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  net/mac80211/wbrf.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
>>> index a05c5b971789..12c23e14f884 100644
>>> --- a/net/mac80211/wbrf.c
>>> +++ b/net/mac80211/wbrf.c
>>> @@ -23,8 +23,8 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
>>>  		return;
>>>  
>>>  	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
>>> -	dev_dbg(dev, "WBRF is %s supported\n",
>>> -		local->wbrf_supported ? "" : "not");
>>> +	wiphy_dbg(wiphy, "WBRF is %s supported\n",
>>> +		  local->wbrf_supported ? "" : "not");
>>>  }
>> 
>> This won't work, I still see the debug message:
>> 
>> [  333.765867] ieee80211 phy0: WBRF is not supported
>> 
>> The issue seems to be that mac80211 defines DEBUG in
>> net/mac80211/Makefile:
>> 
>> ccflags-y += -DDEBUG
>> 
>> That -DDEBUG should be cleaned up, but I think separately. It's just
>> that I cannot come up with any good proposal, all the macros in
>> net/mac80211/debug.h require sdata and we don't have that in this stage.
>> Any ideas?
>
> I will submit a patch that only compiles wbrf.c when CONFIG_AMD_WBRF=y

But does this mean that the debug is still printed when CONFIG_AMD_WBRF
is enabled? And I would assume all distros enable that, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

