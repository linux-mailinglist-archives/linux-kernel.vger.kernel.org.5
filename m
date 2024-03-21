Return-Path: <linux-kernel+bounces-110255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B1885C29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB46280DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12A86637;
	Thu, 21 Mar 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGHL3Xkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9986AC6;
	Thu, 21 Mar 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035265; cv=none; b=LtdV7mixDNRh6ETsglc/BI9FeFYbldAn5g/OajPBoQIWDn1c8PkpGCkxomkxQMXOv8INZh35UeWKE9LYxNJEwBpQkSBZYyUissQnc03N4SSDuiCP86c5FZBk/v+UBgrtRNQ5gdOzKhlSIXmyhI6GwVY6ntDsryiwOoowzfccO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035265; c=relaxed/simple;
	bh=NHdYAaxvtVR1hgs4LTAu4brIdcf4tG0DdKMRKvsq9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzN2sDX9bYDEUO755gEFJGdERhRkvD4RA/6vpJabOYIxWSTWqUT6Hn6Y+ebgydkj8Y72f7HDZsZ3Fa6Omf35sMp4QTjn7VLpBnCxcJpvwhxnZxO0cJ9u7YPua+g1/46UiboqfezA4bj1/wnO3fr6S2SURjTakh5xDY1NTYL1oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGHL3Xkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADCDC433F1;
	Thu, 21 Mar 2024 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035265;
	bh=NHdYAaxvtVR1hgs4LTAu4brIdcf4tG0DdKMRKvsq9hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGHL3XkvR3+D5mCUGkXbXVSrM8ykvghnJNr89wu3Cs4z0DG7wcnfRUG7FqEzl63cb
	 IAsqbwoEcEhKfp/XHuzkO6jww0XfkgnKx6N3837tG1/I3hmqKzQLS3Sxs0OBwhqlb1
	 KAOFGyZ4EUO7iaFSVfmVmUIUYphDcRdIJasOuhtuUygx0qkGZOJvDV8RPQq9UjLkny
	 6X5wZ+AJtJxzUS/uz1TVUJJDFH1RtY9Qv8m5WOy021xqn8CkceiCR1GBiOClIj7UeG
	 RXRYZFff7LtoCTsU4k1iQ5jcpqndflp22xL1g+9twCKaaa+Xe+cyWcZkoPTVvHb6rG
	 nQSEabUZen2Sg==
Date: Thu, 21 Mar 2024 15:34:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Parthiban.Veerasooran@microchip.com
Cc: krzysztof.kozlowski@linaro.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240321-upcountry-finless-b0e9b1ab4deb@spud>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
 <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
 <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hkhej6qqS7FQuj9S"
Content-Disposition: inline
In-Reply-To: <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>


--Hkhej6qqS7FQuj9S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:00:56PM +0000, Parthiban.Veerasooran@microchip.c=
om wrote:
> Hi Krzysztof,
>=20
> On 21/03/24 2:10 pm, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > On 21/03/2024 09:38, Parthiban.Veerasooran@microchip.com wrote:
> >> Hi Krzysztof,
> >>
> >> On 20/03/24 3:23 pm, Krzysztof Kozlowski wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> On 20/03/2024 09:40, Parthiban.Veerasooran@microchip.com wrote:
> >>>> Hi Conor & Andrew,
> >>>>
> >>>> Please find my reply below by consolidating other two emails comments
> >>>> related to this.
> >>>>
> >>>> On 07/03/24 12:31 am, Conor Dooley wrote:
> >>>>> On Wed, Mar 06, 2024 at 07:48:57PM +0100, Andrew Lunn wrote:
> >>>>>>>> +description:
> >>>>>>>> +  The LAN8650/1 combines a Media Access Controller (MAC) and an=
 Ethernet
> >>>>>>>> +  PHY to enable 10BASE=E2=80=91T1S networks. The Ethernet Media=
 Access Controller
> >>>>>>>> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, c=
ompatible
> >>>>>>>> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer =
transceiver
> >>>>>>>> +  integrated into the LAN8650/1. The communication between the =
Host and
> >>>>>>>> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACP=
HY Serial
> >>>>>>>> +  Interface (TC6).
> >>>>>>>> +
> >>>>>>>> +allOf:
> >>>>>>>> +  - $ref: ethernet-controller.yaml#
> >>>>>>>> +
> >>>>>>>> +properties:
> >>>>>>>> +  compatible:
> >>>>>>>> +    oneOf:
> >>>>>>>> +      - items:
> >>>>>>>> +          - const: microchip,lan8650
> >>>>>>>> +          - const: microchip,lan8651
> >>>>>>> The order here is wrong, lan8561 needs to come before the fallbac=
k of
> >>>>>>> lan8650.
> >>>>>> I don't think it is a fallback. There are two devices, and hence t=
wo
> >>>>>> different compatibles. So i suspect the -items: is wrong here?
> >>>>> It'd just be a two entry enum then, but I did take a quick look at =
the
> >>>>> driver earlier and saw:
> >>>>> +static const struct of_device_id lan865x_dt_ids[] =3D {
> >>>>> +    { .compatible =3D "microchip,lan8650" },
> >>>>> +    { .compatible =3D "microchip,lan8651" },
> >>>>> +    { /* Sentinel */ }
> >>>>> +};
> >>>>>
> >>>>> That, along with no other of_device_is_compatible() type operations
> >>>>> made me think that having a fallback actually was suitable.
> >>>>>
> >>>>> You cropped it out, but the patch had:
> >>>>>> +  compatible:
> >>>>>> +    oneOf:
> >>>>>> +      - items:
> >>>>>> +          - const: microchip,lan8650
> >>>>>> +          - const: microchip,lan8651
> >>>>>> +      - enum:
> >>>>>> +          - microchip,lan8650
> >>>>> So it doesn't appear to be an accidental items in place of an enum,
> >>>>> since the other compatible is in another enum.
> >>>> As per Andrew's comment in another email, both LAN8650 and LAN8651 a=
re
> >>>> two different variants but they both share almost all characteristics
> >>>> except one thing that is LAN8651 has "Single 3.3V supply with integr=
ated
> >>>> 1.8V regulator" which doesn't have anything to do with driver. That's
> >>>
> >>> So why this is not reflected in your driver? Why didn't you address t=
hat
> >>> part, but ignored?
> >> No, it is not ignored. This difference is specific to hardware and the=
re
> >> is no configuration/setting to be done from driver.
> >>>
> >>>> why I have kept them as fallback as Conor said in this email. Hope y=
ou
> >>>> all OK with this.
> >>>
> >>> Did you read the feedback? Your response is not solving here anything.
> >>> How 8650 can be used twice? Please point me to DTS showing both usage=
s.
> >> May be I have a misunderstanding here. Let's clarify it.
> >>
> >> LAN8650 and LAN8651 both are two different variants but both implements
> >> same functionality. The only difference is LAN8651 has "Single 3.3V
> >> supply with integrated" where LAN8650 doesn't have this. This is
> >> hardware specific difference and there is no configuration/setting to =
be
> >> done in the driver specific to this difference in the LAN8651. So
> >> basically the driver can support for both variants without any
> >> additional settings.
> >>
> >> LAN8650: https://www.microchip.com/en-us/product/lan8650
> >> LAN8651: https://www.microchip.com/en-us/product/lan8651
> >>
> >> The below link shows the difference between them,
> >> https://www.microchip.com/en-us/product-comparison.lan8650.lan8651
> >>
> >> With the above details, I would change the microchip,lan865x.yaml with
> >> the below details.
> >>
> >> compatible:
> >>     enum:
> >>       - microchip,lan8650
> >>       - microchip,lan8651
> >>
> >> And in the lan865x.c, I would remove the below line because
> >> .compatible =3D "microchip,lan8650" already supports for LAN8651 as we=
ll.
> >>
> >> .compatible =3D "microchip,lan8651"
> >>
> >> Let me know your opinion on this proposal? or do you have any
> >> misunderstanding here?
> >=20
> > It's still wrong. Upstream your DTS and then test it. You will
> > immediately see that it does not work. So first make it working, then
> > send code to review.
> Sorry for the inconvenience. I did the below changes in my=20
> microchip,lan865x.yaml file and executed dt_binding_check. It=20
> successfully created the microchip,lan865x.example.dts without any=20
> errors. Herewith I have attached the updated microchip,lan865x.yaml file=
=20
> and the generated microchip,lan865x.example.dts file for your reference.
>=20
> properties:
>    compatible:
>      oneOf:
>        - items:
>            - const: microchip,lan8651
>            - const: microchip,lan8650

No, this is not right either. You need to also allow the lan8650 on its
own. All you had to do with the original items list was flip the order
of the lan8650 and lan8651.

--Hkhej6qqS7FQuj9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfxTaAAKCRB4tDGHoIJi
0pn7APwPC0i09RDDMqIEPSfbO956debgSpLA0amibHHjDDzYXwD+Lt2CLi8me13G
AKnDr07DjFN0MT6eFRZNd48M/6ZVDwA=
=920K
-----END PGP SIGNATURE-----

--Hkhej6qqS7FQuj9S--

