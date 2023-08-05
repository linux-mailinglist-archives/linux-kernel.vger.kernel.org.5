Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE77711B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHETOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHETOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:14:16 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF0F180;
        Sat,  5 Aug 2023 12:14:13 -0700 (PDT)
X-QQ-mid: bizesmtp79t1691262849tv1esarj
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 03:14:08 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: +ynUkgUhZJlqMFUsV+V63L4RVv60T1aWAIMIRFHDgi3TzQO7y69a2xSxLE5It
        we58AvBZ13C/4T/k9atIt2EMQHRRi2M72n3nZTBAv3H1aR+a6VAwSBj2bgQFBgfPH19TssA
        JPStRuPxf3Hx6hqsfQiLIrCHJO+KJbkbkgiQtiYG9hriqijtMYgmiAJhahK5s4HMQKlkmUX
        7BAOAuXMYVX+QGv5s5iKzr+PLfFh/vn3s6nhfhhHDVYNOTCeXohUfdk2TtLEemxJeUuSCoj
        dAg7GmTRNwwCHzCo3zjrK3UULoMtYrPJ7tC9cxDTtrBmnFWjILymxAxT/rP/xTgjEQhSt84
        lh11mGlMyO+Oe26tIJSqpdw/GuZrJmT2pPSfzQf901flk+L8YvNxDKt/Ri2Tg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5789592383311383432
From:   Zhangjin Wu <falcon@tinylab.org>
To:     tanyuan@tinylab.org
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux@weissschuh.net,
        tsbogend@alpha.franken.de, w@1wt.eu
Subject: [RFC 0/1] mips: malta: Select PCI_QUIRKS if POWER_RESET_PIIX4_POWEROFF is enabled
Date:   Sun,  6 Aug 2023 03:14:07 +0800
Message-Id: <20230805191407.45290-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <686dbb3128ad4e413b22685cd466a68e1adf670b.1690968173.git.tanyuan@tinylab.org>
References: <686dbb3128ad4e413b22685cd466a68e1adf670b.1690968173.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yuan

To even further reduce the time cost & waste of finding the exact
poweroff options for malta, I suggest to directly select the required
options when CONFIG_POWER_RESET=y:  

    config MIPS_MALTA
    	...
     	select MIPS_L1_CACHE_SHIFT_6
     	select MIPS_MSC
     	select PCI_GT64XXX_PCI0
    +	select PCI if POWER_RESET
    +	select PCI_QUIRKS if POWER_RESET
    +	select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
     	select SMP_UP if SMP
     	select SWAP_IO_SPACE
     	select SYS_HAS_CPU_MIPS32_R1

But it looks a little ugly, let's think about how to improve it.

And aslo, due to the same reason, it is possible to send a RFC patchset
to select required poweroff options for CONFIG_POWER_RESET=y of the
other architectures, like the CONFIG_ACPI=y and CONFIG_PCI=y options for
i386/x86_64 and the CONFIG_MACINTOSH_DRIVERS=y and CONFIG_ADB_CUDA=y for
ppc g3beige.

To simplify the enablement of the poweroff support, selecting the required
options for CONFIG_POWER_RESET=y may make many people happy especially when
they are using a customized config (maybe tinyconfig based) for a target qemu
board. Without normal poweroff support from the kernel side, qemu will simply
hang there after a 'poweroff' command, which is a very bad experience for the
automatical tests. Currently, based on tinyconfig, it is very hard to find the
exact poweroff options, some architectures simply enable poweroff support by
default, the others' poweroff options are hidden deeply, which make things very
hard. 

Thanks,
Zhangjin

> Hi list,
> 
> I just found that the on QEMU Malta, POWER_RESET_PIIX4_POWEROFF relay on
> PCI_QUIRKS to work, or else the reboot will hang.
> 
> Welcome everyone's suggestions.
> 
> Yuan Tan (1):
>   mips: malta: select PCI_QUIRK for POWER_RESET_PIIX4_POWEROFF
> 
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> -- 
> 2.34.1
