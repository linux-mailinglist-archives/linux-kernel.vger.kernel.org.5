Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22579D540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbjILPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjILPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:46:28 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209E10EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:46:24 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RlScF0mcwzMqlp5;
        Tue, 12 Sep 2023 15:46:21 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RlScD1H0czMppKW;
        Tue, 12 Sep 2023 17:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694533580;
        bh=PjHSJ2i24/0IRXkTVDT85ZT3QyF362F0WtU2kWoWeqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/pzsr6erqilAvJiPKztzm9RGP6/1+cy9HIyQ5XO5Y7i2OjMtoxq/HqEfx35a2bmY
         fK9TggOu3DpFfPsj8545w1BkX+C83DZGM9y8NzHLKd6GH8UKvP1qk8XRzy/JuP5/fC
         aV5Uz//B00fU0C7aA657F1q1Bdoe0bQMps7+E/2Y=
Date:   Tue, 12 Sep 2023 17:46:16 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Alfred Piccioni <alpic@google.com>,
        kernel test robot <lkp@intel.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
Message-ID: <20230912.Vic4uMaithoh@digikod.net>
References: <20230906115928.3749928-1-alpic@google.com>
 <202309090600.NSyo7d2q-lkp@intel.com>
 <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
 <CAEjxPJ4uoqkwmbeOOmUHJwoKiK3cnfJP5P2w+hOXr4BZNtQ+JQ@mail.gmail.com>
 <CALcwBGBPaYh98d+3_3k8o+8WCbYU8cNPoOHaqhUduKZYz7Ntow@mail.gmail.com>
 <CAEjxPJ6gFh7h5MnEEqTL34_dVEoAmoGfqa01eeYHnOECjkYxBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ6gFh7h5MnEEqTL34_dVEoAmoGfqa01eeYHnOECjkYxBg@mail.gmail.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:00:12AM -0400, Stephen Smalley wrote:
> On Tue, Sep 12, 2023 at 5:00 AM Alfred Piccioni <alpic@google.com> wrote:
> >
> > On Mon, Sep 11, 2023 at 3:49 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, Sep 11, 2023 at 9:19 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 8, 2023 at 6:54 PM kernel test robot <lkp@intel.com> wrote:
> > > > >
> > > > > Hi Alfred,
> > > > >
> > > > > kernel test robot noticed the following build errors:
> > > > >
> > > > > [auto build test ERROR on 50a510a78287c15cee644f345ef8bac8977986a7]
> > > > >
> > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Alfred-Piccioni/SELinux-Check-correct-permissions-for-FS_IOC32_/20230906-200131
> > > > > base:   50a510a78287c15cee644f345ef8bac8977986a7
> > > > > patch link:    https://lore.kernel.org/r/20230906115928.3749928-1-alpic%40google.com
> > > > > patch subject: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
> > > > > config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230909/202309090600.NSyo7d2q-lkp@intel.com/config)
> > > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090600.NSyo7d2q-lkp@intel.com/reproduce)
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.NSyo7d2q-lkp@intel.com/
> > > > >
> > > > > All errors (new ones prefixed by >>):
> > > > >
> > > > >    security/selinux/hooks.c: In function 'selinux_file_ioctl':
> > > > > >> security/selinux/hooks.c:3647:9: error: duplicate case value
> > > > >     3647 |         case FS_IOC32_GETFLAGS:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3645:9: note: previously used here
> > > > >     3645 |         case FS_IOC_GETFLAGS:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3648:9: error: duplicate case value
> > > > >     3648 |         case FS_IOC32_GETVERSION:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3646:9: note: previously used here
> > > > >     3646 |         case FS_IOC_GETVERSION:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3654:9: error: duplicate case value
> > > > >     3654 |         case FS_IOC32_SETFLAGS:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3652:9: note: previously used here
> > > > >     3652 |         case FS_IOC_SETFLAGS:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3655:9: error: duplicate case value
> > > > >     3655 |         case FS_IOC32_SETVERSION:
> > > > >          |         ^~~~
> > > > >    security/selinux/hooks.c:3653:9: note: previously used here
> > > > >     3653 |         case FS_IOC_SETVERSION:
> > > > >          |         ^~~~
> > > >
> > > > Not sure of the right way to fix this while addressing the original
> > > > issue that this patch was intended to fix. Looking in fs/ioctl.c, I
> > > > see that the some FS_IOC32 values are remapped to the corresponding
> > > > FS_IOC values by the compat ioctl syscall entrypoint. Also notice this
> > > > comment there:
> > > >
> > > >         /* RED-PEN how should LSM module know it's handling 32bit? */
> > > >         error = security_file_ioctl(f.file, cmd, arg);
> > > >         if (error)
> > > >                 goto out;
> > > >
> > > > So perhaps this is a defect in LSM that needs to be addressed?
> > >
> > > Note btw that some of the 32-bit ioctl commands are only handled in
> > > the fs-specific compat_ioctl routines, e.g. ext4_compat_ioctl()
> > > handles EXT4_IOC32_GETVERSION == FS_IOC32_GETVERSION and ditto for
> > > _SETVERSION.
> > >
> > > >
> > > >
> > > > >
> > > > >
> > > > > vim +3647 security/selinux/hooks.c
> > > > >
> > > > >   3634
> > > > >   3635  static int selinux_file_ioctl(struct file *file, unsigned int cmd,
> > > > >   3636                                unsigned long arg)
> > > > >   3637  {
> > > > >   3638          const struct cred *cred = current_cred();
> > > > >   3639          int error = 0;
> > > > >   3640
> > > > >   3641          switch (cmd) {
> > > > >   3642          case FIONREAD:
> > > > >   3643          case FIBMAP:
> > > > >   3644          case FIGETBSZ:
> > > > >   3645          case FS_IOC_GETFLAGS:
> > > > >   3646          case FS_IOC_GETVERSION:
> > > > > > 3647          case FS_IOC32_GETFLAGS:
> > > > >   3648          case FS_IOC32_GETVERSION:
> > > > >   3649                  error = file_has_perm(cred, file, FILE__GETATTR);
> > > > >   3650                  break;
> > > > >   3651
> > > > >   3652          case FS_IOC_SETFLAGS:
> > > > >   3653          case FS_IOC_SETVERSION:
> > > > >   3654          case FS_IOC32_SETFLAGS:
> > > > >   3655          case FS_IOC32_SETVERSION:
> > > > >   3656                  error = file_has_perm(cred, file, FILE__SETATTR);
> > > > >   3657                  break;
> > > > >   3658
> > > > >   3659          /* sys_ioctl() checks */
> > > > >   3660          case FIONBIO:
> > > > >   3661          case FIOASYNC:
> > > > >   3662                  error = file_has_perm(cred, file, 0);
> > > > >   3663                  break;
> > > > >   3664
> > > > >   3665          case KDSKBENT:
> > > > >   3666          case KDSKBSENT:
> > > > >   3667                  error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
> > > > >   3668                                              CAP_OPT_NONE, true);
> > > > >   3669                  break;
> > > > >   3670
> > > > >   3671          case FIOCLEX:
> > > > >   3672          case FIONCLEX:
> > > > >   3673                  if (!selinux_policycap_ioctl_skip_cloexec())
> > > > >   3674                          error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> > > > >   3675                  break;
> > > > >   3676
> > > > >   3677          /* default case assumes that the command will go
> > > > >   3678           * to the file's ioctl() function.
> > > > >   3679           */
> > > > >   3680          default:
> > > > >   3681                  error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> > > > >   3682          }
> > > > >   3683          return error;
> > > > >   3684  }
> > > > >   3685
> >
> > Hey Stephen,
> >
> > Thanks for looking into it a bit deeper! This seems a bit of a pickle.
> > I can think of a few somewhat hacky ways to fix this.
> >
> > I can just set the flags to check `if FS_IOC32_*; set FS_IOC_*;`,
> > which is the quickest but kinda hacky.
> >
> > I can go with the other plan of dropping the irrelevant bytes from the
> > cmd code, so all codes will be read as u16. This effectively does the
> > same thing, but may be unclear.
> >
> > I can also look into whether this can be solved at the LSM or a higher
> > level. Perhaps the filesystems setting `if FS_IOC32_*; set FS_IOC_*;`
> > is a hint that something else interesting is going wrong.
> >
> > I'll spend a little time thinking and investigating and get back with
> > a more concrete solution. I'll also need to do a bit more robust
> > testing; it built on my machine!
> 
> Likewise for me; I don't generally try building for 32-bit systems.
> Remapping FS_IOC32_* to FS_IOC_* in selinux_file_ioctl() seems
> reasonable to me although optimally that would be conditional on
> whether selinux_file_ioctl() is being called from the compat ioctl
> syscall (e.g. adding a flag to the LSM hook to indicate this or using
> a separate hook for it). Otherwise we might misinterpret some other
> ioctl on 64-bit.

I think adding a boolean argument to the LSM hook makes sense. LSMs
might decide to handle it or not, at their own pace.

> 
> If we didn't have compatibility requirements, it would be tempting to
> just get rid of all the special case ioctl command handling in
> selinux_file_ioctl() and let ioctl_has_perm() handle them all with the
> extended ioctl permissions support. But that would require a SELinux
> policy cap to switch it on conditionally for compatibility at least
> and not sure anyone is willing to refactor their policies accordingly.
