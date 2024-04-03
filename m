Return-Path: <linux-kernel+bounces-129958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E9897284
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C71F212DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12341149C4B;
	Wed,  3 Apr 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHeJypll"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99E148FE8;
	Wed,  3 Apr 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154340; cv=none; b=hn8CwZtADc/zQT/sGTMZC7Wwf6VzKno0zbOineOWhLZHcdHwwdIPtNcx+cPDv/OBarEQ1zRB50v8kWmDDzkhS4GtrkPsXGaMoBnqwrf0O/y/xdMyD0mbdtWrMupAnQYFdcbMrTIygFuOAMBC9n/VSRrX0sOXFhHBlKYXK/tnDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154340; c=relaxed/simple;
	bh=rEQlpF8LEm0jnwECyk8fqxYAF5glW3sXu62EM8DBMu4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FbGFxDn1K4qLZTPB2YZQ3mrTAmDxaad5ZoPTBV2Y2DzTd8yV41rSPglsrtGZVXELCjFZMRcPutAncO0l/9XkEV4aGADiFVFr0Jzw5aOFnYJqxwDr4hLKQ7+kAqGNsItbieJ6AsSoREkqPIaCrLEvFbKkSknl93wDV+gJrLY/J44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHeJypll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C1BC433C7;
	Wed,  3 Apr 2024 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154339;
	bh=rEQlpF8LEm0jnwECyk8fqxYAF5glW3sXu62EM8DBMu4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gHeJypllYzbUGBJwibURijLQb0SIDI7zpW+Qaei+IC8LBG3xUNLYozHUis9iLbrl4
	 58PXcNn1ndJu7ZQJvlSHVsrufYEmyM0/bN3iATMbtOkeNRGnVTMTCK9oXYTlbCMZGT
	 iTUiFrpBT1GTywPrRFzbxLuBBLQdWiI6ElRjOnJR9VcaD/xhYyKMXNOwZXyyv/nUEB
	 6gwSK3BRDmpb77x/0iKotz4fCsKUlqfwNh6BgT4gfRCQAuCrfw+Zj1hqcd89Itwmb+
	 ADiOvohvIqDASUCxT06Tva8mOrm6XSSJVM/49vwP7Z3iGGuocm/zCutQt2PM7tbDjK
	 5SXgj2cm1uWGA==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Jeff Johnson
 <jjohnson@kernel.org>,  Brian Norris <briannorris@chromium.org>,  Ajay
 Singh <ajay.kathat@microchip.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] wifi: ath10k: sdio: simplify module initialization
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
	<f78fa061-3b34-47d2-a40c-bbec744f0f97@quicinc.com>
	<87jzle5zda.fsf@kernel.org>
	<ec78df08-118b-4086-beec-9227b309595a@linaro.org>
Date: Wed, 03 Apr 2024 17:25:36 +0300
In-Reply-To: <ec78df08-118b-4086-beec-9227b309595a@linaro.org> (Krzysztof
	Kozlowski's message of "Wed, 3 Apr 2024 16:02:30 +0200")
Message-ID: <8734s25xr3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 03/04/2024 15:50, Kalle Valo wrote:
>
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>> On 3/29/2024 10:10 AM, Krzysztof Kozlowski wrote:
>>>> This driver's initialization functions do not perform any custom code,
>>>> except printing messages.  Printing messages on modules
>>>> loading/unloading is discouraged because it pollutes the dmesg
>>>> regardless whether user actually has this device.  Core kernel code
>>>> already gives tools to investigate whether module was loaded or not.
>>>>
>>>> Drop the printing messages which allows to replace open-coded
>>>> module_sdio_driver().
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>
>>>>
>>>> ---
>>>>
>>>> FYI:
>>>> I have ongoing patchset touching few lines above this patch chunk
>>>> (sdio_driver) which might go via different tree. If that patchset is
>>>> applied via different tree, it might result in a trivial conflict, but
>>>> there is no dependency. They can go via separate trees (except that
>>>> trivial conflict).
>>>
>>> I'll let Kalle respond if he'll take this through the ath tree vs letting you
>>> take it through your tree
>> 
>> I prefer to avoid conflicts as much as possible. In this patchset I'm
>> not anticipating any conflicts with wireless trees, so if we can avoid
>> any conflicts, please take this patchset via the other tree:
>> 
>> Acked-by: Kalle Valo <kvalo@kernel.org>
>> 
>> I'll drop this patchset from my queue. But if I should take these to
>> wireless trees instead just let me know.
>
> Just to clarify - only the first patch has possible conflict. The rest
> should be fine.

Ah, I was not quite sure what patches had the conflict.

> Can you pick up 2-6 patches from this set?

Yeah, that sounds the best. So patches 2-6 are back in my queue:

https://patchwork.kernel.org/project/linux-wireless/list/?series=839844&state=*&order=date

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

