Return-Path: <linux-kernel+bounces-15632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F56822F34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2171C20996
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879441A27A;
	Wed,  3 Jan 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSmEjkNY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B21A59D;
	Wed,  3 Jan 2024 14:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEBAC433C8;
	Wed,  3 Jan 2024 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290973;
	bh=2RyW2FyfKqulF+XdUN4uGTLJOz6xINLjJ7oev9I+OEk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mSmEjkNYQ8CS09mi8y/qhZLxPZMtfNSZ2VFKWuyZ53RrzjtIRxhSrId+JK8i68urZ
	 wU3ZoD7C5xB6QBWh7+WRtnxeofc3GLV2e+++LETAFdtSjp3HKtPXl+Rqe7RaDv+oQJ
	 dYMU7QopRYMKdUOkB7UW0mwkFnp2/SqEz4rOIwvkfpzFVkB5kEXC9xv342UWMWZkAs
	 KI+26TwS8cazaUw/SWjBL6rn5ioc5d+GcCp2QAQeADgK6KjEyIlISItSt/qq7iFq2S
	 CdSJS+eK9y6boKhL8keuxnVGA9ke3BtdLnK1yjJ5o7wDdmdN5Rn3gnNoV6knkJw6Mq
	 goyBIPEPlP3TQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 16:09:29 +0200
Message-Id: <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
Cc: <itrymybest80@protonmail.com>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrity: don't throw an error immediately when failed
 to add a cert to the .machine keyring
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Coiby Xu" <coxu@redhat.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231227044156.166009-1-coxu@redhat.com>
In-Reply-To: <20231227044156.166009-1-coxu@redhat.com>

On Wed Dec 27, 2023 at 6:41 AM EET, Coiby Xu wrote:
> Currently when the kernel fails to add a cert to the .machine keyring,
> it will throw an error immediately in the function integrity_add_key.
>
> Since the kernel will try adding to the .platform keyring next or throw
> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring)=
,
> so there is no need to throw an error immediately in integrity_add_key.
>
> Reported-by: itrymybest80@protonmail.com

Missing "Firstname Lastname".

> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2239331
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  security/integrity/digsig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index df387de29bfa..45c3e5dda355 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -179,7 +179,8 @@ static int __init integrity_add_key(const unsigned in=
t id, const void *data,
>  				   KEY_ALLOC_NOT_IN_QUOTA);
>  	if (IS_ERR(key)) {
>  		rc =3D PTR_ERR(key);
> -		pr_err("Problem loading X.509 certificate %d\n", rc);
> +		if (id !=3D INTEGRITY_KEYRING_MACHINE)
> +			pr_err("Problem loading X.509 certificate %d\n", rc);
>  	} else {
>  		pr_notice("Loaded X.509 cert '%s'\n",
>  			  key_ref_to_ptr(key)->description);

BR, Jarkko

