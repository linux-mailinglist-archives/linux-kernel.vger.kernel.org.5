Return-Path: <linux-kernel+bounces-79892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C08862802
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942191F219A2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB004E1C6;
	Sat, 24 Feb 2024 22:48:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394C12B82
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814885; cv=none; b=O/DLa7dbdQotvXYDdCL5ExS9Vmv+EbMLUl63c59ncm5bCUJDc+j2PbPVfVlVNooWY81UMD+ThMHXNpTwEfqUP+N11ShhyoXlRwn/wW0WiLSdX6HyoBMH8Q/ECz8ElU7teSERYE8FfW9Qie5QCfYQ/3BBuhIX7qxBVrsc7ztiLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814885; c=relaxed/simple;
	bh=gYI/oF7Q3flur3e/UsUzCZlkvHTwJOcmRVYlQ1nGFL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMz7riT0uoC8W1kx6r/A/kTvBQAoWLmKeYVqT5PCYKBCYYcQ0z+YrtdduQKwYlNGHWhKSdjE5XRlhAZtiZMEz5r0o6SjgKkOlnK+zTYpHTSvslrAJVuLe6dxBnXcYtRaM41uGtYwTi43a4E5gcwNPJOz3F7EoQt/LAXpBHuj8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1re0oD-0002H7-Sz; Sat, 24 Feb 2024 23:47:53 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1re0oD-002gyz-1I; Sat, 24 Feb 2024 23:47:53 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1re0oC-005s4W-33;
	Sat, 24 Feb 2024 23:47:52 +0100
Date: Sat, 24 Feb 2024 23:47:52 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] uvc_video: check for fid change early in decode_start
 and avoid wrong error counting
Message-ID: <ZdpyGPMIY5K02nmj@pengutronix.de>
References: <20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de>
 <CANiDSCtFRugwLX-9jLUwkvxxvO2EFZES6899qcdfnoeQwX3fOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2qYFMPS5AWAZrko"
Content-Disposition: inline
In-Reply-To: <CANiDSCtFRugwLX-9jLUwkvxxvO2EFZES6899qcdfnoeQwX3fOQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--x2qYFMPS5AWAZrko
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ricardo

On Fri, Feb 23, 2024 at 03:09:39PM +0100, Ricardo Ribalda wrote:
>In your code when is  uvc_video_stats_update() called or
>stream->sequence incremented in normal use case?
>
>I might be interpreting it wrong, but it seems like if buf->bytesused
>is !=3D0 that code is never called.

Doh, Seems I missed that.

I will move the condition behind the sequence handling code.
Thanks for pointing this out.

Michael

>On Wed, 21 Feb 2024 at 23:53, Michael Grzeschik
><m.grzeschik@pengutronix.de> wrote:
>>
>> When the uvc request will get parsed by uvc_video_decode_start it will
>> leave the function with -EAGAIN to be restarted on the next frame. While
>> the first wrong parse the statistics will already be updated with
>> uvc_video_stats_decode.
>>
>> One value e.g. is the error_count, which therefor will be incremented
>> twice in case the fid has changed on the way. This patch fixes the
>> unnecessary extra parsing by returning early from the function when the
>> fid has changed.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> ---
>>  drivers/media/usb/uvc/uvc_video.c | 64 +++++++++++++++++++-------------=
-------
>>  1 file changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/u=
vc_video.c
>> index 7cbf4692bd875..fce5349b5f9fa 100644
>> --- a/drivers/media/usb/uvc/uvc_video.c
>> +++ b/drivers/media/usb/uvc/uvc_video.c
>> @@ -1068,11 +1068,43 @@ static int uvc_video_decode_start(struct uvc_str=
eaming *stream,
>>
>>         fid =3D data[1] & UVC_STREAM_FID;
>>
>> +       /*
>> +        * Store the payload FID bit and return immediately when the buf=
fer is
>> +        * NULL.
>> +        */
>> +       if (buf =3D=3D NULL) {
>> +               stream->last_fid =3D fid;
>> +               return -ENODATA;
>> +       }
>> +
>>         /*
>>          * Increase the sequence number regardless of any buffer states,=
 so
>>          * that discontinuous sequence numbers always indicate lost fram=
es.
>>          */
>>         if (stream->last_fid !=3D fid) {
>> +               /*
>> +                * Mark the buffer as done if we're at the beginning of =
a new frame.
>> +                * End of frame detection is better implemented by check=
ing the EOF
>> +                * bit (FID bit toggling is delayed by one frame compare=
d to the EOF
>> +                * bit), but some devices don't set the bit at end of fr=
ame (and the
>> +                * last payload can be lost anyway). We thus must check =
if the FID has
>> +                * been toggled.
>> +                *
>> +                * stream->last_fid is initialized to -1, so the first i=
sochronous
>> +                * frame will never trigger an end of frame detection.
>> +                *
>> +                * Empty buffers (bytesused =3D=3D 0) don't trigger end =
of frame detection
>> +                * as it doesn't make sense to return an empty buffer. T=
his also
>> +                * avoids detecting end of frame conditions at FID toggl=
ing if the
>> +                * previous payload had the EOF bit set.
>> +                */
>> +               if (buf->bytesused) {
>> +                       uvc_dbg(stream->dev, FRAME,
>> +                               "Frame complete (FID bit toggled)\n");
>> +                       buf->state =3D UVC_BUF_STATE_READY;
>> +                       return -EAGAIN;
>> +               }
>> +
>>                 stream->sequence++;
>>                 if (stream->sequence)
>>                         uvc_video_stats_update(stream);
>> @@ -1081,15 +1113,6 @@ static int uvc_video_decode_start(struct uvc_stre=
aming *stream,
>>         uvc_video_clock_decode(stream, buf, data, len);
>>         uvc_video_stats_decode(stream, data, len);
>>
>> -       /*
>> -        * Store the payload FID bit and return immediately when the buf=
fer is
>> -        * NULL.
>> -        */
>> -       if (buf =3D=3D NULL) {
>> -               stream->last_fid =3D fid;
>> -               return -ENODATA;
>> -       }
>> -
>>         /* Mark the buffer as bad if the error bit is set. */
>>         if (data[1] & UVC_STREAM_ERR) {
>>                 uvc_dbg(stream->dev, FRAME,
>> @@ -1124,29 +1147,6 @@ static int uvc_video_decode_start(struct uvc_stre=
aming *stream,
>>                 buf->state =3D UVC_BUF_STATE_ACTIVE;
>>         }
>>
>> -       /*
>> -        * Mark the buffer as done if we're at the beginning of a new fr=
ame.
>> -        * End of frame detection is better implemented by checking the =
EOF
>> -        * bit (FID bit toggling is delayed by one frame compared to the=
 EOF
>> -        * bit), but some devices don't set the bit at end of frame (and=
 the
>> -        * last payload can be lost anyway). We thus must check if the F=
ID has
>> -        * been toggled.
>> -        *
>> -        * stream->last_fid is initialized to -1, so the first isochrono=
us
>> -        * frame will never trigger an end of frame detection.
>> -        *
>> -        * Empty buffers (bytesused =3D=3D 0) don't trigger end of frame=
 detection
>> -        * as it doesn't make sense to return an empty buffer. This also
>> -        * avoids detecting end of frame conditions at FID toggling if t=
he
>> -        * previous payload had the EOF bit set.
>> -        */
>> -       if (fid !=3D stream->last_fid && buf->bytesused !=3D 0) {
>> -               uvc_dbg(stream->dev, FRAME,
>> -                       "Frame complete (FID bit toggled)\n");
>> -               buf->state =3D UVC_BUF_STATE_READY;
>> -               return -EAGAIN;
>> -       }
>> -
>>         stream->last_fid =3D fid;
>>
>>         return data[0];
>>
>> ---
>> base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
>> change-id: 20240221-uvc-host-video-decode-start-af53df5924cd
>>
>> Best regards,
>> --
>> Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>>
>
>
>--=20
>Ricardo Ribalda
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--x2qYFMPS5AWAZrko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXachYACgkQC+njFXoe
LGR7cQ/+IdpAKLFSjhM/90y2EbwBhsibkUq+JEt5rb94vKK9OyjLn5KO2pBeU5i3
NIvGb3+St11nQ8noybsdCJElALUZ5mZijeZJ4FElI99dnY/7vuv4H00/bAZCyg84
Ga/2cUUuzMORKVdeixCvEsZGeegytoUYri/OgOaAeMssGUAoSFhDbhd6d2hybfUf
a+j9/+nPgt9DA0nJZgCn1KBS3TWXBYBZUfE0XAOGdr7W4PSjhWqpws6fSu4PQNJJ
mMQR37+2MlaZ2lXCp2bmsyCLjDlPcF6rAhqdFMTAcyMyFxO8KTjMEi4kCmDTufeJ
ow/ep4cgjBndaQL2hhftE0YZ77XEGwFeBmsZIBzVGdwJE1xWz1Nf57vg+rqofSGG
tYIalgJgdGY14lhEtIfyZ9zib1ouIlpk2KPtqkjWvHkI83jIrLkkt/p4lAifhYtt
kBp5tXV1d/JjK5G6IbRWqAEgEneswehIarmwVWLgXyMYStfF9fC/pPhKZt+uTckp
Vn7eCpfyIpu5JMWAiVWD9MjvtpfK3pMMvww5xO+rMhMW75KnBvYMhFASWUc0o1FP
rpOpgXv0fPbJvibsYW6HkTpj39gQ6HeZgYPRSPvSOlyaJtP7ANw8iubo518WWe0d
3BZYiXyLGxhVNa49gr11vYbyu+lnVFFBtRhzwh7+zZlbmkGzjVU=
=zn5T
-----END PGP SIGNATURE-----

--x2qYFMPS5AWAZrko--

