Return-Path: <linux-kernel+bounces-105293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCF87DB81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53154281E47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0001CAAD;
	Sat, 16 Mar 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DbpupfPQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4F1CAA5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623272; cv=none; b=gqhW5cKcYYw9TFb7rwwGi9r1W5vTCoY8Si3EInksEDEtkLfTZfLgtHSjQphEe+1uLwsp402M9s0FQc3ThSFzuiMrthMtaoNTn3HtXhTZGLwVqT/NeoYMAji6XNLn4sINV+Og3OymFoZe4vvMgpH4s9PLIEhkcfMUPAy3VJRB9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623272; c=relaxed/simple;
	bh=kYptCyj+pw36bBMGXpzqpoXmTuJQg5A47HElm/XBWSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYLUEoClERK//FckLkca2W+vsQ/nuguz3aXSXePGldZaWNEimBAJnTE1+PqeHQbIF4171RdgnpjwXkk/Xc5NKNec4EWKSmk87h1q9WQCe0Dbq0juk9n39RuEewLhX+k1BboSso0C5evJrWhvE1W/I5eMd005ydHmUb11Lh+2hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DbpupfPQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B57EB40E01A0;
	Sat, 16 Mar 2024 21:07:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x0sxDmehAJxK; Sat, 16 Mar 2024 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710623253; bh=G1iNvT1gA12MdIRy/RhuziVSLQNCVqOVU/h/einDDrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbpupfPQxf2csqUdtR5CoVkyun2eAIjHCoanjppztCwKLOqFv3/Yf0Aqb/XPMGplq
	 vtKpUlE8WCFQheFECJCXowazxWZsPz9efRTOjzEdYJTu3WVX0PPOMEvvdw3pKhZPjD
	 nvdBpufQ1Zfl6dz1Rl4HKnC60x0J6PDBS/xmLlHqgCb8QwbUOadYErW6mSl1ohATPB
	 LmaUHzMy03T60TnTMERXthPYQaZt/QzquC8aCE2Aj6ZrUwoR9iFu8U8tGINWsyuHuG
	 7YmhytmrQXo2D8ipVfkYHHIxIkxMzKIxubacNeoe3HXXlvh3CvRbe0MI5HMBJkyUp1
	 NicC3Rn9n+guYpq1MWdSALmM4y/CwlO09hawuL1s0wAO1E4ky6cTnb+1qg/URUPMca
	 hPZxC0rsyad1ZRrPgu8gX94oOYQbCNfbSB+CHBCwVc4FDGQRxsLiZbCsi2W98WDRU9
	 DH76OYJFnqlN2A3drhS03w4mWbo1VmuKPUXPrZGkl2ZgRlPVsVX5ZpjoyeLK/zPiHB
	 A68HVCCN+5yd1QjIa/PH1GTdkSSD6iiwZ3I1nWd7f3Ui9MoCDqiHe3XAbwXYmXQ6oa
	 aEN20ZdQUddyPQlVBVnWWemWj+Dxx5ivfuDFz4Horqtd4LlP+n1LygXlGkpCw1O1+I
	 V9H+Kxy8OJ8Llj6hkj96C9EI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B3B840E0140;
	Sat, 16 Mar 2024 21:07:18 +0000 (UTC)
Date: Sat, 16 Mar 2024 22:07:12 +0100
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
Message-ID: <20240316210712.GEZfYKADWKOdILezL3@fat_crate.local>
References: <20240315122934.1d3231ce@gandalf.local.home>
 <CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
 <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
 <20240316142002.7480d74b@rorschach.local.home>
 <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
 <20240316200015.GAZfX6T9ftKSv0-Zs5@fat_crate.local>
 <CAHk-=wiGymybvnQu2=+nzc18HkRudoeJODci13RBDr5afyDjfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGymybvnQu2=+nzc18HkRudoeJODci13RBDr5afyDjfg@mail.gmail.com>

On Sat, Mar 16, 2024 at 01:42:06PM -0700, Linus Torvalds wrote:
> But if it's a "one pull to fix a single-line issue in resource
> control, and another pull to fix a single-line issue in objtool", then
> those make perfect sense to keep separate, even if they are both
> trivial and small.

Yeah, that's what they are - we do topic branches so it is always
separate topics - just sometimes they don't have too much going on
during a particular cycle.

Ok, understood - separate pulls, even if small ones, are fine.

> And on the other hand, if you have a couple of trivial branches with
> no real pattern, and decide to just merge them into one that fixes
> "misc x86 problems", and the end result is still completely trivial
> and there are no surprises or gotchas, that's not wrong either.

Ack.

> And sometimes, merging and sending me just one pull request is
> absolutely the right thing.
> 
> For example, the ARM SoC trees tend to just merge "umbrella" updates
> into one single pull request, and I prefer that - because I see no
> point in getting ten different "this is the drivers for SoC xyz"
> thing.

Right.

I do a similar thing with the EDAC tree because it is all EDAC - no need
for separate pulls. We just keep them separate in case we have to rebase
early in the game to keep history clean. Yeah, well, rebase only if it
would get relatively ugly if not.

And then Tony or I merge them all into a single pull.

> So then it's still a clear topic branch ("ARM SoC drivers"), but they
> kept multiple branches for different SoC's and sent me just one pull
> request.
> 
> End result: there's no one right thing.  Make it make sense. Probably
> the only real rule is
> 
>  - try to keep conceptually different things separate just for cleanliness
> 
>  - definitely keep fundamental new features or anything that _might_
> be questionable in a branch of its own

Ok, understood. Makes sense.

> but there aren't some kind of black-and-white rules for "this is so
> small that it's not worth sending on its own".
> 
> This merge window, I think I currently have something like ~15 merges
> that ended up being literally just a couple of lines (maybe spread
> over two or three files). I don't mind at all. If that's all that
> happened, that's fine.

.. and that is also some sort of documenting it: this area didn't see
that much development this cycle.

Thanks for explaining.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

