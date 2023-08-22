Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E04783A19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjHVGjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjHVGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:39:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3EE9;
        Mon, 21 Aug 2023 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692686371; x=1724222371;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ag8xPSatXPcBqAkpWaWMNHbfQOvMz2TFP2WRHFpLRgA=;
  b=TNcl1GmSrWqMvlP0NdLqm63rAfLPQXeJEJs660CexIaXfeNAIhT7ZT5L
   IaPkahz6fLi2poF0mxhr0x48I2cxJ6mxNHuxT8bCji1/n/dTkz0ReG9my
   pYUd6JKuVe8waAjjyskJEmezXqDBt0hIIDJOtziPvsGE1F7BegTghnmdI
   D8DO0n5Ul4hxaBwf/qED7Sid1MAomwnzInp02/CZnMKtU4xp7Ug4fXTFY
   FCr8xMea6tv2CggWQ4jYQ8yVMxdSr1+FU/+27hSH9LHnLs/e+zJxDKr3D
   MBa7EIWCKU+azURr5xP4qpq9wf57GdMkiWHBs1Mer9mlAlwfGBF+h4OSP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373766314"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="373766314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826207994"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826207994"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.141.105])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:39:28 -0700
Date:   Tue, 22 Aug 2023 08:39:23 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Message-ID: <20230822083923.00007fb6@linux.intel.com>
In-Reply-To: <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
        <20230818101630.000027f4@linux.intel.com>
        <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
        <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 23:17:54 -0700
Song Liu <song@kernel.org> wrote:

> On Mon, Aug 21, 2023 at 8:51=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linu=
x.dev> wrote:
> >
> >
> >
> > On 8/18/23 16:16, Mariusz Tkaczyk wrote: =20
> > > On Wed, 16 Aug 2023 16:37:26 +0700
> > > Bagas Sanjaya<bagasdotme@gmail.com>  wrote:
> > > =20
> > >> Hi,
> > >>
> > >> I notice a regression report on Bugzilla [1]. Quoting from it:
> > >> =20
> > >>> It needs to build at least 2 different RAIDs(eg. RAID0 and RAID10, =
RAID5
> > >>> and RAID10) and then you will see below error repeatly(need to use
> > >>> serial console to see it)
> > >>>
> > >>> [ 205.360738] systemd-shutdown[1]: Stopping MD devices.
> > >>> [ 205.366384] systemd-shutdown[1]: sd-device-enumerator: Scan all d=
irs
> > >>> [ 205.373327] systemd-shutdown[1]: sd-device-enumerator: Scanning
> > >>> /sys/bus [ 205.380427] systemd-shutdown[1]: sd-device-enumerator:
> > >>> Scanning /sys/class [ 205.388257] systemd-shutdown[1]: Stopping MD
> > >>> /dev/md127 (9:127). [ 205.394880] systemd-shutdown[1]: Failed to sy=
nc
> > >>> MD block device /dev/md127, ignoring: Input/output error [ 205.4049=
75]
> > >>> md: md127 stopped. [ 205.470491] systemd-shutdown[1]: Stopping MD
> > >>> /dev/md126 (9:126). [ 205.770179] md: md126: resync interrupted.
> > >>> [ 205.776258] md126: detected capacity change from 1900396544 to 0
> > >>> [ 205.783349] md: md126 stopped.
> > >>> [ 205.862258] systemd-shutdown[1]: Stopping MD /dev/md125 (9:125).
> > >>> [ 205.862435] md: md126 stopped.
> > >>> [ 205.868376] systemd-shutdown[1]: Failed to sync MD block device
> > >>> /dev/md125, ignoring: Input/output error [ 205.872845] block device
> > >>> autoloading is deprecated and will be removed. [ 205.880955] md: md=
125
> > >>> stopped. [ 205.934349] systemd-shutdown[1]: Stopping MD /dev/md124p2
> > >>> (259:7). [ 205.947707] systemd-shutdown[1]: Could not stop MD
> > >>> /dev/md124p2: Device or resource busy [ 205.957004]
> > >>> systemd-shutdown[1]: Stopping MD /dev/md124p1 (259:6). [ 205.964177]
> > >>> systemd-shutdown[1]: Could not stop MD /dev/md124p1: Device or reso=
urce
> > >>> busy [ 205.973155] systemd-shutdown[1]: Stopping MD /dev/md124 (9:1=
24).
> > >>> [ 205.979789] systemd-shutdown[1]: Could not stop MD /dev/md124: De=
vice
> > >>> or resource busy [ 205.988475] systemd-shutdown[1]: Not all MD devi=
ces
> > >>> stopped, 4 left. =20
> > >> See Bugzilla for the full thread and attached full journalctl log.
> > >>
> > >> Anyway, I'm adding this regression to be tracked by regzbot:
> > >>
> > >> #regzbot introduced: 12a6caf273240a
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=3D217798  #regzbot title:
> > >> systemd shutdown hang on machine with different RAID levels
> > >>
> > >> Thanks.
> > >>
> > >> [1]:https://bugzilla.kernel.org/show_bug.cgi?id=3D217798
> > >> =20
> > > Hello,
> > > The issue is reproducible with IMSM metadata too, around 20% of reboot
> > > hangs. I will try to raise the priority in the bug because it is valid
> > > high- the base functionality of the system is affected. =20
> >
> > Since it it reproducible from your side, is it possible to turn the
> > reproduce steps into a test case
> > given the importance?

I didn't try to reproduce it locally yet because customer was able to
bisect the regression and it pointed them to the same patch so I connected =
it
and asked author to take a look first. At a first glance, I wanted to get
community voice to see if it is not something obvious.

So far I know, customer is creating 3 IMSM raid arrays, one is the system
volume and do a reboot and it sporadically fails (around 20%). That is all.

> >
> > I guess If all arrays are set with MD_DELETED flag, then reboot might
> > hang, not sure whether
> > below (maybe need to flush wq as well  before list_del) helps or not,
> > just FYI.
> >
> > @@ -9566,8 +9566,10 @@ static int md_notify_reboot(struct notifier_block
> > *this,
> >
> >          spin_lock(&all_mddevs_lock);
> >          list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
> > -               if (!mddev_get(mddev))
> > +               if (!mddev_get(mddev)) {
> > +                       list_del(&mddev->all_mddevs);
> >                          continue;
> > +               } =20
>=20
> I am still not able to reproduce this, probably due to differences in the
> timing. Maybe we only need something like:
>=20
> diff --git i/drivers/md/md.c w/drivers/md/md.c
> index 5c3c19b8d509..ebb529b0faf8 100644
> --- i/drivers/md/md.c
> +++ w/drivers/md/md.c
> @@ -9619,8 +9619,10 @@ static int md_notify_reboot(struct notifier_block
> *this,
>=20
>         spin_lock(&all_mddevs_lock);
>         list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
> -               if (!mddev_get(mddev))
> +               if (!mddev_get(mddev)) {
> +                       need_delay =3D 1;
>                         continue;
> +               }
>                 spin_unlock(&all_mddevs_lock);
>                 if (mddev_trylock(mddev)) {
>                         if (mddev->pers)
>=20
>=20
> Thanks,
> Song

I will try to reproduce issue at Intel lab to check this.

Thanks,
Mariusz
