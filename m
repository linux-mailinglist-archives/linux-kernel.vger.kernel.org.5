Return-Path: <linux-kernel+bounces-91366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7C871024
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24001C20CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422867BB12;
	Mon,  4 Mar 2024 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PryTUwzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657338F44;
	Mon,  4 Mar 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591714; cv=none; b=ee2z0+rTnVWgbeELBvhQgb0Y7RMudyRNqwax9fT7mJGXYZvO57gQAnlV4kQRZLJExuWQkPhaG4KWnn6nwu1tt+/+64M9Ozv+9IwblOFPqvW4Z7Y7IZoheCMGd4bG5xh9pV8XWodBimT9hNy5d4P1gK5qMsTA1onoDyA8wC68aLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591714; c=relaxed/simple;
	bh=amBz0SHnxG7TZY8ssNJpH1w1CYnBUB36OiHoZWaexS8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=V0ZqM/K/5ykgVnIkmf1syDeOEfXEtFqd3ha8O1qKCwTKvuqvRQMJ8FvemnRDBeaYQRdtq50d6UlFtEvqU4S3ybspMZ3tPsA1vyAQtTJKNjtekCvRDgUHHEorDQ+cRAOEZ3Jf/G2cNPvAV4B4avs2zzuo+8j/d2SJyeCTQLCb5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PryTUwzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5720C433F1;
	Mon,  4 Mar 2024 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709591713;
	bh=amBz0SHnxG7TZY8ssNJpH1w1CYnBUB36OiHoZWaexS8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=PryTUwzPWwwXCdvBgfF8SYstPp6+99/peVymjH51J3D8e3mXbJEOU4GmawLaXnlMD
	 zbV2440gyrfx/e/OZqROOWiQned9w3KttppjGwM1qqRAcAmRCbgylkuD3kJPoP96y2
	 kC2kMClL2jSsXwTnK7pL25JI94uAQ/Lchim31o/E9QcvOE5sVxRZUJ3IJtmdqQM18m
	 HKWFF1MYu1gvajPolinuxfn7/3QS2mf8kSqDnRoiz+raX2MinBRKggWmC0EvQXPlq/
	 VfoZtm27SPjSMOTUxkPqZs76X6NTybfi4wtyoxCs5vMOSUidQ0ZRhVZ/l93QRm9gTb
	 M+n6XzriuJLDA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 00:35:05 +0200
Message-Id: <CZLBOJEYP2M1.I4A9D5M5MR01@suppilovahvero>
Subject: Re: [PATCH v5 2/6] KEYS: trusted: improve scalability of trust
 source config
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "NXP Linux
 Team" <linux-imx@nxp.com>, "Ahmad Fatoum" <a.fatoum@pengutronix.de>, "sigma
 star Kernel Team" <upstream+dcp@sigma-star.at>, "David Howells"
 <dhowells@redhat.com>, "Li Yang" <leoyang.li@nxp.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231215110639.45522-1-david@sigma-star.at>
 <20231215110639.45522-3-david@sigma-star.at>
In-Reply-To: <20231215110639.45522-3-david@sigma-star.at>

On Fri Dec 15, 2023 at 1:06 PM EET, David Gstir wrote:
> Checking if at least one valid trust source is selected does not scale
> and becomes hard to read. This improves this in preparation for the DCP
> trust source.

This commit needs a complete rewrite and I do not have time and
energy to propose one but here's what it should contain:

1. Add HAVE_TRUSTED_KEYS to th trusted-keys/Kconfig.
2. The use and purpose of HAVE_TRUSTED_KEYS.

If you read your commit message, do you see anything at all concerning
the code change? It only tells a story about something that is not
properly being defined to be "hard to read", which is no rationale to
change anything at all in the kernel.

If you put factors more focus on being as straight and easy to get
in the commit messages, it will also improve the round-trip time
between sending the patch set and getting reviewed, because people
with limited time at their hands tend to pick the low-hanging fruit
first.

BR, Jarkko

