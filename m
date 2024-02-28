Return-Path: <linux-kernel+bounces-85777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF686BA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704DF284E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413E1361C0;
	Wed, 28 Feb 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GYBdu5kF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4651361A2;
	Wed, 28 Feb 2024 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158572; cv=none; b=qVgkPE1evx1JJjcPuPC4Y3VWqR1AJO8DghoCP4CVn8kK4YLeYdZ8B5o83a1IqzeUyqjY7ttXFBlh3IHbSkZDp+fYTJGCcXv6Q0YS2zRt9HIzGsX7pQFuRwrsH8zg/j+2XOlK1A8E2G5zYzFljXDafjyaDMvNUnM70lVO55e54CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158572; c=relaxed/simple;
	bh=pbol3C/d6CbOoRd3i/PquRtvHsjSPUGwtK9y5Vjhr8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ltta+JXV2RIZWVDLXLfPVZHD4IZwp4lwV2yD7HTYmHCWPyHOj6TBacKlHSIq+On712WpZ4OsV+R5q0v7K0GsD/1Ye4uAdUXgupVInMBK8Bt7Sk2ncqDPdkKtU7Kf3l3Inm0rjTZAdY78JHYR67UrIMgrQZheTwgOZK8qXojk02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GYBdu5kF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36F7D418B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709158565; bh=Lq5jNvdtUpjtScfMNUa8PE+SfaHQ79U7h7StVMGVEjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GYBdu5kFufFhSyMU4cpfPrGWqV2QxzMLbD+zbedrlDRfORZrpJR2L/XjG5GnZSI74
	 FJ+4nVbit9BFclR28YABL4F0EjKMp2ewBCtkznygPMwotY5Wui82alAbT+ym7bxXwR
	 iT4chwZSsVG1EXeJQpdd0PuGfbJSnjmainEvYNzZHE6zAA4vgipUcW7sttMfFZSjMg
	 wz+/NqoMXn4fycnQjsaPzGYCLAXNQyiyldb7uQFpGN5G5yNp/LT18ye5kHY+zA98NL
	 cdjojXqSBX63i9KnQTozJtjkrTHH8pnAOh003Mq82d4mXuSJrnmwRGTGvg1VSZVzHx
	 v/Wfl7h7wlfTw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 36F7D418B4;
	Wed, 28 Feb 2024 22:16:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>, Akira
 Yokosawa <akiyks@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: drop the version constraints for sphinx and
 dependencies
In-Reply-To: <CAKXUXMzejT7++UgpgE_eHbXTC+w0cz2-sPr3XawV6N2mCkupgw@mail.gmail.com>
References: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
 <CAKXUXMzejT7++UgpgE_eHbXTC+w0cz2-sPr3XawV6N2mCkupgw@mail.gmail.com>
Date: Wed, 28 Feb 2024 15:16:04 -0700
Message-ID: <87edcwp74r.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> This change seems to work for my setup, but I have really only dipped my
> toes into the waters of this sphinx-pre-install script.
>
> I only dropped the version constraints, but possibly one can even drop
> some of the packages in the requirements.txt, as they are pulled in
> automatically by Sphinx dependencies.

That's a cleanup we can do at any time, I guess.  I note that not all of
them get pulled in correctly, though; after installing 7.2.6 with pip, I
still had to get pyyaml separately before it would work.

> So, I am happy to get your feedback, but I am well aware about its
> potential to be improved and the lack of my deep knowledge about the
> script. I hope, though, you can test it in your setup and confirm if
> it works as expected and then we can discuss the details (e.g.,
> naming).

I think this is the direction we need to go.  We can add a separate
requirements file for successful installation of 2.4.x later if that's
really needed.  Unless I hear screams, my plan is to apply this.

Thanks,

jon

