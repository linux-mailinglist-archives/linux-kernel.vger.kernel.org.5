Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19107DAB39
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 07:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJ2G4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 02:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2G4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 02:56:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD700D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 23:56:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507b9408c61so4744328e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698562602; x=1699167402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFy+RcQKDTr5alLvXeX4agQqROH2cD25D/5nFBfzPhg=;
        b=AvwSWKKknnogUyeWXHTFhnfjEZA6DUXj98dg6d1NzssR0315p138vk/lIRrcyhC4K5
         sI4BP2h+9X6W0Cre9Q+cjFUQSttwfkhcdXmZXKpiklrJ8dZQt7TJltblc7mRGt2bvwZD
         rOIGcImmthU0wYTGWaS0tuaftQhsopywvHDrDyMNtTHa1x0R4BuRArGPx2HHrr7LKCuv
         +OUPMWtAWneaoDPvHGuwuIWmichdWH5z1w87tXB3TdftpYQ1rAJbOKkESPkQtAEJDrt+
         yX7xGp3K02G7tziuhFQBUmKyB6ZZkTOVB6F75afrT92qUAeY7hoTMFNJxFt6AzYWCP2G
         KQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698562602; x=1699167402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFy+RcQKDTr5alLvXeX4agQqROH2cD25D/5nFBfzPhg=;
        b=xRk3P5luaQSB6C0GsOIJj+3l1yTTvAMk+/z2WMtbMP/9ZDS0u3Gaz+vO884O7Rzafn
         naxVLca9oz+stUhuNCo2vP3QP0F9LfEyzmHmf1zCLDt5eJwhlt8KU0r+VOpprYv4VvwX
         lF+ONP0wKumgda1pe7qVmbqz5AJ0qbudCLrds2iqQC+7Nh6dusHtTL/NIOTy1Y4oWdi3
         8PIxLR/xtZHGWZsWCjDwx9tSG4aZDZv795b/PzGM5Vk36u3luD9gd5wPLLqdbPsUljcS
         PIx1w7HqXq43Yx+Z2mAbtmSRfCEfl+CF57dh5d8k/cVwYu7rlHkmtW9/pdwD+WRl8pVA
         Ty2w==
X-Gm-Message-State: AOJu0YwoZb2OAU6G+pKdTFB/eetgvO8vNyXmT6T9KKYwuE0Q60yjxnLh
        blTxIAVeBd97f7I0clWF5apP6uJtRNvHjdMWxQ==
X-Google-Smtp-Source: AGHT+IFVlRp0lfPgmcGpvpQ+VxM6tmfRLa2oMOe+jrJ/VXYD16A92VETn9a3ezMosmaB6pYNxaHV1+wDiwSesV19a+E=
X-Received: by 2002:ac2:5226:0:b0:507:9a00:c169 with SMTP id
 i6-20020ac25226000000b005079a00c169mr4754464lfl.5.1698562601649; Sat, 28 Oct
 2023 23:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-6-brgerst@gmail.com> <202310290927.2MuJJdu9-lkp@intel.com>
In-Reply-To: <202310290927.2MuJJdu9-lkp@intel.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 29 Oct 2023 02:56:30 -0400
Message-ID: <CAMzpN2iUrfnuGQ9eFTr=NTeC6KSUPC37Qji5_g5MWejmXnXO3A@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] x86/stackprotector/64: Convert stack protector
 to normal percpu variable
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
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

On Sat, Oct 28, 2023 at 9:26=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Brian,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/master]
> [also build test ERROR on next-20231027]
> [cannot apply to tip/x86/core dennis-percpu/for-next linus/master tip/aut=
o-latest v6.6-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gerst/x86-st=
ackprotector-32-Remove-stack-protector-test-script/20231027-000533
> base:   tip/master
> patch link:    https://lore.kernel.org/r/20231026160100.195099-6-brgerst%=
40gmail.com
> patch subject: [PATCH v2 05/11] x86/stackprotector/64: Convert stack prot=
ector to normal percpu variable
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/202=
31029/202310290927.2MuJJdu9-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git =
ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231029/202310290927.2MuJJdu9-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310290927.2MuJJdu9-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> Unsupported relocation type: unknown type rel type name (42)

Clang is generating a new relocation type (R_X86_64_REX_GOTPCRELX)
that the relocs tool doesn't know about.  This is supposed to allow
        movq    __stack_chk_guard@GOTPCREL(%rip), %rax
        movq    %gs:(%rax), %rax
to be relaxed to
        leaq    __stack_chk_guard(%rip), %rax
        movq    %gs:(%rax), %rax

But why is clang doing this instead of what GCC does?
        movq    %gs:__stack_chk_guard(%rip), %rax

Brian Gerst
