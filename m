Return-Path: <linux-kernel+bounces-162908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313308B61EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FB1B22A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02A13B588;
	Mon, 29 Apr 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0RFfydn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9012B73;
	Mon, 29 Apr 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418496; cv=none; b=lvZJ5CwUEjJYo7WOh6O/F1pmQZWUIZ/5BfsYOHuKFxPvhDDr0OpZXcD21k4hYO+egFQJWwC1goHepvcwH8WEAWrfw4K973LCzaeyeAiKnuMC2lhCzib9fdvOSUKyHbuqvIdGAu5hmDF5Hf22GoVjLDF4SZHdjlsinjSeD++T/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418496; c=relaxed/simple;
	bh=vOAjXkqV/BW5BFMy/FugtkSomI+lCtbQeeOuE8DfZRM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o7M6vKzttgiUZ2NiTYYY2BbTwhmAeBvbC+rkkoNY6DMw0kvSHOBeV+AIhHfxzzMvCx5hP39HMwt31Eo094rkLxCPLiYrsG6s7SBRpfQlKlctQTDsFUlOkfbZOMqIerkcUPqvxT00dHtPcTCxMYwUKRwvUpa9/6nSXpJ0vSMCsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0RFfydn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4AEC4AF1A;
	Mon, 29 Apr 2024 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714418495;
	bh=vOAjXkqV/BW5BFMy/FugtkSomI+lCtbQeeOuE8DfZRM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=c0RFfydnB/AYsCs+tTB8U2TfsP/SkMCXDKAFCcdiWgHbk9DVIikiajKo42GI80Bzb
	 /QcXx4KflBBZyWAeym9CEbXh/qGHPhuo7Kco+c4KcJOVSQfcjg8guWhTHkP6/XUAcE
	 +a+iNmYng8SmHShJOR9wjrONK4D8wB0vcsl9QKtk40PyINjGLtMMfZA0nnwOvNc/sd
	 QYzzm5UP/ZEykBARAwTm9RqCCMl878CnBECYblsWQUZQ9P92P/3v2fri6fLCQ+OMqM
	 +9Hs6zv0xovtrYn/RH8NSfiX3dOsovbAgZeZB7xrY/KI1Uji9+RKNjMW96pmwxovVL
	 0cQwguLbnWKUw==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
References: <ZgSTCmdP+omePvWg@neat>
	<171222554691.1806092.8730005090791383928.kvalo@kernel.org>
	<202404291008.51DB333F@keescook> <877cggqdwb.fsf@kernel.org>
	<202404291109.331E1704@keescook>
Date: Mon, 29 Apr 2024 22:21:32 +0300
In-Reply-To: <202404291109.331E1704@keescook> (Kees Cook's message of "Mon, 29
	Apr 2024 11:09:43 -0700")
Message-ID: <87bk5sf003.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Mon, Apr 29, 2024 at 08:25:56PM +0300, Kalle Valo wrote:
>
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
>> >
>> >> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
>> >> 
>> >> > Prepare for the coming implementation by GCC and Clang of the
>> >> > __counted_by attribute. Flexible array members annotated with
>> >> > __counted_by can have their accesses bounds-checked at run-time
>> >> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
>> >> > (for strcpy/memcpy-family functions).
>> >> > 
>> >> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
>> >> > getting ready to enable it globally.
>> >> > 
>> >> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
>> >> > a flexible structure where the size of the flexible-array member
>> >> > is known at compile-time, and refactor the rest of the code,
>> >> > accordingly.
>> >> > 
>> >> > So, with these changes, fix the following warning:
>> >> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure
>> >> > containing a flexible array member is not at the end of another
>> >> > structure [-Wflex-array-member-not-at-end]
>> >> > 
>> >> > Link: https://github.com/KSPP/linux/issues/202
>> >> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> >> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> >> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> >> 
>> >> Patch applied to ath-next branch of ath.git, thanks.
>> >> 
>> >> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct
>> >> wmi_set_link_monitor_cmd and avoid -Wfamnae warning
>> >
>> > Hi,
>> >
>> > I was just walking through our patch tracker and noticed that I don't
>> > see this patch include in -next yet (as of next-20240429). Is there a
>> > flush of the ath-next queue planned soon? Or did I miss some change?
>> 
>> Yeah, wireless-next was pulled last week so most likely we will create
>> ath-next pull request this week.
>> 
>> BTW we are planning to move ath.git to a new location, rename branches
>> etc. I think we'll see if we can also setup it so that it can be pulled
>> to linux-next, so that you don't need to ask this every time ;)
>> 
>> (Just joking of course, there a lot of benefits from having the tree in
>> linux-next)
>
> Ah-ha! Thanks. Yeah, sorry if I keep asking about that. It's different
> from other trees, so it doesn't stick in my head. :) I should keep
> better notes!

BTW I think all vendor specific wireless driver trees are not pulled to
linux-next: iwlwifi, mt76, rtw (Realtek) and ath. So with all of these it will
take a while before the commit is in linux-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

