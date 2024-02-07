Return-Path: <linux-kernel+bounces-55979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2784C477
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738762899F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32E1BC22;
	Wed,  7 Feb 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfpGvmE0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28514F90;
	Wed,  7 Feb 2024 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284798; cv=none; b=Mg0gX8KRC0RaVzn66QYICz2iS++DhM8MhQ37rQxC50yMupSAt50JeTYwMRv4igwtqPBvXvxGaNmOcw0IstgoZQxV8csP2q78w39u/sHrZgZtVqNAT1FCdlqTMDmzybaMaV7UD3l+MPnxwYMbCnxn0HRjbOMzRCFsLcrbdE3hBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284798; c=relaxed/simple;
	bh=wWv9ER3bGnIlVmFYCCzUV1fpnrPWMz/9TKWMjaoxakk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f/XfzC3oZpQGwH90ws/90qLQJIlFt+nKSMn2gvLyLbWeJi9RuvdqI3NxYB/XwjpThOPg7cNCI0K6u2el4BwFIY63T3uq5H8FrkBWtWid0CT6lkCSFoES1F8j3im24P5oSL8IBayFIt7WVfrBjYahZGB8BqFBuk4j6esf4hcneoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfpGvmE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11FCC433C7;
	Wed,  7 Feb 2024 05:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707284798;
	bh=wWv9ER3bGnIlVmFYCCzUV1fpnrPWMz/9TKWMjaoxakk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mfpGvmE03buVVSCUoDrNV3dSp7Tk4hP4upqm7jK2WoZdkhwd03D+RuqIHLYy3Z5pu
	 3TiRIF2ioX1N8EwGMEaZoRWm/JMza5IrcnyXMJrdQEiV5LZMioTTQmkP5DOXFPtYfi
	 LOIsvYl7aWD2hPtm21kWd+AKrQzXRsSt4cJT3al0OFR+qx0Hst5HrUD5GFx8KuojEO
	 WzEBGc2VXzlcsKCZxsq1bbRCcBWovbl+XBAIcSmdtBdgDepudWAn692gI3oQrPVKv0
	 NAv0brAkaq93ZuGaWjt0ii4A4/Ow1+mvWUFmMqE3Nb4n+NvVsC+kbPt9LFS2L8fHnt
	 sIlbVL0vsgWkg==
From: Kalle Valo <kvalo@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,  Felix Fietkau <nbd@nbd.name>,
  Ryder Lee <ryder.lee@mediatek.com>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: mt76: inititalize sband.band to correct value
References: <20240207000130.4040-1-spasswolf@web.de>
Date: Wed, 07 Feb 2024 07:46:34 +0200
In-Reply-To: <20240207000130.4040-1-spasswolf@web.de> (Bert Karwatzki's
	message of "Wed, 7 Feb 2024 01:01:30 +0100")
Message-ID: <87zfwchlmt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bert Karwatzki <spasswolf@web.de> writes:

> Set phy->sband_{2,5,6}g.sband.band to the correct enum value, otherwise
> the ieee80211_register_hw() will fail to register the device.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=218466

s/Fixes/Closes/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

