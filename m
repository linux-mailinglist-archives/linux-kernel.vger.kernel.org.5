Return-Path: <linux-kernel+bounces-119175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403388C51E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71981C30C01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16312E1EA;
	Tue, 26 Mar 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWaMRUFH"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFE12DD95
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463267; cv=none; b=bZ4n6uRw8Yx+V1Q8n01GeLfGzHEzKf28TCQAGOc8s0+sE7NHEHqIKmicZt67DfZvMKYJkgAxdXbYgAPMc3HeGC3Dkg0PuEg0BWzvDa2zRgzhFStXzMcQz8maDJlIZefmH2jBYZA/yqAv05uS08XVbrscgozg86KU2bnD3ni4ACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463267; c=relaxed/simple;
	bh=JGMLiMEqo/ugZVNDsBHPJqbYVvBLqNX6oNDGExzL0/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEKf7EnmSJ9wx/r02Bc7k83Y16GPAB0w0ZhCX5nfCbn1TkKUkH/wuzI3B/AsJDMV35aQFv3WsopuTl7Gd6cio7fp9CgfH2SCvmnRB3a9efQ1S0jOryJ44fbqD55w9acczPpXIIv694qEiFi12v5DTEcf9UWUOVyZVcDDdfr59qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hWaMRUFH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a13117a3dso476462885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711463264; x=1712068064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoDdW4b3h35Fn8JvKyOiN549aSte5PnUw/1LIB5ClwU=;
        b=hWaMRUFHkLa9NRm4NhJzR1CyfQyaN+azCwc3FVrARq5y2VKdOPWAsLYLraS6OZTRMe
         RSyvWyijHdXz0ukBFz+6zZAnpZQFkjBC3PeRqHA2uhVgVkDr1iLRUcKiRAbMDeGVnb1H
         sxMhut42j8XanJuCepLWDNiMYue450cTjxGUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711463264; x=1712068064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDdW4b3h35Fn8JvKyOiN549aSte5PnUw/1LIB5ClwU=;
        b=vts0u3faSs6HCnkzijblmu+4B/osDbMWE2m8JeQyP5XHuM2i0WUoa7OBeQWQY/ewIi
         OQJJoulGgmwTlLgP/+pqYeyWq+M1IlhmQKwaaGnXprY/OqXDtyWC+aIQaKqTBBxGNm/C
         RIlj0o9n1sW4Bn8jImKnFBXpJb13H5QsUie/F5OP2NhLx1b3bS+a7gLb2t1MzamceeeL
         bbw3YUe6NCOzSgoNwEZio+4Q0zr46B7MYBAysMQUB1mJLyXWOfWTVtqBow5P6M/+o1sd
         4xBIdw70Oke2PHtnx/X0wP9IRPUVNX261uQC7bDST8hSFKhk0g92atRs7cwN3s3Z1/kf
         VYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxpdrVWFG7Sbe3S8eElFXe5rZ2pKozwVzEmNDAlyBwCSNCaIzG2FWEWZkva7O9kiHxrgd6WOJvFj2ZUS7OJSk1RCvpY+fc3X4Y7LCt
X-Gm-Message-State: AOJu0YygYoepvvYWhQFslP5gaaNQID5Z2srt6fK1L0kEosZPsQJUVaw6
	2eiNura2689EET9OH6Xko9ZI/BpCor+Z26OowqcM1/iQk2iRvHoudwiw5Al/zY+0ag5K6CRVTvB
	ZuQ==
X-Google-Smtp-Source: AGHT+IFEoEguH29ZALHMHTx1HxdeDyflsTpa0/NzgDvy39T8yJ6o5O0Eig12nggZ+zywd8/wTpe0Aw==
X-Received: by 2002:a05:620a:2611:b0:789:de1d:193a with SMTP id z17-20020a05620a261100b00789de1d193amr1997590qko.31.1711463264330;
        Tue, 26 Mar 2024 07:27:44 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id c9-20020a05620a134900b00788357d6759sm3055209qkl.11.2024.03.26.07.27.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:27:43 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6963c0c507eso55329936d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:27:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpHxVQYSLcFWWH2L0cirKRMWaeo2OUmKUGQJyTmjo/nCLhjN01ApFLmuxweBA7DqUcW0cg/hFDqAjx6uJ4GD7kQ1aVGZgpuX6jLD4b
X-Received: by 2002:a05:6214:27e1:b0:690:b479:527e with SMTP id
 jt1-20020a05621427e100b00690b479527emr2874535qvb.13.1711463263089; Tue, 26
 Mar 2024 07:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-obsbot-quirk-fix-relative-ptz-speed-v1-1-0eb1387d98c7@securitylive.com>
 <6e6b75a15cdc6a1239edc4d49b927b187ed20054.camel@irl.hu> <CAMB8T1ULcfBOB5VwZzUtvRnp4FvtBCFWxxTdb+OJK8FOpjKCXA@mail.gmail.com>
 <ec0430f6e687fc5e1a19338e381804b9d6aeabba.camel@irl.hu> <CAMB8T1Vv7CMqhH1ZY6fouxsE6r+6JbmeLnuFma_0_de814UoMA@mail.gmail.com>
 <CAMB8T1VWGaWtE0k5en4-xhE69G=OyFnhqJ3mexcgNSuvO_7uUQ@mail.gmail.com>
 <CANiDSCvGfA=B5YCQhSMRW-0cTQNWKGytQF74z9F_x-77WFPHpw@mail.gmail.com> <CAMB8T1W5K68fX4jw=V8+kqc8eT2HGCv75PAidO0Nkzy-A1jFAQ@mail.gmail.com>
In-Reply-To: <CAMB8T1W5K68fX4jw=V8+kqc8eT2HGCv75PAidO0Nkzy-A1jFAQ@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Mar 2024 15:27:25 +0100
X-Gmail-Original-Message-ID: <CANiDSCu7qRnySQn=YJ=pkOOYe50H89CDw_AGu287LfjWebnnYQ@mail.gmail.com>
Message-ID: <CANiDSCu7qRnySQn=YJ=pkOOYe50H89CDw_AGu287LfjWebnnYQ@mail.gmail.com>
Subject: Re: [PATCH] uvcvideo: Remo OBSBOT quirk fix for incorrect relative
 min pan/tilt/zoom speeds
To: John Bauer <john@oxt.co>
Cc: Gergo Koteles <soyer@irl.hu>, johnebgood@securitylive.com, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linh.tp.vu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John

On Tue, 26 Mar 2024 at 09:15, John Bauer <john@oxt.co> wrote:
>
> According to the spec bPanRelative and bTiltRelative are of "Signed
> Number" but bPanSpeed and bTiltSpeed are of "Number". I think this
> implies that a negative number is not possible for a minimum here.
>
> It is very beneficial that the direction and speed are condensed into
> one value, it greatly simplifies control as shown in a test I just did
> below.
>
> Here is a quick test I just did with the patch I'll be sending
> shortly: https://www.youtube.com/watch?v=3D1XqWPROw49s

That looks pretty cool :)

Thanks!

>
> Thanks,
> John
>
> On Tue, Mar 26, 2024 at 2:47=E2=80=AFAM Ricardo Ribalda <ribalda@chromium=
org> wrote:
> >
> > Hi Jon, Hi Gergo
> >
> > On Tue, 26 Mar 2024 at 07:23, John Bauer <john@oxt.co> wrote:
> > >
> > > After looking through the current implementation all of the proper ch=
ecks are done in the getter and setter for the pan/tilt/zoom controls so th=
e only change needed is the 2 locations to get/check/set the minimum when n=
eeded. Thankfully all the code that does the hard work is already implement=
ed. I'll be submitting another patch that summarizes our findings.
> >
> >
> > My issue with the spec is that it is not clear about what GET_MIN
> > should return.  Is it the minimum absolute value for that control, or
> > the minimum value in that direction?
> >
> > In other words, can we have a device with a range (-10,20) (-A,B), or
> > only (-20,20) (-A,A) is allowed.
> >
> > If there is no device that supports (-A,B), then we do not need a quirk=
.
> >
> > Regards!
> >
> >
> > >
> > > Thanks,
> > > John
> > >
> > >
> > >
> > > On Mon, Mar 25, 2024 at 10:42=E2=80=AFPM John Bauer <john@oxt.co> wro=
te:
> > >>
> > >> Ok, I get you now Gergo, I think I got lucky and I think you're righ=
t! Digging into the UVC 1.5 spec I can see why this works, the first byte i=
n each 2 byte pair signifying the direction is just getting the signed bit =
set when a negative value is applied to both bytes so there should probably=
 be some checks.
> > >>
> > >> Here from the UVC 1.5 spec:  CT_PANTILT_RELATIVE_CONTROL
> > >> +--------+---------------+------+---------------+-------------------=
-----------------------------+
> > >> | Offset |     Field     | Size |     Value     |                  D=
escription                   |
> > >> +--------+---------------+------+---------------+-------------------=
-----------------------------+
> > >> |      0 | bPanRelative  |    1 | Signed Number | 0: Stop, 1: clockw=
ise, 0xFF: counter-clockwise |
> > >> |      1 | bPanSpeed     |    1 | Number        | Speed of the Pan m=
ovement                      |
> > >> |      2 | bTiltRelative |    1 | Signed Number | 0: Stop, 1: tilt u=
p, 0xFF: tilt down           |
> > >> |      3 | bTiltSpeed    |    1 | Number        | Speed for the Tilt=
 movement                    |
> > >> +--------+---------------+------+---------------+-------------------=
-----------------------------+
> > >>
> > >> I think it is the direction of the original implementation which is =
way easier to use than having 2 controls anyway, I would say it's preferred=
, it's how I have all my analog stick controls mappings.
> > >>
> > >> While the OBSBOT firmware implementation may handle any signed negat=
ive value in the direction byte we should probably check and make sure it c=
onforms to spec with 0xFF for counter clockwise and down.
> > >>
> > >> In the current implementation both pan and tilt each use 2 bytes:
> > >>
> > >> {
> > >> .id =3D V4L2_CID_PAN_SPEED,
> > >> .entity =3D UVC_GUID_UVC_CAMERA,
> > >> .selector =3D UVC_CT_PANTILT_RELATIVE_CONTROL,
> > >> .size =3D 16,
> > >> .offset =3D 0,
> > >> .v4l2_type =3D V4L2_CTRL_TYPE_INTEGER,
> > >> .data_type =3D UVC_CTRL_DATA_TYPE_SIGNED,
> > >> .get =3D uvc_ctrl_get_rel_speed,
> > >> .set =3D uvc_ctrl_set_rel_speed,
> > >> },
> > >> {
> > >> .id =3D V4L2_CID_TILT_SPEED,
> > >> .entity =3D UVC_GUID_UVC_CAMERA,
> > >> .selector =3D UVC_CT_PANTILT_RELATIVE_CONTROL,
> > >> .size =3D 16,
> > >> .offset =3D 16,
> > >> .v4l2_type =3D V4L2_CTRL_TYPE_INTEGER,
> > >> .data_type =3D UVC_CTRL_DATA_TYPE_SIGNED,
> > >> .get =3D uvc_ctrl_get_rel_speed,
> > >> .set =3D uvc_ctrl_set_rel_speed,
> > >> },
> > >>
> > >> Going to do some testing and report back.
> > >>
> > >> Thanks,
> > >> John
> > >>
> > >>
> > >>
> > >> On Mon, Mar 25, 2024 at 9:23=E2=80=AFPM Gergo Koteles <soyer@irl.hu>=
 wrote:
> > >>>
> > >>> Hi John,
> > >>>
> > >>> On Mon, 2024-03-25 at 20:51 -0500, John Bauer wrote:
> > >>>
> > >>> I understand this patch might not be the ideal or proper solution; =
but it works. I don't think the UVC
> > >>> implementation can be trusted on these cameras, just like the Windo=
ws DirectShow implementation is off.
> > >>> I put this patch out there as I have encountered many Linux users w=
ho are struggling to get proper
> > >>> control of these awesome cameras. If the patch dies here for now, t=
hat's OK, at least there's a possible
> > >>> patch for those in need.
> > >>>
> > >>>
> > >>> Sorry, maybe I didn't phrase it well. Based on the UVC specs, I thi=
nk your patch is good for all UVC PTZ cameras, so you don't need to use UVC=
_QUIRK_OBSBOT_MIN_SETTINGS quirk entry, just apply the quirk changes to all=
 cameras.
> > >>>
> > >>> Thanks for doing this!
> > >>>
> > >>> Regards,
> > >>> Gergo
> > >>>
> >
> >
> > --
> > Ricardo Ribalda



--=20
Ricardo Ribalda

