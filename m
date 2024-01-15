Return-Path: <linux-kernel+bounces-25604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11D82D34E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370721F21442
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9841C3D;
	Mon, 15 Jan 2024 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBYUsvo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357ED3C0B;
	Mon, 15 Jan 2024 03:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817DDC433C7;
	Mon, 15 Jan 2024 03:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705289090;
	bh=mo76Nukq1W2YdcLMIvym+hHc0dhnYF0ZzSC0le28VnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBYUsvo0XHkzqVRKkeZu9QuGyxEdZTZEIgkUT2atkEStyBstrXRoCv84LXOliWvVs
	 cliKqsVslsAazoPzFIZ3vHKIhBh2Nyd2kvF3atNT0uasFEx56sW/tvt5Ov/RJNXEQ3
	 3bHaG1DSmTdyVTHjiT+axC/q891hn9HKnQF+ZTospsYDu9Ni4Rmc4f2E+dDfrfz/fM
	 FEf3mKVswtOp5dxJ/mGMbXyEOVZE8D/nO65MtJS6dMqnrL6QUHhQRctiHzzk+yIuQG
	 F4yszopL0vNniBhZHNo5qLwSPiGikBU7NQUMCFzk7BSmWtN12ijgEiLpH9VoIRVmUu
	 gc7+cnHApoxzQ==
Date: Sun, 14 Jan 2024 22:24:49 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tzimmermann@suse.de, Ziqi Zhao <astrajoan@yahoo.com>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
Subject: Re: [PATCH AUTOSEL 4.14 3/6] drm/crtc: Fix uninit-value bug in
 drm_mode_setcrtc
Message-ID: <ZaSlgTAz7vdk97JJ@sashalap>
References: <20231218124725.1382738-1-sashal@kernel.org>
 <20231218124725.1382738-3-sashal@kernel.org>
 <87bkamvay5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87bkamvay5.fsf@intel.com>

On Tue, Dec 19, 2023 at 10:44:02AM +0200, Jani Nikula wrote:
>On Mon, 18 Dec 2023, Sasha Levin <sashal@kernel.org> wrote:
>> From: Ziqi Zhao <astrajoan@yahoo.com>
>>
>> [ Upstream commit 3823119b9c2b5f9e9b760336f75bc989b805cde6 ]
>>
>> The connector_set contains uninitialized values when allocated with
>> kmalloc_array. However, in the "out" branch, the logic assumes that any
>> element in connector_set would be equal to NULL if failed to
>> initialize, which causes the bug reported by Syzbot. The fix is to use
>> an extra variable to keep track of how many connectors are initialized
>> indeed, and use that variable to decrease any refcounts in the "out"
>> branch.
>>
>> Reported-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
>> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
>> Reported-and-tested-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
>> Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> Link: https://lore.kernel.org/r/20230721161446.8602-1-astrajoan@yahoo.com
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This commit fixes an uninitialized value, but introduces a new
>one. Please backport 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable
>use") from v6.7-rc6 to go with it.

I'll take 6e455f5dcdd1 too, thanks!

-- 
Thanks,
Sasha

