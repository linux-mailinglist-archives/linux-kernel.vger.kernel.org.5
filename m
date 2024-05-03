Return-Path: <linux-kernel+bounces-167136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5F8BA4D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3863B22785
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFED2FA;
	Fri,  3 May 2024 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubbmgbmS"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E6BE58
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699123; cv=none; b=r+Mn14JAqQJmfMT13euJxyacl1OGzOTX6nUT6p4Qdouou7TwBYXYPTrZ7UDAZj7ax+QCi2dMi44PpP8EN6xi8vyRCJz0eQ9/pXNCiCof4YY8iabZFkPDna0rCz5koOhDhTXLJpbXjVWIvn/RxwM/EJ3ndThxtivixaePnwL3BF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699123; c=relaxed/simple;
	bh=TOIM1TrKGfF0qDywO4J76ewCZBlUJnZflAHOCDPBgNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ1pKJFk6UBLhhh+9W6vbHPIrp3rMCjHUyXWI7q+9UZfDhwy4pQcBMA9xxk9HPxbRKfEBuLUqDZbDSJf6RL40gJXE2QTMUuRW0SS+P/J07PjCViF5v5i+lYJ3QbUbmp36rGyB68Rnu6sPpSvGxx1/pQMS/XdkVL3/3dO/IteYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubbmgbmS; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso39475ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714699121; x=1715303921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5R9nVMyR6L+so5M8wI/CTn1PoIm8prQ/BbfCQ0zL2BA=;
        b=ubbmgbmSJiMwF6L6BvFsrQWpjmw3I3agUfvZiWNzuRXh0vq+HNUZr8H3cDIo4Qg3fC
         Zf8qHeISgcg1mcj6UDxkqzffEg45Fu/jF25TUxuib1B85nGdFNcOJmkMn785GAPRysIb
         gFG/9Yh6qaZDW2zevckSbglazue2ZXmhHDnz3Rh3tyNi/EuNGO/ZKBP+Dj0oO0UvJPLb
         rtWPJRyMHakYvnGCz8Klxiuvf4apoH3TrxtnxMZRcGr29P3BqIAfdSvXw44ocmByCxr0
         dWOFUWlILRzjRLqpyuYgyMIGd2qjz3H2KBYmtMUMCqABq6v83DFXAH/v4MauwtBqPbed
         Cwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714699121; x=1715303921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R9nVMyR6L+so5M8wI/CTn1PoIm8prQ/BbfCQ0zL2BA=;
        b=INyCNzOdFOV0j9FGykidr8JXxmHTZdQl3HRig0gf99BLwdLBgBolkg9LirnqsAba9T
         EEwZF1Z6j7rmv7H0QP/bREP3xsDnRiEM1jB1UKn6BdoNhHkp+AC/j3tw9yn7wzO4Tmvm
         VM9B90Y9hNWlifzyVF7iL7ESftqo415ppmz7nYMZcGGkbZPBracF60iQO0zogtD/Moyu
         hVewUnwGXFuccU8SA/krVFadVojDV3ffL8FTLCH9pys9NJoPZZ3jstao3O2qWrGHxndd
         xPYyDoZ0MvvNUcY/pZe8+VE8DUALWlmpnpSBrfkmMIAs9MImCPanPwb9gjawYnVBkV/b
         FQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCUA1fKn/blnRGX/5VSBxZuqaEKKuWs8IAuIiOJUKxgBVkYQbf3zJAoJQL9tkQ6h691DBdIPlO4f2kpSKZb2BnBuxY3hWgPkjI8SKOUJ
X-Gm-Message-State: AOJu0YxyRQ98+0GrjIoLrWJsLtnXPwTy/8WP9MIduncC5/OigwGqfY5V
	sdUTEIe5ZakLRAYGQaXeXCoQOCWtHSPfKfx6lqMs6ECJA37duZxdJylDKRBMlA==
X-Google-Smtp-Source: AGHT+IEhLvXfIHRD1iAHuGfsKb08lmkcwq9eCpu1i8vzVJ0Ik4naWRp5Ta9zeJVaWHPzyQji/aSWjw==
X-Received: by 2002:a05:6e02:1087:b0:36c:60f9:5257 with SMTP id e9e14a558f8ab-36c7b0e5fcfmr459225ab.27.1714699120624;
        Thu, 02 May 2024 18:18:40 -0700 (PDT)
Received: from google.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d11-20020a656b8b000000b005f7ff496050sm1696783pgw.76.2024.05.02.18.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 18:18:39 -0700 (PDT)
Date: Fri, 3 May 2024 01:18:35 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in
 trace
Message-ID: <ZjQ7a8EGJlGTXX7W@google.com>
References: <20240503003920.1482447-1-jthies@google.com>
 <20240503003920.1482447-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gZIu0tBn/a3j6Up2"
Content-Disposition: inline
In-Reply-To: <20240503003920.1482447-2-jthies@google.com>


--gZIu0tBn/a3j6Up2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Fri, May 03, 2024 at 12:39:17AM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>=20
> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. When CONFIG_TYPEC_DP_ALTMODE is not enabled
> ucsi_register_displayport returns NULL which causese a NULL pointer
> dereference in trace. Rather than return NULL, call
> typec_port_register_altmode to register DisplayPort alternate mode
> as a non-controllable mode when CONFIG_TYPEC_DP_ALTMODE is not enabled.
>=20
> Reviewed-by: Jameson Thies <jthies@google.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> Changes in V3:
> - Returns typec_port_register_altmode call from
> ucsi_register_displayport when CONFIG_TYPEC_DP_ALTMODE is not enabled.
>=20
> Changes in V2:
> - Checks for error response from ucsi_register_displayport when
> registering DisplayPort alternate mode.
>=20
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index c4d103db9d0f8..f66224a270bc6 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
>  			  bool override, int offset,
>  			  struct typec_altmode_desc *desc)
>  {
> -	return NULL;
> +	return typec_port_register_altmode(con->port, desc);
>  }
> =20
>  static inline void
> --=20
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>=20

--gZIu0tBn/a3j6Up2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZjQ7aAAKCRBzbaomhzOw
wv5KAQDnt1Bax9hdRTZgvfEDnet2yNFHbxPhj8ry665P76DzsAD/aiD6UKZfXZJN
Krwb201Wx4FSZLV+3MJpNqNg2CRi7QE=
=TGSn
-----END PGP SIGNATURE-----

--gZIu0tBn/a3j6Up2--

