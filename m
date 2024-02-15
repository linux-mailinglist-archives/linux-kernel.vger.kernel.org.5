Return-Path: <linux-kernel+bounces-67777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D1857085
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF41284B10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838EE1420D4;
	Thu, 15 Feb 2024 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UJ9izmTw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA41420A8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036061; cv=none; b=S6T8w5dmfZVH7XhXOP1Q+NSDCdNXHQeSfYkZHMq2OR3mLEbOk9gbUESsdzx7ZDv+fpnWyzfVnd2QSgnCX1VCQuPD5+tWRLQgTKoLVeNHKcmHK3EERz/mMFdW/c7fYpCX+NYzrwJCfyHeVUGn8bNRqSje5O18xzY/y2JTTFsLHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036061; c=relaxed/simple;
	bh=Ugmf0DOzi7gU8tUP1o5hRFZp90hdWFYWXs/hHXfK8i0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/zXjMjpkIVJZQk4KKWlrsXDBDT28EJd0jHLBJJR02RNYJCJXHuoMcNTVP9MTE+sI07Nd3BqlPXq3MsauIhGQlG3yjvfdpuAU20KOygUSx6yhVFFV94q/Yomz4uJcvufDuPXnocNtI+b+BxU73+juCVqwzy0OWRYYHgH1nSMiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UJ9izmTw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708036056;
	bh=Ugmf0DOzi7gU8tUP1o5hRFZp90hdWFYWXs/hHXfK8i0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UJ9izmTwqMZ4pONiAyMBzFXgOa0ianY3gaqYhAdiDSuLLyFUHp+9TjptmIHKfFLc5
	 WRQrikLGZHAby0OpF0ul7q59xm27pcG2AceIcX6w/BghjFZYCxmz2RkFdOkz2KSNo3
	 KQEyI58AKUfFUUTejr0b1/aj+1D+uU1q7SCxp+J8fJfmEAq66iTR2IcRTWD0U2tuzH
	 BFIuD/I8CifW5KSEaA+Q8Ys85bwi2GESYJ3HtW2DO8obwi/dtdoKPrRjuE+FFZ/RKx
	 Qni5lwAu3qd/i65jg3GTWclhGGnq6CodSjO6erHvcxWJ96i7TVksUMucQC1NXN/Nk4
	 natSa+/x2Fo8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbV7D1J8Vz4wcK;
	Fri, 16 Feb 2024 09:27:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] macintosh: Convert to platform remove callback
 returning void
In-Reply-To: <mdq5k6lq54c5t5yffjotkovrvzfh4uvt4qt4n6rwddmo26neqr@au5s5u3mkoet>
References: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
 <mdq5k6lq54c5t5yffjotkovrvzfh4uvt4qt4n6rwddmo26neqr@au5s5u3mkoet>
Date: Fri, 16 Feb 2024 09:27:33 +1100
Message-ID: <87zfw15pnu.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> Hello,
>
> On Wed, Jan 10, 2024 at 04:42:47PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>=20
>> this series converts all drivers below drivers/macintosh to use
>> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
>> callback that returns no value") for an extended explanation and the
>> eventual goal. The TL;DR; is to make it harder for driver authors to
>> leak resources without noticing.
>>=20
>> This is merge window material. All patches are pairwise independent of
>> each other so they can be applied individually. There isn't a maintainer
>> for drivers/macintosh, I'm still sending this as a series in the hope
>> Michael feels repsonsible and applies it completely.
>
> this didn't happen yet. Michael, is this still on your radar?

Yes, just behind as always. Thanks for the reminder.

cheers

