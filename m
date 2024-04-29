Return-Path: <linux-kernel+bounces-162746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04C8B6001
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3601F2119E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278186AFE;
	Mon, 29 Apr 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmnSZgx7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6458595F;
	Mon, 29 Apr 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411560; cv=none; b=A4mrSFyh7V4m78UOdEPyn8XNll9ruAbR9lgEVMpfda1nRrFBhZiWFCJQDfs7J89kBaIYq/GR03WXGOeF7R82Hrznzsxj/0bFuyHVNJuj1I5sbQpMUXj++Ax8reGo/2P8dheKRAKfJN8RwtNl4bQjdfWgAlQJabO2XtfQ5OhR65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411560; c=relaxed/simple;
	bh=yWh+/d7hvYOisNptTdkyCNIRiL/pEpjcNGp7wzwrlF4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BDQUZcAAJ+8sLamlicDp/2VRnByGtjkHb4SjxJqfPyXI+ur2XSoWbVQ9cX/KIzPucrurdULySObBCLdVJd+L/MzmcMYNHol/dpQHHLtsFt8afaYjgLEoVppdpf1X5I4wSe23pm7mNIeHzvKDNKhsj/wc9s3tBlD9mAOd19FJg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmnSZgx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FD4C113CD;
	Mon, 29 Apr 2024 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714411559;
	bh=yWh+/d7hvYOisNptTdkyCNIRiL/pEpjcNGp7wzwrlF4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kmnSZgx7B6mABLxeTfo7qZPdx7Zg01FhKCmZFeq+mO65FpNtQOWF5WSyTgrt++0PH
	 UAiI8A2ZYjX1DgKi4TXYTKBjdbNT4rHed87e/Q+zyvH3+XRYNcy/7WZm5vVt1SJRsO
	 EROE4UE9cCw8cznhvY4S6D5jD63afzq/oSG35bcl3Ucgxd+rsJIO84Stex8WuPmGAk
	 iKOUpFFgONj/mAxZdAswAwlc8ANXbdb0Ou3uxFQk8YMvavxTrRtFyzp819TbJCL6ci
	 gOYMxyzxYYtKv6wuls9t6fIX4mrOFmAWqn6Ymtz4FkEnKZGaRer8MYEGWdwiHyBIgk
	 646Y1es6OazVg==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
References: <ZgSTCmdP+omePvWg@neat>
	<171222554691.1806092.8730005090791383928.kvalo@kernel.org>
	<202404291008.51DB333F@keescook>
Date: Mon, 29 Apr 2024 20:25:56 +0300
In-Reply-To: <202404291008.51DB333F@keescook> (Kees Cook's message of "Mon, 29
	Apr 2024 10:10:46 -0700")
Message-ID: <877cggqdwb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
>
>> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
>> 
>> > Prepare for the coming implementation by GCC and Clang of the
>> > __counted_by attribute. Flexible array members annotated with
>> > __counted_by can have their accesses bounds-checked at run-time
>> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
>> > (for strcpy/memcpy-family functions).
>> > 
>> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
>> > getting ready to enable it globally.
>> > 
>> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
>> > a flexible structure where the size of the flexible-array member
>> > is known at compile-time, and refactor the rest of the code,
>> > accordingly.
>> > 
>> > So, with these changes, fix the following warning:
>> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure
>> > containing a flexible array member is not at the end of another
>> > structure [-Wflex-array-member-not-at-end]
>> > 
>> > Link: https://github.com/KSPP/linux/issues/202
>> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> Patch applied to ath-next branch of ath.git, thanks.
>> 
>> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct
>> wmi_set_link_monitor_cmd and avoid -Wfamnae warning
>
> Hi,
>
> I was just walking through our patch tracker and noticed that I don't
> see this patch include in -next yet (as of next-20240429). Is there a
> flush of the ath-next queue planned soon? Or did I miss some change?

Yeah, wireless-next was pulled last week so most likely we will create
ath-next pull request this week.

BTW we are planning to move ath.git to a new location, rename branches
etc. I think we'll see if we can also setup it so that it can be pulled
to linux-next, so that you don't need to ask this every time ;)

(Just joking of course, there a lot of benefits from having the tree in
linux-next)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

