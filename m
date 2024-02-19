Return-Path: <linux-kernel+bounces-71951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7487F85ACF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE819B25985
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6B537EC;
	Mon, 19 Feb 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKptZ0kS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137050267;
	Mon, 19 Feb 2024 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373866; cv=none; b=pRotuprmbZFF75k5JHtu9FMyHtE3EZlTS1ZyjFvD6ZfrD5QXGSyrTWGYgu9LDKpkYEG5rxUEOiCy3JqRh/xxQATOEQooEjYLrgLbQRoCY7qV5ZwKCM7D9gijh2w+QNpTxkAUinJ3uzqaTyik3GvGzGrm8VkmaNfV0f57Ky/tgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373866; c=relaxed/simple;
	bh=KOY1ANOS2dFuGqiw0GK0ZhMjCXxy3Anhz2OyOJ9uGUE=;
	h=Mime-Version:Content-Type:Date:Cc:Subject:From:To:Message-Id:
	 References:In-Reply-To; b=WXMGtBFcyZQ4BzbESjhKb8WQ1tEBbS+5Ac+7Nq+jV9nda/cTAoQGp6n2d53814j3ziG7/BK/abUf0LpJhKssNoBucH+jxHpsvjeE3T+2EU4xsjyl7Hv4v7zLqUkg9+LaCmkrOD2S7Ca+zE9RRgIRK7pbaUobRh68VnODTs/9Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKptZ0kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70D6C43399;
	Mon, 19 Feb 2024 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708373866;
	bh=KOY1ANOS2dFuGqiw0GK0ZhMjCXxy3Anhz2OyOJ9uGUE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kKptZ0kS+bowyvnKt9qKLKHsDmqdCQwopy3H7CldGeuH8WbWvlJKYpOB93RAF9YSb
	 tbCGK/Kfhl2ndzjcBcf5SMB9wHX/9VL/SPo6OO7M4yZrXrDWS2352HqEQcqgONqmDi
	 /yuygcM25TDg4LbKU8yxvj+4jHMSS7fAD7RLZe67HYJ/Xj9KE1VkbNZxAQU5oqhBkq
	 d0z3pYuveMroI4HkIEHt+GtxrGjxMf/0FA7Hz6xPhZl1hUZ2MoXwBbO76TQwzzBARF
	 K7hvzeQ6Ki7G5C/n3zUCbSAmu5SWBil/OSLkQraLpkx7wHVz+kf99+U/U9dA/1NrX7
	 dKNcys4K8WxZg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 20:17:42 +0000
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
Subject: Re: [PATCH 2/3] tpm: ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Message-Id: <CZ9BYSWZVHLI.27ICPVJMGNHIM@seitikki>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-3-dpsmith@apertussolutions.com>
 <CYU3H17QGBR0.37HWK14BDMGCD@suppilovahvero>
 <2dd76ebf-b25d-447f-8abe-30e3423c4cdb@apertussolutions.com>
In-Reply-To: <2dd76ebf-b25d-447f-8abe-30e3423c4cdb@apertussolutions.com>

On Mon Feb 19, 2024 at 7:17 PM UTC, Daniel P. Smith wrote:
> On 2/1/24 17:33, Jarkko Sakkinen wrote:
> > On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >> When tis core initializes, it assumes all localities are closed. There
> >         ~~~~~~~~
> >         tpm_tis_core
> >=20
> >> are cases when this may not be the case. This commit addresses this by
> >> ensuring all localities are closed before initializing begins.
> >=20
> > Remove the last sentence and replace with this paragraph:
> >=20
> > "Address this by ensuring all the localities are closed in the beginnin=
g
> > of tpm_tis_core_init(). There are environments, like Intel TXT, which
> > may leave a locality open. Close all localities to start from a known
> > state."
>
> okay.
>
> > BTW, why we should motivated to take this patch anyway?
>
> Without this change, in this scenario the driver is unnecessarily=20
> thrashing the TPM with locality requests/relinquishes pairs for which=20
> will never take effect and that the TPM must do state change tracking.=20
> While I am confident that TPM chips are resilient to such abuse, I do=20
> not think it would be good form to knowingly allow such behavior to occur=
.

This would a factor better motivation part for the commit. I can=20
buy this argument instead the one right now, thanks :-)

BR, Jarkko

