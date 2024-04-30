Return-Path: <linux-kernel+bounces-163418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50F8B6A91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343771F21706
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34111B96B;
	Tue, 30 Apr 2024 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9i1p07A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5A19477;
	Tue, 30 Apr 2024 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459174; cv=none; b=aFBZJp4RLHZYW55VOfiK96UbIuHnDg7GACcMWK+3xdiUB+ul+XzlTrsqH+4PY6xNdEGMxxBEctoZDlVRj8s2pnScInms2PNGQk9Krv5rTnS1SYO5ydovzLDdC2lVzEybVWMlj1cCmIRiGVZ6D1erYJ/qevK00TMZZlJfjxVelAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459174; c=relaxed/simple;
	bh=oqnLXrIFCIxkLdU3yGt5+mmee31pq5ZWUdGnKAC//2Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ED0fxCMvgafT+GbchuNZBTTzYsSzRMGoLTUabKYSKmEdDgAU5sbq3KhuAIG76HVQFEUB3C3NFbgIva5eOJ+p83UjiEEjuGfrZsGJDOa+Y/lWUfPuLH3fduVB4El4otmZce4PZqxNncWsxZSazlssZzWvuBHLy9CTvDHpYJVWM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9i1p07A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FDAC2BBFC;
	Tue, 30 Apr 2024 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714459173;
	bh=oqnLXrIFCIxkLdU3yGt5+mmee31pq5ZWUdGnKAC//2Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=d9i1p07Aca+YWhFilcHBrCXtPHtGcJx8kthc0StbqTMZrqBtVGMJqiTBqBdbGQvRP
	 hpl6YozRPgM604gTXkL2bWDOHwRQThwiGuQAQ+TD1HftHWCePUbzRXtD/kkAw9hl/1
	 w6Qhlva/Rqny8+ncRVfMZ+5nlmlEobcWMNi9Dml15E+q8XUr0DMl6TcbSEFd7SHRkO
	 9tdopBqtqwaCgjYEILSLLC/YnAeGDZKSApiRkNzxvxSABGn5UPACL3WQZTbgPk0osf
	 zDrqMQaBKB+MDLl4qf8qOhDwo3/8ktquodGSmDosA6q4dwzKa0t8/7atnx/5nTO3rl
	 l0F1JX1iFEpvA==
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
	<202404291109.331E1704@keescook> <87bk5sf003.fsf@kernel.org>
	<202404291251.9CBC42E481@keescook>
Date: Tue, 30 Apr 2024 09:39:30 +0300
In-Reply-To: <202404291251.9CBC42E481@keescook> (Kees Cook's message of "Mon,
	29 Apr 2024 12:52:49 -0700")
Message-ID: <87y18vpd5p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

>> >> > I was just walking through our patch tracker and noticed that I don't
>> >> > see this patch include in -next yet (as of next-20240429). Is there a
>> >> > flush of the ath-next queue planned soon? Or did I miss some change?
>> >> 
>> >> Yeah, wireless-next was pulled last week so most likely we will create
>> >> ath-next pull request this week.
>> >> 
>> >> BTW we are planning to move ath.git to a new location, rename branches
>> >> etc. I think we'll see if we can also setup it so that it can be pulled
>> >> to linux-next, so that you don't need to ask this every time ;)
>> >> 
>> >> (Just joking of course, there a lot of benefits from having the tree in
>> >> linux-next)
>> >
>> > Ah-ha! Thanks. Yeah, sorry if I keep asking about that. It's different
>> > from other trees, so it doesn't stick in my head. :) I should keep
>> > better notes!
>> 
>> BTW I think all vendor specific wireless driver trees are not pulled to
>> linux-next: iwlwifi, mt76, rtw (Realtek) and ath. So with all of these it will
>> take a while before the commit is in linux-next.
>
> How long is "a while"?

The cadence can be anything from 1-4 times per release (~8 weeks).
Depends on the maintainer, how busy we are etc.

> And if the latency can be reduced for these, it'd be nice since it
> would allow for longer bake-time in -next.

Sure but our time is limited, as always :) There's extra overhead with
linux-next, like the rule that no updates during the merge window, so I
can understand why some maintainers have not included their tree to
linux-next builds.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

