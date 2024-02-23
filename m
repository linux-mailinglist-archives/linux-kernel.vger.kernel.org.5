Return-Path: <linux-kernel+bounces-77626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864C86083D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC6F1C21D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000CBB641;
	Fri, 23 Feb 2024 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwGrT4/B"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E379E1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651758; cv=none; b=PxQdwOkOGdRm9endXI0YbXR3W09KCIXN43Vi7f5tSCNnnGh3DKU8oodzGniRaFXk7z/Hk1DqPX5Ocrj4XPDYjy8x+dJM0CEsuxPIAxg8FrBhsAi+TUVFgnyTYOmaAOw+T3f/yl26zohJXrWqvgYXl7GTW3B2uyfj3h7jK8jPk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651758; c=relaxed/simple;
	bh=6BDH/5j1BtrwAHpzR1Da4Isg6Op439aAKnuNUQKzvIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcXi/Gdk7o6vUzp0OT+HLojI/cpXCQCy/3PFwoYPqopqXwme8dCOI7RC8q3mTGdB2PisviFaEZeQAvcP9GMtjtf1xydesoN/TeqGgbUKsmSeBIrkRWU389q+IMFK8WdbpsNB4gS6FFyINJQkw/D0q+BYPJWZrD5qNkpW9d41fHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwGrT4/B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5ce88b51cso45295ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708651756; x=1709256556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuB1ABtl1N3RGzltCRuDKyebLb5jjEUsjBHYE7PM86E=;
        b=mwGrT4/Bx3+Uwh01xSuGKJpSEd4rLLoG74qYSPijE7cI+bd+bIvTEh7KXhv9Rmbk74
         Mh00wphVrdBnWQIeIHdTH3vuDMbcaWL3WUH5iTLDP0TOGEKHzNUMH5yWrxYTKxoeu/Db
         9Ws6v9qDnXqTomSHC7JYT+lOrN6vKfFwsos9gqLFnJ9Cc6NftGp1LMXvoGgP472ceGDM
         geDHbpczIoEAgwPHKYpwRiRa9/XJvXVND4JtjHJRXkxFanOD59DiKiVZw6njO9FX2Ltl
         9pHzisyC6HN8//w/d8QO/cd1W7CvNDTktbKV9pbY7xdpWIT/ZS1SwsXbduvxYQ34m8Ts
         PT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708651756; x=1709256556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuB1ABtl1N3RGzltCRuDKyebLb5jjEUsjBHYE7PM86E=;
        b=RXCJXGKedjF0vOW8Ydvi5hujSujiHxMcIiYRUtg4y64N9lSdDlsqiEZPx3sbwRdnrP
         HAv6ABfs0BCe1GXF/JzseSZ43rU9XoQxYCv87HD2cSxgL3dugvh7b/q48vDNkGJ7M8e4
         Gpaq1K0qnbQycsurgBzN/e9FfnOWDT6bsVy9h4tSdxKiX6ZNhQ2jJRJ0aGRsFICE4mia
         vb4BSvhVzqW/PCVK6HO2YIdNBj81siGc7pFlV1/C/NEfqejg1Bh0XxDqiJPsITF2sm+U
         24StGnZaqcgIOJYf8PzdhB7eCZ9L6Y7nxFYZ45U2jWYVuctQMy4nhUETku/Xign+54ip
         9ezQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGSTUfxoZ3tJRv7up3RIZhnsixikjzIxXtj1gE/wY7gnKn7Mg4Oq/BzJYy7pkd7591hahlKB2s9DPtu7uZqESqvwDADI9d+P8VY+5q
X-Gm-Message-State: AOJu0YyqA1ToO7CocjmgnU6EpQbuatQ4RwXdM4GRDm68+UdxTsdQJARv
	5r+rCVKEWl2AG0q05pvLhqNGQTo3/cphxeHMaRKVZlkThDZFreje1u66OsN5NQ==
X-Google-Smtp-Source: AGHT+IGULdvFtv+IqIQO59RWFRqUlvKcWX3JpizuVzem+DvGQnogLCL2bQ5wMmZmyWNtLt9tAJ8DZQ==
X-Received: by 2002:a17:903:3113:b0:1d9:8e37:56cc with SMTP id w19-20020a170903311300b001d98e3756ccmr686307plc.10.1708651755476;
        Thu, 22 Feb 2024 17:29:15 -0800 (PST)
Received: from google.com (30.176.125.34.bc.googleusercontent.com. [34.125.176.30])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170902fa4e00b001db8145a1a2sm10491026plb.274.2024.02.22.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 17:29:14 -0800 (PST)
Date: Fri, 23 Feb 2024 01:29:10 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: ucsi: Register cables based on
 GET_CABLE_PROPERTY
Message-ID: <Zdf05szkJe7R9aq2@google.com>
References: <20240223010328.2826774-1-jthies@google.com>
 <20240223010328.2826774-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9TahtzCofWb3Qd6R"
Content-Disposition: inline
In-Reply-To: <20240223010328.2826774-3-jthies@google.com>


--9TahtzCofWb3Qd6R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Fri, Feb 23, 2024 at 01:03:26AM +0000, Jameson Thies wrote:
> Register cables with the Type-C Connector Class in the UCSI driver based
> on the PPM response to GET_CABLE_PROPERTY. Registered cable properties
> include plug type, cable type and major revision.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> Tested on v6.6 kernel. Expected cable properties populate the USB Type-C
> connector class sysfs paths:
> redrix-rev3 /sys/class/typec # ls port2-cable
> device  identity  plug_type  port2-plug0  power  subsystem  type  uevent
> usb_power_delivery_revision
>=20
>  drivers/usb/typec/ucsi/ucsi.c | 69 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  5 +++
>  2 files changed, 74 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index ae105383e69e..15e82f5fab37 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -734,6 +734,50 @@ static void ucsi_unregister_partner_pdos(struct ucsi=
_connector *con)
>  	con->partner_pd =3D NULL;
>  }
> =20
> +static int ucsi_register_cable(struct ucsi_connector *con)
> +{
> +	struct typec_cable *cable;
> +	struct typec_cable_desc desc =3D {};
> +
> +	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_A:
> +		desc.type =3D USB_PLUG_TYPE_A;
> +		break;
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_B:
> +		desc.type =3D USB_PLUG_TYPE_B;
> +		break;
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_C:
> +		desc.type =3D USB_PLUG_TYPE_C;
> +		break;
> +	default:
> +		desc.type =3D USB_PLUG_NONE;
> +		break;
> +	}
> +
> +	desc.active =3D !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & con->cable_prop.=
flags);
> +	desc.pd_revision =3D UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(con->cabl=
e_prop.flags);
> +
> +	cable =3D typec_register_cable(con->port, &desc);
> +	if (IS_ERR(cable)) {
> +		dev_err(con->ucsi->dev,
> +			"con%d: failed to register cable (%ld)\n", con->num,
> +			PTR_ERR(cable));
> +		return PTR_ERR(cable);
> +	}
> +
> +	con->cable =3D cable;
> +	return 0;
> +}
> +
> +static void ucsi_unregister_cable(struct ucsi_connector *con)
> +{
> +	if (!con->cable)
> +		return;
> +
> +	typec_unregister_cable(con->cable);
> +	con->cable =3D NULL;
> +}
> +
>  static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  {
>  	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
> @@ -807,6 +851,7 @@ static void ucsi_unregister_partner(struct ucsi_conne=
ctor *con)
>  	typec_partner_set_usb_power_delivery(con->partner, NULL);
>  	ucsi_unregister_partner_pdos(con);
>  	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
> +	ucsi_unregister_cable(con);
>  	typec_unregister_partner(con->partner);
>  	con->partner =3D NULL;
>  }
> @@ -907,6 +952,28 @@ static int ucsi_check_connection(struct ucsi_connect=
or *con)
>  	return 0;
>  }
> =20
> +static int ucsi_check_cable(struct ucsi_connector *con)
> +{
> +	u64 command;
> +	int ret;
> +
> +	if (con->cable)
> +		return 0;
> +
> +	command =3D UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
> +	ret =3D ucsi_send_command(con->ucsi, command, &con->cable_prop, sizeof(=
con->cable_prop));
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D ucsi_register_cable(con);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static void ucsi_handle_connector_change(struct work_struct *work)
>  {
>  	struct ucsi_connector *con =3D container_of(work, struct ucsi_connector,
> @@ -948,6 +1015,7 @@ static void ucsi_handle_connector_change(struct work=
_struct *work)
>  			ucsi_register_partner(con);
>  			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> +			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> =20
>  			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) =3D=3D
>  			    UCSI_CONSTAT_PWR_OPMODE_PD)
> @@ -1346,6 +1414,7 @@ static int ucsi_register_port(struct ucsi *ucsi, st=
ruct ucsi_connector *con)
>  		ucsi_register_partner(con);
>  		ucsi_pwr_opmode_change(con);
>  		ucsi_port_psy_changed(con);
> +		ucsi_check_cable(con);
>  	}
> =20
>  	/* Only notify USB controller if partner supports USB data */
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 469a2baf472e..f0aabef0b7c6 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -265,6 +265,9 @@ struct ucsi_cable_property {
>  #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
>  #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
>  #define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
> +#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_)	(((_f_) & GENMASK(7, 6)) =
>> 6)
> +#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(_f_) \
> +	UCSI_SPEC_REVISION_TO_BCD(UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_))
>  	u8 latency;
>  } __packed;
> =20
> @@ -400,6 +403,7 @@ struct ucsi_connector {
> =20
>  	struct typec_port *port;
>  	struct typec_partner *partner;
> +	struct typec_cable *cable;
> =20
>  	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
>  	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
> @@ -408,6 +412,7 @@ struct ucsi_connector {
> =20
>  	struct ucsi_connector_status status;
>  	struct ucsi_connector_capability cap;
> +	struct ucsi_cable_property cable_prop;
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	u32 rdo;
> --=20
> 2.44.0.rc0.258.g7320e95886-goog
>=20

--9TahtzCofWb3Qd6R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZdf05gAKCRBzbaomhzOw
wiT7AQC3ELVG6RWpmLQ5VoQ5XkNdLLjCSlc1+npUy12NygHEKwD/ZGoi4v9y7N28
aU8hhd0bZetqRlKQXKIUc9gefK+BwwY=
=7BY3
-----END PGP SIGNATURE-----

--9TahtzCofWb3Qd6R--

