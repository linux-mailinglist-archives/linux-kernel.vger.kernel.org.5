Return-Path: <linux-kernel+bounces-160001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E258B3784
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FDE1C222EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95778146A9F;
	Fri, 26 Apr 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XD8Arhp9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CF146A7C;
	Fri, 26 Apr 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135977; cv=none; b=Sss/v4Y5+WOLEmCd7jx7nNC4Xtc2d/TA3XsDjkCDAJjmUkhjBVnbCdqHf0vm+FZxCEdbEOBnHjm2qWuG3SsgKVMEfBNu7WBrE0rOQ7eCZDkS+HDS8PtCbx0+R69heS6wkawGC197OLpmyHwvU9HkuZVJIS2DtSLL7gg5+ATEm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135977; c=relaxed/simple;
	bh=RFcyu1BPkbt433ch0McHicnWLmyFM5Oz6/usGFOxUQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAd11N2XnO2Y22zg+HMb/C4OeCDwX+S5NUVjYNRspiV2g6SxSDVIwR0l2I1fZQ9LxpWdQP+gxprl54JWca08QCAAYiEVCqMTzQR4zIPXee5mR67gViQB0IHbsdLzkRMH1dk6y/oFquJyVVYYyKxAXZNPNgAz4yEhFuFsxniTrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XD8Arhp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5925C113CD;
	Fri, 26 Apr 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XD8Arhp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1714135973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFcyu1BPkbt433ch0McHicnWLmyFM5Oz6/usGFOxUQ4=;
	b=XD8Arhp9nYK+s8PviVRQLiSsC5kWvD4WBfq0/0bJXphLDH/u8Wt7AFACX17oaaTlkJkvcM
	SCEoo1nG+6gpEK2Bee86F9PKXR0LgiB//GHTCZNuKDRofYSQrs3jeJxkEGU4AAUMZk4t8T
	Vn1dqbpbOwjgQmLUorA3mP+70apRsAY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 371fa002 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Apr 2024 12:52:53 +0000 (UTC)
Date: Fri, 26 Apr 2024 14:52:51 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Graf <graf@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>, linux@leemhuis.info,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
Message-ID: <Ziujox51oPzZmwzA@zx2c4.com>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>

I don't think adding UAPI to an individual device driver like this is a
good approach especially considering that the virtio changes we
discussed some time ago will likely augment this and create another
means of a similar notification. And given that this intersects with
other userspace-oriented work I hope to get back to pretty soon, I think
introducing some adhoc mechanism like this adds clutter and isn't the
ideal way forward.

On top of that, your extremely aggressive approach and apparent
disregard for established processes and general sneakiness doesn't
really earn you a lot of points here. There wasn't even an iota of
recognition in your reply that you realize the way you've gone about
this is not fine. That doesn't really sit too well, you know?

