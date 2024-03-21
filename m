Return-Path: <linux-kernel+bounces-110317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A15885D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E98B2447D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E212C522;
	Thu, 21 Mar 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPtqcps1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180676052;
	Thu, 21 Mar 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037581; cv=none; b=SXqtk1s8HLUaxWELPJ2dRUvp3GFiTI/alB5u+cH/3vrx3iXTvFixqkfcTLbgpyPzcIQEOXi91GZ+x7eq4CBJJQzc4BlcrQd1AYg2iV/81ipYVa2NuBm2OBh1Bvh3v+Sw/YVzVS0e0ENj5nuAXXTG2ILOzJB0d9COYGHSaLfpgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037581; c=relaxed/simple;
	bh=tUZSPagVnxlSPXiCUxy39X6cj4+GA0/zLIHYPdPCTX8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ANORgEKY/+10nZl8VmSBYno3T/0yrVpR202igzzWepFhWoQUCZ060sjjFbShGv9CljIo4jrcptf0bHWlicD/o53wdJO6iyfqXFVPpxoX24falhoRaIjk5N50+ZVDUTUJuxct6T5lxzgFePXEF1FUlO7tias0NiSD2hTLDjC50K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPtqcps1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D4C433F1;
	Thu, 21 Mar 2024 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037580;
	bh=tUZSPagVnxlSPXiCUxy39X6cj4+GA0/zLIHYPdPCTX8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TPtqcps1MVy2J4Z6DJQPSJv6c7n+WkGgwhEz4ZETzPDJJGTcbsEuiKmuamXzbaQaA
	 upbVqtDp01fHcD5PCDsHkI/FSdq+OF/sB1CaDZ5xasTuOaSz78EzNQ3pWSErBnM21R
	 5QPODJ4yvanZC+2v0OrX7zeCUQ+2AMM9x72x9ygYzu5B3o1TmJcabEhRxcJbG1FLfS
	 Y9e3JQti6ZVs/1giuyBzkFcu7mEQ9dtmGgRRLe7xTLJ5gm48eGqqTXrnes+SvqP/jZ
	 7iTrABtAGzFPWnz4/SAfkoiQrsceiSk4MdfWQeersX/GcbAQxqUDNRXIuthnSsA3PL
	 YIwnQTTaJbOqA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:12:56 +0200
Message-Id: <CZZK77BY3FK4.2WMP1X5H9GTL1@kernel.org>
Subject: Re: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roman Smirnov" <r.smirnov@omp.ru>, "David Howells"
 <dhowells@redhat.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, "Andrew Zaborowski"
 <andrew.zaborowski@intel.com>
Cc: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>
X-Mailer: aerc 0.17.0
References: <20240315103320.18754-1-r.smirnov@omp.ru>
 <CZX9T3TU6YU0.3JE9M7M3ENUE0@kernel.org>
 <b5f21d1175c142efb52e68a24bc4165a@omp.ru>
 <CZY02YNBTGYQ.3KG8NLH8X3RQE@kernel.org>
 <7fd0f2a8252d4a6aa295adc1e76bc0e2@omp.ru>
In-Reply-To: <7fd0f2a8252d4a6aa295adc1e76bc0e2@omp.ru>

On Wed Mar 20, 2024 at 10:21 AM EET, Roman Smirnov wrote:
> On Tue, 19 Mar 2024 22:14:22 +0200 Jarkko Sakkinen wrote:
> > On Tue Mar 19, 2024 at 4:44 PM EET, Roman Smirnov wrote:
> > > On Tue, 19 Mar 2024 01:39:00 +0200 Jarkko Sakkinen wrote:
> > > > On Fri Mar 15, 2024 at 12:33 PM EET, Roman Smirnov wrote:
> [...]
> > > > >
> > > > > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > > >=20
> > > > I'm not sure if this should be part of the commit message.
> > >
> > > I have already submitted patches with this line, some have been
> > > accepted. It is important for the Linux Verification Center to mark
> > > patches as closing issues found with Svace.
> > >
> > > > >
> > > > > Fixes: 7d30198ee24f ("keys: X.509 public key issuer lookup withou=
t AKID")
> > > > > Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > > >=20
> > > > Should be reported-by.
> > >
> > > The suggested-by tag belongs to Sergey because he suggested the fix,
> > > subject/description of the patch. The tag reported-by belongs to
> > > Svace tool.
> >
> > 1. I did not see any reported-by tags in this which is requirement.
> > 2. Who did find the issue using that tool? I don't put reported-by to
> >    GDB even if I use that find the bug.
>
> Svace is an automated bug finding tool. This error was found during
> source code analysis by the program, so the tag reported-by does not
> belong to any person. I don't know what to do in such a situation,
> but write something like:
>
>     Reported-by: Svace
>
> would be weird. I think that the line "Found by Linux ... with Svace"
> could be a substitute for the tag.

I'd prefer a person here that used the tool as it is not korg hosted
automated tool.

BR, Jarkko

