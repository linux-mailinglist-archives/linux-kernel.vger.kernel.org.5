Return-Path: <linux-kernel+bounces-100689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C92879BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7A286C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1E1420C6;
	Tue, 12 Mar 2024 18:49:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E97433A3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269387; cv=none; b=Rjv7QwmCCCrL/wh6WNR7M14ybkYTuuD2fxGp37nhhhIUmSRDt3ptUmGL2hyYcNssjzgp3YE7xeQkuYoUXs6C/14sl62ZQRPirCssmffOnpiEfIkjXo+9kvVEMoIdudCG9RK5zMQnJ9MSPmCJQjhIY7/CiKONEE3vOkxbnFIngxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269387; c=relaxed/simple;
	bh=C2UpO1Vrql9j3LyDrX4w4b1Re3/Vft0wf2V8Hg/Sg+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BberJypnYNHZKRqAGTpU0un7uD2rFwwwj5mICqd4Zyw5+W6GV5pL9bS5lu0W7lnBKdv4hYrfkGV8Xth2cBhuHjSwzTY+lrKm6arrJsV/66tq3He++AAyxhzbLmL50cDZiyF34W1Qa/Q5BN7zhTLil3qAKN+o1Fgw9MP4nkdbyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rk7Bs-00050r-0v; Tue, 12 Mar 2024 19:49:32 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rk7Br-005y4v-7Q; Tue, 12 Mar 2024 19:49:31 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rk7Br-00E7ri-0S;
	Tue, 12 Mar 2024 19:49:31 +0100
Date: Tue, 12 Mar 2024 19:49:31 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2] uvc_video: check for fid change early in decode_start
 and avoid wrong error counting
Message-ID: <ZfCju80gnglLNB6N@pengutronix.de>
References: <20240221-uvc-host-video-decode-start-v2-1-88c6e17e487a@pengutronix.de>
 <CANiDSCtCse74oK_nCcJXRRQ__RnAAfYEFzfftty58stsFVKoYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WfC7h8bH4szX/i/z"
Content-Disposition: inline
In-Reply-To: <CANiDSCtCse74oK_nCcJXRRQ__RnAAfYEFzfftty58stsFVKoYg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--WfC7h8bH4szX/i/z
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 07:20:53PM +0100, Ricardo Ribalda wrote:
>Hi Michael
>
>So if my understanding is correct, what you want to achieve is to
>avoid double stats_decode when the function returns -EAGAIN.
>
>Wouldn't it be simpler to simply move uvc_video_clock_decode() and
>uvc_video_stats_decode() before
>
>stream->last_fid =3D fid;
>
>just at the end of the function? Or am I missing something?
>
>Besides being a small and documented function,
>uvc_video_decode_start() is difficult to follow :), So I might be
>saying something stupid

No, there is nothing stupid. I tested the changed patch. And it works as
expected. So thanks for the review and the extra mile. I will send v3 now.

Regards,
Michael

>On Sat, 24 Feb 2024 at 23:52, Michael Grzeschik
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
>> Changes in v2:
>> - Moved the EAGAIN bailout after the sequence handling as mentioned by R=
icardo Ribalda
>> - Link to v1: https://lore.kernel.org/r/20240221-uvc-host-video-decode-s=
tart-v1-1-228995925c70@pengutronix.de
>> ---
>>  drivers/media/usb/uvc/uvc_video.c | 64 +++++++++++++++++++-------------=
-------
>>  1 file changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/u=
vc_video.c
>> index 7cbf4692bd875..af368c45c4297 100644
>> --- a/drivers/media/usb/uvc/uvc_video.c
>> +++ b/drivers/media/usb/uvc/uvc_video.c
>> @@ -1068,6 +1068,15 @@ static int uvc_video_decode_start(struct uvc_stre=
aming *stream,
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
>> @@ -1076,20 +1085,34 @@ static int uvc_video_decode_start(struct uvc_str=
eaming *stream,
>>                 stream->sequence++;
>>                 if (stream->sequence)
>>                         uvc_video_stats_update(stream);
>> +
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
>>         }
>>
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
>> base-commit: e89fbb5bc21a10a0de2bb878d4df09f538dc523b
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

--WfC7h8bH4szX/i/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXwo7gACgkQC+njFXoe
LGT2mw/+MIQQZbPBgQCfvfV1yeQzgW0prVNIVHy/leCAxMmhPbHM+AQ44Z4jDjB/
KzBS/06wvwzmvQTVLE6fBjzq1Oq8dZdkQ+ZuWxbb0zteAsunr/j3iVCrAwqcyn4e
l7YnsTyjQdeK2ZfdwSxut3HirKr28CduF7SoUx21xxkJ4TlUrSyuumAHcvmYo0EO
0zx7aCvsJte7s++9s+ScKuK2Z/aAZPWBm/+ZM2q167UiCgG9bODb611cPQpRYPJM
2xKMTQ3iHV7ogk7OaQfOFMNbry+36bWqSEVM3/DxXRuRXFO79n2BGRGwgpxsMEvy
+eYNpZZxBnbujGW3XqW+nbDt/gwPmffxmxCMxn1FmPX2HYTXTtwFhjOSrVGI/9bk
nXOwbWrqY/oEY7rpf9eY5ujVJ20Bj/rxpeM9Xbrokdy+mTlRbOVezd0jB4diaqJJ
07lCAJLQ9YeatyEVnxcZjvaSmFkNiSpppkoVkR+YofHEOdD0KuTqqMr0HZkopj6b
dWACIxjs3QzCgqrFpd1AO7VopyDSZJ4prH1sJVs9Rr0KSBZaXQHneTLLiOTnCjgl
wsLEXbxIEWxYBZwzAkgbDZ0/eCfarONeAMQn+G1b3cs+x9mk1Z4JsPpep9B4kIYj
qVWA6pwyaSzVMfF+NOdZwYtJlYenvBBWBf8JOWEZVym4EbwH9lM=
=u9ci
-----END PGP SIGNATURE-----

--WfC7h8bH4szX/i/z--

