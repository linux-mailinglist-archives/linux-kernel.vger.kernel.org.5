Return-Path: <linux-kernel+bounces-77650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37486087B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E74D1C22092
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E7B671;
	Fri, 23 Feb 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLlBP5Ai"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADDAD53
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652864; cv=none; b=EC20dv81yQppqW/LadmCa5AIRhlb4jATSxtPRvn8Bgp+oZ8ud00TpK7LBIUxpc0DjOlUVYpWyljqBHhgVUq2XXPs62A/sRj8F8C5brM8KSCthQMVo1ymPc3qXZO5R1oa8itseaM9qHtBTfyN+GZZvKHes1qvF5csPn/CmHb24EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652864; c=relaxed/simple;
	bh=xIQxyrijVvw5tFZVsDF24qabtT7R6qgyFyEjcKmhITw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b279Zl0aVhGHeZg/OklB84zn2HnOIMEjkR55H6ONnw34lLT16XlwoqR0MORNuQF3Oi1ex3iIlY+0UIZETRwbvi5K29FbP42UVIZ6LIpLCbP+8kmE+5aZHGSuNpV8iRJw2q07Nmge90rRWRyYhTsL0F0NY3tqGmIUTL/giOvKEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLlBP5Ai; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbcf58b05cso35905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652862; x=1709257662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8LqUSdRok/CA+tRah7op5DIjhzrzfCw19wfAf0zitA=;
        b=CLlBP5Aiih526HFjAfCeUED1Bl23xXDcNdtwhPnjzW8J30gKm3VdfVtWJgoQLLVE9J
         y8Q27ZAWQXzyzwE9NmnJL8Qp1wD0rpqGoxO1mzLm2aSZ2z2jCYBeqyNQ/4YjNgV3UfTa
         J3GJt25ovYvSlRKl/eiIjvA6N305LUlW0OUik7Ox+sJGdnYNfsuEtzU6INuiK3RemD+H
         fwmfnQdompWHfS32//YFz8kzxL7QU1jVqrQxDZUXhfZQee19P5kEWr2kFXI7UBZUK2x/
         znCYfdwVwCQ3hQVR+fTmmPtEo8sXNnKCGBHiot/oq/ItMuv/5sfq1viE0IMJuOkFeYt5
         pbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652862; x=1709257662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8LqUSdRok/CA+tRah7op5DIjhzrzfCw19wfAf0zitA=;
        b=f2KYglIwv0ZNcmOojbVQL1f6PUAEhnw8S2OxYPNBur2XagbPIFmQ+KXIp26zAJcXd/
         3gde/kzCk5qXZV1z0OFAqJ2IJqGn22WiAeFIch/4kClSxsDO59yp9vK/pKrwY1Vzbv2a
         +uGdBsgfJT4VyhmFuFBxtdDKftLC/2wzfWZQcs97djCxo6NXcLoVyd3gml4Jsp7uLPlP
         q5vs1wCBCM1IlMHoqY9xMzRkQRAVNwljYE4zhL7sAneFx37BNJudBcG+YI7QehNrQNga
         +dubCP0Kfis+aLf4OsTVpjX3kPRHX9lVqgIP60oX3jxmnJ9quQIS05batd9cueKGY19W
         d/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUArSePgCQw1Z6D45yYmj6BwHJ5XPmcmxuUJ1DS5L2hj50W4pBcFSgFirBOlx6bLOiJYtMIWLTFTQ/RUWjAvWlnZukzglOmPrsPu54r
X-Gm-Message-State: AOJu0Yy28G5QL/r83H6VIFamJjilJd5pGgY+2hRNMK6Yq5s0h/glFT/7
	X/ruQvAgzbgLVuxgQLTQdPUcwPxL++/73dgh3vnUwxpM8SrmMDzvYpdSy35izA==
X-Google-Smtp-Source: AGHT+IHJh4lJkS324hWVEfeHHCDYDYahMyeLB4IsT6cMcZZZGLq3E1DHCneNrGMY6CSoZVw+J0j8eA==
X-Received: by 2002:a17:902:bc45:b0:1db:e5e3:f7ac with SMTP id t5-20020a170902bc4500b001dbe5e3f7acmr639536plz.7.1708652861816;
        Thu, 22 Feb 2024 17:47:41 -0800 (PST)
Received: from google.com (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7888b000000b006e0465879b2sm11562873pfe.70.2024.02.22.17.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 17:47:40 -0800 (PST)
Date: Fri, 23 Feb 2024 01:47:37 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: typec: ucsi: Register SOP' alternate modes with
 cable plug
Message-ID: <Zdf5OQectSrBf_sn@google.com>
References: <20240223010328.2826774-1-jthies@google.com>
 <20240223010328.2826774-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="crR+FIe5gTszUjTd"
Content-Disposition: inline
In-Reply-To: <20240223010328.2826774-5-jthies@google.com>


--crR+FIe5gTszUjTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Fri, Feb 23, 2024 at 01:03:28AM +0000, Jameson Thies wrote:
> Register SOP' alternate modes with a Type-C Connector Class cable plug.
> Alternate modes are queried from the PPM using the GET_ALTERNATE_MODES
> command with recipient set to SOP'.
>=20

Is there a plan to do the same for the SOP Double Prime for advanced active
cables with two plugs?

> Signed-off-by: Jameson Thies <jthies@google.com>

Other than that question,

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> Tested on v6.6 kernel. SOP' GET_ALTERNATE_MODE responses from the PPM
> are correctly registered as to the cable plug.
> redrix-rev3 /sys/class/typec # ls port2-cable/port2-plug0/
> device  port2-plug0.0  port2-plug0.1  power  subsystem  uevent
>=20
>  drivers/usb/typec/ucsi/ucsi.c | 60 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  2 ++
>  2 files changed, 62 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 6d6443e61faa..9b541547917b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -399,6 +399,27 @@ static int ucsi_register_altmode(struct ucsi_connect=
or *con,
> =20
>  		con->partner_altmode[i] =3D alt;
>  		break;
> +	case UCSI_RECIPIENT_SOP_P:
> +		i =3D ucsi_next_altmode(con->plug_altmode);
> +		if (i < 0) {
> +			ret =3D i;
> +			goto err;
> +		}
> +
> +		ret =3D ucsi_altmode_next_mode(con->plug_altmode, desc->svid);
> +		if (ret < 0)
> +			return ret;
> +
> +		desc->mode =3D ret;
> +
> +		alt =3D typec_plug_register_altmode(con->plug, desc);
> +		if (IS_ERR(alt)) {
> +			ret =3D PTR_ERR(alt);
> +			goto err;
> +		}
> +
> +		con->plug_altmode[i] =3D alt;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -566,6 +587,9 @@ static void ucsi_unregister_altmodes(struct ucsi_conn=
ector *con, u8 recipient)
>  	case UCSI_RECIPIENT_SOP:
>  		adev =3D con->partner_altmode;
>  		break;
> +	case UCSI_RECIPIENT_SOP_P:
> +		adev =3D con->plug_altmode;
> +		break;
>  	default:
>  		return;
>  	}
> @@ -801,6 +825,33 @@ static void ucsi_unregister_partner_pdos(struct ucsi=
_connector *con)
>  	con->partner_pd =3D NULL;
>  }
> =20
> +static int ucsi_register_plug(struct ucsi_connector *con)
> +{
> +	struct typec_plug *plug;
> +	struct typec_plug_desc desc =3D {.index =3D TYPEC_PLUG_SOP_P};
> +
> +	plug =3D typec_register_plug(con->cable, &desc);
> +	if (IS_ERR(plug)) {
> +		dev_err(con->ucsi->dev,
> +			"con%d: failed to register plug (%ld)\n", con->num,
> +			PTR_ERR(plug));
> +		return PTR_ERR(plug);
> +	}
> +
> +	con->plug =3D plug;
> +	return 0;
> +}
> +
> +static void ucsi_unregister_plug(struct ucsi_connector *con)
> +{
> +	if (!con->plug)
> +		return;
> +
> +	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP_P);
> +	typec_unregister_plug(con->plug);
> +	con->plug =3D NULL;
> +}
> +
>  static int ucsi_register_cable(struct ucsi_connector *con)
>  {
>  	struct typec_cable *cable;
> @@ -842,6 +893,7 @@ static void ucsi_unregister_cable(struct ucsi_connect=
or *con)
>  	if (!con->cable)
>  		return;
> =20
> +	ucsi_unregister_plug(con);
>  	typec_unregister_cable(con->cable);
>  	con->cable =3D NULL;
>  	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
> @@ -1046,6 +1098,14 @@ static int ucsi_check_cable(struct ucsi_connector =
*con)
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D ucsi_register_plug(con);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index b89fae82e8ce..32daf5f58650 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -429,9 +429,11 @@ struct ucsi_connector {
>  	struct typec_port *port;
>  	struct typec_partner *partner;
>  	struct typec_cable *cable;
> +	struct typec_plug *plug;
> =20
>  	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
>  	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
> +	struct typec_altmode *plug_altmode[UCSI_MAX_ALTMODES];
> =20
>  	struct typec_capability typec_cap;
> =20
> --=20
> 2.44.0.rc0.258.g7320e95886-goog
>=20

--crR+FIe5gTszUjTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZdf5OAAKCRBzbaomhzOw
wonTAQDqAauPp5X46PDTM5+U7Sw5KGHeA77Vn5fKGzxHWNWM+gEAkmbBJC78698T
6M+p+fQHFs85ChV5M6Gy5rhtaShYtgM=
=llRe
-----END PGP SIGNATURE-----

--crR+FIe5gTszUjTd--

