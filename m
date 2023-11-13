Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888897E9702
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 08:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjKMHUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 02:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjKMHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 02:20:09 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E910E5;
        Sun, 12 Nov 2023 23:20:04 -0800 (PST)
X-QQ-mid: bizesmtp63t1699859986trcai2ec
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 13 Nov 2023 15:19:43 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: CR3LFp2JE4kJjXOcdkorczscpSzH6+axHpSU32WFVYbv/RGXMGwZNm0mqCz6D
        gz9/sgtHdEu0Hpdze0GuS3D6Irg4Df8QiNwDsaA6ysM60/Ho50JMfM3UXJDjxhxTAQJmf08
        2g+pmLbzG6sqegUOfI7Bqk0cBi8wPyNlP79jzi4+2G/4EB+bteo4XqATZZMPqdIZxNerVW7
        zYzBrU5bsvqnxAgq9RY7WWSKOF4WLCtt1HmqlkFh/RReaAs7ttv7DELAls5+VJ7BadjYxZ5
        lnXtZ30WpuH37gpQ2xpywx2N6bQQzJWukdBKANUZas2U6RtWXYUj1hf5q4jZyp24XNNb9tI
        jXfxcsenjYsV+UPuIj2lO0Tur+eydKLmUqICFwU
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17312017847681261293
From:   Yuan Tan <tanyuan@tinylab.org>
To:     i@maskray.me
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux@weissschuh.net,
        luc.vanoostenryck@gmail.com, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tanyuan@tinylab.org, tim.bird@sony.com,
        tsbogend@alpha.franken.de, w@1wt.eu
Subject: Re: [PATCH v1 09/14] DCE/DSE: inhibit .size directive for SHF_GROUP
Date:   Mon, 13 Nov 2023 15:19:42 +0800
Message-Id: <20231113071942.35259-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DS7PR12MB576503711253C682DCE40524CBABA@DS7PR12MB5765.namprd12.prod.outlook.com>
References: <DS7PR12MB576503711253C682DCE40524CBABA@DS7PR12MB5765.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fangrui

Thank you for your time :)

On 11/6/2023 4:50 AM, Fangrui Song wrote:
> On Fri, Nov 3, 2023 at 9:01 AM Yuan Tan <tanyuan@tinylab.org> wrote:
> >
> > .size directive fails in some functions with SHF_GROUP, this is not
> > really required for normal building, inhibit it to silence the compiling
> > failures with SHF_GROUP.
> >
> > Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index a4e522b747cb..f67b6e8d2c45 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -936,6 +936,9 @@ endif
> >  # `rustc`'s `-Zfunction-sections` applies to data too (as of 1.59.0).
> >  ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >  KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
> > +ifdef CONFIG_SECTION_SHF_GROUP_SUPPORT
> > +KBUILD_CFLAGS_KERNEL += -finhibit-size-directive
> > +endif
> >  KBUILD_RUSTFLAGS_KERNEL += -Zfunction-sections=y
> >  LDFLAGS_vmlinux += --gc-sections
> >  ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION_DEBUG
> > --
> > 2.34.1
> >
> 
> Clang doesn't support -finhibit-size-directive, so this would break
> Clang builds.

Currently, Clang doesn't support LD_DEAD_CODE_DATA_ELIMINATION. So in this
patch series I didn't take much thought about clang.

> 
> GCC has had this option since 1992, but it is not used in the wild.
> https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-finhibit-size-directive
> says
> 
> > ... This option is used when compiling crtstuff.c; you should not need to use it for anything else.
> 
> What problem have you seen with .size directives (st_size field in
> symbol table entries)?

$ make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- fs/ioctl.o
/tmp/ccy5E3wN.s: Error: .size expression for __riscv_sys_ioctl does not evaluate to a constant
make[3]: *** [scripts/Makefile.build:243: fs/ioctl.o] Error 1
make[2]: *** [scripts/Makefile.build:480: fs] Error 2
make[1]: *** [/home/tanyuan/projects/linux/Makefile:1916: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

And the fs/ioctl.s is like
	.section	.text.__riscv_sys_ioctl,"ax",@progbits
	.align	1
	.globl	__riscv_sys_ioctl
	.type	__riscv_sys_ioctl, @function
__riscv_sys_ioctl:
        ...
        ...
	.size	__riscv_sys_ioctl, .-__riscv_sys_ioctl

I cannot understand this error and this option just solve the problem :)

> 
> % cat a.c
> int v;
> void f() {}
> % diff -u0 <(gcc -S a.c -o -) <(gcc -S -finhibit-size-directive a.c -o -)
> --- /proc/self/fd/11    2023-11-05 12:42:51.298618475 -0800
> +++ /proc/self/fd/15    2023-11-05 12:42:51.298618475 -0800
> @@ -7 +6,0 @@
> -       .size   v, 4
> @@ -27 +25,0 @@
> -       .size   f, .-f
> 
> 
