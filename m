Return-Path: <linux-kernel+bounces-126269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4FB893485
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC431F245A5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902715ECEB;
	Sun, 31 Mar 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bzi2tAuT"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FF15E1E9;
	Sun, 31 Mar 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903421; cv=fail; b=i1K5WI5V5aTx5KRRkuRqiaWHLvBsW//nkx8AWscYON832Z6HRCwhgX67AILa9YKmk+bIn9+Bf9djToKn88AIMbc43rc+BI+q7b1QE74KiOSP2Iq/xTRW2xfdeEDrsS6kXHZ9ygIDmr3lQcD06W+xvXw2i4PH21Ty3NYgeqmO0kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903421; c=relaxed/simple;
	bh=14J6KqKrxEjZL77/xx1syMEjUoPHET0eLOsNVF8OHBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHNiRWjIzrAVNIHytlxZsFtCGVE+nn9wUhUPknPuePlPUuAU7poxVzO4vKTndjFnDe2BljFRAJN88vyDg/mbLfyqRrupLurR/uzX3l0JIe1qZUhoR+r0k7lKsF1W6COxVZ9tyqC5YnpCLZyiwr5ZrMYFEQ0zv+m7o76WTMllQjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bzi2tAuT reason="signature verification failed"; arc=none smtp.client-ip=209.85.219.177; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E1C99208C3;
	Sun, 31 Mar 2024 18:43:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDDJ0n_bYWTv; Sun, 31 Mar 2024 18:43:35 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9B865208BE;
	Sun, 31 Mar 2024 18:43:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9B865208BE
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8DD32800060;
	Sun, 31 Mar 2024 18:43:34 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:34 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:23 +0000
X-sender: <linux-usb+bounces-8668-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAMo6mlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBkAAAA3IoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 21886
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=linux-usb+bounces-8668-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 423DA20882
X-Original-To: linux-usb@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805963; cv=none; b=G8a+yhsnXg1b3YOmx9h0ECP/rS9E13sv2dRmUY6tVQp2eIzpEwG3dtdk5iTRos1bDmwLn8AyOIRGdvzwRojhK8FcPsai/+TM//CDgTvjqQbGXufGNXThfDsSdB4IVNW6bkmmNefCm1TQVoVcxCjdIjLkPSmm+fhmEudv7WqEhzo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805963; c=relaxed/simple;
	bh=xnc2DMxKZjv9rXvPh1SmsY2JW7l8+Agut1TKYkzA/CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFOn4efTA6YwJfpc7Vaun/pLzmOM3T+bC/6vQdS1FtvVuzJjc9u3I2b6DgcI00KkdU1T613qxnUlPTNiNvXRsOaGy31mrNogkl/VELrHOC6Q6O4RqDC9zXVQEYnOlsNKtJJqgk6OhTmltIha3eNrLHGjYUzgO51F3Q6r6FnszbI=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bzi2tAuT; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711805960; x=1712410760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1eYTzSDwNGOt2CpoFbnU3JixxEFJqYUgc9AODKFrFA=;
        b=Bzi2tAuTalPk00O876OBb7VRCQj3ZSqJfDjEmilUDZD3OcAk3NTlgnPHLHM05I+dyf
         arbKMrf+jEpGq1YaxtS3mPGvPdfH8vcSBsjHkWYC+mfCGluo/BixhpDI+2Veha2nLsOQ
         uPYZDS7NnanNrQsn1zhMlSbWz9GzWMLXE2hEYM3xZmKoraFVzlFLY2ErrNqAuYtKkiGm
         BK9ekM1o/fL9QuKUfjeosslIuUpBYRWNLbDTd1lREDOq+hG8EunKJ+qkdDtIF74gMDOb
         ThNgVeMJynCZyosQPjjroFqc11bBYYSwQSdQfTconbC+kQRhRhYHumkWG5881Cf/ZGe0
         GiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711805960; x=1712410760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1eYTzSDwNGOt2CpoFbnU3JixxEFJqYUgc9AODKFrFA=;
        b=VJgNxz69d2TP8QSY9MRVuH2JE0F93U003lc4gezLlOwFsLLbFEHfR5c6mocPFaBYys
         hMlcQOib9Umg9gzpjtdZLL0IjaO4R8ExFJQi89dlPQlPpWifnLAgo4RMPDTmrnMB6g+L
         wFHv8U2KnrSR/AiS05QFkqj8H9nbwzknGRS6twapa5eRz1H9QigDvgKB8jTEBeNnAU3E
         yEA2UnAmAaoKbLEw1y5bMBIT/CmWNRVs41gx+v45lIcP4hhq7MGFi/duTbih7bedcdel
         vPctGlt/HyJ6VHfpYVuKBh4uYgmS6qTZfRUZF01XwK3fvQKz7XPTnlqN638BaUAi0mX1
         LTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv/RWIYrvRpDS0qNW1xjLB45b31lNQAETbvSFcdWU1L7oq7OyZU+Ge5wuuMbRgR0Y3F2L5WBUjutc4OZX08UnHf+nisSH6/k5O
X-Gm-Message-State: AOJu0Yyi4F1eVVdKGGcyBYw++dFyN6UCT5hI8q8UPV/CcTEzRRoIS0u3
	SAiVYjIgz4IP15zA+4QVBY8eqZJNH3nbz8n2kadgvl+opcfhnJvnwwbqy6bMZgsG5ziBlm9mfmH
	wAkZ9Q78fkR+P7/YUpsyM5ZcFuuNrZ9Xla4OSOw==
X-Google-Smtp-Source: AGHT+IF6ThxitzS4Qqvqh1XJrgmv5PX715nooF+qv5g6MJ7bKFjS6CcMSXAR1eSDDfmsKQ9hqTYmjkYYyHmZ10tfRK4=
X-Received: by 2002:a25:baca:0:b0:dd1:2f58:6a2e with SMTP id
 a10-20020a25baca000000b00dd12f586a2emr3920278ybk.9.1711805960439; Sat, 30 Mar
 2024 06:39:20 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
 <CAA8EJpqx+VFW8z6oG=+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com> <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
In-Reply-To: <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Mar 2024 15:39:08 +0200
Message-ID: <CAA8EJppa4hVBSenLgxc5MYxTfzPPf4exHvh8RWTP=p8mgB_RCw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add gpio-usb-c-connector compatible
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor+dt@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kyle Tso <kyletso@google.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, u.kleine-koenig@pengutronix.de, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, 30 Mar 2024 at 11:13, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
> On 3/29/2024 6:23 PM, Dmitry Baryshkov wrote:
> > On Fri, 29 Mar 2024 at 09:20, Krishna Kurapati
> > <quic_kriskura@quicinc.com> wrote:
> >>
> >> QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
> >> However it relies on usb-conn-gpio driver to read the vbus and id
> >> gpio's and provide role switch. However the driver currently has
> >> only gpio-b-connector compatible present in ID table. Adding that
> >> in DT would mean that the device supports Type-B connector and not
> >> Type-c connector. Thanks to Dmitry Baryshkov for pointing it out [2].
> >
> > USB-B connector is pretty simple, it really has just an ID pin and
> > VBUS input, which translates to two GPIOs being routed from the
> > _connector_ itself.
> >
> > USB-C is much more complicated, it has two CC pins and a VBus power
> > pin. It is not enough just to measure CC pin levels. Moreover,
> > properly handling USB 3.0 inside a USB-C connector requires a separate
> > 'orientation' signal to tell the host which two lanes must be used for
> > the USB SS signals. Thus it is no longer possible to route just two
> > pins from the connector to the SoC.
> >
> > Having all that in mind, I suspect that you are not describing your
> > hardware properly. I suppose that you have a Type-C port controller /
> > redriver / switch, which handles CC lines communication and then
> > provides ID / VBUS signals to the host. In such a case, please
> > describe this TCPC in the DT file and use its compatible string
> > instead of "gpio-c-connector".
> >
>
> Hi Dmitry,
>
>   My bad. I must have provided more details of the HW.
>
>   I presume you are referring to addition of a connector node, type-c
> switch, pmic-glink and other remote endpoints like in other SoC's like
> SM8450/ SM8550/ SM8650.
>
>   This HW is slightly different. It has a Uni Phy for Super speed and
> hence no DP.

This is fine and it's irrelevant for the USB-C.

>   For orientation switching, on mobile SoC's, there is a provision for
> orientation gpio given in pmic-glink node and is handled in ucsi_glink
> driver. But on this version of HW, there is a USB-C Switch with its own
> firmware taking care of orientation switching. It takes 8 SS Lines and 2
> CC lines coming from connector as input and gives out 4 SS Lines (SS
> TX1/TX2 RX1/RX2) as output which go to the SoC. So orientation switch is
> done by the USB-C-switch in between and it automatically routes
> appropriate active SS Lane from connector to the SoC.

This is also fine. As I wrote, you _have_ the Type-C port controller.
So your DT file should be describing your hardware.

>   As usual like in other targets, the DP and DM lines from type-c
> connector go to the SoC directly.
>
>   To handle role switch, the VBUS and ID Pin connections are given to
> SoC as well. There is a vbus controller regulator present to provide
> vbus to connected peripherals in host mode.
>
>   There is no PPM entity (ADSP in mobile SoC's) and no UCSI involved
> here. Hence we rely on usb-conn-gpio to read the vbus/id and switch
> roles accordingly.

This is also fine.

You confirmed my suspicions. You have an external Type-C switch which
handles orientation (and most likely PD or non-PD power negotiation)
for you. It has GPIO outputs, etc.

But it is not a part of the connector. Instead of adding the
"gpio-usb-c-connector", add proper compatible string (see, how this is
handled e.g. by the spidev - it is a generic driver, but it requires
hardware-specific compatibles).
Your hardware description should look like:

typec {
    compatible =3D "your,switch";
    id-gpios =3D <&gpio 1>;
    vbus-gpios =3D <&gpio 2>;
    vbus-supplies =3D <&reg-vbus>;

    ports {
       #address-cells =3D <1>;
       #size-cells =3D <1>;
       port@0 {
          endpoint {
              remote-endpoint =3D <&usb_dwc3_hs_out>;
          };
       };
       port@1 {
          endpoint {
              remote-endpoint =3D <&usb_uni_phy_out>;
          };
      };
      /* No SBU port */
   };
};

Note, I haven't said anything regarding the driver. You can continue
using the usb-conn-gpio driver. Just add a compatible string for you
switch.

>
>   Hope this answers the query as to why we wanted to use usb-conn-gpio
> and why we were trying to add a new compatible.
>
> Regards,
> Krishna,
>
> >>
> >> This series intends to add that compatible in driver and bindings
> >> so that it can be used in QDU1000 IDP DT.
> >>
> >> [1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@qu=
icinc.com/
> >> [2]: https://lore.kernel.org/all/CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABF=
BcRt-9BQaCberg@mail.gmail.com/
> >>
> >> Krishna Kurapati (2):
> >>    dt-bindings: connector: Add gpio-usb-c-connector compatible
> >>    usb: common: usb-conn-gpio: Update ID table to add usb-c connector
> >>
> >>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +=
++
> >>   drivers/usb/common/usb-conn-gpio.c                             | 1 +
> >>   2 files changed, 4 insertions(+)
> >>
> >> --
> >> 2.34.1
> >>
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

X-sender: <linux-kernel+bounces-125736-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAMo6mlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGYAAADcigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 22022
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 14:39:43 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 14:39:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id A2BCD20322
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 14:39:43 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHKZz900jZRx for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 14:39:42 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125736-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 793A02025D
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"Bzi2tAuT"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 793A02025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 14:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AFF1F21EA6
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA6347C2;
	Sat, 30 Mar 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"Bzi2tAuT"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.2=
19.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838851C0DE0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.219.169
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711805963; cv=3Dnone; b=3DVsmY03LRBGPvYGJ3htwSPM19/jwCNnkstizr1255TKj=
Lip2cydFC/jsIMBmfHWTA4woI4+Fu6E/sJSNee0ugqnu03xVzoLNhRALAU1yIQFLVXhEhX/6Nyl=
W07qpXAjuUsx5xCc6zhcuoKcTB/JcevM6nH3OCznfIOy+a7tPoooQ=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711805963; c=3Drelaxed/simple;
	bh=3Dxnc2DMxKZjv9rXvPh1SmsY2JW7l8+Agut1TKYkzA/CE=3D;
	h=3DMIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3DRFOn4efTA6YwJfpc7Vaun/pLzmOM3T+bC/6vQdS1FtvVuzJjc=
9u3I2b6DgcI00KkdU1T613qxnUlPTNiNvXRsOaGy31mrNogkl/VELrHOC6Q6O4RqDC9zXVQEYnO=
lsNKtJJqgk6OhTmltIha3eNrLHGjYUzgO51F3Q6r6FnszbI=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinaro.org; spf=3Dpass smtp.mailfrom=3Dl=
inaro.org; dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@lin=
aro.org header.b=3DBzi2tAuT; arc=3Dnone smtp.client-ip=3D209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d8bd612d=
so2845435276.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 06:39:21 -0700=
 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dlinaro.org; s=3Dgoogle; t=3D1711805960; x=3D1712410760; darn=3D=
vger.kernel.org;
        h=3Dcc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3DG1eYTzSDwNGOt2CpoFbnU3JixxEFJqYUgc9AODKFrFA=3D;
        b=3DBzi2tAuTalPk00O876OBb7VRCQj3ZSqJfDjEmilUDZD3OcAk3NTlgnPHLHM05I+=
dyf
         arbKMrf+jEpGq1YaxtS3mPGvPdfH8vcSBsjHkWYC+mfCGluo/BixhpDI+2Veha2nLs=
OQ
         uPYZDS7NnanNrQsn1zhMlSbWz9GzWMLXE2hEYM3xZmKoraFVzlFLY2ErrNqAuYtKki=
Gm
         BK9ekM1o/fL9QuKUfjeosslIuUpBYRWNLbDTd1lREDOq+hG8EunKJ+qkdDtIF74gMD=
Ob
         ThNgVeMJynCZyosQPjjroFqc11bBYYSwQSdQfTconbC+kQRhRhYHumkWG5881Cf/ZG=
e0
         GiWA=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711805960; x=3D1712410760;
        h=3Dcc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-i=
d
         :reply-to;
        bh=3DG1eYTzSDwNGOt2CpoFbnU3JixxEFJqYUgc9AODKFrFA=3D;
        b=3DwrAyIEE4fpgYRXIakYPKWxGZ458enzebr/apBNjGwny3xnHcdkq4kJ9UN3ZbkVN=
for
         KQSgXQRvlNSy1nCKmUUyZHxRHI7v+dN1YoWrjSLP3pS6Rfx6O2NH3TS5XGDQmYSriD=
l3
         2VjIsnfEyhLCogXehZ1779TqjLw/umOdhhj1dmmSyD3QM/errL/NAAuTxUFKyUtw67=
vh
         zOmDvjgjPVyGjWQY5k0WacN4CIJeBsMbsQERadGjDKtl0T/4w3YBhch3bwdVNfpIVo=
ph
         kBqUHgg8em7xjmsaGyYq9tysX+eCvFH8UzhwPzWSegmZOHCWNQ9UQ+/M+f6l5hIw10=
DY
         23yw=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCVI7s5+8a4VQgS5qj2UxlRT2x3w/dvwtx1peqiUQ=
zp+JMxyWOi4dCwa5XaOdsg919leo+ugA3lGT2wZbi9JekucIwhrB+tUgz+tKBPO
X-Gm-Message-State: AOJu0YyAPHvrI3oTLhfTCvNCLlS0XxG1/4UzLXAF/Y19H1Irx2NlazQ=
i
	wc+LXov5s9Y7pL7yl6oh8XjnMfj5V83P3SBDz6yRAG77d4XrfQKrAeAM4BSRPVfNOSdDfWeg5r=
j
	DDs8I2MHAn0ys/fkuoUl7QbXy9EGghQIBokuTYw=3D=3D
X-Google-Smtp-Source: AGHT+IF6ThxitzS4Qqvqh1XJrgmv5PX715nooF+qv5g6MJ7bKFjS6=
CcMSXAR1eSDDfmsKQ9hqTYmjkYYyHmZ10tfRK4=3D
X-Received: by 2002:a25:baca:0:b0:dd1:2f58:6a2e with SMTP id
 a10-20020a25baca000000b00dd12f586a2emr3920278ybk.9.1711805960439; Sat, 30 =
Mar
 2024 06:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
 <CAA8EJpqx+VFW8z6oG=3D+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com> <6f=
2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
In-Reply-To: <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Mar 2024 15:39:08 +0200
Message-ID: <CAA8EJppa4hVBSenLgxc5MYxTfzPPf4exHvh8RWTP=3Dp8mgB_RCw@mail.gma=
il.com>
Subject: Re: [RFC PATCH 0/2] Add gpio-usb-c-connector compatible
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Rob Herring <robh@kernel.org>,=20
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,=20
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor+dt@ke=
rnel.org>,=20
	Miquel Raynal <miquel.raynal@bootlin.com>, Guenter Roeck <linux@roeck-us.n=
et>,=20
	Bjorn Helgaas <bhelgaas@google.com>, Kyle Tso <kyletso@google.com>,=20
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,=20
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, u.kleine-koenig@pengutr=
onix.de,=20
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devi=
cetree@vger.kernel.org,=20
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,=20
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset=3D"UTF-8"
Return-Path: linux-kernel+bounces-125736-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 13:39:43.6991
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 79151791-a669-4059-b4b7-08dc=
50bedb89
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.401|SMR=3D0.324(SMRDE=3D0.004|SMRC=3D0.319(=
SMRCL=3D0.102|X-SMRCR=3D0.317))|CAT=3D0.076(CATOS=3D0.001
 |CATRESL=3D0.024(CATRESLP2R=3D0.018)|CATORES=3D0.048(CATRS=3D0.048(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.046)));2024-03-30T13:39:44.128Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 14115
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.026|SMR=3D0.025(SMRPI=3D0.022(SMRPI-FrontendProxyAgent=3D0.022))=
|SMS=3D0.001
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAW0NAAAPAAADH4sIAAAAAAAEAKVYbVMj=
xxFeISEJge58ji
 tx8iVT56oc+NArnH1HHMoHxAY72PgEvnNcLmpZDdIe0q68s0IhsX9h
 /lSe7p5ZrYCyXRVOB6vZnp7up59+2f3vxteR6vnpptpqq2M/Ud12d1
 v5qep0djpbm+rLJDTDyFdfThN/4qehOun1vvq2Xvvkx2kYnF/h7hXu
 fErfwihoBvF4V82SONU79dqugu6tVvdFi5V+tNPdUifHm+pgHKbJjd
 rzkxszvIqvcxt4y2dJuKm6LxbMab/Y6bbvmiN7fpsxu7vyW31zcNZp
 t9vq6OBEfd/5QQ19o3x1ejPRjUAFcRTpII0T5Ud9ZaaTSZykRp319t
 RWs920Kg7jmb7WiQpTlehRqI2KIzU1Fw3a3hhMwlj1k5Ak0hgSfl+l
 Q62uL6aG1YZ9q4ckn8jaJImvw75WSTzSyszCNBg2s3Not1UYTJNER+
 nohuy2auIIX0lXQywQB+A/YXQBfZNEG2xSYQSvVepjrale9vthNIBu
 P7V6cPvgVM3i6aivxtqP+J4crq/DQM/xYLT2bqEVxU7RbTCb6nToR1
 eG4LgT/ktsn8RhlJI1QDSepur77g+CtUQY8C+cFhpyKU1vlAnHk5He
 lEj4I4FFvZ2aFCaRsxM4BeNEz7d7Zz14OZmC8LNhGAxVmviRGfmpZt
 vSWaw+Pzn62qgLTdYksEX31WUSjwkGUXKe2XGOY40eXd42dZ8MHE+h
 fhwnmgMxCgMc0mdDyUI6aX+frJPw+7AN7Jgg4Ikowq2mOkpJFYBVOo
 qng6F4BksRHjOFbtGhRqDJyDTVMc6LQZNNqyOJJzphUKL+iDyyRAYI
 htjmW3vn0CYa+QO64JbREz+B1aLrSZyE4BAYFUdPgPsg8keMmR6NmC
 PDGKZZVOHdyI80oYDFC43kIBxj6xuJkyW9nlVkiCHwP7T+qlEcDTTx
 whhmMOURBcMCMIszkEwWnpwXZBcWevF+PjaH/jVh4LPBPqfDOIwQlC
 Mw20ywVdZv4qnyAS7h3tcmSMIL2odla//QT/ozknAAN1kFksPouYqh
 f61dZUGYkDhkYYoMH8G1lqhKtE3sls16x0wOGRBEhBE5XIBG42lEPE
 IEmDRwMcoCTdXDEONbQnMLrIOCogMrI5gJ5b4KfIO0Qe7gr+iwnpID
 iMHp/sk+AUR7URQuQwSBzkQgifX56mLSBPCIEsQjpXoXX6rHXJGCeU
 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
 NrdXJhQHF1aWNpbmMuY29tPC9FbWFpbFN0cmluZz4NCiAgICA8L0Vt
 YWlsPg0KICA8L0VtYWlscz4NCjwvRW1haWxTZXQ+AQyOBTw/eG1sIH
 ZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPENvbnRh
 Y3RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KIC
 A8Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRleD0iMTE0
 IiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxQZXJzb24gU3
 RhcnRJbmRleD0iMTE0IiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAg
 ICAgICAgPFBlcnNvblN0cmluZz5EbWl0cnkgQmFyeXNoa292PC9QZX
 Jzb25TdHJpbmc+DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFp
 bHM+DQogICAgICAgIDxFbWFpbCBTdGFydEluZGV4PSIxOTYiIFBvc2
 l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgICAgIDxFbWFpbFN0cmlu
 Zz5xdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPC9FbWFpbFN0cmluZz
 4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAg
 ICAgPENvbnRhY3RTdHJpbmc+RG1pdHJ5IEJhcnlzaGtvdiB3cm90ZT
 oNCiZndDsgJmd0OyBPbiBGcmksIDI5IE1hciAyMDI0IGF0IDA5OjIw
 LCBLcmlzaG5hIEt1cmFwYXRpDQomZ3Q7ICZndDsgJmx0O3F1aWNfa3
 Jpc2t1cmFAcXVpY2luYy5jb208L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0Pg
 EOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwxO1JldHJpZXZlck9wZXJh
 dG9yLDExLDM7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDE7UG9zdE
 RvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDEwLDM7UG9zdFdvcmRCcmVha2VyRGlhZ2
 5vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVj ZXIsMjAsMjQ=3D
X-MS-Exchange-Forest-IndexAgent: 1 4544
X-MS-Exchange-Forest-EmailMessageHash: 1F8AF30C
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Sat, 30 Mar 2024 at 11:13, Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
> On 3/29/2024 6:23 PM, Dmitry Baryshkov wrote:
> > On Fri, 29 Mar 2024 at 09:20, Krishna Kurapati
> > <quic_kriskura@quicinc.com> wrote:
> >>
> >> QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
> >> However it relies on usb-conn-gpio driver to read the vbus and id
> >> gpio's and provide role switch. However the driver currently has
> >> only gpio-b-connector compatible present in ID table. Adding that
> >> in DT would mean that the device supports Type-B connector and not
> >> Type-c connector. Thanks to Dmitry Baryshkov for pointing it out [2].
> >
> > USB-B connector is pretty simple, it really has just an ID pin and
> > VBUS input, which translates to two GPIOs being routed from the
> > _connector_ itself.
> >
> > USB-C is much more complicated, it has two CC pins and a VBus power
> > pin. It is not enough just to measure CC pin levels. Moreover,
> > properly handling USB 3.0 inside a USB-C connector requires a separate
> > 'orientation' signal to tell the host which two lanes must be used for
> > the USB SS signals. Thus it is no longer possible to route just two
> > pins from the connector to the SoC.
> >
> > Having all that in mind, I suspect that you are not describing your
> > hardware properly. I suppose that you have a Type-C port controller /
> > redriver / switch, which handles CC lines communication and then
> > provides ID / VBUS signals to the host. In such a case, please
> > describe this TCPC in the DT file and use its compatible string
> > instead of "gpio-c-connector".
> >
>
> Hi Dmitry,
>
>   My bad. I must have provided more details of the HW.
>
>   I presume you are referring to addition of a connector node, type-c
> switch, pmic-glink and other remote endpoints like in other SoC's like
> SM8450/ SM8550/ SM8650.
>
>   This HW is slightly different. It has a Uni Phy for Super speed and
> hence no DP.

This is fine and it's irrelevant for the USB-C.

>   For orientation switching, on mobile SoC's, there is a provision for
> orientation gpio given in pmic-glink node and is handled in ucsi_glink
> driver. But on this version of HW, there is a USB-C Switch with its own
> firmware taking care of orientation switching. It takes 8 SS Lines and 2
> CC lines coming from connector as input and gives out 4 SS Lines (SS
> TX1/TX2 RX1/RX2) as output which go to the SoC. So orientation switch is
> done by the USB-C-switch in between and it automatically routes
> appropriate active SS Lane from connector to the SoC.

This is also fine. As I wrote, you _have_ the Type-C port controller.
So your DT file should be describing your hardware.

>   As usual like in other targets, the DP and DM lines from type-c
> connector go to the SoC directly.
>
>   To handle role switch, the VBUS and ID Pin connections are given to
> SoC as well. There is a vbus controller regulator present to provide
> vbus to connected peripherals in host mode.
>
>   There is no PPM entity (ADSP in mobile SoC's) and no UCSI involved
> here. Hence we rely on usb-conn-gpio to read the vbus/id and switch
> roles accordingly.

This is also fine.

You confirmed my suspicions. You have an external Type-C switch which
handles orientation (and most likely PD or non-PD power negotiation)
for you. It has GPIO outputs, etc.

But it is not a part of the connector. Instead of adding the
"gpio-usb-c-connector", add proper compatible string (see, how this is
handled e.g. by the spidev - it is a generic driver, but it requires
hardware-specific compatibles).
Your hardware description should look like:

typec {
    compatible =3D "your,switch";
    id-gpios =3D <&gpio 1>;
    vbus-gpios =3D <&gpio 2>;
    vbus-supplies =3D <&reg-vbus>;

    ports {
       #address-cells =3D <1>;
       #size-cells =3D <1>;
       port@0 {
          endpoint {
              remote-endpoint =3D <&usb_dwc3_hs_out>;
          };
       };
       port@1 {
          endpoint {
              remote-endpoint =3D <&usb_uni_phy_out>;
          };
      };
      /* No SBU port */
   };
};

Note, I haven't said anything regarding the driver. You can continue
using the usb-conn-gpio driver. Just add a compatible string for you
switch.

>
>   Hope this answers the query as to why we wanted to use usb-conn-gpio
> and why we were trying to add a new compatible.
>
> Regards,
> Krishna,
>
> >>
> >> This series intends to add that compatible in driver and bindings
> >> so that it can be used in QDU1000 IDP DT.
> >>
> >> [1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@qu=
icinc.com/
> >> [2]: https://lore.kernel.org/all/CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABF=
BcRt-9BQaCberg@mail.gmail.com/
> >>
> >> Krishna Kurapati (2):
> >>    dt-bindings: connector: Add gpio-usb-c-connector compatible
> >>    usb: common: usb-conn-gpio: Update ID table to add usb-c connector
> >>
> >>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +=
++
> >>   drivers/usb/common/usb-conn-gpio.c                             | 1 +
> >>   2 files changed, 4 insertions(+)
> >>
> >> --
> >> 2.34.1
> >>
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry


