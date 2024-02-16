Return-Path: <linux-kernel+bounces-68758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF3857FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B55B286859
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1112EBFF;
	Fri, 16 Feb 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8VKPuke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65012EBE9;
	Fri, 16 Feb 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094786; cv=none; b=fu7YZB/O1ZZSFB/BoXXeyKqP1gl1Nli6nwRI4VvGr9V027iqSMXUtvYp7xKeQLjUDeIkYM0tv5oh/8BNi/FMxWCG6jnJbN9AGMER1fshS0oIXoBGoLf4X2XWECvMor9MlFHwbsNuKQ2sZlZLVVHr/2qjas52GhFp5yQaz/GJKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094786; c=relaxed/simple;
	bh=33cDlRRDwaR+e4Orkjw/IflYx11X++xZ5hBYAy4VnMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UagPpPk/arAP2eXdMtP4OKhNhgRDF/E8sKVTwc4o9CzPLJokb9u5kbdqXFMDAlSlL8AptnTsLM4YquJXURQvxGNcoika09JLujofPz1gseXexOk5WxZfWWjLONaZadsEyH4VhZJRxx/9tLK1IqWfftsxLRQ1JouP/WMikJtRsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8VKPuke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F26C433F1;
	Fri, 16 Feb 2024 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708094785;
	bh=33cDlRRDwaR+e4Orkjw/IflYx11X++xZ5hBYAy4VnMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8VKPuked3793jdt57KiqqnBtBt0C95jH8+NaeMOa1fTUXRYPVFSgsPfW2lImKUnX
	 4NlRMzqfyNFFBCJ3lct3GjxcXfFFrbjKN/KUtbz7SObvMSJ1XhQopMMpEzEbZG8Iq1
	 RXPx58q3REphGJSnpLyg/pK1hJoXjt6GAFRaRbQGt4V9SUdqkMlYyg/79bHPd0ymGl
	 tdxdLRV6jostbTHHhi5qkm3ir0jPgxyWNWvfpxZjsVtuxy0AF+KntT5mu3Isf1A42T
	 TTgkquZgZukM12nnjxzgnHXRAhSMdfSUHYKYG0OQrYK03bwUpAUXkuJ2aNH/pwSE0E
	 2jAxMUiquZ5eA==
Date: Fri, 16 Feb 2024 15:46:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
References: <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216130625.GA8723@redhat.com>

> SI_USER means that the target can trust the values of si_pid/si_uid
> in siginfo.

Bah, what an annoying nonsense. I see that this can be used to emulate
stuff like SI_TIMER and SI_ASYNCIO. But I very much doubt the value of
e.g., emulating SI_DETHREAD. Maybe I'm missing something very obvious.
In any case, thanks for keeping me honest:

So wouldn't be better of just writing this as?

if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
        goto err;

So that we don't have to repeat the same exercise if we extend this to
anything above PIDTYPE_PGID?

