Return-Path: <linux-kernel+bounces-117359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9867A88B3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D31CE0325
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3E2B9A5;
	Mon, 25 Mar 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZcGTBEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1YUMNbey";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZcGTBEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1YUMNbey"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46C3399F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380403; cv=none; b=Uu8iFkxBjH88ccJThJa09SoQNqsbOoKnJCI1749w6JBUm25KeT0Yx8E/KSLVLYJm+8j2R3NRA3U0cXfkkzoGmqADAQJSIM3HPgVcGVA5ctjgeP89Ne87Twsm0LE4VRUDjei5XXHMyC+/U0hah3lHOEXS9tGRx1L97fV2Y8TKPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380403; c=relaxed/simple;
	bh=qBwz/D+N7NO6TYpY0VTh9S1IAPPpgZFOm5NY3XbTLOE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLKLmqPJS9+aUw2eWVXLNG0zJ9766bFF6whNvNK6cCXmuTAsYc28RbXygvbYGGBuGrnLK0ONLZroCfsVDxKGWk9ye2dUk7Sq7SN/YrDtWG08oDwMCTuMuaAS78FQPEEdtgcVY8P/M/SIn6jvjcIAy53t7m1RuiULIn5yClyQ+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZcGTBEr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1YUMNbey; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZcGTBEr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1YUMNbey; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C84C75C85C;
	Mon, 25 Mar 2024 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711380399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71g0L5Pz45C04Zlk45TyfpyXd4ITzbCM/wHLkRhHKmw=;
	b=dZcGTBErsXuOJeGmiUuF4xSDl9oX49Vwwy/GeDPS/HAZQCef+kFToGR3ktQml0XPTkZUt8
	etw8jGfMqubjziCszCTNY+eCqcH3RtBm/s+TPlA3wqJv/WL8sDQrqXizXDmSg1D8OPTWvK
	qPMyRHdQDH7fxUIDMeeRVnXblRbsqhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711380399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71g0L5Pz45C04Zlk45TyfpyXd4ITzbCM/wHLkRhHKmw=;
	b=1YUMNbeyS6fyA0+ya9gfN3WEs/HoUegUzBHyHZnz7NUhD52jdbDnr62NJw5vaHkcmukzkQ
	uccHBDeb69ya9ZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711380399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71g0L5Pz45C04Zlk45TyfpyXd4ITzbCM/wHLkRhHKmw=;
	b=dZcGTBErsXuOJeGmiUuF4xSDl9oX49Vwwy/GeDPS/HAZQCef+kFToGR3ktQml0XPTkZUt8
	etw8jGfMqubjziCszCTNY+eCqcH3RtBm/s+TPlA3wqJv/WL8sDQrqXizXDmSg1D8OPTWvK
	qPMyRHdQDH7fxUIDMeeRVnXblRbsqhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711380399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71g0L5Pz45C04Zlk45TyfpyXd4ITzbCM/wHLkRhHKmw=;
	b=1YUMNbeyS6fyA0+ya9gfN3WEs/HoUegUzBHyHZnz7NUhD52jdbDnr62NJw5vaHkcmukzkQ
	uccHBDeb69ya9ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59B7D137C4;
	Mon, 25 Mar 2024 15:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9QttFK+XAWZsCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 25 Mar 2024 15:26:39 +0000
Date: Mon, 25 Mar 2024 16:26:40 +0100
Message-ID: <871q7yxrgv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Brian Gerst" <brgerst@gmail.com>,
	"Uros Bizjak" <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Borislav Petkov" <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	mwilck@suse.com,
	tiwai@suse.de,
	vbabka@suse.cz,
	denis.kirjanov@suse.com,
	nmorey@suse.com
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
In-Reply-To: <ef640185-21e2-46a8-839c-d81030fb13f8@app.fastmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
	<CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
	<CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
	<CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
	<CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
	<ef640185-21e2-46a8-839c-d81030fb13f8@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,vger.kernel.org,kernel.org,linutronix.de,alien8.de,zytor.com,suse.com,suse.de,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon, 25 Mar 2024 15:51:30 +0100,
Arnd Bergmann wrote:
> 
> On Sat, Mar 23, 2024, at 18:06, Linus Torvalds wrote:
> > On Sat, 23 Mar 2024 at 09:16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > The SLES situation seems somewhat similar, with SLES12 being 4.8.x and
> > SLES15 being 7.3. But again with a "Development Tools Module" setup.
> > So that *might* argue for 7.3.
> 
> According to https://distrowatch.com/table.php?distribution=sle, they
> also provide gcc-12.2.1 with the sp5 update, so we're probably fine.
> 
> On the other hand, I can see that OpenSUSE Leap 15.6 contains
> a fairly modern kernel (6.4.x) built with the gcc-7.3 system
> compiler, and I think this is the same one as in SLES.
> 
> Not sure if they plan to update the kernel release beyond that,
> or how inconvenient it would be for them to require
> using the other compiler for future updates, so I've added
> the developers that last touched the OpenSUSE kernel RPM
> package to Cc here.

SLE15-SP6 kernel (based on 6.4.x) is still built with gcc7, currently
gcc 7.5, indeed.  openSUSE Leap shares the very same kernel, so it's
with gcc 7.5, too.  Even though gcc-13 is provided as additional
compiler package, it's not used for the kernel package build.

AFAIK, it's not decided yet about SP7 kernel.  But since we take a
conservative approach for SLE, I guess SLE15-SP7 will be likely
sticking with the old gcc, unless forced to change by some reason.

SLE12 is built with the old gcc 4.8, and SLE12-SP5 (based on 4.12) is
still actively maintained, but only for a few months until October
2024.

The next generation of SLE is built with the latest gcc (gcc-13 for
now).  So SLE16 will be a totally different story.

openSUSE Tumbleweed always uses a bleeding edge compiler (gcc-13),
too.


Takashi

