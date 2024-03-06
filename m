Return-Path: <linux-kernel+bounces-93822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A21873530
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E111828937B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DAF63102;
	Wed,  6 Mar 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSH671vw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA540779F8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722648; cv=none; b=Rdz0AKZ2LPQ4dPJo2mQ9wD7Gm4s4X5ibyTm/2F9MPgAuQ89ECPdyaw+7tR/rC4MlpDf3hRWfoIda/bEUDOhrxdSS+d7pfnoebAcqwaglHuo+OBY6CMlvr/XCWmXXXrx2P/wJKKE44tor3tSclqfMaC7bezDQGhlQg9PBv7Wu0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722648; c=relaxed/simple;
	bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnghBFD5NRm9tjU5sRuK/2sWLOtY07Yxotqi9t8Ia3HhGhXV9VxxOxyY4T2rk732EokZX5D3ipaN1BHaW6+q7KcSYTJ7lbM+hde+OIvRZHRkzhxHKdzi7RPecI5nNUxzIpzCtWW1cJi1muX8s4AYgcy7x9QpyA/j7+Wup6XVgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSH671vw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709722645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
	b=DSH671vwCJN+v69pk6RKe/udFDqYlsJUBm+V0skAxpsNgFYBFhzxpqiZPFDqy63KNWOtOy
	DDI+eQnrvFluvDDK2cn4Cz3/aDRP4bXaSspmsfQMbpYeGbiDA9trbyZ+rOkjes5kLkbV7N
	NbogP6hGxwO9MPhR/fm+Raa3yVm0Cts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-q8SZT93IPn-ctm5Aea4oYQ-1; Wed, 06 Mar 2024 05:57:21 -0500
X-MC-Unique: q8SZT93IPn-ctm5Aea4oYQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d60ac6781so955844f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722640; x=1710327440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
        b=MZAYI3AJlRROZwMcgDaPR6f/IdEnGCr8hju4QM5Al+oz8Nq1/CVaKTcz08IyGjDJ0V
         /2wYzJZD6jYHcgc0BRW0vZvvdXDsyJA+RjgB21xGwF5faMXz/ph/jP4sHSr3A+KY4DDT
         jPDxy0Zyk09cFm77RzLdlewH4Ye9K2d6H15UBHrSKmeCfrjdIRzJbqCI+6z4psTLVrGD
         6uP65l+jumCm4f7qHCW3n+drwHxJsbV6lvz4eiZoro/+APUdTzNhxTFOjmxd4ASOe301
         6kBhsvOsyE4AN4E+jPqmNAFtvOSTLe6iVFKWOlweuE6k57pYhkOCTZ55EM3TWdUH/05j
         Ujlw==
X-Forwarded-Encrypted: i=1; AJvYcCVfywEFda3gx2VNaQb5HD5uC38uBz/uzKPa/W6z7V+ZVJaR0As5+FByNyWIs1OJ8kSZxDvBxEctZif1BcAkPITjM9cn3GApQ+0PTBl4
X-Gm-Message-State: AOJu0Yw+wD4Jxr5U7Cvr0l9xjMpJlv3vfNbnvuG3n835d/UxvhKKviEf
	ZSitqAYRvc0RreB8EqhGj5QfHqa+KZxnu38nBrVTsIzhavmVFsUvYs2/gWFT+T08vVUMmRMB26Y
	DYffMeUOKPvC0nLZ8b2xGHuXDwoIBBrn2cwL0XujFwHjulR73r9+7DoNA0QMVvg==
X-Received: by 2002:a5d:5f48:0:b0:33d:215a:1914 with SMTP id cm8-20020a5d5f48000000b0033d215a1914mr13001148wrb.38.1709722640468;
        Wed, 06 Mar 2024 02:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRZPOXIucKkLpt2y1Kl5ONuSx0wUfC6rVS8K/ER3pp2uiUyHn4H8Vrm+c3L1dNUe5NOyldIw==
X-Received: by 2002:a5d:5f48:0:b0:33d:215a:1914 with SMTP id cm8-20020a5d5f48000000b0033d215a1914mr13001113wrb.38.1709722639939;
        Wed, 06 Mar 2024 02:57:19 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id bx5-20020a5d5b05000000b0033e103eaf5bsm17353346wrb.115.2024.03.06.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:57:19 -0800 (PST)
Date: Wed, 6 Mar 2024 11:57:19 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <20240306-humongous-nuthatch-of-science-00e58b@houat>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv7pnznz2fqkk5di"
Content-Disposition: inline
In-Reply-To: <20240109002429.1129950-1-coxu@redhat.com>


--xv7pnznz2fqkk5di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry, Eric, James, Mimi, Paul, Serge,

On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
> Currently when the kernel fails to add a cert to the .machine keyring,
> it will throw an error immediately in the function integrity_add_key.
>=20
> Since the kernel will try adding to the .platform keyring next or throw
> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
> so there is no need to throw an error immediately in integrity_add_key.
>=20
> Reported-by: itrymybest80@protonmail.com
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2239331
> Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine=
")
> Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Any chance this patch can be merged? This is breaking (at least) Fedora
at the moment.

Thanks!
Maxime

--xv7pnznz2fqkk5di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZehMDgAKCRDj7w1vZxhR
xRjcAQDO43bKYImGBD+B/EBUcAe1M2J0uqbm6+QesqiYtsPvGAD/fUFr3rDbhTvM
CAt76KLDM5Hbt0iKpgt0TgS06wTsLQQ=
=tyck
-----END PGP SIGNATURE-----

--xv7pnznz2fqkk5di--


