Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE57BC7F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjJGN3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:29:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE6AB;
        Sat,  7 Oct 2023 06:29:48 -0700 (PDT)
X-QQ-mid: bizesmtp88t1696685377tixjkyac
Received: from linux-lab-host.localdomain ( [116.30.131.235])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 07 Oct 2023 21:29:36 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: uGhnJwy6xZJV/e0VH8OkfFMOH//RSXNosQBDUF7ZgNu4tnUxukivDhU5cuyB7
        XloNsxalsLoVEKJoacjMo8tIjByfc9yws6qcaf5yIW9vl4Sv8vreGJSeYU7AnrWpgiDjEGA
        /jVVbA5i3USp5MjqqBTn7YOLTz3XIIk0qn5ClJkR2xmjHJe1kDXBygKbAmPMgDx5LOtLS6Y
        9eGAxj+0xWVb5DMJ2JSUQzJYwkL0JeVKE3cTS2GilDQ4XBJ2f3/XgtY2brOAxG5IBiIEp74
        u6q4EA4mlAyAUABRZ/h/CfeFTtBNqUYqJFiYk/TTGJP+USiKteN/iTi3Ckn6dFgQ/1ZCpgf
        WHHE9ur/U9x9YStAXTpSGRtqgQrNZ5IHLT5LFabhyeGDssoI6sMKWeHh1cdKI6fImGtbTAq
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8522446484513126745
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        tim.bird@sony.com
Subject: Re: [PATCH v1 6/7] DCE/DSE: riscv: add HAVE_TRIM_UNUSED_SYSCALLS support
Date:   Sat,  7 Oct 2023 21:29:35 +0800
Message-Id: <20231007132935.6276-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3a8f0d0a-25ad-49c3-9cd2-66db44a4a1e6@app.fastmail.com>
References: <3a8f0d0a-25ad-49c3-9cd2-66db44a4a1e6@app.fastmail.com>
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

> On Tue, Sep 26, 2023, at 00:42, Zhangjin Wu wrote:
> > For HAVE_TRIM_UNUSED_SYSCALLS, the syscall tables are hacked with the
> > inputing unused_syscalls.
> >
> > Firstly, the intermediate preprocessed .i files are generated from the
> > original C version of syscall tables respectively, and named with a
> > 'used' suffix: syscall_table_used.i, compat_syscall_table_used.i.
> >
> > Secondly, all of the unused syscalls are commented.
> >
> > At last, two new objective files sufixed with 'used' are generated from
> > the hacked .i files and they are linked into the eventual kernel image.
> >
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> 
> As mentioned in my comment on the mips patch, hacking the preprocessed
> file here is too much strain on the old infrastructure, the
> asm-generic/unistd.h file is already too hard to understand for
> anyone and in need of an overhaul, so let's work together on fixing
> it up first.
>

Ok, I was thinking about using asm/syscall_table.h instead of asm/unistd.h like mips.

    void * const sys_call_table[NR_syscalls] = {
    	[0 ... NR_syscalls - 1] = __riscv_sys_ni_syscall,
    #include <asm/syscall_table.h>
    };

Therefore, we can generate syscall_table.h from asm/unist.h with a tool like scripts/syscallused.sh

Another solution may be firstly generate a list of `#define __USED_NR_##call 1`
for the used syscalls from Kconfig symbol, and then change __SYSCALL() macro
to:

   #define __SYSCALL(nr, call)     [nr] = __is_defined(__USED_NR_##call) ? __riscv_##call : __riscv_sys_ni_syscall,

`include/linux/kconfig.h` defined the '__is_defined'.

This method may work for the archs with .tbl files too.

Thanks,
Zhangjin

>       Arnd
