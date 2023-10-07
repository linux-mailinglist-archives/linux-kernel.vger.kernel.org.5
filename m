Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F567BC847
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJGOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343893AbjJGOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:07:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA402BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 07:07:38 -0700 (PDT)
X-QQ-mid: bizesmtp71t1696687653t72l74ws
Received: from linux-lab-host.localdomain ( [116.30.131.235])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 07 Oct 2023 22:07:32 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: znfcQSa1hKZKhX27X40Savq3SzwTh6BMfmcCeU6mUPa0F+q0Z0SOvYudDJUc0
        DjvaJYtOnEhHzKQJZrwSAHQFhCynAM80gowZKhcc4Sc92w3lNhUylJ6g9jUcyI7cSIhrvq1
        jvs0EP8xATKkKC/SYVbbv3PNBKuz6OOaOHM3X+KIRsusw/x4CViUPmCuVxSur260h1apNui
        s6e2ncFUvKe4BnnhEJOHVewPTDa7QIYIz29vzcbhUoCDYC/oTk6+zE1xmNX1Ubz98AWkc9d
        mCEE4VrV+dvsLXx43d+gOj5lhnYetZp+DRO4Ox/+brkQ91VJZ0Dq9EPwBFa8YFEozSTlblK
        82pM9zSTeUeRao0q/5TonKEGC5u7pOm9TXqe1LJUN0z4KA5UesG+1A4nqm3Ew==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 172060980312053188
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, rodrigo@sdfg.com.ar, w@1wt.eu
Subject: Re: [PATCH 1/1] tools/nolibc: Add workarounds for centos-7
Date:   Sat,  7 Oct 2023 22:07:27 +0800
Message-Id: <20231007140727.7399-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5d4d14f5-b90d-4fd7-865e-0d64b8520c0e@t-8ch.de>
References: <5d4d14f5-b90d-4fd7-865e-0d64b8520c0e@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas

> On 2023-09-27 15:06:03+0200, Rodrigo Campos wrote:
> ...
> > For now we are work-arounding it by doing basically the same thing I'm doing
> > here:
> > 	https://github.com/opencontainers/runc/blob/96a61d3bf0dcc26343bfafe5112934d73d280dd3/libcontainer/dmz/xstat.h
> > 
> > We then include this file before nolibc.h, and then the type works as fine:
> > 	https://github.com/opencontainers/runc/blob/96a61d3bf0dcc26343bfafe5112934d73d280dd3/libcontainer/dmz/_dmz.c
> > 
> > Would it be acceptable for nolibc if I just define what we use:
> >  * struct statx
> >  * struct statx_timestamp (used inside struct statx)
> >  * STATX_BASIC_STATS (or STATX_* constants too, as you prefer)
> 
> Without __NR_statx this would still only result in dead code.
> 
> *IF* we want to fix/work around this in nolibc it would be more like
> 
>   #ifdef __NR_statx
>   
>   /* whatever was done before */
>   
>   #else
>   
>   int stat(const char *path, struct stat *buf)
>   {
>   	return __sysret(-ENOSYS);
>   }
>   
>   #endif
> 
> Or we drop the #else completely to make it obvious for applications that
> stat() will just not work.

This may worth a patch, sorry for my fault ;-(

And to avoid breaking the older kernel users or especially for some
older kernel books readers, and since this also has introduced some
inconvenience to Willy, perhaps it is valuable to restore original
'sys_stat' support, I will look into how or simply revert the commit but
need to add a new one for powerpc, I will learn how to avoid defining
the extra structure for the not required architectures, the
__ARCH_WANT_SYS_STAT macro may help. I'm also working on cleaning up the
old_select(), old_mmap() and sys_fork()/sys_clone() selection support,
they may be put in a series.

Willy, what about your suggestion?

Thanks,
Zhangjin Wu
