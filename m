Return-Path: <linux-kernel+bounces-40948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8A83E8AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A34DB27323
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945273C13;
	Sat, 27 Jan 2024 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kLInt7AC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02772573;
	Sat, 27 Jan 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316288; cv=none; b=VUIInI1eK3zYEj6DxGIBbsvyVl88lB5lxBEMOpcgLUQkcJinxB3qsB6aDbJoFudVKzvWKdDvoOLhNdNu3aF4souXz0e0WAGlFrBouQBBTn0n3o+Uz7XfC1F2T4r5u4t2mAHr5kyjta2NeG6ONZKsDvG0VyBMZKZFLeBqPsvFI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316288; c=relaxed/simple;
	bh=4lYVIs/+rZG4bNmhU3BPuzDZIthKg9gmdo2bombYMp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv/S7rKJ/JnDB7LoHhMvDdirtzF0CHKMyu1n/vdorkefIjfCqpXkPBb2K7y/DaVJ7AphVGKI/dtOk2uveOEuMNSB90PeDvFXgUtKaQB91mBuJgIj4ILkpVwW2MVGEHQ/Zme45dLzcEp4eJEwEeIZxmPMw7RsMj3H6pz92udz9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kLInt7AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48491C433F1;
	Sat, 27 Jan 2024 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706316288;
	bh=4lYVIs/+rZG4bNmhU3BPuzDZIthKg9gmdo2bombYMp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLInt7ACX/WHFNjvUKxWJKFKxAlttFK/2Sm93N5hBZjII0Rzv0ktN0cR69whsgb9c
	 dquZgWf6sicIY1AOfVo+4UAFF4jEQhRMY6rd2foFo/RtFZOBcZIoIrLIdTqVHJE1pi
	 4f8YBYlt0UPJA24JiRQluU2wN/aydol6e9IF2ZOo=
Date: Fri, 26 Jan 2024 16:44:47 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: Consider picking up "tpm: Enable hwrng only for Pluton on AMD
 CPUs" rather sooner than later
Message-ID: <2024012639-trekker-fraction-367c@gregkh>
References: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfb5c07-664e-49cd-a470-635a36bcf806@leemhuis.info>

On Fri, Jan 26, 2024 at 07:02:43AM +0100, Thorsten Leemhuis wrote:
> Hi stable team, JFYI, yesterdays mainline commit 556857aa1d0855 ("wifi:
> ath11k: rely on mac80211 debugfs handling for vif") from Benjamin
> contains no stable tag, but a Fixes: tag for a 6.7 commit. So it guess
> you will pick it up anyway. Might be worth picking up rather sooner than
> later, as it fixes a regression that according to Kalle causes ath11k to
> crash during suspend:
> https://lore.kernel.org/all/874jfjiolh.fsf@kernel.org/
> https://bugzilla.kernel.org/show_bug.cgi?id=218364
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
> 

Now queued up, thanks.

greg k-h

