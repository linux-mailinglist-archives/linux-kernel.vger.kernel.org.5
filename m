Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8B7B6EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjJCQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjJCQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:43:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E3A7;
        Tue,  3 Oct 2023 09:43:24 -0700 (PDT)
X-QQ-mid: bizesmtp77t1696351393tys816h6
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 04 Oct 2023 00:43:10 +0800 (CST)
X-QQ-SSF: 01200000004000B06000B00A0000000
X-QQ-FEAT: rZJGTgY0+YOUZ7bEZUW/04TLkOEPwIzf85azerfjIvKCpbffmSPTMh+v0i1qs
        tgGncN4m1gwYkonbPq1eThUWyRnw2TvHRdPkhotwvL4yixGCsT2jXlN4skTNt6MvuA6kwSQ
        rhXcCeAhBRTLiHe0qE0ZhLWYOUF5Dk9VfcH8eilV2t870tu6DR2i23OeALoXGmUNJBJvfnJ
        Z1IFcy2cWKUb3kNJtAb1ehtVQ9ouvPZD4ZecOK61t58ulaeEklH1YJvF9cZ4RNXxlsjLup+
        PNMUTGSq0O02jlqadVdMZDLXHDb7LwUO1VGnIQ5EapioiWpzabTBgqQ3fobnD6OUDOJuSc5
        vrBIkkZjpB6HD4lm3j595L+yYCuyXPLf0lUshBD
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5112236808884648054
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu
Subject: Re: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support, part1
Date:   Wed,  4 Oct 2023 00:43:09 +0800
Message-Id: <20231003164309.463912-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [43.154.54.12 listed in list.dnswl.org]
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

I didn't test DSE with explicit KEEP() in the previous mail. So, I will make up
for it now.

This test result is about DEAD_CODE_DATA_ELIMINATION (DCE) and dead syscalls
elimination (DSE). It's based on config[1] and a simple hello.c initramfs.

We set CONFIG_SYSCALLS_USED="sys_write sys_exit sys_reboot", which is used by
hello.c to simply print "Hello" then exit and shut down qemu.

|                                                              | syscall remain | vmlinux size     | vmlinux after strip |
| ------------------------------------------------------------ | -------------- | ---------------- | ------------------- |
| disable DCE                                                  | 236            | 2559632          | 1963400             |
| enable DCE                                                   | 208            | 2037384 (-20.4%) | 1485776 (-24.3%)    |
| enable DCE and DSE with explicit KEEP() of except table      | 17             | 1899208 (-25.8%) | 1387272 (-29.3%)    |
| enable DCE and DSE without KEEP() (By SHF_GROUP method)      | 3              | 1856640 (-27.6%) | 1354424 (-31.0%)    |
| enable DCE and DSE without KEEP() (By SHE_LINK_ORDER method) | 3              | 1856664 (-27.6%) | 1354424 (-31.0%)    |


It shows that dead syscalls elimination can save 7% of space based on DCE.

Although no KEEP() can only save up 2% space, it can reduce the attack surface
and eliminate the misuse of KEEP(). It ensures that every orphan section is not
orphaned anymore.

[1]: https://pastebin.com/KG4fd7aT

