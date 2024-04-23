Return-Path: <linux-kernel+bounces-155429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85A8AEA39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E81281A86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B313BAED;
	Tue, 23 Apr 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQAs3pWT"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940B13B7A3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885018; cv=none; b=XR/ioVhHDd3iRjIwbbW+KF/QSFUIXuCsVfqn5X7zTZs0vgQ7RZV7OF0Eh5oeJgQFrANJKSXBvGFP9WOeCTYCcJ9hiF6FrU2vgpMY/ooNTFGfKd8LT46c+5HGdl0+wLVDzwhCfX+76DqA5ZsQK2pJrTO7WhqlvDtYVk9qI/5CBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885018; c=relaxed/simple;
	bh=84AUFf0foJnSmBlX9HPAcRjtAjatYeA61J9LKrFXBnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVHu6w5pqlFRN0ZVAnxYUYWPIqD6uUVULmAFRJiKkxD2odRmbE1DWc7sqU+FQhC54XKS+pXEtC6uuVTF85/vZCH7XhHY4XZ5UZUgh4BQc6IhLIIhhVmrw1FTUmcC/Wk/qJKHVz4hA5dL3/hkVmUlCQwKOCgkSM5dqhhnCv/VPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQAs3pWT; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78edc0f9636so363876585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713885014; x=1714489814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c7sC01lqcDH+H4+0eNwjxUVDf+LGV3FDlIiOAhdlzg=;
        b=RQAs3pWT3I9U6Y2mTMFY+QK1hQgCkBYWUAwR7pNcUxisDYt2AMtnxnm20/EWg7GXcl
         CjjsXTUWNLWjtHL8ik2B+YO4qkvtvCU/c2HuiBtn4RjGLaSoeVwKNobwcFOQdQHkqWk1
         ZMJiymSNboFWR6CKwb8MR5ApigO5unRine0O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885014; x=1714489814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1c7sC01lqcDH+H4+0eNwjxUVDf+LGV3FDlIiOAhdlzg=;
        b=Cy9hSeS1oqFMMgZJN34rbv4FV+FDcSXSQs5MfgO//UH60JmbEBA6Z5/6UVc0OgDzm0
         loEoKpmcLKBqEw+D+okXv7kgfTqjfzE8YU8RlR8Ndk7xMe11v7tg+mI0rYUKe8t5XT3k
         eE0Z+4hWcl5Gezay9/Q5nSUEx2qwx7Owb8fbjczwZ/yLyYopoYqbgUngNCjDiCgp1ixy
         AWaR5RKgo/omiMOLygIZkkLZ3Uc/VmZMr5mCnvXtj//6Mq5C+xq0oGkCWsdUqXBDglai
         1k+jSSjmxqDeoY8ZgDzvYKIVtuk9VTsy+rCji54S/1vrcIo/jFlPcJsLpx6yc+75uNaL
         rRtw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQX9QA7vq9Ft51E1tRlOGsNmArhE9Wr1qUd2OhwfOodDKJdletLP/qk5KDD1vFtK9u2ckFTHDGF+FtiC8xMzSRjjDkuNviq5aBCmF
X-Gm-Message-State: AOJu0YysxdId0KOdz1fQlifuj3Kn6lxzz729+bqlecke+VcIeBVlfl7L
	x/X5DLodI6scXHc+y9DhsNXUic2RLpFQ0ew+vzM0Tw1w9b1rbNL5Ak+oFCcckPIHndXb0Y+lwHX
	xtlkm
X-Google-Smtp-Source: AGHT+IHP2cBnKHEVCv/gXdBZ1LGDeV9Q6NDMCvvoM/DoiZKDStqKWkgryL83CwOqzCrZfKU8pTUwuw==
X-Received: by 2002:a05:620a:6115:b0:790:89d3:13dd with SMTP id oq21-20020a05620a611500b0079089d313ddmr522306qkn.76.1713885014142;
        Tue, 23 Apr 2024 08:10:14 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id bl7-20020a05620a1a8700b0079089e69414sm111528qkb.65.2024.04.23.08.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:10:12 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434ffc2b520so206961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+3pNYSymhz/vW7lQ9667R2J72s3dqvFC+JAuw9WKRk/QI/Kjan1e0r7Vl6+JjjdttNvXQ5LVtiS/We0soM4BgQo/L5g6MJtcdZgzS
X-Received: by 2002:ac8:568a:0:b0:439:f138:3691 with SMTP id
 h10-20020ac8568a000000b00439f1383691mr229060qta.19.1713885012110; Tue, 23 Apr
 2024 08:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com> <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
In-Reply-To: <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Apr 2024 08:09:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
Message-ID: <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 2:08=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Hi Doug and Janaki,
>
> On Mon, Apr 22, 2024 at 10:50:33AM -0700, Doug Anderson wrote:
> > On Tue, Apr 16, 2024 at 2:17=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
>
> > > As Chromium is the only known user of the 'local-bd-address' property=
,
> > > could you please confirm that your controllers use the 00:00:00:00:5a=
:ad
> > > address by default so that the quirk continues to be set as intended?
> >
> > I was at EOSS last week so didn't get a chance to test this, but I
> > just tested it now and I can confirm that it breaks trogdor. It
> > appears that trogdor devices seem to have a variant of your "default"
> > address. Instead of:
> >
> > 00:00:00:00:5a:ad
> >
> > We seem to have a default of this:
> >
> > 39:98:00:00:5a:ad
> >
> > ...so almost the same, but not enough the same to make it work with
> > your code. I checked 3 different trogdor boards and they were all the
> > same, though I can't 100% commit to saying that every trogdor device
> > out there has that same default address...
> >
> > Given that this breaks devices and also that it's already landed and
> > tagged for stable, what's the plan here? Do we revert? Do we add the
> > second address in and hope that there aren't trogdor devices out in
> > the wild that somehow have a different default?
>
> This patch is currently queued for 6.10 so there should be time to get
> this sorted.
>
> My fallback plan was to add further (device-specific) default addresses
> in case this turned out to be needed (e.g. this is what the Broadcom
> driver does).
>
> I assume all Trogdor boards use the same controller, WCN3991 IIUC, but
> if you're worried about there being devices out there using a different
> address we could possibly also use the new
> "qcom,local-bd-address-broken" DT property as an indicator to set the
> bdaddr quirk.

They all should use the same controller, but I'm just worried because
I don't personally know anything about how this address gets
programmed nor if there is any guarantee from Qualcomm that it'll be
consistent. There are a whole pile of boards in the field, so unless
we have some certainty that they all have the same address it feels
risky.


> We have Qualcomm on CC here so perhaps Janaki, who should have access to
> the documentation, can tell us what the default address on these older
> controllers looks like?
>
> Janaki, are there further default addresses out there that we need to
> consider?
>
> Perhaps "39:98" can even be inferred from the hardware id somehow (cf.
> bcm4377_is_valid_bdaddr())?
>
> Doug, could you please also post the QCA version info for Trogdor that's
> printed on boot?

You want this:

[    9.610575] ath10k_snoc 18800000.wifi: qmi chip_id 0x320
chip_family 0x4001 board_id 0x67 soc_id 0x400c0000
[    9.620634] ath10k_snoc 18800000.wifi: qmi fw_version 0x322102f2
fw_build_timestamp 2021-08-02 05:27 fw_build_id
QC_IMAGE_VERSION_STRING=3DWLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
[   14.607163] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target
0x00000008 chip_id 0x00000000 sub 0000:0000
[   14.616917] ath10k_snoc 18800000.wifi: kconfig debug 1 debugfs 1
tracing 0 dfs 0 testmode 1
[   14.625543] ath10k_snoc 18800000.wifi: firmware ver  api 5 features
wowlan,mfp,mgmt-tx-by-reference,non-bmi,single-chan-info-per-channel
crc32 3f19f7c1
[   14.682372] ath10k_snoc 18800000.wifi: htt-ver 3.87 wmi-op 4 htt-op
3 cal file max-sta 32 raw 0 hwcrypto 1
[   14.797210] ath: EEPROM regdomain: 0x406c
[   14.797223] ath: EEPROM indicates we should expect a direct regpair map
[   14.797231] ath: Country alpha2 being used: 00
[   14.797236] ath: Regpair used: 0x6c

..or this...

[   12.899095] Bluetooth: hci0: setting up wcn399x
[   13.526154] Bluetooth: hci0: QCA Product ID   :0x0000000a
[   13.531805] Bluetooth: hci0: QCA SOC Version  :0x40010320
[   13.537384] Bluetooth: hci0: QCA ROM Version  :0x00000302
[   13.543002] Bluetooth: hci0: QCA Patch Version:0x00000de9
[   13.565775] Bluetooth: hci0: QCA controller version 0x03200302
[   13.571838] Bluetooth: hci0: QCA Downloading qca/crbtfw32.tlv
[   14.096362] Bluetooth: hci0: QCA Downloading qca/crnv32.bin
[   14.770148] Bluetooth: hci0: QCA setup on UART is completed
[   14.805807] Bluetooth: hci0: AOSP extensions version v0.98
[   14.814793] Bluetooth: hci0: AOSP quality report is supported
[   15.011398] Bluetooth: hci0: unsupported parameter 28
[   15.016649] Bluetooth: hci0: unsupported parameter 28

Just as a random guess from looking at "8" in the logs, maybe the
extra 8 in 3998 is the "target" above?

..though that also makes me think that perhaps this chip doesn't
actually have space for a MAC address at all. Maybe they decided to
re-use the space to store the hardware ID and other information on all
of these devices?

-Doug

