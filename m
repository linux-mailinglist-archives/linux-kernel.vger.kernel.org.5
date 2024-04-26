Return-Path: <linux-kernel+bounces-160254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5328B3AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845212817A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075714901A;
	Fri, 26 Apr 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bY8jFY8R"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95114900F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144272; cv=none; b=JfCmKbN0uwfhLOlITZeGcivOW5/lccyznzOgBlmcEMj7IZ2NiM1UoDeRsJt2xJvAOjTRB7sazRlBYTKN7EKL+KV5ARV8qDBwTvcNM/LY8BhGb6jhPrW62jlDAKejt9ha4Z1o+qBIjcun0HVzLhi/mC87al2GbQXII1kOs89nUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144272; c=relaxed/simple;
	bh=FQK4lB6+yrIINaZRIIsKwVh5cEpzmDd5OAvC4iav8oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6PA8SjVLWTQ5VbX3q4mxI+HuzaREXgJnb9Al5YakSke9g0dxGXNUj1H9aHdqTfvGeoKb9+l/H4v9Sd78+YFTzRPTMXfPdBnqD+I3BVqH8YKclFAlEZvqZpExgPs/zOiZauxbwiWRo7xUA8B5c+8dRVf50m06Ks1MOKqvwemsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bY8jFY8R; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5af702072a9so668185eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714144268; x=1714749068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdjT+GCSzg2ucR/xpsPh53yfn1FbmRv5yaAbVKecdaI=;
        b=bY8jFY8RJmplvmBD4ab2b47xXFhp+rotTt2sYxopCeUdaUq8FINdD9bLlnqjqE6EbA
         MeYKLqF/z75VHMIgnXNXKNIe5mrkqkVZsUG+mwBy3ConqyA0hgZjjd+cliZEWTjk8hxG
         neerT0PiVki/IpHFyTC3vfNEjGvbq3JtCBtgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144268; x=1714749068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdjT+GCSzg2ucR/xpsPh53yfn1FbmRv5yaAbVKecdaI=;
        b=gRsU39VoiWm1c9kxfZdQe0gukBRLakh5KcBqG59f4gJtWU7smSK5OjpobPRHH02dcq
         TZMFGbFIU2zBSkfGY4TX6ZOGRRyhbbn7ojjr9LD0R0zSmiYpCWNULGy1T4p/dFXZTsR7
         H3xpsbQPG0OzoajLgtbuDH0cgX6kMyff/6gMYspnsfiFPNmzE5FJn1YS6LjxUd4MlOy5
         hQXJeEB3flLKBJGx/lmHOphmZrm/aPFgXd38GTUkYYX2xqEujNUkP72iE3E/iQAZG8UN
         HuF+Pscd51Kbcr+zNcE3pOTHc/ZtB0I+if21Lr6/dXsy+FVx2hj23GeHzbNw25ikPXij
         FwPA==
X-Forwarded-Encrypted: i=1; AJvYcCXJnTRJka3FV/2Dt8Y9sm/WLiSJqSieUd+kU5emPnQN9UotlUN4SfLzEo16624doaVASOKIl17Hh+enC6qiM2THbyrbWOT5yjyPpUA5
X-Gm-Message-State: AOJu0Yy+6IKwcINbgnmfuDeVSp2G8OBP0w5J4BX7xIbZnn+YXVEqOvDT
	rXcpYt/s21pquCoNVPmmevPDn5lB0Hf+LJQaFqXdY7hWAd1lodNDQHbPzZH5m8PupBRDJ5SMRY5
	0WkCJDvyriKpInjNotV+SCAIxG7UuFz8bgx/KW9LXT1jfEFB6vA==
X-Google-Smtp-Source: AGHT+IHeMEOlOAEGE7kcWQkDz6QG75KRsh1lsNxWSwDqbdtSIZCnQwM4KSeQIx55m5V30BI0aCBPxI1jHZ5ZJONzf4g=
X-Received: by 2002:a4a:1704:0:b0:5af:2f93:47de with SMTP id
 4-20020a4a1704000000b005af2f9347demr1423459ooe.0.1714144268615; Fri, 26 Apr
 2024 08:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423200234.21480-1-kamal.dasu@broadcom.com>
 <CAPDyKFqLqbRx3gWCqT4G6mUVeMDWyA_f8T2_iYt07r_Ffqaaow@mail.gmail.com> <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com>
In-Reply-To: <3f69d64e-7c41-48de-a7a0-42ab99cd7e7d@intel.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Fri, 26 Apr 2024 11:10:31 -0400
Message-ID: <CAKekbev6YG+yVnX-n9tsQSwujj5mD-vpJXrd+xwcF-K=z45q+w@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: core: check R1_STATUS for erase/trim/discard
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, ludovic.barre@st.com, f.fainelli@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003eb8480617015007"

--0000000000003eb8480617015007
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:17=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 25/04/24 19:18, Ulf Hansson wrote:
> > + Wolfram, Adrian (to see if they have some input)
> >
> > On Tue, 23 Apr 2024 at 22:02, Kamal Dasu <kamal.dasu@broadcom.com> wrot=
e:
> >>
> >> When erase/trim/discard completion was converted to mmc_poll_for_busy(=
),
> >> optional ->card_busy() host ops support was added. sdhci card->busy()
> >> could return busy for long periods to cause mmc_do_erase() to block du=
ring
> >> discard operation as shown below during mkfs.f2fs :
> >>
> >> Info: [/dev/mmcblk1p9] Discarding device
> >> [   39.597258] sysrq: Show Blocked State
> >> [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid=
:1561  ppid:1542   flags:0x0000000d
> >> [   39.610609] Call trace:
> >> [   39.613098]  __switch_to+0xd8/0xf4
> >> [   39.616582]  __schedule+0x440/0x4f4
> >> [   39.620137]  schedule+0x2c/0x48
> >> [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
> >> [   39.628562]  schedule_hrtimeout_range+0x10/0x18
> >> [   39.633169]  usleep_range_state+0x5c/0x90
> >> [   39.637253]  __mmc_poll_for_busy+0xec/0x128
> >> [   39.641514]  mmc_poll_for_busy+0x48/0x70
> >> [   39.645511]  mmc_do_erase+0x1ec/0x210
> >> [   39.649237]  mmc_erase+0x1b4/0x1d4
> >> [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
> >> [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
> >> [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
> >> [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
> >> [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
> >> [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
> >> [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
> >> [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
> >> [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
> >> [   39.693539]  __submit_bio+0x1c/0x80
> >> [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
> >> [   39.701875]  submit_bio_noacct+0x1b0/0x22c
> >> [   39.706042]  submit_bio+0xac/0xe8
> >> [   39.709424]  blk_next_bio+0x4c/0x5c
> >> [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
> >> [   39.717835]  blkdev_common_ioctl+0x374/0x728
> >> [   39.722175]  blkdev_ioctl+0x8c/0x2b0
> >> [   39.725816]  vfs_ioctl+0x24/0x40
> >> [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
> >> [   39.733114]  invoke_syscall+0x68/0xec
> >> [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
> >> [   39.741609]  do_el0_svc+0x18/0x20
> >> [   39.744981]  el0_svc+0x68/0x94
> >> [   39.748107]  el0t_64_sync_handler+0x88/0x124
> >> [   39.752455]  el0t_64_sync+0x168/0x16c
> >
> > Thanks for the detailed log!
> >
> >>
> >> Fix skips the card->busy() and uses MMC_SEND_STATUS and R1_STATUS
> >> check for MMC_ERASE_BUSY busy_cmd case in the mmc_busy_cb() function.
> >>
> >> Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for er=
ase/trim/discard")
> >> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> >> ---
> >>  drivers/mmc/core/mmc_ops.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> >> index 3b3adbddf664..603fbd78c342 100644
> >> --- a/drivers/mmc/core/mmc_ops.c
> >> +++ b/drivers/mmc/core/mmc_ops.c
> >> @@ -464,7 +464,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
> >>         u32 status =3D 0;
> >>         int err;
> >>
> >> -       if (data->busy_cmd !=3D MMC_BUSY_IO && host->ops->card_busy) {
> >> +       if (data->busy_cmd !=3D MMC_BUSY_IO &&
> >> +           data->busy_cmd !=3D MMC_BUSY_ERASE && host->ops->card_busy=
) {
> >>                 *busy =3D host->ops->card_busy(host);
> >>                 return 0;
> >>         }
> >
> > So it seems like the ->card_busy() callback is broken in for your mmc
> > host-driver and platform. Can you perhaps provide the information
> > about what HW/driver you are using?
> >

Using the sdhci-brcmstb driver on a Broadcom Settop based SoC.

> > The point with using the ->card_busy() callback, is to avoid sending
> > the CMD13. Ideally it should be cheaper/faster and in most cases it
> > translates to a read of a register. For larger erases, we would
> > probably end up sending the CMD13 periodically every 32-64 ms, which
> > shouldn't be a problem. However, for smaller erases and discards, we
> > may want the benefit the ->card_busy() callback provides us.
> >

I have tested two scenarios. One is like the mkfs.f2fs app that calls :
ioctl(fd, BLKSECDISCARD, &range);

This has the following CMD and completion sequence:
{CMD35->CMD36->CMD38} and poll for  DAT0  signal via card->busy .
CMD38 has a response of R1b. The DAT0 (Busy line) will be driven by the dev=
ice.
Busy (DAT0  =3D 0) is asserted by a device for  erasing blocks. Stays
busy in brcmstb sdhci controller.

With the additional change followed by CMD13 (response of R1), which
returns the device status, the
DAT0 will be pulled-up and next time we read the BUSY status it will
indicate it is not busy.

Also I tried the mmc util and that does not show the same issue with
exactly the same ranges, however in that case there are some
differences in the way the CMD sequence is sent for the entire discard
operation.
# mmc erase discard 0x000087a4 0x002effff /dev/mmcblk1
/* send erase cmd with multi-cmd */
ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);

CMD35->CMD13->CMD36->CMD13->CMD38->CMD13
I do not see any hang in all the erase options discard, legacy, trim, trim2=
,
secure-trim used here with mmc util .

Also looking at JEDEC Standard No. 84-B51 Page 276, 277
"Once the erase groups are selected the host will send an ERASE
(CMD38) command. It is recom-
mended that the host terminates the sequence with a SEND_STATUS
(CMD13) to poll any additional
status information the Device may have (e.g., WP_ERASE_SKIP, etc.)."

> > I would suggest that we first try to fix the implementation of the
> > ->card_busy() callback for your HW. If that isn't possible or fails,
> > then let's consider the approach you have taken in the $subject patch.
>

I have verified this with hardware behavior and default
sdhci->card->busy() seems to work fine except
in the above sequence of CMD35->CMD36->CMD38 without any MMC_STATUS interle=
aved.

Maybe we can do both, check the card busy and send CMD13.
__mmc_poll_for_busy() does have
throttling changes as well that would limit the rate at which CMD13
will be sent.

> Note, sdhci drivers can override host->ops.  For example,
> sdhci-omap.c has:
>
>         host->mmc_host_ops.card_busy =3D sdhci_omap_card_busy;
>
> Probably, if ->card_busy() cannot be supported, then setting
> it to NULL would work.
>
>         host->mmc_host_ops.card_busy =3D NULL; /* Cannot detect card busy=
 */
>

Yes, that's an option I have tested to be working and will have to
take in case  mmc_busy_cb() change  is not acceptable.

Thanks
Kamal

--0000000000003eb8480617015007
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN1fiSjzNTTOp4jix0Jz92XDY6fZz5VYyAGeNI+4
gvVGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyNjE1MTEw
OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAp70wRCBhIGdv3IC6Y5P9+7JmlM6q2TJfMxZtgh8RDsxjZZ1EYkIkXWlrE
e23iHlEuiVZdJ6+QsmIa9EXpWo5f5FInwmoCFSAvSBwOzLD2poof4uRVi3cW+2EotPKoUHnLWRo9
oyqTslhCIE3FL7AQNWcjsMkcrebSK7NB+RI/hDJivOhz4dCBN9kXiC9gCznV65A4u6D5ujLtMJRk
F4Loh7MfM1rqk6Xw4VkNaVmfLjGJFVp2pQC7UARLZtKs0JCuqT/d1etY+Afo0rhXX1YJXPu0pSS4
sZpRl/tq8yKStHWW123EmnoQ64DpcTZ1sekV0+46PPh93TlqXz0LVRgJ
--0000000000003eb8480617015007--

