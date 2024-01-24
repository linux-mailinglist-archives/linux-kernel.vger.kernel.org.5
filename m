Return-Path: <linux-kernel+bounces-36478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D283A178
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA461C21EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60CEE575;
	Wed, 24 Jan 2024 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="F0BpVUTY"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29743DDCE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074892; cv=none; b=q1w1bpFHFT3KXbTI7uw3/ROcXjLUIlq4d6kLIhZ00lzNEhmnZjDvBUUCKgK9fOZDi4Y8A6lZOXDsH99fi+9yPc2U/GMDh6Dca4Z6eYJ9u+KoKoxDUkm44CDdJByQuUmTqfAYdvauID/vLw1ZSh6fpCB0fJgaq1EnHkEBgN1wr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074892; c=relaxed/simple;
	bh=RLLxUdkDPBsC4Vc8m/92Z8uc3PsBrwkuLEFD0qAnxk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0XqUHkgSXYCq0hUmQcp2kOpbHET1AbAwkv8csqk/mr0M6qalTpH7pwn75DAw4es52Zr12erhsJb8EaBG1x8nRlLZPEUGM4VpJiYGG4L29dPqY0ytmBBGVL3P4nsgyY0CRo4Gnzh6p/3aPVquDBTtI5SvRLfI13FvcSM5RWa+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=F0BpVUTY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-122-36.bstnma.fios.verizon.net [173.48.122.36])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40O5aZSQ021415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 00:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706074597; bh=sRhoaUO93OYOZ4Mh1rIvfQPvG6ITdq3qLbPLkxj4DZc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=F0BpVUTYIIq9DhD6RIMbtl8UtRyoZOfiiIWalFE4m3/nj+EyRGTrwU07sQz/KoWal
	 NpwtarN3J7R0VIgTAZxNMn3j1CcW3B17QaYGzOmNRp+6OKAtvZqKBwWOCGFOh6NikM
	 NjSG7Ek2kdVd08NvNoixsHjp72hiUpfCLyRR5H/fkOVd0EKbl0mlsmdiQyV/KrMt8S
	 VlENNQZuzuAQAmho+7Lw/Nb0AaHZVmCdD4cPY7xQFtiETbaRjXgBCh9I1UYcfFDzNH
	 HWTSjgdWUITuD/nyJOFZe0PRnXoXMgy98sSEevoH28zJJCQMS239VPFd3TJk/qhuI3
	 8d6NgA4oLWMew==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E029415C04DD; Wed, 24 Jan 2024 00:36:34 -0500 (EST)
Date: Wed, 24 Jan 2024 00:36:34 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, G@mit.edu,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
Message-ID: <20240124053634.GD1452899@mit.edu>
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
 <20240121063038.GA1452899@mit.edu>
 <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>

On Sun, Jan 21, 2024 at 10:48:35AM -0800, Linus Torvalds wrote:
> On Sat, 20 Jan 2024 at 22:30, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Linus, you haven't been complaining about my key, which hopefully
> > means that I'm not causing you headaches
> 
> Well, honestly, while I pointed out that if everybody was expiring
> keys, I'd have this headache once or twice a week, the reality is that
> pretty much nobody is. There's James, you, and a handful of others.
> 
> So in practice, I hit this every couple of months, not weekly. And if
> I can pick up updates from the usual sources, it's all fine. James'
> setup just doesn't match anybody elses, so it's grating.

If we told those people who wantg to pursue key rotation to just
always upload keys to the Kernel keyring, using the instructions
here[1], and at the beginning of each merge window, you updated your
local clone of the kernel keyring git repo[2], and then ran the
scripts/korg-refresh-keys, the headache to you would be limited to
running "cd ~/git/korg-pgpkeys ; git pull ;
/scripts/korg-refresh-keys" every 2 or 3 months.  The work you'd have
to do would be a fixed amount of work, even if more people were using
PGP key rotation.

[1] https://korg.docs.kernel.org/pgpkeys.html
[2] https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Would that be an acceptable (hopefully minimal!) amount of annoyance
for you?

					- Ted

