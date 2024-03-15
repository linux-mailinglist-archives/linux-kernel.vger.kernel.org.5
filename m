Return-Path: <linux-kernel+bounces-104999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFE87D776
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9451282927
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B65A4D4;
	Fri, 15 Mar 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jDaSFAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6a2sLaIb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F24D9FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547121; cv=none; b=Qh+KgDP/kyiROMciETNV8v4mfP21qF1SmEZLnGYqUOJDEHIBJmogpNSE7uVby+9TTna20M6SwbXCCeD/jpgmCJbIx0FDxMIpcdMp/cE6y9x49su7hFzRUABR4qPQfgrktrcUpqmEKxK9BoDB/yiYUZczHR+FhFBfngkthpcr7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547121; c=relaxed/simple;
	bh=OjyWHRS6To7CoYzJwDoXQTV1mnF63TJmVfL2/CN0E2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7W3s1idun1c2vN6YgCv/1dBs7wyCHPeYfS+4I3lSbErT8oMsXk61PBnlODyD5QIXwNy4KcZZG+NJNmenUsFiyJfh9MX1NdiqYHyVRYuIKqWEoQZceMJsx5SMW882AAicyzjn3j9azouTXriRZbAN9fg1myRoHUFgMvNCZXsPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jDaSFAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6a2sLaIb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710547116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlgIIWxaWEjG1a30AVbW0gP+tYBECI0dfUcH3JwXRqA=;
	b=1jDaSFAVkXSWfMADGyngJf5aNZrXF4vGU2GVGEKIDDG06OsTmIvxp9Sz/V/UeajZQZJOYO
	VnDZkxzPU1Ni8cZ5P6VGweUpW90MQFTkGiBmCpduoOLPeOY4Ivul5jY4eDrQBgipjWQTdr
	6WkURhQNtGO6TONjYFQcy9OGsLlJzsoIiqDchOzleLiDPHeOj1ml2SCzoqZZBsFEI6f5qe
	ukz3ujQdZrVThbhXn75geMTvLSMcLHJC0b+1IGJFF9LFmNPGG4Wmn1mp35gNQQxiv8NdsO
	dqyO9oNuMAOk5tBkEbktSylY4PojCi6CHghTr5NY5FnRUldN52PGR6uyRwHqeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710547116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlgIIWxaWEjG1a30AVbW0gP+tYBECI0dfUcH3JwXRqA=;
	b=6a2sLaIblwhp7628ZPsC/HGs8EbPeWBG9EC60ycbfEqMBzXF+jK2IcQ+IsGE8ijGdAdRpU
	FuvdXYaT1Jg/MDDw==
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Peter Griffin
 <peter.griffin@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Peng Fan
 <peng.fan@nxp.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Sergio Paracuellos
 <sergio.paracuellos@gmail.com>, Mubin Sayyed <mubin.sayyed@amd.com>, Ley
 Foon Tan <lftan@altera.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] timer drivers for v6.9-rc1
In-Reply-To: <5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org>
References: <5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org>
Date: Sat, 16 Mar 2024 00:58:36 +0100
Message-ID: <87a5mzjbdf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024 at 16:37, Daniel Lezcano wrote:
> The following changes since commit 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09:
>
>    tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug 
> (2024-01-19 16:40:38 +0100)
>
> are available in the Git repository at:
>
>    https://git.linaro.org/people/daniel.lezcano/linux.git 
> tags/timers-v6.9-rc1

First of all why are you sending this pull request in the middle of the
merge window instead of having it in my tree at least a week ago?

That aside:

git pull https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v6.9-rc1
fatal: protocol error: bad pack header

Three times in a row with a 5 minutes gap between each attempts. I try
it again tomorrow morning.

Thanks,

        tglx

