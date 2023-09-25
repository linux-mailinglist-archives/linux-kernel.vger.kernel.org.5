Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D67AE1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjIYWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjIYWgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:36:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EE91BF;
        Mon, 25 Sep 2023 15:36:34 -0700 (PDT)
X-QQ-mid: bizesmtp66t1695681384tmochcm2
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:36:22 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: TVZM0Uoyj00JUk8OvUcLIPa/EY8r7PpEQ1C4lcN0OuATw0N34N96kW+oYTtBN
        Jaai4dDH6wtD7ZkDRGpxrDXJs8kGC6i0K1xINYbt7WEradLvwu7MjA6BcfUnB7FQ28vLUNE
        oQHy3mNLduqnMVzzsi6WBKxgK0AAM3INML+mLcNbhvWg2TzhqPZTKPUYjS11nZRjvZcUiuD
        NRW/R54I/WUXENzteFZ23F0t6lmXK5Gg+8WdV//S+i7xLiuIrZryziyd/4peU2qgsix+rev
        4q/4iJniLeeMCnq1PbhyWM3hk3jVoJGyF2rmv3i3bq3HesUqB4dLD5mRubDvLJZ1TV80lce
        ETiR3coFd9RGXByeptpmtL7fTDNYSIbW6nDutyAuvYsEvMnBnNwa0HvNQHDPey2/Yz4tq+W
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16786486805464770233
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 2/7] DCE/DSE: add unused syscalls elimination configure support
Date:   Tue, 26 Sep 2023 06:36:21 +0800
Message-Id: <3f0eaf5fcb19f1c70cab075a97f067846f36f736.1695679700.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
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
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
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

A minimal embedded Linux system may only has a very few of functions and
only uses a minimal subset of the posix syscalls, the unused syscalls
will never be used and eventually in a dead status, that also means disk
storage and memory footprint waste.

Based on dead code elimination support, it is able to further eliminate
the above dead or unused syscalls.

Firstly, both a new common CONFIG_TRIM_UNUSED_SYSCALLS option and a new
architecture specific HAVE_TRIM_UNUSED_SYSCALLS are added to enable or
disable such feature.

Secondly, a new CONFIG_USED_SYSCALLS option is added to allow configure
the syscalls used in a target system. CONFIG_USED_SYSCALLS can be a list
of the used syscalls or a file to store such a list.

Based on the above options, it is able to only reserve the used syscalls
and let CONFIG_LD_DEAD_CODE_DATA_ELIMINATION trim the unused ones for us
automatically.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 4350d8ba7db4..aa648ce8bca1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1457,6 +1457,11 @@ config BPF
 	bool
 	select CRYPTO_LIB_SHA1
 
+config HAVE_TRIM_UNUSED_SYSCALLS
+	bool
+	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	default n
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
@@ -1683,6 +1688,43 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config TRIM_UNUSED_SYSCALLS
+	bool "Trim unused syscalls (EXPERIMENTAL)" if EXPERT
+	default n
+	depends on HAVE_TRIM_UNUSED_SYSCALLS
+	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	select LD_DEAD_CODE_DATA_ELIMINATION
+	help
+	  Say Y here to trim all of the unused syscalls for a target system.
+
+	  Note, this is only for minimal embedded systems, please don't use it
+	  for generic Linux distributions.
+
+	  If unsure, say N.
+
+config USED_SYSCALLS
+	string "Configure used syscalls (EXPERIMENTAL)" if EXPERT
+	depends on TRIM_UNUSED_SYSCALLS
+	default ""
+	help
+	  This option allows to configure the syscalls used in a target system,
+	  the unused ones will be disabled and trimmed by TRIM_UNUSED_SYSCALLS.
+
+	  The used syscalls should be listed one by one like this:
+
+	      write exit reboot
+
+	  Or put them into a file specified by this option, one syscall per
+	  line is recommended for such a config file:
+
+	      write
+	      exit
+	      reboot
+
+	  Note, If keep this empty, all of the syscalls will be trimmed.
+
+	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.25.1

