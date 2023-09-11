Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A8F79B5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbjIKWPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbjIKNTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:19:19 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EBFEB;
        Mon, 11 Sep 2023 06:19:14 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bd8639e7e5so3288375a34.1;
        Mon, 11 Sep 2023 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438354; x=1695043154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZAzIIMzf1qPGHHQFdp02fgFY8ovyjwDuzAUQe5+kww=;
        b=Nd4oHenOHfHGXOPqHZ2VN4aefvLQBjoKU1RkgClvfYM54W7ADDIVhdzIZ/VJgEwdMe
         SebwEdM1UgrzQJhJ73ljlqdq7Hrk6eVyeNHuZUG4E3ALESGq2r4QUI05F7OpYDNw3/08
         5YojrUBHPVbnJKO3UHWcC30BMboRgj6fy8+6TzDZ47DZgMSmX2culGDDUTwBozrxYQ02
         QLam8zpEq3R6Ny36DwE0TJT+qTVkJTpjqfu1WfT1Y5NAzt6p3Znd7GMtVJtkG1qPQ/lK
         HWsSVrnC7Igw84jTsmZAclhpWpDYen/b+4AONJUv+3NxY4g+ZLMj7OUsyajyxGhGEKbA
         yd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438354; x=1695043154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZAzIIMzf1qPGHHQFdp02fgFY8ovyjwDuzAUQe5+kww=;
        b=QRtQk3dyzPKWGlurVUQugdjVldYRHkjtDl+P952qDSJ+Gavskgfc/2I6kWkjOS6JS9
         tkwSyVzBVxtAPdxGyVOiKURZBMK4uU96IrPhqBsQ51QQH3Ff1870g6ZSTjFzUeRVSwop
         h582LSdfJC9wd1xt07mQlNd9CjzCHGnpwk2DRFXK6jkQ1TSySgAhkow73x0PlLbRFucg
         bywZJNZAiuOnHdq+RE4zmSalNC6IvvWNi/xQfVbew8ubKXyQh3ofo+cbgNxAzi/MDIMx
         UOPfq6uTXSS6wQ2bTBvmzqImZEhD7DXljHqsNWHfdV5wd6t/toohmdurHT02qUv+ZF1P
         uPRw==
X-Gm-Message-State: AOJu0YycR1TbyZiUJtZ9gKg+WL+yyL2V22wkBA1LD8ZuPA8qgEizwAeO
        Yarw+L4p/oNOnt9imINWBf3h9YzIYXGyp4mG1MM=
X-Google-Smtp-Source: AGHT+IF8qbD6uz9otQZQEGtQsPL1DHxdrKK0dBiU8LawxxVZ1ppEHEbFpM8gS5aweNPYJmJhdCoyODSPMja4C28SAFU=
X-Received: by 2002:a05:6830:2088:b0:6c0:b3fb:2e65 with SMTP id
 y8-20020a056830208800b006c0b3fb2e65mr10241850otq.16.1694438354175; Mon, 11
 Sep 2023 06:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230906115928.3749928-1-alpic@google.com> <202309090600.NSyo7d2q-lkp@intel.com>
In-Reply-To: <202309090600.NSyo7d2q-lkp@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 11 Sep 2023 09:19:02 -0400
Message-ID: <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
To:     kernel test robot <lkp@intel.com>
Cc:     Alfred Piccioni <alpic@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 6:54=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Alfred,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 50a510a78287c15cee644f345ef8bac8977986a7]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alfred-Piccioni/SE=
Linux-Check-correct-permissions-for-FS_IOC32_/20230906-200131
> base:   50a510a78287c15cee644f345ef8bac8977986a7
> patch link:    https://lore.kernel.org/r/20230906115928.3749928-1-alpic%4=
0google.com
> patch subject: [PATCH V2] SELinux: Check correct permissions for FS_IOC32=
_*
> config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/2023090=
9/202309090600.NSyo7d2q-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230909/202309090600.NSyo7d2q-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.NSyo7d2q-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    security/selinux/hooks.c: In function 'selinux_file_ioctl':
> >> security/selinux/hooks.c:3647:9: error: duplicate case value
>     3647 |         case FS_IOC32_GETFLAGS:
>          |         ^~~~
>    security/selinux/hooks.c:3645:9: note: previously used here
>     3645 |         case FS_IOC_GETFLAGS:
>          |         ^~~~
>    security/selinux/hooks.c:3648:9: error: duplicate case value
>     3648 |         case FS_IOC32_GETVERSION:
>          |         ^~~~
>    security/selinux/hooks.c:3646:9: note: previously used here
>     3646 |         case FS_IOC_GETVERSION:
>          |         ^~~~
>    security/selinux/hooks.c:3654:9: error: duplicate case value
>     3654 |         case FS_IOC32_SETFLAGS:
>          |         ^~~~
>    security/selinux/hooks.c:3652:9: note: previously used here
>     3652 |         case FS_IOC_SETFLAGS:
>          |         ^~~~
>    security/selinux/hooks.c:3655:9: error: duplicate case value
>     3655 |         case FS_IOC32_SETVERSION:
>          |         ^~~~
>    security/selinux/hooks.c:3653:9: note: previously used here
>     3653 |         case FS_IOC_SETVERSION:
>          |         ^~~~

Not sure of the right way to fix this while addressing the original
issue that this patch was intended to fix. Looking in fs/ioctl.c, I
see that the some FS_IOC32 values are remapped to the corresponding
FS_IOC values by the compat ioctl syscall entrypoint. Also notice this
comment there:

        /* RED-PEN how should LSM module know it's handling 32bit? */
        error =3D security_file_ioctl(f.file, cmd, arg);
        if (error)
                goto out;

So perhaps this is a defect in LSM that needs to be addressed?


>
>
> vim +3647 security/selinux/hooks.c
>
>   3634
>   3635  static int selinux_file_ioctl(struct file *file, unsigned int cmd=
,
>   3636                                unsigned long arg)
>   3637  {
>   3638          const struct cred *cred =3D current_cred();
>   3639          int error =3D 0;
>   3640
>   3641          switch (cmd) {
>   3642          case FIONREAD:
>   3643          case FIBMAP:
>   3644          case FIGETBSZ:
>   3645          case FS_IOC_GETFLAGS:
>   3646          case FS_IOC_GETVERSION:
> > 3647          case FS_IOC32_GETFLAGS:
>   3648          case FS_IOC32_GETVERSION:
>   3649                  error =3D file_has_perm(cred, file, FILE__GETATTR=
);
>   3650                  break;
>   3651
>   3652          case FS_IOC_SETFLAGS:
>   3653          case FS_IOC_SETVERSION:
>   3654          case FS_IOC32_SETFLAGS:
>   3655          case FS_IOC32_SETVERSION:
>   3656                  error =3D file_has_perm(cred, file, FILE__SETATTR=
);
>   3657                  break;
>   3658
>   3659          /* sys_ioctl() checks */
>   3660          case FIONBIO:
>   3661          case FIOASYNC:
>   3662                  error =3D file_has_perm(cred, file, 0);
>   3663                  break;
>   3664
>   3665          case KDSKBENT:
>   3666          case KDSKBSENT:
>   3667                  error =3D cred_has_capability(cred, CAP_SYS_TTY_C=
ONFIG,
>   3668                                              CAP_OPT_NONE, true);
>   3669                  break;
>   3670
>   3671          case FIOCLEX:
>   3672          case FIONCLEX:
>   3673                  if (!selinux_policycap_ioctl_skip_cloexec())
>   3674                          error =3D ioctl_has_perm(cred, file, FILE=
__IOCTL, (u16) cmd);
>   3675                  break;
>   3676
>   3677          /* default case assumes that the command will go
>   3678           * to the file's ioctl() function.
>   3679           */
>   3680          default:
>   3681                  error =3D ioctl_has_perm(cred, file, FILE__IOCTL,=
 (u16) cmd);
>   3682          }
>   3683          return error;
>   3684  }
>   3685
