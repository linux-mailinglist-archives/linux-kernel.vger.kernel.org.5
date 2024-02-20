Return-Path: <linux-kernel+bounces-73764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDCA85CAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48C3B222F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53302153BE6;
	Tue, 20 Feb 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9eD54gk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E255787;
	Tue, 20 Feb 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468288; cv=none; b=O6qL/zvXHgZwIXjfomH4eMQwl179WQOTyJkCdMqhtceOr0d7zH1RkFKo5Cq5qVe3aY4QNRjsfsmZDBy6b7LoAgmGs/zqEtRvJCj9NCLTthBwVpQy9kgYm5WwndyOHW9j9UTwLoVKXSCJA9f0mtCr+i8yAm+5bOeAYq7wX4z7gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468288; c=relaxed/simple;
	bh=w945/N5R/OZj4+mcozJCxYwDnDG838MQGaRoMaxpMuM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tCs4RHd5/9doYr4vnYBIN0ewR1n6T/hGQXZK3xnJxZPMrwgPrf8ePmopOUrjMm/iJMXoygOW4iq3BpFra8zBiI7NozUXvMMo06TBDw4Y+xaHcmCpCVwdk2wKM8IYvwh2ypXEYR1/CI3HeDYa6zlT9AZ0AsIK7BI6dw9cvr5xVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9eD54gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A41EC433F1;
	Tue, 20 Feb 2024 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708468288;
	bh=w945/N5R/OZj4+mcozJCxYwDnDG838MQGaRoMaxpMuM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k9eD54gkimidEdoj4SAOqqp1mTghcxNAq04TIp2spSY/8HZ/ZSakg9+4b4WTCVzwd
	 bX45wq+fdMZ6HvrwfwwQJsNjAsySJxQlYldE0jl2cVOqcBubXiHK819w+O+Uq5Fmkt
	 keiOlWObKjiqABnBUiiOK1FZZMcXXnMKioMppinn36NC4QjIigvp/yIXXjIpu5WhZe
	 mLYTp+c8ZWYj2n6E/p85lyPBdFJBBTW+FWXPe/WlNc3A4GaMQ+TCikScibqUcLCJmz
	 F17bIMmqmAgEUtpSBt7QWjyFNkxyDg66lmeeIw/9CIi23NAmIf3Ig+bcfoMib2wjKx
	 fzEQUrz1TA5EQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 22:31:23 +0000
Message-Id: <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki>
In-Reply-To: <CZA9CM3PDILC.82JMLUWMB6B7@seitikki>

On Tue Feb 20, 2024 at 10:26 PM UTC, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> > for (i =3D 0; i <=3D MAX_LOCALITY; i++)
> > 	__tpm_tis_relinquish_locality(priv, i);
>
> I'm pretty unfamiliar with Intel TXT so asking a dummy question:
> if Intel TXT uses locality 2 I suppose we should not try to
> relinquish it, or?
>
> AFAIK, we don't have a symbol called MAX_LOCALITY.

OK it was called TPM_MAX_LOCALITY :-) I had the patch set applied
in one branch but looked up with wrong symbol name.

So I reformalize my question to two parts:

1. Why does TXT leave locality 2 open in the first place? I did
   not see explanation. Isn't this a bug in TXT?
2. Because localities are not too useful these days given TPM2's
   policy mechanism I cannot recall out of top of my head can
   you have two localities open at same time. So what kind of
   conflict happens when you try to open locality 0 and have
   locality 2 open?

BR, Jarkko

