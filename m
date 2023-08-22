Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DF7839D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHVGST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjHVGSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F81A4;
        Mon, 21 Aug 2023 23:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B4C63615;
        Tue, 22 Aug 2023 06:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80714C433CC;
        Tue, 22 Aug 2023 06:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692685088;
        bh=+MGLTXNbrFnnrTitTj7A9hMBuY9jQ/3Yp97qYAAvB1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S5dU7Trh7ZiLW6LeyT9BNNvGy7usNy5Ff7G7/q11kNF97UPnNuCZXct55PfCfVyeT
         g6rJYlN8Cpk2MXam9KzUN7Qy8uJfznF8e28yFqMnNEFClD6qykGiED4fvldFAuNwgm
         ll3f7t0Rg/KIaWKH9QzoqNYdBcLP59cFP4Y91zWyPMJhPHeoLdvNIZ636XrW3mxtV/
         m4IGxBOO+9BhTUk8Vd40IuHAMk3G42+quMuBNx1bUR+eP1pMMhApDETIw8/PpBeIue
         nfWbhevBHf3RFQ+poeNvN1YYtE2uaEEGvfZMC2xZSn4nBJBmWsNt3qG55ecZqwxzPB
         UwRRtbPlSB5fw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so6223009e87.2;
        Mon, 21 Aug 2023 23:18:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw5gdmPP7K8BCFTNa1iO8NeSwiBY81JeNcgFDSH+RLblHtw7/az
        hLuwFoFqEDgwIEBARMUlqv2/iItFlpFu5Uwkzh8=
X-Google-Smtp-Source: AGHT+IHI+/Y4BA4mcN+yUjE57pWT/7CCgdwsQZMtMBTNuSlPXNLqrv+JFh6B6z6cbCIT5WrjJs6J6InsN4zQh4OTdFA=
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id
 u22-20020a056512129600b004fe09932218mr8129241lfs.31.1692685086445; Mon, 21
 Aug 2023 23:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com> <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
In-Reply-To: <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Aug 2023 23:17:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
Message-ID: <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 8:51=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
>
>
> On 8/18/23 16:16, Mariusz Tkaczyk wrote:
> > On Wed, 16 Aug 2023 16:37:26 +0700
> > Bagas Sanjaya<bagasdotme@gmail.com>  wrote:
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
> >> See Bugzilla for the full thread and attached full journalctl log.
> >>
> >> Anyway, I'm adding this regression to be tracked by regzbot:
> >>
> >> #regzbot introduced: 12a6caf273240a
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D217798  #regzbot title: =
systemd
> >> shutdown hang on machine with different RAID levels
> >>
> >> Thanks.
> >>
> >> [1]:https://bugzilla.kernel.org/show_bug.cgi?id=3D217798
> >>
> > Hello,
> > The issue is reproducible with IMSM metadata too, around 20% of reboot =
hangs. I
> > will try to raise the priority in the bug because it is valid high- the
> > base functionality of the system is affected.
>
> Since it it reproducible from your side, is it possible to turn the
> reproduce steps into a test case
> given the importance?
>
> I guess If all arrays are set with MD_DELETED flag, then reboot might
> hang, not sure whether
> below (maybe need to flush wq as well  before list_del) helps or not,
> just FYI.
>
> @@ -9566,8 +9566,10 @@ static int md_notify_reboot(struct notifier_block
> *this,
>
>          spin_lock(&all_mddevs_lock);
>          list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
> -               if (!mddev_get(mddev))
> +               if (!mddev_get(mddev)) {
> +                       list_del(&mddev->all_mddevs);
>                          continue;
> +               }

I am still not able to reproduce this, probably due to differences in the
timing. Maybe we only need something like:

diff --git i/drivers/md/md.c w/drivers/md/md.c
index 5c3c19b8d509..ebb529b0faf8 100644
--- i/drivers/md/md.c
+++ w/drivers/md/md.c
@@ -9619,8 +9619,10 @@ static int md_notify_reboot(struct notifier_block *t=
his,

        spin_lock(&all_mddevs_lock);
        list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
-               if (!mddev_get(mddev))
+               if (!mddev_get(mddev)) {
+                       need_delay =3D 1;
                        continue;
+               }
                spin_unlock(&all_mddevs_lock);
                if (mddev_trylock(mddev)) {
                        if (mddev->pers)


Thanks,
Song
