Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7361179CAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjILJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjILJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:00:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C910C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:00:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso40478965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509220; x=1695114020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPuhXIrsoDRwKm2c4doZfBy6UJlqWZcuCP4pbW2cMJU=;
        b=0eBJ92P6BYnTkFW0+cPbzrWvT42U+FZO2ZI5HfpmEOnYc6XlGdpqGiChXcjooLDxyQ
         3OwHffrWQUUyvACncs+0v0HOoxrUUFC27rFzupl8j62NlinAHFO4C0yN2Us0U6IpsUBd
         7TBnjsyHF2xdn/7mv0uLqOAuEEqRr1WdHGG1Mqao9y9JFRoKcozoIHAjBVObZc6FRUZs
         lF9JUj+zrq+y7StxK+nBlzxvz6bp4qDrFsOLbXYGuAhs3mPneCzRCi028ZUZ7TMHGbk7
         bCjhdef7Z8roSo5pjKlsBA522t3CM2konVhuFqhXAccjYehxWgSuPllKbaqp2s4AdiaL
         svJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509220; x=1695114020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPuhXIrsoDRwKm2c4doZfBy6UJlqWZcuCP4pbW2cMJU=;
        b=CP55MDtCrtWZECeSLXuUWuuXJnXfXRyAOfymTTDYzpjJkII96kMFPR9EEgoKGFKe18
         4qMjvvln784SH70uZJ+ixUDIhfJ6QtlkESLEQI5wcJGJMwacF4pyJgG/LNUHVB//rGTf
         rkWyywPqUjDBk3O6/i3x6gPiGZPzpsaFh1pNq66v0TY+8ZgdNrSCIuaewgf/vWKmiQhz
         rbMxB7YbJ6sOYB7JCFhIwclIIcFdfLJx9Kh9xHzmCmJwF2owZDPoJj1956+l/AnTu4dg
         +9otwNmim7lChCqcfg+RhcDEmJyYhknoEiWV9MN7zWqLZS8FP+GqAERzr5WyHcCJLqIR
         lt/w==
X-Gm-Message-State: AOJu0Yz6X1g9Svzp6Pf4goRYV9zzAzg4NYywx5TFuOtZR2MOUgsWTRA+
        YUzpGUYSk6GrdyqJzukobbGX6Uf6jf9oj7iDHPBJqQ==
X-Google-Smtp-Source: AGHT+IEruaY/XJBjah+iWq3HcBLI4GKyhigsTj6VWb1ntfR010vgfqEBZKHcesQHRAHWD6nSXOXZYQmhyGeyUOCjYig=
X-Received: by 2002:a05:6000:1245:b0:319:6b14:555c with SMTP id
 j5-20020a056000124500b003196b14555cmr1373860wrx.3.1694509220233; Tue, 12 Sep
 2023 02:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230906115928.3749928-1-alpic@google.com> <202309090600.NSyo7d2q-lkp@intel.com>
 <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com> <CAEjxPJ4uoqkwmbeOOmUHJwoKiK3cnfJP5P2w+hOXr4BZNtQ+JQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4uoqkwmbeOOmUHJwoKiK3cnfJP5P2w+hOXr4BZNtQ+JQ@mail.gmail.com>
From:   Alfred Piccioni <alpic@google.com>
Date:   Tue, 12 Sep 2023 11:00:07 +0200
Message-ID: <CALcwBGBPaYh98d+3_3k8o+8WCbYU8cNPoOHaqhUduKZYz7Ntow@mail.gmail.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 3:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 11, 2023 at 9:19=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Sep 8, 2023 at 6:54=E2=80=AFPM kernel test robot <lkp@intel.com=
> wrote:
> > >
> > > Hi Alfred,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on 50a510a78287c15cee644f345ef8bac8977986a7]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Alfred-Piccion=
i/SELinux-Check-correct-permissions-for-FS_IOC32_/20230906-200131
> > > base:   50a510a78287c15cee644f345ef8bac8977986a7
> > > patch link:    https://lore.kernel.org/r/20230906115928.3749928-1-alp=
ic%40google.com
> > > patch subject: [PATCH V2] SELinux: Check correct permissions for FS_I=
OC32_*
> > > config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/202=
30909/202309090600.NSyo7d2q-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20230909/202309090600.NSyo7d2q-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.NSyo7d2q=
-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    security/selinux/hooks.c: In function 'selinux_file_ioctl':
> > > >> security/selinux/hooks.c:3647:9: error: duplicate case value
> > >     3647 |         case FS_IOC32_GETFLAGS:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3645:9: note: previously used here
> > >     3645 |         case FS_IOC_GETFLAGS:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3648:9: error: duplicate case value
> > >     3648 |         case FS_IOC32_GETVERSION:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3646:9: note: previously used here
> > >     3646 |         case FS_IOC_GETVERSION:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3654:9: error: duplicate case value
> > >     3654 |         case FS_IOC32_SETFLAGS:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3652:9: note: previously used here
> > >     3652 |         case FS_IOC_SETFLAGS:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3655:9: error: duplicate case value
> > >     3655 |         case FS_IOC32_SETVERSION:
> > >          |         ^~~~
> > >    security/selinux/hooks.c:3653:9: note: previously used here
> > >     3653 |         case FS_IOC_SETVERSION:
> > >          |         ^~~~
> >
> > Not sure of the right way to fix this while addressing the original
> > issue that this patch was intended to fix. Looking in fs/ioctl.c, I
> > see that the some FS_IOC32 values are remapped to the corresponding
> > FS_IOC values by the compat ioctl syscall entrypoint. Also notice this
> > comment there:
> >
> >         /* RED-PEN how should LSM module know it's handling 32bit? */
> >         error =3D security_file_ioctl(f.file, cmd, arg);
> >         if (error)
> >                 goto out;
> >
> > So perhaps this is a defect in LSM that needs to be addressed?
>
> Note btw that some of the 32-bit ioctl commands are only handled in
> the fs-specific compat_ioctl routines, e.g. ext4_compat_ioctl()
> handles EXT4_IOC32_GETVERSION =3D=3D FS_IOC32_GETVERSION and ditto for
> _SETVERSION.
>
> >
> >
> > >
> > >
> > > vim +3647 security/selinux/hooks.c
> > >
> > >   3634
> > >   3635  static int selinux_file_ioctl(struct file *file, unsigned int=
 cmd,
> > >   3636                                unsigned long arg)
> > >   3637  {
> > >   3638          const struct cred *cred =3D current_cred();
> > >   3639          int error =3D 0;
> > >   3640
> > >   3641          switch (cmd) {
> > >   3642          case FIONREAD:
> > >   3643          case FIBMAP:
> > >   3644          case FIGETBSZ:
> > >   3645          case FS_IOC_GETFLAGS:
> > >   3646          case FS_IOC_GETVERSION:
> > > > 3647          case FS_IOC32_GETFLAGS:
> > >   3648          case FS_IOC32_GETVERSION:
> > >   3649                  error =3D file_has_perm(cred, file, FILE__GET=
ATTR);
> > >   3650                  break;
> > >   3651
> > >   3652          case FS_IOC_SETFLAGS:
> > >   3653          case FS_IOC_SETVERSION:
> > >   3654          case FS_IOC32_SETFLAGS:
> > >   3655          case FS_IOC32_SETVERSION:
> > >   3656                  error =3D file_has_perm(cred, file, FILE__SET=
ATTR);
> > >   3657                  break;
> > >   3658
> > >   3659          /* sys_ioctl() checks */
> > >   3660          case FIONBIO:
> > >   3661          case FIOASYNC:
> > >   3662                  error =3D file_has_perm(cred, file, 0);
> > >   3663                  break;
> > >   3664
> > >   3665          case KDSKBENT:
> > >   3666          case KDSKBSENT:
> > >   3667                  error =3D cred_has_capability(cred, CAP_SYS_T=
TY_CONFIG,
> > >   3668                                              CAP_OPT_NONE, tru=
e);
> > >   3669                  break;
> > >   3670
> > >   3671          case FIOCLEX:
> > >   3672          case FIONCLEX:
> > >   3673                  if (!selinux_policycap_ioctl_skip_cloexec())
> > >   3674                          error =3D ioctl_has_perm(cred, file, =
FILE__IOCTL, (u16) cmd);
> > >   3675                  break;
> > >   3676
> > >   3677          /* default case assumes that the command will go
> > >   3678           * to the file's ioctl() function.
> > >   3679           */
> > >   3680          default:
> > >   3681                  error =3D ioctl_has_perm(cred, file, FILE__IO=
CTL, (u16) cmd);
> > >   3682          }
> > >   3683          return error;
> > >   3684  }
> > >   3685

Hey Stephen,

Thanks for looking into it a bit deeper! This seems a bit of a pickle.
I can think of a few somewhat hacky ways to fix this.

I can just set the flags to check `if FS_IOC32_*; set FS_IOC_*;`,
which is the quickest but kinda hacky.

I can go with the other plan of dropping the irrelevant bytes from the
cmd code, so all codes will be read as u16. This effectively does the
same thing, but may be unclear.

I can also look into whether this can be solved at the LSM or a higher
level. Perhaps the filesystems setting `if FS_IOC32_*; set FS_IOC_*;`
is a hint that something else interesting is going wrong.

I'll spend a little time thinking and investigating and get back with
a more concrete solution. I'll also need to do a bit more robust
testing; it built on my machine!

Thanks!
