Return-Path: <linux-kernel+bounces-87762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139D586D8A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE07D285098
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CE37160;
	Fri,  1 Mar 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtYmQQYt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958C36137
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255984; cv=none; b=bSKIziqx3lHQmI0s74WSYgsTUhad0hZAwj+6oD3BxCw+QcG698/VjtkllVGPgNvCm02yk20YL0yYFKfatz04qugchPcRYJJhm199iDpuZ02Ilbyza1i/xrG00ZbBfZ+O35CL/qXgNvFURzdvLLGfiV6sXYbA7L+aqjc6y60V7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255984; c=relaxed/simple;
	bh=tEKWJtG51YAewLaiv6i2gRn9iCJrlrLBmxpCOsnNFgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+Ns8JtPpKp1cN5EVJqrClj56UKIHlAOqxn83mjolxXd82ldHBH+cM5xls9kiPuFb9ZOSW9aDQ9iWPf1UpCaWxhuYTEJU0Db0mX4EZjh5GsjpnePruV0A6bdGCcH8+DbYGeMmLFxXzNNZERwxjs/Mr33IyuMHKyFiZ/LUGL5x78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtYmQQYt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc744f54d0so91095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709255982; x=1709860782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XY4iK5q+WSMfCP+4I32SSQ9WzdgztdIyR7UmvGP2XS4=;
        b=JtYmQQYty1k3ZoHp6EhNL7X4iW9YWfboYZCdABGPQwj7V6NUYblWvbvnEJXY/KXouz
         8DK03YEQiSe1C3jrfle3Tomy1ztfteBHBf9IcG1x+aFpn7CUWMOLEZ6T6ktqHaIxGyEL
         XMsw33aWBmiRjsBvemsU0GVMvsRZXSNS+AAj6fMd4c55nCud8pjiqQ55Z3voLmMEgEyl
         MGylvtigNy/ZLGsRhhA9bfQe1vXwCI1tMaj+1xinwIjlfKTLIZ/bvrMt8aoRPb2fss2l
         d9udN63vgunMzSlDAzfNIs1yNWsiG0ZKr0UITWMqZJfjDD7ORbbYb5eb3HoYDc9Zee4R
         w/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709255982; x=1709860782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY4iK5q+WSMfCP+4I32SSQ9WzdgztdIyR7UmvGP2XS4=;
        b=EmVWoesMAEmM7HtmfhpT8IsvKAfAJxa88zGKyFNMRQNHmGLSFhzxwALCQmGRA32Rz7
         zxCt9+SKxLTyNRcWV6wuWuVDbvlCOryuqRojGhXGOLYCQE7w4cylOKoe+Ey5asJL3tIx
         uG1tw23kNzlPe5FLJJUNnzku6krBo5Ezzhux9tmgmeDJbOfttTF6DVvoHckuulXDczf/
         2CPTZza+hyin+cyZrW3+LbHbYU6PwLnZwJ1JbOMdwd8oSGGkg7QURAGxOoaRW2sNXlfW
         QIL5SQtiuMN6g+FXSy3aDarGVg3QtDshs0YIXrOdVGw0OLzLJIg4/HajKvqX9eIqsvoy
         m4QA==
X-Forwarded-Encrypted: i=1; AJvYcCXzXBwPvNr6a7M3fJeccOpblaJKv1f9gA5aEJ9nH6ndIYVcNgHMOHRX7EcTYnjOy4RLJzorgdXVLnc/t6wJEuRpEjMirV17u27sna5s
X-Gm-Message-State: AOJu0Yxz0yspYl3/0rYd27H9uXmMFMjMs/NKhMyQpbHC7vEUgetwNhXx
	LGoUsd0REiircOXJlYcwk8jopSbgdOEGVOnFVDVcSvMbE9xasQAIcjz61H58mw==
X-Google-Smtp-Source: AGHT+IGI73EwH4cpv4Jcb46oAnDJHdqA9NsV6OSC+8BppulefSyU9w8HvGGDYDAATXT3/1st2qLmFw==
X-Received: by 2002:a17:903:228e:b0:1dc:df1b:6017 with SMTP id b14-20020a170903228e00b001dcdf1b6017mr42855plh.21.1709255981785;
        Thu, 29 Feb 2024 17:19:41 -0800 (PST)
Received: from google.com (109.120.125.34.bc.googleusercontent.com. [34.125.120.109])
        by smtp.gmail.com with ESMTPSA id ta6-20020a17090b4ec600b0029a849e7268sm4275336pjb.28.2024.02.29.17.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 17:19:40 -0800 (PST)
Date: Fri, 1 Mar 2024 01:19:36 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] usb: typec: ucsi: Register SOP/SOP' Discover
 Identity Responses
Message-ID: <ZeEtKIl5FmFQq1PT@google.com>
References: <20240229232625.3944115-1-jthies@google.com>
 <20240229232625.3944115-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hF6TYH8Ny7dvps26"
Content-Disposition: inline
In-Reply-To: <20240229232625.3944115-4-jthies@google.com>


--hF6TYH8Ny7dvps26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Thu, Feb 29, 2024 at 11:26:24PM +0000, Jameson Thies wrote:
> Register SOP and SOP' Discover Identity responses with the USB Type-C
> Connector Class as partner and cable identities, respectively. Discover
> Identity responses are requested from the PPM using the GET_PD_MESSAGE
> UCSI command.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> GET_PD_MESSAGE responses from the PPM populate partner and cable
> identity in sysfs:
> nospike-rev4 /sys/class/typec # ls port0-partner/identity/
> cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
> product_type_vdo3
> nospike-rev4 /sys/class/typec # ls port0-cable/identity/
> cert_stat  id_header  product  product_type_vdo1  product_type_vdo2
> product_type_vdo3
>=20
> Changes in v3:
> - None.
>=20
> Changes in v2:
> - Re-ordered memset call and null assignment when unregistering partners
> and cables.
> - Supports registering partner and cable identity with UCSI versions
> before v2.0.
> - Shortened lines to within 80 characters with the exception of two
> error log lines with three indentations.
> - Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.
>=20
>  drivers/usb/typec/ucsi/ucsi.c | 125 ++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  29 ++++++++
>  2 files changed, 154 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7c84687b5d1a3..4088422b33c74 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -646,6 +646,121 @@ static int ucsi_get_src_pdos(struct ucsi_connector =
*con)
>  	return ret;
>  }
> =20
> +static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient,
> +			      struct usb_pd_identity *id)
> +{
> +	struct ucsi *ucsi =3D con->ucsi;
> +	struct ucsi_pd_message_disc_id resp =3D {};
> +	u64 command;
> +	int ret;
> +
> +	if (ucsi->version < UCSI_VERSION_2_0) {
> +		/*
> +		 * Before UCSI v2.0, MESSAGE_IN is 16 bytes which cannot fit
> +		 * the 28 byte identity response including the VDM header.
> +		 * First request the VDM header, ID Header VDO, Cert Stat VDO
> +		 * and Product VDO.
> +		 */
> +		command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> +		    UCSI_CONNECTOR_NUMBER(con->num);
> +		command |=3D UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +		command |=3D UCSI_GET_PD_MESSAGE_OFFSET(0);
> +		command |=3D UCSI_GET_PD_MESSAGE_BYTES(0x10);
> +		command |=3D UCSI_GET_PD_MESSAGE_TYPE(
> +		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +		ret =3D ucsi_send_command(ucsi, command, &resp, 0x10);
> +		if (ret < 0) {
> +			dev_err(ucsi->dev,
> +				"UCSI_GET_PD_MESSAGE v1.2 failed first request (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		/* Then request Product Type VDO1 through Product Type VDO3. */
> +		command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> +		    UCSI_CONNECTOR_NUMBER(con->num);
> +		command |=3D UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +		command |=3D UCSI_GET_PD_MESSAGE_OFFSET(0x10);
> +		command |=3D UCSI_GET_PD_MESSAGE_BYTES(0xc);
> +		command |=3D UCSI_GET_PD_MESSAGE_TYPE(
> +		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +		ret =3D ucsi_send_command(ucsi, command, &resp.vdo[0], 0xc);
> +		if (ret < 0) {
> +			dev_err(ucsi->dev,
> +				"UCSI_GET_PD_MESSAGE v1.2 failed second request (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +	} else {
> +		/*
> +		 * In UCSI v2.0 and after, MESSAGE_IN is large enough to request
> +		 * the large enough to request the full Discover Identity
> +		 * response at once.
> +		 */
> +		command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> +		    UCSI_CONNECTOR_NUMBER(con->num);
> +		command |=3D UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +		/* VDM Header + 6 VDOs (0x1c bytes) without an offset */
> +		command |=3D UCSI_GET_PD_MESSAGE_OFFSET(0);
> +		command |=3D UCSI_GET_PD_MESSAGE_BYTES(0x1c);
> +		command |=3D UCSI_GET_PD_MESSAGE_TYPE(
> +		    UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +		ret =3D ucsi_send_command(ucsi, command, &resp, sizeof(resp));
> +		if (ret < 0) {
> +			dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	id->id_header =3D resp.id_header;
> +	id->cert_stat =3D resp.cert_stat;
> +	id->product =3D resp.product;
> +	id->vdo[0] =3D resp.vdo[0];
> +	id->vdo[1] =3D resp.vdo[1];
> +	id->vdo[2] =3D resp.vdo[2];
> +	return 0;
> +}
> +
> +static int ucsi_get_partner_identity(struct ucsi_connector *con)
> +{
> +	int ret;
> +
> +	ret =3D ucsi_read_identity(con, UCSI_RECIPIENT_SOP,
> +				 &con->partner_identity);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D typec_partner_set_identity(con->partner);
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "Failed to set partner identity (%d)\n",
> +			ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ucsi_get_cable_identity(struct ucsi_connector *con)
> +{
> +	int ret;
> +
> +	ret =3D ucsi_read_identity(con, UCSI_RECIPIENT_SOP_P,
> +				 &con->cable_identity);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D typec_cable_set_identity(con->cable);
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "Failed to set cable identity (%d)\n",
> +			ret);
> +	}
> +
> +	return ret;
> +}
> +
>  static int ucsi_check_altmodes(struct ucsi_connector *con)
>  {
>  	int ret, num_partner_am;
> @@ -754,6 +869,7 @@ static int ucsi_register_cable(struct ucsi_connector =
*con)
>  		break;
>  	}
> =20
> +	desc.identity =3D &con->cable_identity;
>  	desc.active =3D !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
>  			 con->cable_prop.flags);
>  	desc.pd_revision =3D UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
> @@ -777,6 +893,7 @@ static void ucsi_unregister_cable(struct ucsi_connect=
or *con)
>  		return;
> =20
>  	typec_unregister_cable(con->cable);
> +	memset(&con->cable_identity, 0, sizeof(con->cable_identity));
>  	con->cable =3D NULL;
>  }
> =20
> @@ -827,6 +944,7 @@ static int ucsi_register_partner(struct ucsi_connecto=
r *con)
>  		break;
>  	}
> =20
> +	desc.identity =3D &con->partner_identity;
>  	desc.usb_pd =3D pwr_opmode =3D=3D UCSI_CONSTAT_PWR_OPMODE_PD;
>  	desc.pd_revision =3D UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->=
cap.flags);
> =20
> @@ -855,6 +973,7 @@ static void ucsi_unregister_partner(struct ucsi_conne=
ctor *con)
>  	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
>  	ucsi_unregister_cable(con);
>  	typec_unregister_partner(con->partner);
> +	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
>  	con->partner =3D NULL;
>  }
> =20
> @@ -975,6 +1094,10 @@ static int ucsi_check_cable(struct ucsi_connector *=
con)
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D ucsi_get_cable_identity(con);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
> =20
> @@ -1019,6 +1142,7 @@ static void ucsi_handle_connector_change(struct wor=
k_struct *work)
>  			ucsi_register_partner(con);
>  			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> +			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
>  			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> =20
>  			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) =3D=3D
> @@ -1418,6 +1542,7 @@ static int ucsi_register_port(struct ucsi *ucsi, st=
ruct ucsi_connector *con)
>  		ucsi_register_partner(con);
>  		ucsi_pwr_opmode_change(con);
>  		ucsi_port_psy_changed(con);
> +		ucsi_get_partner_identity(con);
>  		ucsi_check_cable(con);
>  	}
> =20
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index f0aabef0b7c64..b89fae82e8ce7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -106,6 +106,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_GET_CABLE_PROPERTY		0x11
>  #define UCSI_GET_CONNECTOR_STATUS	0x12
>  #define UCSI_GET_ERROR_STATUS		0x13
> +#define UCSI_GET_PD_MESSAGE		0x15
> =20
>  #define UCSI_CONNECTOR_NUMBER(_num_)		((u64)(_num_) << 16)
>  #define UCSI_COMMAND(_cmd_)			((_cmd_) & 0xff)
> @@ -159,6 +160,18 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num=
);
>  #define UCSI_MAX_PDOS				(4)
>  #define UCSI_GET_PDOS_SRC_PDOS			((u64)1 << 34)
> =20
> +/* GET_PD_MESSAGE command bits */
> +#define UCSI_GET_PD_MESSAGE_RECIPIENT(_r_)	((u64)(_r_) << 23)
> +#define UCSI_GET_PD_MESSAGE_OFFSET(_r_)		((u64)(_r_) << 26)
> +#define UCSI_GET_PD_MESSAGE_BYTES(_r_)		((u64)(_r_) << 34)
> +#define UCSI_GET_PD_MESSAGE_TYPE(_r_)		((u64)(_r_) << 42)
> +#define   UCSI_GET_PD_MESSAGE_TYPE_SNK_CAP_EXT	0
> +#define   UCSI_GET_PD_MESSAGE_TYPE_SRC_CAP_EXT	1
> +#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_CAP	2
> +#define   UCSI_GET_PD_MESSAGE_TYPE_BAT_STAT	3
> +#define   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY	4
> +#define   UCSI_GET_PD_MESSAGE_TYPE_REVISION	5
> +
>  /* ---------------------------------------------------------------------=
----- */
> =20
>  /* Error information returned by PPM in response to GET_ERROR_STATUS com=
mand. */
> @@ -338,6 +351,18 @@ struct ucsi_connector_status {
>  	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
>  } __packed;
> =20
> +/*
> + * Data structure filled by PPM in response to GET_PD_MESSAGE command wi=
th the
> + * Response Message Type set to Discover Identity Response.
> + */
> +struct ucsi_pd_message_disc_id {
> +	u32 vdm_header;
> +	u32 id_header;
> +	u32 cert_stat;
> +	u32 product;
> +	u32 vdo[3];
> +} __packed;
> +
>  /* ---------------------------------------------------------------------=
----- */
> =20
>  struct ucsi_debugfs_entry {
> @@ -428,6 +453,10 @@ struct ucsi_connector {
>  	struct usb_power_delivery_capabilities *partner_sink_caps;
> =20
>  	struct usb_role_switch *usb_role_sw;
> +
> +	/* USB PD identity */
> +	struct usb_pd_identity partner_identity;
> +	struct usb_pd_identity cable_identity;
>  };
> =20
>  int ucsi_send_command(struct ucsi *ucsi, u64 command,
> --=20
> 2.44.0.rc1.240.g4c46232300-goog
>=20

--hF6TYH8Ny7dvps26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZeEtKAAKCRBzbaomhzOw
wi8lAQC6aengjuuD6Fo37TcK5EXHZ6Yu5yKVRRmL6cz+2snIYAEAiIUQB7/ZWutH
V7GqOFELnyLxH7T5L4onZBAJuSBHsgk=
=GPiY
-----END PGP SIGNATURE-----

--hF6TYH8Ny7dvps26--

