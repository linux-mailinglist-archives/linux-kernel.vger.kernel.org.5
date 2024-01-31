Return-Path: <linux-kernel+bounces-46739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF8E84436A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F41BB22915
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338FB12A14C;
	Wed, 31 Jan 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGN10B/1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9C433CB;
	Wed, 31 Jan 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716354; cv=none; b=nGt3mWcewYwn/t5S9MeJMc1eYcERZriEH0Jt2X9zuAk19FSxO7URPktWqLCJqj6Qh8k12ZFOPmRH0dLLZV8jS4KWid55iaYIcohXNIO3aoo0h5XQr2cx2/UMRSEeLo95VZzeR2bERFjR96Mis/L+cbIi/Iw7iMErSQOoJ5zJG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716354; c=relaxed/simple;
	bh=gh7UgQTt1upM52DH9/brHa41xulwVb6hdMi49LlFaU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICypWAs3r25YJdCC9IrU7jv0Oe7phJg7LKjPaY1oMMs+ahoL09NlVNyxQdqmMmzriE/CyFAN2RKmO41y5cRGVEgxg/aI6UvRTtP53NLjBFd0s17uGoehsS+4rhNidxs7zaxwEkcpxqnI2T5wyxzgQKER6HxKKPmh6FobbntZn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGN10B/1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51124d43943so1218734e87.2;
        Wed, 31 Jan 2024 07:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716350; x=1707321150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQX3o9OdnVWodXK7XnVqKIBMgmyYUG9SCf1DG/2FOUc=;
        b=KGN10B/1Q2izJ7khreM+avVzPxttmnrQ0fWfhHKlJH37fb0c3IGfzA+Vhr8gTudMpR
         Mm+UN2/Ew0y2ad4QbrJzkqhVQXj6koccU5ukHsXH1rydGRma1ylWaQc+TbB+ImEH0VC2
         DLO8D1TIeYsWvNNjdzXZB6Cap31gg1O6WQrCiWvUavYlqfSmQnkaR2YsOcQ9XHVWiYq9
         VxHTPR+PV7wjZ2VrAuoJkME/eUCucPA0dtSF6uOmLipkMbXvzfLGTemDW1PFplD2c5nq
         NPrPSubPsk7oHXi94Fj9Y0Phb3EUxrIDa/q0CpxRBfbmxPqMAhgxaK+PP/P0HE3HHthx
         FGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716350; x=1707321150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQX3o9OdnVWodXK7XnVqKIBMgmyYUG9SCf1DG/2FOUc=;
        b=KqAwN9l4C3i/DZIlxvb06SKiUD9DwRLn48zVE6250ml48wCpcOdAFOt8e9GcbOWSQp
         HkHrtp9neg6ijTQV4LXL5D6MRMd5bWIJFWCDEFfD7A4JILV7kS9O2tW5+RanAGwe1S6T
         rczRzNHWn5eKE+OKMRy955jp9bWhqLuykGudFHWaNOtUoKB22gzKfxy289K6Uhjc0hfO
         8h0/iO/ZAwYLLOcrptlt51Vh0xyplHmjEhL2RZdEBcLAa6LpcBvY5AcxSW2iy5mFFQnx
         SqOpOHCxIm/v7G3y4liQZzu64WDqfX8XoZRpBYxMrEASuYieiml+SmtKfRHDmisONEXT
         +rgg==
X-Gm-Message-State: AOJu0Yx4sYe9BfuV+q0Cnd2e74wMIdytWxPerJlDRE8nkLdAqkFUO9jG
	jZT+nWyQPoVYoQ6okVx4xhIP40YOn2lTcbs53vYUQkjkFl+3UHKwIDTSGF0OXDeNus4u85LV6s+
	lgPrmD5y3ymusTg5R4VkMC1Ea5cw=
X-Google-Smtp-Source: AGHT+IHGgRpeCu9yNBRtA4a5mdEUPe6rJOKy5MddfQNAEf49HG41vyeNWWjwuxEzNvIAJhfV9seBWUCZ2kKje+jEW6w=
X-Received: by 2002:a05:651c:10c9:b0:2d0:4fbb:7bfd with SMTP id
 l9-20020a05651c10c900b002d04fbb7bfdmr1431157ljn.10.1706716349820; Wed, 31 Jan
 2024 07:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz> <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com> <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com> <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz> <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com> <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com> <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com> <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com> <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
In-Reply-To: <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 31 Jan 2024 07:52:17 -0800
Message-ID: <CAEc3jaDsv0hv8gcqsMdcrMf4WK-Nq0LMgPcVHzv87x+J0M=V2Q@mail.gmail.com>
Subject: Re: Future handling of complex RGB devices on Linux
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	jikos@kernel.org, linux-kernel@vger.kernel.org, 
	Jelle van der Waa <jelle@vdwaa.nl>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-input@vger.kernel.org, 
	ojeda@kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:42=E2=80=AFAM Werner Sembach <wse@tuxedocomputers=
com> wrote:
>
> Hi,
>
> so I combined Hans last draft, with the discussion since then and the com=
ments
> from the OpenRGB maintainers from here
> https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916 and my own exper=
ience
> and came up witrh this rough updated draft for the new uapi:
>
> Future handling of complex RGB devices on Linux:
>
> Optional: Provide a basic leds-subsystem driver:
>      - The whole device is treated as a singular RGB led in the current l=
eds uapi
>          - Backwards compatibility
>          - Have something work out-of-the-box and during boot time
>      - The driver also registers a misc device with a singluar sysfs attr=
ibute
> select_uapi
>          - reading this gives back "[leds] none"
>          - the current active uapi can be selected by writing it to that =
attribute
>          - switching the uapi means deregistering the device from that en=
tirely
> and registering and initializing it with the new one froms scratch
>          - selecting none only does the deregistering
>
> If the device is already reachable by userspace directly, e.g. via hidraw=
, the
> kernel will only offer this basic implementation and a more complex drive=
r has
> to be implemented in userspace.
>      - This driver has to use the select_uapi attribute first and select =
"none"
> to avoid undefined behaviour caused by accessing the leds upai and hidraw=
 to
> control the lighting at the same time
>      - Question: How to best associate the select_uapi attribute to the
> corresponding hidraw (or other) direct access channel? So that a userspac=
e
> driver can reliable check whether or not this has to be set.
>
> Devices not reachable by userspace directly, e.g. because they are contro=
led via
> a wmi interface, can also be implemented in the new rgbledstring-subsyste=
m
> (working title) for more complex control
>      - a rgbledstring device provides an ioctl interface (ioctl only no r=
/w)
> using /dev/rgbledstring0, /dev/rgbledstring1, etc. registered as a misc c=
hardev.
>          - get-device-info ioctl which returns in a single struct:
>              - char name[64]                     /* Device model name /
> identifier, preferable human readable. For keyboards, if known to the dri=
ver,
> physical layout (or even printed layout) should be separated here */
>              - enum device_type                  /* e.g. keyboard, mouse,
> lightbar, etc. */
>              - char firmware_version_string[64]  /* if known to the drive=
r,
> empty otherwise */
>              - char serial_number[64]            /* if known to the drive=
r,
> empty otherwise */
>              - enum supported_modes[64]          /* modes supported by th=
e
> firmware e.g. static/direct, breathing, scan, raindrops, etc. */
>          - get-mode-info icotl, RFC here: Hans thinks it is better to hav=
e the
> modes and their inputs staticly defined and have, if required, something =
like
> breathing_clevo_1, breathing_clevo_2, breathing_tongfang_1 if the inputs =
vary
> between vendors. I think a dynamic approach could be useful where userspa=
ce just
> queries the struct required for each individual mode.
>              - input: a mode from the supported_modes extracted from get-=
device-info
>              - output: static information about the mode, e.g.
> max_animation_speed, max_brightness, etc.
>              - output: the struct/a list of attributes and their types re=
quired
> to configure the mode
>          - set-mode ioctl takes a single struct:
>              - enum mode                         /* from supported_modes =
*/
>              - union data
>                  - char raw[3072]
>                  - <all structs returned by get-mode-info>
>          - The driver also registers a singluar sysfs attribute select_ua=
pi
>              - reading this gives back "[leds] rgbledstring none" or
> "[rgbledstring] none" respectifly
>              - Discussion question: should select_uapi instead be use_led=
s_uapi
>                  - if 1: use basic leds driver
>                  - if 0: if device is userspace accessible no kernel driv=
er is
> active, if device ist not userspace accessible register rgbledstring (aka
> implicit separation between rgbledstring and none instead of explicit one=
)
>
> Zone configuration would be seen as a subset of mode configuration, as I =
suspect
> not every mode needs the zone configuration even on devices that offer it=
?
>
> The most simple mode would be static/direct and the set-mode struct would=
 look
> like this:
> {
>      enum mode, /* =3D static */
>      {
>          uint8 brightness, /* global brightness, some keyboards offer thi=
s */
>          uint8 color[<number_of_leds>*3]
>      }
> }
>
> Question: Are there modes that have a separate setup command that is only
> required once and then a continuous stream of update information? If yes,=
 should
> we reflect that by splitting set-mode into set-mode-setup and set-mode-up=
date
> (with get-mode-info returning one struct for each)? Or should userspace j=
ust
> always send setup and update information and it's up to the kernel driver=
 to
> only resend the setup command when something has changed? In the former c=
ase
> set-mode-update might be a noop in most cases.
>
> Discussion on this might also happen here:
> https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916#note_1751170108
>
> Regards,
>
> Werner
>
>

Hi Werner,

I don't have a particular opinion as I don't know too much about RGB
keyboards. I just want to provide some food for thought and provide
some extra context of other devices. Just to challenge the discussion
and make sure than any API is flexible enough as it is hard to change
kernel interfaces later on.

At Sony our PlayStation controllers historically had a variety of LEDs
whether basic indicator ones (e.g. used to pick a player number) as
well as RGB leds. The devices are all HID based, but we do custom
parsing in hid-playstation to break out them out through LED framework
(regular leds and leds-class-multicolor for RGB). They were a bit of a
nightmare for applications to discover as crawling sysfs isn't fun (we
wrote a lot of code for Android's input framework to do this for our
own peripherals, but others too).

I'm not entirely sure where your RGB proposal is headed, but if one of
the higher goals is making dealing with LEDs and input devices easier,
maybe this extra info helps some of the discussion.

Thanks,
Roderick Colenbrander

