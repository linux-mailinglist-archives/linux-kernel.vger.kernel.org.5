Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBB7B3FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjI3Jbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjI3Jbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:31:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6764DD;
        Sat, 30 Sep 2023 02:31:48 -0700 (PDT)
X-QQ-mid: bizesmtp80t1696066296thr4pjsz
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 30 Sep 2023 17:31:33 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: znfcQSa1hKbcYxqfol5fP9hy+d5iapd9bWXb81pkq2JorFRHt2ASdRq962bXO
        Eyl4InpEH2CpYAFUV9l2NYqPU+ovjnAGXlV6VuKPT6l5hIoGbwACL65IFYfcAOI9R5vxSxh
        ZVK2QI8L8KAdq3fCDHpMUKqg5zwNrhJUoqciQm/r0agtEM+FpE3cQOMFpaybcCKzl0E4XwZ
        9z4sDnmlMVDXzTD5KCn1+nfGuufGJHuDtn28ZndGAGAbYBESgzNcHQM4gRGtRIqZuNd1nW1
        fMB4ZZVjW7hiEYljO5IhyEo5/GJCihu7WTCh7i2Ah7wj3qRXX4Mzy/96toY/0Q8o16OgfJV
        7p7T0l6pCJRY2QycXGEvTE4JwG19BRfLV6CaVq6Zbm9SizxlAc=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15485949091047528839
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu
Subject: Re: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support, part1
Date:   Sat, 30 Sep 2023 17:31:32 +0800
Message-Id: <20230930093132.2166-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.154.54.12 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.154.54.12 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why linux-kernel@vger.kernel.org reject my email send out by
thunderbird. So here I am resending this mail with git send-email.

Here is a test result about DEAD_CODE_DATA_ELIMINATION (DCE) and dead syscalls
elimination (DSE). It's based on config[1] and a simple hello.c initramfs.

In the DSE test, we set CONFIG_SYSCALLS_USED="sys_write sys_exit
sys_reboot," which is used by hello.c to simply print "Hello" then exit
and shut down qemu.


|                                    | syscall remain | vmlinux size     | vmlinux after strip |
| ---------------------------------- | -------------- | ---------------- | ------------------- |
| disable DCE                        | 236            | 2559632          | 1963400             |
| enable DCE                         | 208            | 2037384 (-20.4%) | 1485776 (-24.3%)    |
| enable DCE and DSE(SHE_GROUP)      | 3              | 1856640 (-27.6%) | 1354424 (-31.0%)    |
| enable DCE and DSE(SHE_LINK_ORDER) | 3              | 1856664 (-27.6%) | 1354424 (-31.0%)    |

It shows that dead syscalls elimination can save 7% of space based on DCE.

[1]: https://pastebin.com/KG4fd7aT

