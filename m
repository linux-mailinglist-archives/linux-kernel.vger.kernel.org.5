Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6438E7821CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjHUDYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjHUDYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:24:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71C9D;
        Sun, 20 Aug 2023 20:24:00 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bd6a34474cso2198805a34.3;
        Sun, 20 Aug 2023 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692588240; x=1693193040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dwP756RQWeaJUheDspLg4gz0IMnHyBo7z6aeWKm5to=;
        b=ikAQcJ4pWR7NAzM1i/Bgbnlbkj024BEWnn91N44/NzFa9swQlRwFAaNY39ydO6Yu27
         UIadmkqHoNqErOR+9fp4V+LQo5C86utCfJfTyqRMBDN5iUYmd23obEmipmiHvulSLn8O
         frmwgwufGqKHQrUtuTa92RDTheTr2jpCPVsFjkKh4BGb/5a7wtoJuH/slxCz67N3VcyJ
         iLNts3eW0vYlf5yl3QUPUBBx2zXThPW3yCzxw4nPdaZbWNE36hqNW3iYV8rsT47nLNSz
         uJ/eU8lOg460Mx+dAMARgvr1xuZbBpBKEG+p9dVZkiewPmVHxzpdwd+UK6ho+K0YrZlD
         UJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692588240; x=1693193040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dwP756RQWeaJUheDspLg4gz0IMnHyBo7z6aeWKm5to=;
        b=gmCVzRthV9tpr87/ewAfIv44CuEVUMUX+9rBnQPHCj6SclIt1mB0XUh3RGRZfsYt9h
         hkT9eXVnvYQW5SHTzD2z3zxo+qLjX5gFFUSVtsugmnKyUYv8d1S0FONqh8QNvtVwUK9A
         A05Pca9Et/YMPu+Nd/GQjizEFMugEbT19zPFPr00tJ9umHAUp+tJo33u5B9QHCx1gyS5
         1x9dygkdKpOK1xzc13eNrk8rYn4jEviE+YVfDZz9+vO0baCnRIQNs0aAfaseNFeO9AXk
         vG+m/E4aUlrRgsMSIKGslHZCIl198KOhUPv1lbGVyswRp/1/haUpHPI9bP+XYDaCv8ZH
         0Q1Q==
X-Gm-Message-State: AOJu0YzZ1txsmC75q+dsJFWfbZDY3Z4LlB5q8gjhdz3PXAkr9wcl55dL
        jgzqKbThJSYNQUlHkXUzVXA1LDn4X2E84kKKOrM=
X-Google-Smtp-Source: AGHT+IGgEE6tM7judRJSXqnBK33LYdSELpr0YKoHweeIXfDb1yhLZ1CzJS6GH8YXCJhIfW/wV7rvwXw3FbU9cGjr6ys=
X-Received: by 2002:a05:6870:b4ac:b0:1be:cf5d:6f7b with SMTP id
 y44-20020a056870b4ac00b001becf5d6f7bmr8318594oap.17.1692588239918; Sun, 20
 Aug 2023 20:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com> <1b2166ab-e788-475e-a8e2-a6cef26f2524@suse.de>
In-Reply-To: <1b2166ab-e788-475e-a8e2-a6cef26f2524@suse.de>
From:   AceLan Kao <acelan@gmail.com>
Date:   Mon, 21 Aug 2023 11:23:47 +0800
Message-ID: <CAMz9Wg_Homvy7KSSV5kFJKatVCA0_kmG96h577Ak1qv88CHD6g@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Hannes Reinecke <hare@suse.de>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> =E6=96=BC 2023=E5=B9=B48=E6=9C=8818=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 8/18/23 10:16, Mariusz Tkaczyk wrote:
> > On Wed, 16 Aug 2023 16:37:26 +0700
> > Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> >> Hi,
> >>
> >> I notice a regression report on Bugzilla [1]. Quoting from it:
> >>
> >>> It needs to build at least 2 different RAIDs(eg. RAID0 and RAID10, RA=
ID5
> >>> and RAID10) and then you will see below error repeatly(need to use se=
rial
> >>> console to see it)
> >>>
> >>> [ 205.360738] systemd-shutdown[1]: Stopping MD devices.
> >>> [ 205.366384] systemd-shutdown[1]: sd-device-enumerator: Scan all dir=
s
> >>> [ 205.373327] systemd-shutdown[1]: sd-device-enumerator: Scanning /sy=
s/bus
> >>> [ 205.380427] systemd-shutdown[1]: sd-device-enumerator: Scanning /sy=
s/class
> >>> [ 205.388257] systemd-shutdown[1]: Stopping MD /dev/md127 (9:127).
> >>> [ 205.394880] systemd-shutdown[1]: Failed to sync MD block device
> >>> /dev/md127, ignoring: Input/output error [ 205.404975] md: md127 stop=
ped.
> >>> [ 205.470491] systemd-shutdown[1]: Stopping MD /dev/md126 (9:126).
> >>> [ 205.770179] md: md126: resync interrupted.
> >>> [ 205.776258] md126: detected capacity change from 1900396544 to 0
> >>> [ 205.783349] md: md126 stopped.
> >>> [ 205.862258] systemd-shutdown[1]: Stopping MD /dev/md125 (9:125).
> >>> [ 205.862435] md: md126 stopped.
> >>> [ 205.868376] systemd-shutdown[1]: Failed to sync MD block device
> >>> /dev/md125, ignoring: Input/output error [ 205.872845] block device
> >>> autoloading is deprecated and will be removed. [ 205.880955] md: md12=
5
> >>> stopped. [ 205.934349] systemd-shutdown[1]: Stopping MD /dev/md124p2
> >>> (259:7). [ 205.947707] systemd-shutdown[1]: Could not stop MD /dev/md=
124p2:
> >>> Device or resource busy [ 205.957004] systemd-shutdown[1]: Stopping M=
D
> >>> /dev/md124p1 (259:6). [ 205.964177] systemd-shutdown[1]: Could not st=
op MD
> >>> /dev/md124p1: Device or resource busy [ 205.973155] systemd-shutdown[=
1]:
> >>> Stopping MD /dev/md124 (9:124). [ 205.979789] systemd-shutdown[1]: Co=
uld
> >>> not stop MD /dev/md124: Device or resource busy [ 205.988475]
> >>> systemd-shutdown[1]: Not all MD devices stopped, 4 left.
> >>
> >> See Bugzilla for the full thread and attached full journalctl log.
> >>
> >> Anyway, I'm adding this regression to be tracked by regzbot:
> >>
> >> #regzbot introduced: 12a6caf273240a
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D217798 #regzbot title: s=
ystemd
> >> shutdown hang on machine with different RAID levels
> >>
> >> Thanks.
> >>
> >> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217798
> >>
> >
> > Hello,
> > The issue is reproducible with IMSM metadata too, around 20% of reboot =
hangs. I
> > will try to raise the priority in the bug because it is valid high- the
> > base functionality of the system is affected.
> >
> > Christoph, could you take a look in short term?
> >
> Does this help?
>
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 78be7811a89f..b3661c8def8c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9575,6 +9575,7 @@ static int md_notify_reboot(struct notifier_block
> *this,
>          struct mddev *mddev, *n;
>          int need_delay =3D 0;
>
> +       flush_workqueue(md_misc_wq);
>          spin_lock(&all_mddevs_lock);
>          list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
>                  if (!mddev_get(mddev))
>
> Cheers,
>
> Hannes
>

Hi Hannes,

The patch doesn't work, I still can reproduce the issue after applied
the patch on top of v6.5-rc7
706a74159504 Linux 6.5-rc7

--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
