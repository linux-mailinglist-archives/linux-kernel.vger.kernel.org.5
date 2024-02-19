Return-Path: <linux-kernel+bounces-72046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8A85AE36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF16CB211A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BE54FA0;
	Mon, 19 Feb 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JWTL3GIg"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB154BFA;
	Mon, 19 Feb 2024 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380774; cv=none; b=dr0A3MaVGYf2RJAYkaigCFU/9MxrtXUEr89oftzkJTLtdKJa8LzOSFSokdE/xEhWNM5oearMUBbLo80Ddpz31iq40Vt6MiXLHAmew+P7Nx5FRXrZ2wkMije/Btbpb3T13MqF6iUR2ujXimTQFIESJyA5nBaHhYWmlnVIF0vtw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380774; c=relaxed/simple;
	bh=MprGuCqzth6nJ+bm3v2om+NnHH0gsp5Q48D1qQdrV8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3W+c6miG/vHWLbcwLdNnSkGssg6Lcd5JGw8qGrzfBDssFZ1hEV0eouIc9ePbzE8QLPcAZosOzUjMmuXagCFAERJXG/fZiXuqXCPAaR2cb6aqyc0FdejbCindk+i4Lrz7srvffWmoXj9LE0333oDKg7xsPVpjdTyORtwVN+bQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JWTL3GIg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BBBE247A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708380772; bh=Qd0BQ3n6gkIeJuHHuKpFJNVK61hbHPyFzkqZDXaQUCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JWTL3GIgUu00nWJ7QqjWuPjSfIECMiZAVqAjb2jqlxfNl7FzB3tONbcrxg/5F37wh
	 /7AAa0fAEYIAnbNJoikxGU2BT88mppF5zJL0rmQLTmW0xv1F25NGqHt1avfewFhhe2
	 8Y7CZJT+a0yd9QPAUvqOgawIO8enEPNvQarRL+sOZn0S+CJJX8Tkr4caw4d9kPguqR
	 SGm+prdBQYuTd9T/mKPi+D9MoBl192Xww+tbZ2ltLsVhooGC44aFUN6s1dxK11bp+T
	 eQjY0k+I8awPmSCisFgBLUHFKDui4HOD+fijC6u3XE8RWIxMA55DJcqPECqok9+vEw
	 YlViVCDY9vEJQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BBBE247A99;
	Mon, 19 Feb 2024 22:12:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>, Petr =?utf-8?B?VGVzYcWZw61r?=
 <petr@tesarici.cz>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] docs: new text on bisecting which also covers bug
 validation
In-Reply-To: <62ea7097-256c-4331-b937-778444125a06@leemhuis.info>
References: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
 <20240216204140.2ecbceec@meshulam.tesarici.cz>
 <62ea7097-256c-4331-b937-778444125a06@leemhuis.info>
Date: Mon, 19 Feb 2024 15:12:52 -0700
Message-ID: <87a5nwm7bv.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Leemhuis <linux@leemhuis.info> writes:

> On 16.02.24 20:41, Petr Tesa=C5=99=C3=ADk wrote:
>> Is this because you want to keep it readable if the target audience
>> reads the source text of the documentation? Otherwise, the .. include
>> directive does not make a difference after rendering to HTML. AFAIK.
>
> It less that I want that, it's more that I got the impression that both
> Jonathan and most of the kernel development community wants the source
> text to be readable; not totally sure, but I think that's the right
> thing to do, too.

As a general rule, yes.  To harp on this one more time, I do think we
could create sections of the manual (a "tutorials" book, say) with a
different set of priorities.

In the documentation session at the last kernel summit, I got some
pretty clear feedback that plain-text readability could be made
secondary to getting the best rendered output, at least in some cases.
Tutorials seems like a good example of such a case, where we could focus
on good web output without, as you say, creating potential maintenance
troubles going forward.

Thanks,

jon

