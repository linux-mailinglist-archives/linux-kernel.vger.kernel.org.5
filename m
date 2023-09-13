Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B879F4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjIMWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:19:08 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7AC198B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:19:04 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58dfe2d5b9aso5186327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694643543; x=1695248343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pve2evvQG8Wu6dcM6eIRAvQq/3oe/203mcy+b19gA8=;
        b=JXbUn+C9hYr/UbHJPlAGR8ydV8unkggCBmeHKJrtstvUXX5xlvGSLHbVR2PGqqqga3
         RBNAKTCLk18m6fy1aCkgJUriHC4Br0AtOieTzKtoq2N7PcBka1sfSi8LLyFUU/w+b6A6
         JZmuQRxhom7rrHmoxkNnvNXVnUp1TogQlszyEjF/K6Lkr7EnUpMi3HOZ80v78mnKIaeE
         VtcW9ptQ83XitvjCAUe4LB4G2KQvkoU39Ww5BdMUpr84JMNjcm4gStsOsMcxtYyu75yx
         Hua1TEXEyX2C7P+AzlNzDA0njmcKZ89FJoB8khjZokXn8YeLtzB9vM0nW6TiuO6R8+bG
         wIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643543; x=1695248343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pve2evvQG8Wu6dcM6eIRAvQq/3oe/203mcy+b19gA8=;
        b=GKTdPmjjS9UnRKX0S2k+oQRBexgS0l9oyM7fRbOPZHQ0UyxI0IrGdm9ooo8YBvhTNY
         mliV6kYWu6M8/iJUdPko9EGjnNKT134QRk20eDsY6bsf6R/DRsxxlmRioHN9Kr6IG/IN
         sYD6C2Gghqf/4GBds9qTbcZneMCqVGk7hGhwf6hHyeMgdTTw3OSIwvIdc6IOqYKeP1FW
         ixAksjSnj6rdQQFfpWecdpFaK36tx4pFAJdsDe8PJrJ46S1pYhIIvDwSQTUOsgNKoX4c
         V3DSZv1JIuLX5Qh27EgmMAzf26bKNqcni4jKTE/OJj3ebtOb/R5v5PD1zzhM2KlCrFKf
         UfIg==
X-Gm-Message-State: AOJu0YwsCVmJvY56xaUx+fcZK5290Qumvfvxv0tAKsj7t2RWgaO0tT7R
        Myjk2Sc6iJiqy97N8iVY2/YBPpoe3/l03Rx/2rq7
X-Google-Smtp-Source: AGHT+IHd6f6RECjVcqmCL7A7894346dihNwE1aPIds0EMQzgoG2VHb2Uwc+wEHwTPX1DhNcQCvdHYBRnbGkUN+jxvow=
X-Received: by 2002:a81:91d3:0:b0:59b:52c2:5f15 with SMTP id
 i202-20020a8191d3000000b0059b52c25f15mr19342ywg.25.1694643543316; Wed, 13 Sep
 2023 15:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZOXG/VVC1XRc7TtI@gmail.com> <202308240128.Gsn0b0Fv-lkp@intel.com>
In-Reply-To: <202308240128.Gsn0b0Fv-lkp@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 18:18:52 -0400
Message-ID: <CAHC9VhS2Smf9V0xJoBeuVfpMP2fhUnn8za_rLzJCmLB_-wBVLA@mail.gmail.com>
Subject: Re: [PATCH] lsm: constify 'mnt_opts' parameter in security_free_mnt_opts()
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ztarkhani@microsoft.com,
        alison.schofield@intel.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 1:22=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Khadija,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on pcmoore-selinux/next]
> [also build test ERROR on pcmoore-audit/next linus/master v6.5-rc7 next-2=
0230823]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/lsm=
-constify-mnt_opts-parameter-in-security_free_mnt_opts/20230823-170310
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.g=
it next
> patch link:    https://lore.kernel.org/r/ZOXG%2FVVC1XRc7TtI%40gmail.com
> patch subject: [PATCH] lsm: constify 'mnt_opts' parameter in security_fre=
e_mnt_opts()
> config: riscv-randconfig-001-20230823 (https://download.01.org/0day-ci/ar=
chive/20230824/202308240128.Gsn0b0Fv-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git =
f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240128=
.Gsn0b0Fv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308240128.Gsn0b0Fv-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> fs/btrfs/super.c:1523:25: error: passing 'void **' to parameter of typ=
e 'const void **' discards qualifiers in nested pointer types [-Werror,-Win=
compatible-pointer-types-discards-qualifiers]
>            security_free_mnt_opts(&new_sec_opts);
>                                   ^~~~~~~~~~~~~
>    include/linux/security.h:301:42: note: passing argument to parameter '=
mnt_opts' here
>    void security_free_mnt_opts(const void **mnt_opts);
>                                             ^
>    fs/btrfs/super.c:1536:25: error: passing 'void **' to parameter of typ=
e 'const void **' discards qualifiers in nested pointer types [-Werror,-Win=
compatible-pointer-types-discards-qualifiers]
>            security_free_mnt_opts(&new_sec_opts);
>                                   ^~~~~~~~~~~~~
>    include/linux/security.h:301:42: note: passing argument to parameter '=
mnt_opts' here
>    void security_free_mnt_opts(const void **mnt_opts);
>                                             ^
>    fs/btrfs/super.c:1699:26: error: passing 'void **' to parameter of typ=
e 'const void **' discards qualifiers in nested pointer types [-Werror,-Win=
compatible-pointer-types-discards-qualifiers]
>                    security_free_mnt_opts(&new_sec_opts);
>                                           ^~~~~~~~~~~~~
>    include/linux/security.h:301:42: note: passing argument to parameter '=
mnt_opts' here
>    void security_free_mnt_opts(const void **mnt_opts);
>                                             ^
>    3 errors generated.

Hi Khadija, can you check to see if these errors can be resolved?

--=20
paul-moore.com
