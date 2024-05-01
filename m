Return-Path: <linux-kernel+bounces-165586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2748B8E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E13282839
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8ADDA1;
	Wed,  1 May 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WXkDwuwU"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B518CA4E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581295; cv=none; b=H5WpImWAQlk4kz5AP1Hpvu2L5wvPHuaZYzv0/mSd3BaVE2kEiC/lznDQWlihoZ998WCbcHl7SoIrrQfB3kmLEheshhveBb+RDIfRDTxoKnzQCA3syoQjjg0yz6S+5A5nOIzZ0As8foY+lEoZN5Ux8cHGuiP4W/On1lUVmnBaPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581295; c=relaxed/simple;
	bh=HLRpuJW4wpmvXc3cjO2hjEdv0yZ1MmbzHnWkQZqqRVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSt6cJjf/xdOn1wUtSMHLl+4+jEYswY7hW7xmIRkdLqu+EqFGhS2yA0MC+FC+4ymjUJ3tArm32AYozr8E4wGvI2A0/U/FexcFM+If8rHDNVD05CH5XNMDO2w1Fub1VvF7V5RKlkLapXm1y+zBv5uZI0vX1RQZFBoBR6R13K/jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WXkDwuwU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61ab6faf179so69135207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714581293; x=1715186093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5m5Ft8ibLTazqZcd0FT8Mzs4EFYTDmw9YeSBSiXSp0=;
        b=WXkDwuwUFO20A0Qc2vzR7wjtnt54keY6Qcz3o7UvFHxZm4VdiH0kSVQzQMPjGASwKi
         zYFMQnikA0Jh4nGvTa+qcOzqlPKApAlsNtkT6xrSuoBysHTtf6Fh/H9ZQQ0nsd6ycr/w
         bo5MMWeNzay1Cm0ogv27zf3u9F3kfwguJX70I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714581293; x=1715186093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5m5Ft8ibLTazqZcd0FT8Mzs4EFYTDmw9YeSBSiXSp0=;
        b=SjRoRgCbYRIpTA+8wQhj5Wh0Yw1M58SeROeUrvouUhG/0oEMOut6R4g8qBR7zcdLXB
         Xddv3PFI7ayRZAdrEPpPUdrPg00kvAvqdjF5xJRwk3bONJpHXropsyH1txQRMQK/6Owh
         tEMwX+UusognK1OOr9Sppnx05dmPNB5EnOFrxSSOcraI0/GylSGXcyiJrMbwdEwHz3Wr
         OYqYnrbxeYnsmb6WEXmoEtUTEfGGh4IhlK5wVyrvH1ZV2Jc40Zd6WPhYumMuuqarB9Da
         SWsff9uPT6VJTplWPrsa6Qszi2n9G4/AcGdt4hoqA9RaCyF9bGdHH7K+P0hMYiUSDc2e
         eLow==
X-Forwarded-Encrypted: i=1; AJvYcCXqxG/neij3PLO67GCIfu/uF4meFzKVg+iOQBwRCmOfm3T5d+EJRTCkUM1kE+E2t+mssPWrIoMyNChctNQPm19lhkDWuD5Y0noVvxun
X-Gm-Message-State: AOJu0Yzi20Njri9NE+0eK7XrHbUngZUdxPC0HdRGoUIVQLLRIy1/3evH
	obsKrBDdTsxu6GkSGYMsQH+bzkWv9rsrXrxyecSsCRgr10TdnpBUO7odhdonn9iuVWOu63OHKgv
	N2kCWTzlH/L53WtVAfrFRzy2Cx9buFNlxkdEi
X-Google-Smtp-Source: AGHT+IExBD8RTBL8xum3e8Vc0foHDr1ntymyD24zXkO1pDy4EK+ZR53f24gPaF9yd/K4OBUlanMFViIAGl1MJIXUnoU=
X-Received: by 2002:a81:4c86:0:b0:617:cc94:31bf with SMTP id
 z128-20020a814c86000000b00617cc9431bfmr3068340ywa.50.1714581293231; Wed, 01
 May 2024 09:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
 <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
 <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com>
 <CANFp7mU2Chj_cZ_26kfM8TE1OToZzUeFKz61D7j-0ykMBQeG4A@mail.gmail.com> <CABBYNZJK6zyYYmi66prKMdF69HkwfhOvMeB0TnEcGYRLTTr2jw@mail.gmail.com>
In-Reply-To: <CABBYNZJK6zyYYmi66prKMdF69HkwfhOvMeB0TnEcGYRLTTr2jw@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 1 May 2024 09:34:41 -0700
Message-ID: <CANFp7mWWYmm9gPrsDBho3sDGu5q_fQztR+LJJUWQ_Faw0QRXFQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Archie Pusaka <apusaka@google.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 9:46=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Fri, Apr 26, 2024 at 1:04=E2=80=AFPM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > On Fri, Apr 26, 2024 at 2:08=E2=80=AFAM 'Archie Pusaka' via ChromeOS Bl=
uetooth
> > Upstreaming <chromeos-bluetooth-upstreaming@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Thu, 25 Apr 2024 at 03:05, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Archie,
> > > >
> > > > On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusaka@goog=
le.com> wrote:
> > > > >
> > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > >
> > > > > Sometimes we want the controller to not wake the host up, e.g. to
> > > > > save the battery. Add some debugfs knobs to force the wake by BT
> > > > > behavior.
> > > > >
> > > > > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> > > > >
> > > > > ---
> > > > >
> > > > >  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> > > > >  1 file changed, 19 insertions(+)
> > > > >
> > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.=
c
> > > > > index 8bede0a335668..846b15fc3c04c 100644
> > > > > --- a/drivers/bluetooth/btusb.c
> > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > @@ -873,6 +873,9 @@ struct btusb_data {
> > > > >         unsigned cmd_timeout_cnt;
> > > > >
> > > > >         struct qca_dump_info qca_dump;
> > > > > +
> > > > > +       bool force_enable_remote_wake;
> > > > > +       bool force_disable_remote_wake;
> > > > >  };
> > > > >
> > > > >  static void btusb_reset(struct hci_dev *hdev)
> > > > > @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interfac=
e *intf,
> > > > >
> > > > >         debugfs_create_file("force_poll_sync", 0644, hdev->debugf=
s, data,
> > > > >                             &force_poll_sync_fops);
> > > > > +       debugfs_create_bool("force_enable_remote_wake", 0644, hde=
v->debugfs,
> > > > > +                           &data->force_enable_remote_wake);
> > > > > +       debugfs_create_bool("force_disable_remote_wake", 0644, hd=
ev->debugfs,
> > > > > +                           &data->force_disable_remote_wake);
> > > > >
> > > > >         return 0;
> > > > >
> > > > > @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interf=
ace *intf, pm_message_t message)
> > > > >                 }
> > > > >         }
> > > > >
> > > > > +       if (!PMSG_IS_AUTO(message)) {
> > > > > +               if (data->force_enable_remote_wake) {
> > > > > +                       data->udev->do_remote_wakeup =3D 1;
> > > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &d=
ata->flags))
> > > > > +                               data->udev->reset_resume =3D 0;
> > > > > +               } else if (data->force_disable_remote_wake) {
> > > > > +                       data->udev->do_remote_wakeup =3D 0;
> > > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &d=
ata->flags))
> > > > > +                               data->udev->reset_resume =3D 1;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.44.0.769.g3c40516874-goog
> > > >
> > > > There is a D-Bus interface available to overwrite the wakeup settin=
g:
> > > >
> > > > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst=
#boolean-wakeallowed-readwrite
> > > >
> > > > Or do you want a master switch for it? On the other hand aren't we
> > > > getting into the rfkill area if you really want to switch off radio
> > > > activity while suspended? That seems like a better idea then just
> > > > disable remote wakeup.
> >
> > This DBUS api is different from the quirk this is introducing.
> >
> > The `Wake Allowed` field in D-bus controls whether we add the address
> > to the Classic Event Filter (HIDP) or LE Filter Accept List (HOGP) but
> > not whether we allow wake at the transport level (which is why
> > hdev->wakeup exists).
> >
> > This change specifically addresses a quirk with Realtek chipsets:
> > RTL8822/RTL8852 will do "global shutdown" and power off Bluetooth if
> > USB Remote Wake bit is not set. The USB remote_wake bit is normally
> > set by the USB stack based on whether device_may_wakeup(udev) =3D=3D tr=
ue.
> > This means that RTL88x2 will lose power around suspend/resume if there
> > are no wake capable devices connected.
> >
> > ChromeOS decided to use idle power and resume-time to determine
> > whether to allow remote wake or not for these chipsets and we want to
> > move this control to userspace so that we don't have to hold CHROMIUM
> > patches in the kernel applying this policy (we want udev rules
> > instead). RTL8852 gets force enabled remote wake because the
> > RESET_RESUME behavior of this chip would otherwise increase our resume
> > time >1s which breaks one of our platform requirements.
> >
> > The end-goal of these changes:
> > * We detect RTL8822 or RTL8852 with udev and apply the right policy.
> > * RTL8822 gets force_disable_remote_wake (idle power consumption too
> > high otherwise)
> > * RTL8852 gets force_enable_remote_wake (resume time too long otherwise=
)
>
> Got it, but the suggestion was to instead of using
> force_enable_remote_wake, which is sort of non-standard, why don't
> Chrome OS simply use rkill interface to tell the driver to shutdown?
> On resume then you can just unblock via rfkill that should have the
> same result as using force_enable_remote_wake, well except if there is
> a bug in the driver that is not handling rfkill as a 'global
> shutdown', but then you need to fix the driver not introduce yet
> another debugfs entry to bypass it.

Did you mean `force_disable_remote_wake`? rfkill will work for that
around system suspend. We preferred not to do it because we don't use
userspace suspend signals with Bluez today (preferring the kernel
suspend notifier).

`force_enable_remote_wake` still needs debugfs as rfkill can't force
an interface to stay awake as far as I know.

>
> > Hope this provides enough context for why this change is necessary.
> >
> > >
> > > Yes, the initial idea was a master switch.
> > > Thanks for your suggestions.
> > > Let me discuss it with Abhishek.
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > > Thanks,
> > > Archie
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups "ChromeOS Bluetooth Upstreaming" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> > > To post to this group, send email to chromeos-bluetooth-upstreaming@c=
hromium.org.
> > > To view this discussion on the web visit https://groups.google.com/a/=
chromium.org/d/msgid/chromeos-bluetooth-upstreaming/CAJQfnxHUW%2BMdJUp9VCrF=
2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ%40mail.gmail.com.
>
>
>
> --
> Luiz Augusto von Dentz

