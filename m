Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922A766DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjG1NOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjG1NOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A93A99
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690549999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSfTQKibmae4BhoaMP33vHySs6u+SsBNyYuCmTTcvXg=;
        b=d2ZQQLONssEukjI66O+o+JFmYqqNXKCTZ0kyD6BKpIhp0U8hStzpnmPhJDmGCH5+tJm9vO
        GH6lgFN2NWYx2GrqZHhalffjJXs7zOAG2aUSpKICreBdSUuHV4UGZZ38qPpx/cAm/UOgQX
        Jzwvm5Cwl3B+C+7hHZMaSqCYWoFSxpk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-9ctmbCOuPJqxn_OK_pmG8g-1; Fri, 28 Jul 2023 09:13:18 -0400
X-MC-Unique: 9ctmbCOuPJqxn_OK_pmG8g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2680f0cc480so1400912a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549998; x=1691154798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSfTQKibmae4BhoaMP33vHySs6u+SsBNyYuCmTTcvXg=;
        b=OyAsVGXrvVLcF07eGgHM2ZzJ9HmOe9k9VwXG3dQ426Nfxo/sf3HX4nXX8kkL5HYlNO
         +x1WR588agiGgskc94xmmyiv5+Le0DB95+rZyFK15zlyLDD/+ztfd6F/dQMS1hgC8GBI
         uLXzZnEOvcV8ZVpylrHXm9zEsLymMa97CWZxKCH9zimX8REFRQ5xmARMBzf2cy4wGdUX
         z30ml1O28X7YjyV68HXigH0nPb4O7WAkO7j0jB6e0GrL6t1EI3Ud52sAkSElvekwxhrg
         4iGIhCIn2tSI7eAGIPtg0oOC1naLmNXmILPM8F6mrN3y26i2ewSD4QmMRbdpsqjORflA
         Jd3Q==
X-Gm-Message-State: ABy/qLYvIiLKnIitDYWUvStgqoU/uvlSa6WSurqGIk3Xg2DVKc55mNQE
        J1bT7FtCgw3AkBFUTZlyCve5SVSqVPi6CJcW02FwF+zVZAoWtd5bkewSYa4tvjnWjx6w+NSS59E
        tA4I1qkohO8ogj41pYD7Ykf2880sLiAVcFoE1fxuv
X-Received: by 2002:a17:90a:410f:b0:268:dd0:3497 with SMTP id u15-20020a17090a410f00b002680dd03497mr1369810pjf.7.1690549997695;
        Fri, 28 Jul 2023 06:13:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5y8wFNdiLqc3ETlKLPa+cfJmG8GRCRBtKGldFGO/sJezVu4H1NQVwj6+DjFFGt2eUfFGCSlMorGpLCIOQyOY=
X-Received: by 2002:a17:90a:410f:b0:268:dd0:3497 with SMTP id
 u15-20020a17090a410f00b002680dd03497mr1369793pjf.7.1690549997418; Fri, 28 Jul
 2023 06:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131223.431281-1-omosnace@redhat.com> <87edkseqf8.fsf@mail.lhotse>
 <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com> <CAEjxPJ643nmW6HZOmQGNFDj-cQGf-x3jzZcrO8BHVN9thM23Dw@mail.gmail.com>
In-Reply-To: <CAEjxPJ643nmW6HZOmQGNFDj-cQGf-x3jzZcrO8BHVN9thM23Dw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Jul 2023 15:13:06 +0200
Message-ID: <CAFqZXNuM-807tmT84rZ25xwh078BxvSfav88AozH=tt=J+dCrA@mail.gmail.com>
Subject: Re: Login broken with old userspace (was Re: [PATCH v2] selinux:
 introduce an initial SID for early boot processes)
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 28, 2023 at 7:36=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > On Fri, Jul 28, 2023 at 4:12=E2=80=AFAM Michael Ellerman <mpe@ellerman.=
id.au> wrote:
> > >
> > > Ondrej Mosnacek <omosnace@redhat.com> writes:
> > > > Currently, SELinux doesn't allow distinguishing between kernel thre=
ads
> > > > and userspace processes that are started before the policy is first
> > > > loaded - both get the label corresponding to the kernel SID. The on=
ly
> > > > way a process that persists from early boot can get a meaningful la=
bel
> > > > is by doing a voluntary dyntransition or re-executing itself.
> > >
> > > Hi,
> > >
> > > This commit breaks login for me when booting linux-next kernels with =
old
> > > userspace, specifically Ubuntu 16.04 on ppc64le. 18.04 is OK.
> > >
> > > The symptom is that login never accepts the root password, it just
> > > always says "Login incorrect".
> > >
> > > Bisect points to this commit.
> > >
> > > Reverting this commit on top of next-20230726, fixes the problem
> > > (ie. login works again).
> > >
> > > Booting with selinux=3D0 also fixes the problem.
> > >
> > > Is this expected? The change log below suggests backward compatibilit=
y
> > > was considered, is 16.04 just too old?
> >
> > Hi Michael,
> >
> > I can reproduce it on Fedora 38 when I boot with SELINUX=3Ddisabled in
> > /etc/selinux/config (+ a kernel including that commit), so it likely
> > isn't caused by the userspace being old. Can you check what you have
> > in /etc/selinux/config (or if it exists at all)?
> >
> > We have deprecated and removed the "runtime disable" functionality in
> > SELinux recently [1], which was used to implement "disabling" SELinux
> > via the /etc/selinux/config file, so now the situation (selinux=3D0 +
> > SELINUX=3Ddisabled in /etc/selinux/config) leads to a state where
> > SELinux is enabled, but no policy is loaded (and no enforcement is
> > done). Such a state mostly behaves as if SElinux was truly disabled
> > (via kernel command line), but there are some subtle differences and I
> > believe we don't officially support it (Paul might clarify). With
> > latest kernels it is recommended to either disable SELinux via the
> > kernel command line (or Kconfig[2]) or to boot it in Enforcing or
> > Permissive mode with a valid/usable policy installed.
> >
> > So I wonder if Ubuntu ships by default with the bad configuration or
> > if it's just a result of using the custom-built linux-next kernel (or
> > some changes on your part). If Ubuntu's stock kernel is configured to
> > boot with SELinux enabled by default, they should also by default ship
> > a usable policy and SELINUX=3Dpermissive/enforcing in
> > /etc/selinux/config (or configure the kernel[2] or bootloader to boot
> > with SELinux disabled by default). (Although if they ship a pre-[1]
> > kernel, they may continue to rely on the runtime disable
> > functionality, but it means people will have to be careful when
> > booting newer or custom kernels.)
> >
> > That said, I'd like to get to the bottom of why the commit causes the
> > login to fail and fix it somehow. I presume something in PAM chokes on
> > the fact that userspace tasks now have "init" instead of "kernel" as
> > the pre-policy-load security context, but so far I haven't been able
> > to pinpoint the problem. I'll keep digging...
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Df22f9aaf6c3d92ebd5ad9e67acc03afebaaeb289
> > [2] via CONFIG_LSM (or CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE on older=
 kernels)
>
> Prior to selinux userspace commit
> 685f4aeeadc0b60f3770404d4f149610d656e3c8 ("libselinux:
> is_selinux_enabled(): drop no-policy-loaded test.") libselinux was
> checking the result of reading /proc/self/attr/current to see if it
> returned the "kernel" string as a means of detecting a system with
> SELinux enabled but no policy loaded, and treated that as if SELinux
> were disabled. Hence, this does break old userspace. Not sure though
> why you'd see the same behavior with modern libselinux.

Hm... now I tried booting the stock Fedora kernel (without the early
boot initial SID commit) and I got the same failure to login as with
the new kernel. So if Ubuntu 16.04 ships with pre-685f4aeeadc0
libselinux (quite possible), then it seems that the scenario with
terminal login + SELinux enabled + policy not loaded only works with
pre-685f4aeeadc0 libselinux and pre-5b0eea835d4e kernel, the other
combinations are broken. With pre-685f4aeeadc0 libselinux +
post-5b0eea835d4e kernel it is expected as you say (and probably
inevitable barring some hack on the kernel side), but it's not clear
why also only updating libselinux seems to break it... /sys/fs/selinux
is not mounted in my scenario, so there must be something else coming
into play.


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

