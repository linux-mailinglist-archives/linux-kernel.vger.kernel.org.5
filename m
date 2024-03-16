Return-Path: <linux-kernel+bounces-105283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3887DB60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAF11C20A06
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9B1C280;
	Sat, 16 Mar 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bVPzAivR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275C1B81F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710619248; cv=none; b=S0iVSxkEM1wydnTllOOi9H8gJjns1M8vOy/ZQOkKQ6Lk51IOSzWJ1SRHjABy70Yd5MHzrQNg+troUPZd1U0bZVfJvQjz8fphDOllQ496FoyiuWp29rns/tuCoSImCviqjwm7VlRhOmDPhqeQxCQgduVuTWZ4fZSxNOopEvklnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710619248; c=relaxed/simple;
	bh=AkVVYSYQM3y7NUqRtbpiMwYvB5peILbqU1B3Xj1uVdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYLoe0gjeOM7rel2UqR/2QHX0PRRPPznEY7mZkZFn4H96PyZDLlPXtG2jU6zfZVPaGGfOKN2n5lXxKclyZJ22BW7psxOw1v+FSnOTQqBjvQMUdvGIa8s3QDL4NLqPNH6Wy2aunjW53osVW5bgp4Dnne1ASnQzF9h6rhap7N638w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bVPzAivR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 863B940E01A0;
	Sat, 16 Mar 2024 20:00:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ej9hvAROFzB7; Sat, 16 Mar 2024 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710619237; bh=Z3V/1eQtFSYSd2aCqgrz+az8U7kdklIes+re2AC74NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVPzAivRkrt/kwNY7cctm8kH5ufM/9hrN7HC9m6F8t+wfa+95jYusIbzzwI64J/nb
	 GtVlJQjSqN1YExdr8OeXnH2FKrBJWFjVX/2H6v8x/eDQuaC/YYjexP0oxi6kl021m0
	 Pg16krhA/nE3Kh4sBw8BEUnF36Dbyuk++PPiIXq+JvZk6nD9Con2cp4gnz5jJb0/m7
	 VlqK7wVb32gkF3Hq7cv60SZU8redL+i0PAwa1giX7t4THkrdX2AuJW3FxVX2l5G8bT
	 OFtjCLZbmKf8vu6X8UdYKahhhPuJfwFBhfm5mm3TaAcJAPmc+cT6UaJC54obp3OFMs
	 wXFZNWVE5qb5CiBRvy4MtgbYz6LsT/BeRYoe6vA1qqy8yt63SkfTHPCy6+wSag0mkp
	 TaU3VJyJOE0SWz4yKgqpmK0hDh/lU+4pIvGbDwI1+OOyeswjB8uhjQWfnt03EYVpfT
	 GejktY/L/K7BjgtRqz2Pt73v1sB7ayu/d266nkoSoF1y6JDP+sPpsYPb49cEBSGxmW
	 ErdohbIvzuOa0DZy0wVYu1FfKdoCuCLhQMobuwD+fgS67aqCbeSRik/ukhR/tmX+4p
	 fTzpjXHxdkzceHrSwifuzOaqYtTlyRkhVoNYAuc580NEemtzGD6DULRwdrZdq8kdGq
	 6Kn84RIBx1eziWjIHhtfsWm8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 151C540E0140;
	Sat, 16 Mar 2024 20:00:22 +0000 (UTC)
Date: Sat, 16 Mar 2024 21:00:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	John Garry <john.g.garry@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linke li <lilinke99@qq.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	x86-ml <x86@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
Message-ID: <20240316200015.GAZfX6T9ftKSv0-Zs5@fat_crate.local>
References: <20240315122934.1d3231ce@gandalf.local.home>
 <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
 <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
 <20240316142002.7480d74b@rorschach.local.home>
 <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>

On Sat, Mar 16, 2024 at 11:42:42AM -0700, Linus Torvalds wrote:
> Now, I'm not suggesting anything like the multiple topic branches from
> -tip (from a quick check, there's been a total of 25 tip/tip topic
> branches merged just this merge window), but for clear new features
> definitely.

So some of those branches are really tiny (1-2 patches) during some
cycles so I have often wondered whether I should merge those small
branches into a single pull...

So as not to have too many tiny pull requests.

Any preference?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

