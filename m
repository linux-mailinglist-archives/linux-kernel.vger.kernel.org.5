Return-Path: <linux-kernel+bounces-167672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054C8BAD38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837011C21CF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F11BF24;
	Fri,  3 May 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqPh5Zro"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBE153575
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741827; cv=none; b=DiYJ4Mex5bmAjtoTikO93hSkj5YovCLZshKPVhWjOmj9BdYr3oo/jckiaR4UNk33KBf6DeTS1BCfB5IH90nzVfuybgBWmTnY67Ym1QqI4sz2iaF5KMMIzDe8osN4rjs6jTA0QwGmmq16MMMm/6IBo6ujEootJo56DbqfHN8PxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741827; c=relaxed/simple;
	bh=gugcEeAp1g+bOY88HeWap5QlirdEmSZIECRa73fEtUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArdWqTE87KeJrBrw/QAtFcZd8r1HBL+Dd0H2uCxtbwUhRWLC0VxcPSDlH5ihU58aKuJFj/bB3zsWVXeu6GqLlmovsk+RQpow35omHx+QdbCvO2lUPdAiMorbtmKtO0rdjnNy8l81lR+Nrb6doU6DKv0GzdM6BlRPosFKu/3yrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqPh5Zro; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso8875586276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714741824; x=1715346624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEcUnH1jzP3yCvRSRRTtGglfL7MMd/mBbsAHLuHMWgg=;
        b=kqPh5ZroNX+w/Kratf0zm82CvdOCABqpe5C05KC42bKBR7xX5V633y5snCIz4YPMEe
         JlASbIhb6s92vnlOs5ngvZqvKugCaHs4fMrKvR4j+46aV0ZEGBex+h0oyhxfS/FuorCe
         SKHLODn/+l+ulad00H7z5jVS4WjOmVbt5jJLIEoqvSUy410JtFq07QE/s5Guj3sQJJuZ
         7NubwbXV/o47eKuNtu8NS+XfW+COi8u8LsqHD5S8fJNiGkDRPZkcvqMl3jzVCfWjWS+k
         44VNh4YSZlls43BmJyFGRuG6lMXo159ZtSW8NdjHE4LMVpsoyja4YvezqcjNNOcXyUR6
         j2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741824; x=1715346624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEcUnH1jzP3yCvRSRRTtGglfL7MMd/mBbsAHLuHMWgg=;
        b=Rgguum7rzMvMTKWWE4fx3P2Z8gj3UG+UJtwcSZ1TbL6WEYAA1J8ZV4OQIpz+gNN+4o
         hM3cimVywl+mkfgkPmdJUUKfHU/3oquuFLKYuvO/ocVBJdjXZcneE1mawKoc+N+6Vf0b
         WTLTc79wRR0KBWZguE/jJZKV1Xc1ej98Lv/e3Uc+9PhoQXnaz3WSGEfo3/QIrYsHpEWN
         9XNvRvMTJW4XysKjsf5EMPAlhgwL5kWGQHeLsnVvGcLJeru6lGnpjYpNid6NMRzCgY7O
         8paiKnFTJSqDBto7bs8am4960dkTHgcmnjeMYI2ul+xiwqi+4ExwsqkWMIoOXb41IfWM
         jENA==
X-Forwarded-Encrypted: i=1; AJvYcCX5fjHbppjtOFS1IwHVhtSzKdccid4TMMwmjw/kPjYqYQ7LksDPYx/jQ7yY5Iaj1cp4/81F3UhF3neLVemS7wWllKcqNxcBMRMY9ZzS
X-Gm-Message-State: AOJu0YzIKRLgSO33vpSAfhhwa+40Hd7c8juKRstcRhlIQxaPiFqCDXHy
	SPJt4TaU4jydXj6OiRiPJLYhAefK5FGLXqA2fZ6ty2uA1g6kuwqyFKoPFQQMIJRLsZhm0G7JzgL
	BVqDobw9dv2VCmMvBT/buXtJmNlP4lwk3xMrdRQ==
X-Google-Smtp-Source: AGHT+IFzk7bZXWAoTaIhIbUXMAIN7kCTEXcGtdlj8W2t1wwTzT1h77eug8sEfphRhKWmYhtKER+9rSydgVe9ULiGBbQ=
X-Received: by 2002:a5b:18e:0:b0:de0:e7f2:a03d with SMTP id
 r14-20020a5b018e000000b00de0e7f2a03dmr2786092ybl.3.1714741824456; Fri, 03 May
 2024 06:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
 <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com>
 <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com> <CAKekbev6YG+yVnX-n9tsQSwujj5mD-vpJXrd+xwcF-K=z45q+w@mail.gmail.com>
In-Reply-To: <CAKekbev6YG+yVnX-n9tsQSwujj5mD-vpJXrd+xwcF-K=z45q+w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:09:48 +0200
Message-ID: <CAPDyKFoE4+sQ3D-9SKtFcksQQ88GyYd_P88dVOj9SYyVFqLxig@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, ludovic.barre@st.com, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 at 17:11, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> On Fri, Apr 26, 2024 at 2:17=E2=80=AFAM Adrian Hunter <adrian.hunter@inte=
l.com> wrote:
> >
> > On 25/04/24 19:18, Ulf Hansson wrote:
> > > + Wolfram, Adrian (to see if they have some input)
> > >
> > > On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com> wr=
ote:
> > >>
> > >> When erase/trim/discard completion was converted to mmc_poll_for_bus=
y(),
> > >> optional ->card_busy() host ops support was added. sdhci card->busy(=
)
> > >> could return busy for long periods to cause mmc_do_erase() to block =
during
> > >> discard operation as shown below during mkfs.f2fs :
> > >>
> > >> Info: [/dev/mmcblk1p9] Discarding device
> > >> [   39.597258] sysrq: Show Blocked State
> > >> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tg=
id:1561  ppid:1542   flags:0x0000000d
> > >> [   39.610609] Call trace:
> > >> [   39.613098]  __switch_to+0xd8/0xf4
> > >> [   39.616582]  __schedule+0x440/0x4f4
> > >> [   39.620137]  schedule+0x2c/0x48
> > >> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
> > >> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
> > >> [   39.633169]  usleep_range_state+0x5c/0x90
> > >> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
> > >> [   39.641514]  mmc_poll_for_busy+0x48/0x70
> > >> [   39.645511]  mmc_do_erase+0x1ec/0x210
> > >> [   39.649237]  mmc_erase+0x1b4/0x1d4
> > >> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
> > >> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
> > >> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
> > >> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
> > >> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
> > >> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
> > >> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
> > >> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
> > >> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
> > >> [   39.693539]  __submit_bio+0x1c/0x80
> > >> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
> > >> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
> > >> [   39.706042]  submit_bio+0xac/0xe8
> > >> [   39.709424]  blk_next_bio+0x4c/0x5c
> > >> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
> > >> [   39.717835]  blkdev_common_ioctl+0x374/0x728
> > >> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
> > >> [   39.725816]  vfs_ioctl+0x24/0x40
> > >> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
> > >> [   39.733114]  invoke_syscall+0x68/0xec
> > >> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
> > >> [   39.741609]  do_el0_svc+0x18/0x20
> > >> [   39.744981]  el0_svc+0x68/0x94
> > >> [   39.748107]  el0t_64_sync_handler+0x88/0x124
> > >> [   39.752455]  el0t_64_sync+0x168/0x16c
> > >
> > > Thanks for the detailed log!
> > >
> > >>
> > >> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
> > >> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function=
.
> > >>
> > >> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for =
erase/trim/discard")
> > >> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > >> ---
> > >>  drivers/mmc/core/mmc_ops.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > >> index 3b3adbddf664..603fbd78c342 100644
> > >> --- a/drivers/mmc/core/mmc_ops.c
> > >> +++ b/drivers/mmc/core/mmc_ops.c
> > >> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy=
)
> > >>         u32 status =3D 0;
> > >>         int err;
> > >>
> > >> -       if (data->busy_cmd !=3D MMC_BUSY_IO && host->ops->card_busy)=
 {
> > >> +       if (data->busy_cmd !=3D MMC_BUSY_IO &&
> > >> +           data->busy_cmd !=3D MMC_BUSY_ERASE && host->ops->card_bu=
sy) {
> > >>                 *busy =3D host->ops->card_busy(host);
> > >>                 return 0;
> > >>         }
> > >
> > > So it seems like the ->card_busy() callback is broken in for your mmc
> > > host-driver and platform. Can you perhaps provide the information
> > > about what HW/driver you are using?
> > >
>
> Using the sdhci-brcmstb driver on a Broadcom Settop based SoC.
>
> > > The point with using the ->card_busy() callback, is to avoid sending
> > > the CMD13. Ideally it should be cheaper/faster and in most cases it
> > > translates to a read of a register. For larger erases, we would
> > > probably end up sending the CMD13 periodically every 32-64 ms, which
> > > shouldn't be a problem. However, for smaller erases and discards, we
> > > may want the benefit the ->card_busy() callback provides us.
> > >
>
> I have tested two scenarios. One is like the mkfs.f2fs app that calls :
> ioctl(fd, BLKSECDISCARD, &range);
>
> This has the following CMD and completion sequence:
> {CMD35->CMD36->CMD38} and poll for  DAT0  signal via card->busy .
> CMD38 has a response of R1b. The DAT0 (Busy line) will be driven by the d=
evice.
> Busy (DAT0  =3D 0) is asserted by a device for  erasing blocks. Stays
> busy in brcmstb sdhci controller.

How big is the "range"?

Just so I get this right, it stays busy and we are waiting for the
timeout to fire? And ideally you think we should not be busy for that
long, right?

>
> With the additional change followed by CMD13 (response of R1), which
> returns the device status, the
> DAT0 will be pulled-up and next time we read the BUSY status it will
> indicate it is not busy.

So you are referring to read the BUSY status with you ->card_busy()
callback? Or did you actually verify that this is true from an
electrical point of view, by monitoring the DAT0 signal?

If the latter, perhaps it's the card that is failing and simply
requires CMD13 to be used to poll for busy. What card is this?

Have you tried different cards with the same platform/driver?

>
> Also I tried the mmc util and that does not show the same issue with
> exactly the same ranges, however in that case there are some
> differences in the way the CMD sequence is sent for the entire discard
> operation.
> # mmc erase discard 0x000087a4 0x002effff /dev/mmcblk1
> /* send erase cmd with multi-cmd */
> ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>
> CMD35->CMD13->CMD36->CMD13->CMD38->CMD13
> I do not see any hang in all the erase options discard, legacy, trim, tri=
m2,
> secure-trim used here with mmc util .

So CMD13 seems to do the trick for you. Although, I think we need to
figure out if this a special "broken" card or if the problem is with
the ->card_busy() implementation for your platform.

>
> Also looking at JEDEC Standard No. 84-B51 Page 276, 277
> "Once the erase groups are selected the host will send an ERASE
> (CMD38) command. It is recom-
> mended that the host terminates the sequence with a SEND_STATUS
> (CMD13) to poll any additional
> status information the Device may have (e.g., WP_ERASE_SKIP, etc.)."

Isn't that exactly what is being done? After the card has stopped
signaling busy, we send a CMD13 in mmc_busy_cb() to read the
additional status information.

I don't get it, why should the card stop signal busy, just because we
send a CMD13. If so, the card should probably be considered broken.
For broken cards, we can try to use a card-quirk instead - to enforce
CMD13 polling.

>
> > > I would suggest that we first try to fix the implementation of the
> > > ->card_busy() callback for your HW. If that isn't possible or fails,
> > > then let's consider the approach you have taken in the $subject patch=
.
> >
>
> I have verified this with hardware behavior and default
> sdhci->card->busy() seems to work fine except
> in the above sequence of CMD35->CMD36->CMD38 without any MMC_STATUS inter=
leaved.
>
> Maybe we can do both, check the card busy and send CMD13.
> __mmc_poll_for_busy() does have
> throttling changes as well that would limit the rate at which CMD13
> will be sent.

Polling with both wouldn't help, but make the polling-loop heaviers,
we certainly don't want that.

>
> > Note, sdhci drivers can override host->ops.  For example,
> > sdhci-omap.c has:
> >
> >         host->mmc_host_ops.card_busy =3D sdhci_omap_card_busy;
> >
> > Probably, if ->card_busy() cannot be supported, then setting
> > it to NULL would work.
> >
> >         host->mmc_host_ops.card_busy =3D NULL; /* Cannot detect card bu=
sy */
> >
>
> Yes, that's an option I have tested to be working and will have to
> take in case  mmc_busy_cb() change  is not acceptable.
>
> Thanks
> Kamal

Kind regards
Uffe

