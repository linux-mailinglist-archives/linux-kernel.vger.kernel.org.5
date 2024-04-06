Return-Path: <linux-kernel+bounces-134067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7160789ACC8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 21:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21681C21126
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0854D9F7;
	Sat,  6 Apr 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T1+hEUEI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016634545
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712433252; cv=none; b=rHlgJcp7u3t9UoZM147eGC6u1TQ2v3yJXPRsWWqK4bJphJfg1JYofcWPkKdveyiWZ020sp/qy/EeFhPGeZbHuuOEGSRBV5vtEe55LhuXreQTq3ViXIWRNJt4sMXJGG+mXCvfknSZc6xuftecoSImFxus+sLQPl9umVht3MDtbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712433252; c=relaxed/simple;
	bh=uWkMIFA9pDOXHsFyOvcOESw2flmE29vwkV/XD05XcvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdCROTU9toMk8lWV4zXi6Td/baKAGjDzolKc/h9pI9P31GgXkamjPBEIrTxyy3u2/pi2RATIVQ0zYVqywi/YqznQgmmFML1xMUcXXuNGnBFO8oZwlSBughweH2QbWFDAkqRdpNmHeK2ECf0hZHz9dv/Y73hxGT0aNXjks4mdQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T1+hEUEI reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 419DC40E0202;
	Sat,  6 Apr 2024 19:54:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1kz_p41A0I-9; Sat,  6 Apr 2024 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712433236; bh=fqhHslrWiyU84kc7rZUanPrGmId4lXQnhx5ISa+DyXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1+hEUEIzp2URHBcvO6p5QlgwybCwGmNrjUF3844F7YPy1sHOZtvYQG2t58A3bgSX
	 RNW/c9wnVjzPn30R9tKTdfI88kMZCXWJN2PBf8x7rD4VAJqaBDzCcQC8Szics9/lxv
	 8xbShYMJN7th5SHOpLlmzc6XyGvVVp0K3X07hF4fGGH4T11MQ7ssRU6O9zax6SFLax
	 rcoG5sByFCARFuHh3vLyP5gySMEZe+KO8AwZtach+Xo4VDv/fx6ju1qABQX0nawkGE
	 DESdSaXKPww+ziRLt3Ig5rbr4HLuR5ZVIHJ2Nq+JD+KF0ZdMgVxWz+JemCxkEKuVbR
	 2NapwhydWV1ot5P2v22LOQuSVfcDOTWBmQY7uo3YfvdegJpwoxlLhBIAjKOb235Xxm
	 92B4oQ+0zE2s/5X8ntsWzscOkXnOeXGfpKU2O7+Y+tanOspKZU03RqmgdESRJjVgRy
	 XgOocxzAFFF4ycaM/RLapoLvw9y2B8wYv8KA7ZM4RK+k8luRs/bqRbpzMLUEIpzz8S
	 XgqN/m2X10IxaI/4DBoyeubB8k7QoJL8F0a0e+51+vszPjp17/04Bzj2ud6hH1zVuI
	 lyeyvl1yJL70upOauT8FtcZz/dXKx2zHWos1iOMpXMne0OkmB/GwWZCjOm8dw2f9Mi
	 6+DgFAKaAUZAy0htM3zpuoFs=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50ED440E0192;
	Sat,  6 Apr 2024 19:53:50 +0000 (UTC)
Date: Sat, 6 Apr 2024 21:53:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Build failure on 6.9-rc2 with "x86/bugs: Fix the
 SRSO mitigation on Zen3/4"
Message-ID: <20240406195342.GAZhGoRqGgEhAyJK54@fat_crate.local>
References: <658b2641-1f06-4680-8bf9-87b64ad5241d@o2.pl>
 <20240405002051.GHZg9D43hLP8DAm0Ph@fat_crate.local>
 <9f82dbdd-3b10-4c68-ae3c-0e4144604fe2@o2.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f82dbdd-3b10-4c68-ae3c-0e4144604fe2@o2.pl>
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 09:04:37PM +0200, Mateusz Jo=C5=84czyk wrote:
> Sorry for not searching for this commit more carefully earlier.

Nothing to be sorry for - thanks for reporting!

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

