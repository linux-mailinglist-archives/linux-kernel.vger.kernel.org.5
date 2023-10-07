Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B977BC7FC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbjJGNgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:36:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB62BA;
        Sat,  7 Oct 2023 06:36:03 -0700 (PDT)
X-QQ-mid: bizesmtp86t1696685746tumf87vq
Received: from linux-lab-host.localdomain ( [116.30.131.235])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 07 Oct 2023 21:35:45 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: 3M0okmaRx3jgGcczq7ckLHewl2tbA5gqgi51LqUGP7as6L5o4OHQBGbMr+O0K
        Ev5u1YtIpPxQGtJlVHeYgCFGWuSyU4pupUt3i9h5i6zVcsE9kmXpl7AbGbnnLBOxIZeJQPL
        +Uf+RAHoyB1WFXVIuEQ+hM+OUqylNxlzXA9MGEgfMEhjuEEyP835Kv4abK53J0LUbGOnySj
        JxxpaCy54pY0AHvDEJ/5ycR62jiLW/n5w+rhGGqYxuoJG8GNAJr8OBXEIj6XKza1Sw4w5Nj
        27F3twjB0oVAqiVQJOYZP6DupfkRZWP2HbTzQPMtM/u15Tu153r5elnFLt4UgaJcgJmVG0Z
        mQlI8VDelUKWCRAEg97X1DbevJXNLRuEWG8ACCAxcpwN6vtCWNF6jsT4uDBoQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6264558970741984576
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        tim.bird@sony.com, tanyuan@tinylab.org
Subject: Re: [PATCH v1 7/7] DCE/DSE: riscv: trim syscall tables
Date:   Sat,  7 Oct 2023 21:35:44 +0800
Message-Id: <20231007133544.6580-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e160b4df-92ce-4b9c-96ba-200f259c8216@app.fastmail.com>
References: <e160b4df-92ce-4b9c-96ba-200f259c8216@app.fastmail.com>
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

> On Tue, Sep 26, 2023, at 00:43, Zhangjin Wu wrote:
> > When the maximum nr of the used syscalls is smaller than __NR_syscalls
> > (original syscalls total). It is able to update __NR_syscalls to
> > (maximum nr + 1) and further trim the '>= (maximum nr + 1)' part of the
> > syscall tables:
> >
> > For example:
> >
> >     sys_call_table [143] = {
> > 	[0 ... 143 - 1] = sys_ni_syscall,
> >         [64] = sys_write,
> >         [93] = sys_exit,
> >         [142] = sys_reboot,
> >     }
> >
> > The >= 143 part of the syscall tables can be trimmed.
> >
> > At the same time, the syscall >= 143 from user space must be ignored
> > from do_trap_ecall_u() of traps.c.
> >
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  arch/riscv/include/asm/unistd.h               |  2 ++
> >  arch/riscv/kernel/Makefile                    |  2 ++
> >  arch/riscv/kernel/syscalls/Makefile           | 22 +++++++++++++++++++
> >  .../kernel/syscalls/compat_syscall_table.c    |  4 ++--
> >  arch/riscv/kernel/syscalls/syscall_table.c    |  4 ++--
> >  5 files changed, 30 insertions(+), 4 deletions(-)
> 
> This bit feels like you are overoptimizing for a corner case:
> there is not much to be gained in terms of memory savings, but
> you add complexity in an area that I feel should be made common
> between architectures.
> 
> I hope to get back to working on consolidating both the
> syscall.tbl input files and the build infrastructure for them
> across architectures, and you make that harder here, so I'd
> prefer you to drop this part, at least until the code is
> shared across all architectures.
>

Agree, let's drop it.

Thanks,
Zhangjin

>     Arnd
