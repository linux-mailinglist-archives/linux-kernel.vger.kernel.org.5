Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B97BC7E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjJGM6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343748AbjJGM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:58:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B0FAB;
        Sat,  7 Oct 2023 05:58:32 -0700 (PDT)
X-QQ-mid: bizesmtp62t1696683499toxoeh80
Received: from linux-lab-host.localdomain ( [116.30.131.235])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 07 Oct 2023 20:58:18 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: znfcQSa1hKZVfh9GrD3uNMtHNu/dw/83w4TCDC4x6Jkd6m4RFK30wwv2HWQDi
        KugXEjBTPsuU63pTKX6kpwf6tCMey5OtbXURMx/GfECLbAQJOHnY1olUoKfE2C0DhXXEGUK
        7vkArlwgpGMvr3PmudYOTzGZUCDAnWzB2lBm/xMADqA0KzWwZ7wW94nePe3r8/ozUgWH+x0
        QeskCUegNlNShOPcCSC/oa6tLrv+mOGQa+JFUsTRHgVVh35NIdfmeXMmYpDS3x12S1KqH6g
        YQtzglvBMd/L1n8DnnFJbiyCecymNKTV74C1HIanc52TVIGytRS/+51gao0723AL6cZSL8Y
        UHsmO2K0qCEQWFiuxIuaZLs4owMb1IpjNmYwTBPO1wKxjIMVXI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4895001494971990047
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        tim.bird@sony.com, tanyuan@tinylab.org
Subject: Re: [PATCH v1 4/7] DCE/DSE: mips: add HAVE_TRIM_UNUSED_SYSCALLS support
Date:   Sat,  7 Oct 2023 20:58:17 +0800
Message-Id: <20231007125817.5259-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <862f42d7-b582-4d88-a9d2-f72ea5bfe903@app.fastmail.com>
References: <862f42d7-b582-4d88-a9d2-f72ea5bfe903@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd

> On Tue, Sep 26, 2023, at 00:40, Zhangjin Wu wrote:
> > For HAVE_TRIM_UNUSED_SYSCALLS, the syscall tables are hacked with the
> > input used syscalls.
> >
> > Based on the used syscalls information, a new version of tbl file is
> > generated from the original tbl file and named with a 'used' suffix.
> >
> > With this new tbl file, both unistd_nr_*.h and syscall_table_*.h files
> > are updated to only include the used syscalls.
> >
> >     $ grep _Linux_syscalls -ur arch/mips/include/generated/asm/
> >     arch/mips/include/generated/asm/unistd_nr_n64.h:#define 
> > __NR_64_Linux_syscalls	165
> >     arch/mips/include/generated/asm/unistd_nr_n32.h:#define 
> > __NR_N32_Linux_syscalls	165
> >     arch/mips/include/generated/asm/unistd_nr_o32.h:#define 
> > __NR_O32_Linux_syscalls	89
> >
> >     $ grep -vr sys_ni_syscall 
> > arch/mips/include/generated/asm/syscall_table_*.h
> >     arch/mips/include/generated/asm/syscall_table_n32.h:__SYSCALL(58, 
> > sys_exit)
> >     arch/mips/include/generated/asm/syscall_table_n32.h:__SYSCALL(164, 
> > sys_reboot)
> >     arch/mips/include/generated/asm/syscall_table_n64.h:__SYSCALL(58, 
> > sys_exit)
> 
> My feeling is that instead of postprocessing the generated files,
> it would be much better to make the elimination part of the
> existing infrastructure that generates the files from syscall.tbl,
> and finally change the include/asm-generic/unistd.h to the
> same format, as we had planned for a long time.
>

Agree very much, then we can simply touch the common files, no need to
touch the arch specific files.

> I should be able to help out with that part.
>

Thanks, is it enough to touch these ones?

    $ ls scripts/syscall*
    scripts/syscallhdr.sh  scripts/syscallnr.sh  scripts/syscalltbl.sh

One question here is that is it possible or required to share the used syscalls
selection code among them?

Another question require your help is the compat part, the compat stuff makes
things harder (include the Kconfig symbol interface definition and select
logic), perhaps we can simply limit our first DSE version under !COMPAT?

Best regards,
Zhangjin

>       Arnd
