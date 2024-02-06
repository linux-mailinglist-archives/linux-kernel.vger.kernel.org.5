Return-Path: <linux-kernel+bounces-55200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7784B91A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7786B31847
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFE1350E3;
	Tue,  6 Feb 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQphKxI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A4137C32;
	Tue,  6 Feb 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232274; cv=none; b=lcNLILbgjZblUXF53eItLWUOOWPKOihFvT0zwLx9rvyTjE2J2CT/6QBnUIOD5Bb7m6+dt2vRh48YGO7Otqr/xLLEt6w5JByGz1+LEP8KSsFPmQ+SZshScGg4YxIZTT9tocTwUcqNsgAozlN+M1RncYWtCdjXu/TjjyhV8fc856o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232274; c=relaxed/simple;
	bh=OCse2MRBed0kmHIi9Fj9QuVp66gLc62VHDjtWvqcog8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SUokyKH0R7U348ZT6R5KwSvHNhu3se51ZRXZE9QY0mzaM1sQIzgKWLe07NE/VGAojm/tXQ2tx1fqoq9RAc69xMm7cYRzu8ikuRBdNXVcol5kwdfSFOFGiNQOQtGHZ+paaacs7paCA7Pm5E830TOPz58uteo0EsAOkq14UvL/0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQphKxI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE5BC433C7;
	Tue,  6 Feb 2024 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232274;
	bh=OCse2MRBed0kmHIi9Fj9QuVp66gLc62VHDjtWvqcog8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cQphKxI/Zb79rQA7qfIMj2ubiNnH39Tarcl1h2pU1/U8fa9aV2cok95p50kdGo43+
	 WBeI5i/yO9xhQKfweVQznR8/zuF3/DqO5+pcI+Sp8DsZspIX9uALLpZ86t5VqEAkH7
	 N0BidLnGUZqa7PxHFs4Jty9zqz2VKPdghWmniblfKzu4N833E9G/yy7xULAqo9+C/T
	 K8YWEWy03ve+Z41lxtk7LPqYGqr3QpYSZYtbSruSwUnJLnOFJoXdKRnO7B/4OHakNq
	 ssIki+nMjfhWwg2tlGkk1dtPlINZx1B/jXVpOaJHh4Bra03FrT61tKoxa55kCaBUzk
	 JXqqmW9o8Bg4Q==
Date: Tue, 6 Feb 2024 16:11:14 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
cc: Oleksandr Natalenko <oleksandr@natalenko.name>, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Do not flood kernel log
In-Reply-To: <4bd022b8-e4a9-4269-a261-65fddc791ec5@redhat.com>
Message-ID: <nycvar.YFH.7.76.2402061611020.21798@cbobk.fhfr.pm>
References: <20240129164931.38477-1-oleksandr@natalenko.name> <4bd022b8-e4a9-4269-a261-65fddc791ec5@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jan 2024, Hans de Goede wrote:

> > Since commit 680ee411a98e ("HID: logitech-hidpp: Fix connect event race")
> > the following messages appear in the kernel log from time to time:
> > 
> > logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> > logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> > 
> > As discussed, print the first per-device "device connected" message
> > at info level, demoting subsequent messages to debug level. Also,
> > demote the "Disconnected message" to debug level unconditionally.
> > 
> > Link: https://lore.kernel.org/lkml/3277085.44csPzL39Z@natalenko.name/
> > Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied to hid.git#for-6.8/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs


