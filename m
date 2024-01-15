Return-Path: <linux-kernel+bounces-25948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF382D8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58A6282B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6F2C69E;
	Mon, 15 Jan 2024 12:03:25 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C81E865;
	Mon, 15 Jan 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id F0DD414035E; Mon, 15 Jan 2024 12:57:23 +0100 (CET)
Date: Mon, 15 Jan 2024 12:57:23 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: ucsi: Apply UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD
 to Dell systems
Message-ID: <ZaUdowRhVjAxAIM+@cae.in-ulm.de>
References: <20240107001701.130535-1-lk@c--e.de>
 <20240107001701.130535-5-lk@c--e.de>
 <ZaTp5rQLu4rh3Xhm@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZaTp5rQLu4rh3Xhm@kuha.fi.intel.com>


Hi Heikki,

On Mon, Jan 15, 2024 at 11:05:36AM +0200, Heikki Krogerus wrote:
> Hi Christian,
>=20
> On Sun, Jan 07, 2024 at 01:17:01AM +0100, Christian A. Ehrhardt wrote:
> > Apply the UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD to all Dell systems.
> >=20
> > There are various reports that ucsi does not work on Dell systems
> > with "GET_CONNECTOR_STATUS failed". At least some of these are
> > most likely due to the need for this quirk.
> >=20
> > If the logic is wrong users can still use the new quirk override
> > for the typec_ucsi module to disable the quirk.
> >=20
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> >  drivers/usb/typec/ucsi/ucsi_acpi.c | 36 +++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucs=
i/ucsi_acpi.c
> > index 78a0d13584ad..690d5e55bdc4 100644
> > --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> > @@ -27,6 +27,11 @@ struct ucsi_acpi {
> >  	u64 cmd;
> >  };
> > =20
> > +struct ucsi_acpi_attach_data {
> > +	const struct ucsi_operations *ops;
> > +	unsigned int quirks;
> > +};
> > +
> >  static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
> >  {
> >  	union acpi_object *obj;
> > @@ -121,12 +126,30 @@ static const struct ucsi_operations ucsi_zenbook_=
ops =3D {
> >  	.async_write =3D ucsi_acpi_async_write
> >  };
> > =20
> > -static const struct dmi_system_id zenbook_dmi_id[] =3D {
> > +static const struct ucsi_acpi_attach_data ucsi_acpi_default_attach_dat=
a =3D {
> > +	.ops =3D &ucsi_acpi_ops,
> > +	.quirks =3D 0
> > +};
> > +
> > +static const struct dmi_system_id ucsi_acpi_quirks[] =3D {
> >  	{
> >  		.matches =3D {
> >  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> >  			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
> >  		},
> > +		.driver_data =3D &(struct ucsi_acpi_attach_data) {
> > +			.ops =3D &ucsi_zenbook_ops,
> > +			.quirks =3D 0
> > +		},
> > +	},
> > +	{
> > +		.matches =3D {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +		},
> > +		.driver_data =3D &(struct ucsi_acpi_attach_data) {
> > +			.ops =3D &ucsi_acpi_ops,
> > +			.quirks =3D UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD
>=20
> Please don't add any more quirk flags like that for single user (you
> may never have more than the one user for it). Let's just first handle
> this with only Dell's like I proposed.
>=20
> If there are other platforms that need the same quirk, then we can
> start looking at how to share the quirk.

Ok, thanks for the feedback. Will do.

However, please note that it is not clear if it is all or only some
dells that need this. This is the prime reason why I was looking for
a way to enable/disable the quirk.

     regards   Christian


