Return-Path: <linux-kernel+bounces-125914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5021892E23
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423F51F21972
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7903A64F;
	Sun, 31 Mar 2024 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=16bits.net header.i=@16bits.net header.b="IFQ9O1v/";
	dkim=pass (2048-bit key) header.d=16bits.net header.i=@16bits.net header.b="QUZNcr0S"
Received: from mail.direccionemail.com (mail.direccionemail.com [198.23.137.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E60383
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.23.137.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711845779; cv=none; b=PZFYIp12F5mUz9Zwvvnf+/qcxA9IazaiZl9+9vQvl+7GFbJz4ITnmRrRV1hAws30rBz5XhhV2WOo03sv3QJuwPKOKezcwhPVNOg4HArFKm5A0GL5x62P0LOKNAZaq5morqP+ewdUDM5M2MJk5rpt/KCr8wiCoTLzmQEBt7MQedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711845779; c=relaxed/simple;
	bh=iCxeJcNOkxgZobbksFzeMpkBarjY0hOOiZ8z/jhPQ2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mf0vonhoyEGgDWo/e/x3a6uP6wRbbq71APXsr5KrqWRIDjLD3+//vyG/TAwccg6ApE84wbmJWybF8IzjQE467K1HYK8zxokSm/RTRBknq4weoVLHlAksxU8LFjMmpVGdj0t+aBbHFMY3qaC8yMJPY/jmSZZXPSeX35KqsuANis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=16bits.net; spf=pass smtp.mailfrom=16bits.net; dkim=permerror (0-bit key) header.d=16bits.net header.i=@16bits.net header.b=IFQ9O1v/; dkim=pass (2048-bit key) header.d=16bits.net header.i=@16bits.net header.b=QUZNcr0S; arc=none smtp.client-ip=198.23.137.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=16bits.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=16bits.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=16bits.net;
	s=ec2401; t=1711845751;
	bh=DPrEQ8VIsCnwPBCgVB8ZQfxkn20Goq/qqCb1lEguxbU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=IFQ9O1v/9bA2gjqLtbJYHl5YKHzaLq8lQadkJWPUQ5N4UsMjDSojYMks0veFRH3nD
	 OGk3RzgTdZxsAtxom8KAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=16bits.net;
	s=rsa2401; t=1711845751;
	bh=DPrEQ8VIsCnwPBCgVB8ZQfxkn20Goq/qqCb1lEguxbU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=QUZNcr0SpORpssbKtx3wvSGqeiz35HJ7OkilYMOSm+9rNmylsK5wMqVXs8HREdSza
	 kwOUIttLUXWa7g+ijNPF6i6Bc2lsHNSIndANFgzqR5extIyuJ4A9VQAYk/v+7/7WRM
	 sr3aZ/mQkzGV0OoXE5deSqWZ/11OyJxf+KvDPFV21LhUZrqhl7pBAzbQoRDKjZw2vW
	 Gjj5K4KmC5R+NbKjUth2ngo5zQX9/HtzAPWJlrDtbYY1fA4pFMVHiNaq+eb9tS3ztA
	 fEO6M8hyYBPmduGXNdWuuYZcRvkXPlkPT6iSEoE7an4GQf8mHMe89XCdRMAIRxujtg
	 +/H8Rz+roKjug==
Message-ID: <27db456edeb6f72e7e229c2333c5d8449718c26e.camel@16bits.net>
Subject: Re: [PATCH 11/11] xz: Adjust arch-specific options for better
 kernel compression
From: <angel.lkml@16bits.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lasse.collin@tukaani.org, Jubin Zhong <zhongjubin@huawei.com>, 
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com
Date: Sun, 31 Mar 2024 01:42:31 +0100
In-Reply-To: <20240320183846.19475-12-lasse.collin@tukaani.org>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
	 <20240320183846.19475-12-lasse.collin@tukaani.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Under the light of the recent xz backdoor, I should note that this
patch (patch 11) does:

> +# Set XZ_VERSION (and LIBLZMA_VERSION). This is needed to disable featur=
es
> +# that aren't available in old XZ Utils versions.
> +eval "$($XZ --robot --version)" || exit
> +

in order to do=20

> +	arm64)
> +		ALIGN=3D4
> +
> +		# ARM64 filter was added in XZ Utils 5.4.0.
> +		if [ "$XZ_VERSION" -ge 50040002 ]; then
> +			BCJ=3D--arm64
> +		else
> +			echo "$0: Upgrading to xz >=3D 5.4.0" \
> +				"would enable the ARM64 filter" \
> +				"for better compression" >&2
> +		fi
> +		;;

and
> +		# RISC-V filter was added in XZ Utils 5.6.0.
> +		if [ "$XZ_VERSION" -ge 50060002 ]; then
> +			BCJ=3D--riscv
> +		else
> +			echo "$0: Upgrading to xz >=3D 5.6.0" \
> +				"would enable the RISC-V filter" \
> +				"for better compression" >&2
> +		fi
>=20

which was noted on Hacker News as a potential gadget of
exploitation[1]. Thanks Vegard for bringing it up[2].

A compromised $XZ could modify the build files directly in C, or even
produce a file that decompresses into a kernel with added evil
instructions, at a quite near level to Reflections on Trusting Trust.

Nonetheless, execution of high level shell script would probably be
more useful for an attacker that has to surreptitiously include their
backdoor, as it would only require a few bytes (e.g. a sed call) when
compared to coding that in C.

So, in the spirit of keeping a fair amount of paranoia, and since it
doesn't do any harm, any such code should be failproofed to ensure it
can only import the expected shell variables with the right format[3]:

 eval "$($XZ --robot --version | grep '^\(XZ\|LIBLZMA\)_VERSION=3D[0-9]*$')=
" || exit


Regards



[1] https://news.ycombinator.com/item?id=3D39869715
[2] https://www.openwall.com/lists/oss-security/2024/03/30/11
[3] Actually, LIBLZMA_VERSION isn't used, only XZ_VERSION. Being
generous and accepting that one as well. :)



