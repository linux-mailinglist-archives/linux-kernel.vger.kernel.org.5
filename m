Return-Path: <linux-kernel+bounces-110415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F1885EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8BD1F22F11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71779137938;
	Thu, 21 Mar 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1uIKI2x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5C13174B;
	Thu, 21 Mar 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039830; cv=none; b=JfkTaaUQQUQsjiN9WiZg+o8ljTV7g6L+ayIeEJPshFYrkV7ZBS8hJpZuGnqZ9Cfd2xjvpS4niNO11q1ERp9+cAYdd0FLR1mbp+0+7SWmD1xcipR3LJSUbsn4ia4+wJNgHHQdWR5tlvtOJTteKEPQ8nzRYq9RM7atS2EhKm6cbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039830; c=relaxed/simple;
	bh=tNuHZJKyhybA+h0H/rFDTN4oQHxgp+RHik+5RM1pSFA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eOwD0UKsR2/Ks9WwRfXvSQ/M+G7evE6nRRQndVqpOOBbsXEwNs1jz2V9wU4prcbOiTYaugqv4Sho07MglobRo+mrBQ626FvSWDhfbMbeHTId8djzjBma6Y+ZlB80eJFTfiHtJHNkVwqX5vB8kFMaWRyqx/Nj/M2oWYASQB5iy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1uIKI2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F257C433C7;
	Thu, 21 Mar 2024 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039830;
	bh=tNuHZJKyhybA+h0H/rFDTN4oQHxgp+RHik+5RM1pSFA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=C1uIKI2xevaptJ90Hqq1QUXxuZHAEmTHqvo+FVf/fEqhFKGZqT2ZlLw3u7F0S/g28
	 hDwkTlc58ISAZxpmvBoQC2eOCtWp3i9ly7hkhhvS+w5E7Qt/5pdd9iruAWfryoUp6L
	 eHMcGYefUvPDxIHevws0UZmC0kp+922W/r8hAlrJaVlGQC1BlWnxAitca2Jx574ZUg
	 SiwW91UlmL3GUJaixS5LwpwNpy0CBTBjdc2rVZ1kT8HJRHsQDmWI+zcvwEhUFOAEGO
	 wDK6vVdnc4Ay/K8aOEgJxrSA7/eNYxLyf0G69iBpBw+KXNwkS/gYx8JzPLBIxQzp6P
	 eGUDJ93F1kw1A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:50:26 +0200
Message-Id: <CZZKZWV6FOIW.31F7VSV9I578I@kernel.org>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Konstantin Ryabitsev"
 <konstantin@linuxfoundation.org>, "Lukas Wunner" <lukas@wunner.de>
Cc: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>
X-Mailer: aerc 0.17.0
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org> <Zfp20bLB0onXo7FV@wunner.de>
 <20240320-quirky-truthful-manul-da6eb9@lemur>
 <CZZKAZB5K1PD.2UKMDD28AUCEC@kernel.org>
 <CZZKCJGKVP5N.3GUU48O4Y62KQ@kernel.org>
 <cce10484-99cb-4c2e-9768-862fc35a6725@linux.ibm.com>
In-Reply-To: <cce10484-99cb-4c2e-9768-862fc35a6725@linux.ibm.com>

On Thu Mar 21, 2024 at 6:36 PM EET, Stefan Berger wrote:
> >=20
> > Putting tested-by to every possible patch only degrades the quality
> > of the commit log.
>
> I would still be interested how one would test individual patches in a=20
> series so they are worthy of a Tested-by tag.

I've at least said this twice in this thread.

I.e. in a feature you most likely test the uapi so 13/13.

In a bug fix you test kernel with and without the patch. Generally you
test stuff that you can observe.

You can also test non-uapi behaviour with e.g. kprobes or measure
e.g. performance, depending on patch.

BR, Jarkko

