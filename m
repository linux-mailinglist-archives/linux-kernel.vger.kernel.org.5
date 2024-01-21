Return-Path: <linux-kernel+bounces-31979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751A8354B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 07:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311FD1C2167E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D526ADF;
	Sun, 21 Jan 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fI8Tlpma"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1D3D68
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705818659; cv=none; b=FDmEV8jwSnuoBr9OZu+arZveb7kJMaNlrTXHaLT9c3TB/epL9x1bCCmi6vBSVFv9NX4NuAt9qRbbP6bti7JkEnERdIwwDlsL+ZfyNQu5VxDOOOxvoheg4MEF8YWmQv1/SSNCEZ/1J4zEC9dack83R0Tsz4UGKpMCtSJA/wc+sOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705818659; c=relaxed/simple;
	bh=tK3UcJvJ5BQkGY+bTb2CdK4v2VbqSQmssmv32Na54XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo4EvkuIj03FqpctCJWqzOq2tIWNIC1J/h5l0hYMZ50taeHTRihJ/5nKPPzIrBVXiKirt9MOUda16D2o3bXJK7nENyh8JGnOHVIBMhnuFAOria3+WS7yo91o4PhXkewiaSl6eaNrWt9AW7EKgY0ouBPjVKls0JY6yRyA133zlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fI8Tlpma; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-225.bstnma.fios.verizon.net [173.48.117.225])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40L6UdaR023566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jan 2024 01:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705818641; bh=sgpy4bLPdBnGfXdgc0vYyKPC4rFyOPZ19TPy1I8VkNY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fI8TlpmaI6N8auQGmVuYYwtSQdVLpDYqPbkt+dMB0Evk0vNokom+FCG8JV2/aAiAq
	 9oWBOMxHqpJQX1Br3BT0QfHqYnsUSAjCZ3BviicSPbheTgEnjUVAT5zouv50szulp+
	 sr41Ye3EfI2swt1nQpb1YKVnfP79CyG1tXi5UCtrezFYsIYu80q0hXMWQqkyWRyT/o
	 +YGJMcAW7aVPnIkLCH339V5IZcgDlPI1GfbG6DfNopFp5MtVNnK2W1TptbCSkGdYvu
	 Q9YWzgLNTb83nidTD20Q1vJyMCCLNlclzNc0lwDE4f9/J+kXHi52//bEwfT8meFcxY
	 KRrq2DaYcMTwg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D419715C0278; Sun, 21 Jan 2024 01:30:38 -0500 (EST)
Date: Sun, 21 Jan 2024 01:30:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>, G@mit.edu
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
Message-ID: <20240121063038.GA1452899@mit.edu>
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>

On Sat, Jan 20, 2024 at 11:35:18AM -0800, Linus Torvalds wrote:
> Guess why I don't? BECAUSE NOBODY ELSE DOES THAT POINTLESS EXPIRY DANCE.

So I guess I need to confess.  I haven't been doing the expiry dance
(which I started doing because GPG revocation certificates are also a
disaster).  There are certainly those folks who recommend it as a best
practice[1].

[1] https://www.g-loaded.eu/2010/11/01/change-expiration-date-gpg-key/

However, I tend to set the expiration 6 to 12 months in
advance, and make sure I renew them 3 months or so before they expire,
and then I make a point of sending them to keys@linux.kernel.org to
update the the kernel keyring, as documented here[2].

[2] https://korg.docs.kernel.org/pgpkeys.html

Linus, you haven't been complaining about my key, which hopefully
means that I'm not causing you headaches (or at least I hope so).
Would it be perhaps because you are periodically running
scripts/korg-refresh-keys as documented in [2].  Or perhaps you are
running it out of cron or a systemd timer (again, as documented in [2])?

Unlike James, I've tried to use DANE, since about the only thing that
has as disastrous a user experience as gpg is DNSSEC.  :-) I just
manually upload keys to the kernel and Debian keyrings, and it's been
working out, apparently without much pain for either me or to those
who rely on my keys --- at least, no one as complained to me so
far....

					- Ted

