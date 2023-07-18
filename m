Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7E17570BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGRADK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGRADH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:03:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E7FB;
        Mon, 17 Jul 2023 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689638579;
        bh=2rJryBbBuEudGvHbXHROzk2M+u1hbo1A1vezElOeJQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=JfWkf9x0oiee18GUonQle3OgyVv4BF6aTm5/BYGXBw3bk8S9HO1uWPRfL0d3Blxbh
         00KrJczuS48Z5t/n/lAEm3/Vpzz63LyrqgEGVq0hQZP6U5vWt4OQ+R7LUMTZ4hi+mS
         xEIotaJ6eHWkZPuU6pCo330FwueslWzxD86B6mrAUM6XP2mm+17ueTU2PymVLycUbZ
         rrgrIJNRC9bT8E9s4P4mlyW1yRJLtgegFK2VvzVlQFsyuBAZvhU1H/OLLKM1CeIFj6
         iVqWTYcXwboktSbcr9C/PmYQ45/SJfgSNZgGMtyC1IvJ1cdZK0YjBmmiLplAHdvnf9
         lvLSqgIaE2Opg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4fKZ5xktz4wb0;
        Tue, 18 Jul 2023 10:02:58 +1000 (AEST)
Date:   Tue, 18 Jul 2023 10:02:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230718100257.1ed9290e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T.R3Mt1SR3+YabFEHW4FJpQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T.R3Mt1SR3+YabFEHW4FJpQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/arm-smccc.h:8,
                 from arch/arm/mm/proc-v7-bugs.c:2:
arch/arm/mm/proc-v7-bugs.c: In function 'spectre_v2_get_cpu_fw_mitigation_s=
tate':
include/linux/arm-smccc.h:485:29: error: '__declare_arg_3' undeclared (firs=
t use in this function)
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                             ^~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in definition of macro '__CONCAT'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/arm-smccc.h:485:17: note: in expansion of macro 'CONCATENATE'
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                 ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:485:29: note: each undeclared identifier is repor=
ted only once for each function it appears in
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                             ^~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in definition of macro '__CONCAT'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/arm-smccc.h:485:17: note: in expansion of macro 'CONCATENATE'
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                 ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:417:38: error: 'arg0' undeclared (first use in th=
is function); did you mean 'r0'?
  417 | #define __constraint_read_0     "r" (arg0)
      |                                      ^~~~
include/linux/arm-smccc.h:418:33: note: in expansion of macro '__constraint=
_read_0'
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:420:33: note: in expansion of macro '__constraint=
_read_2'
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:418:59: error: 'arg1' undeclared (first use in th=
is function); did you mean 'r1'?
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                                           ^~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:420:33: note: in expansion of macro '__constraint=
_read_2'
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:59: error: 'arg2' undeclared (first use in th=
is function); did you mean 'r2'?
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                                           ^~~~
include/linux/arm-smccc.h:420:33: note: in expansion of macro '__constraint=
_read_2'
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:420:59: error: 'arg3' undeclared (first use in th=
is function); did you mean 'r3'?
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                                           ^~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:492:21: error: '___res' undeclared (first use in =
this function)
  492 |                 if (___res)                                        =
     \
      |                     ^~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:17:9: note: in expansion of macro 'arm_smccc_1_1=
_invoke'
   17 |         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
      |         ^~~~~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c: In function 'call_smc_arch_workaround_1':
include/linux/arm-smccc.h:485:29: error: '__declare_arg_2' undeclared (firs=
t use in this function)
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                             ^~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in definition of macro '__CONCAT'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/arm-smccc.h:485:17: note: in expansion of macro 'CONCATENATE'
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                 ^~~~~~~~~~~
include/linux/arm-smccc.h:510:33: note: in expansion of macro '__arm_smccc_=
1_1'
  510 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:58:9: note: in expansion of macro 'arm_smccc_1_1=
_smc'
   58 |         arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:417:38: error: 'arg0' undeclared (first use in th=
is function); did you mean 'r0'?
  417 | #define __constraint_read_0     "r" (arg0)
      |                                      ^~~~
include/linux/arm-smccc.h:418:33: note: in expansion of macro '__constraint=
_read_0'
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
2'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:510:33: note: in expansion of macro '__arm_smccc_=
1_1'
  510 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:58:9: note: in expansion of macro 'arm_smccc_1_1=
_smc'
   58 |         arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:418:59: error: 'arg1' undeclared (first use in th=
is function); did you mean 'r1'?
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                                           ^~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
2'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:510:33: note: in expansion of macro '__arm_smccc_=
1_1'
  510 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:58:9: note: in expansion of macro 'arm_smccc_1_1=
_smc'
   58 |         arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:59: error: 'arg2' undeclared (first use in th=
is function); did you mean 'r2'?
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                                           ^~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
2'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:510:33: note: in expansion of macro '__arm_smccc_=
1_1'
  510 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:58:9: note: in expansion of macro 'arm_smccc_1_1=
_smc'
   58 |         arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:492:21: error: '___res' undeclared (first use in =
this function)
  492 |                 if (___res)                                        =
     \
      |                     ^~~~~~
include/linux/arm-smccc.h:510:33: note: in expansion of macro '__arm_smccc_=
1_1'
  510 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:58:9: note: in expansion of macro 'arm_smccc_1_1=
_smc'
   58 |         arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c: In function 'call_hvc_arch_workaround_1':
include/linux/arm-smccc.h:485:29: error: '__declare_arg_2' undeclared (firs=
t use in this function)
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                             ^~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in definition of macro '__CONCAT'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/arm-smccc.h:485:17: note: in expansion of macro 'CONCATENATE'
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                 ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:63:9: note: in expansion of macro 'arm_smccc_1_1=
_hvc'
   63 |         arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:417:38: error: 'arg0' undeclared (first use in th=
is function); did you mean 'r0'?
  417 | #define __constraint_read_0     "r" (arg0)
      |                                      ^~~~
include/linux/arm-smccc.h:418:33: note: in expansion of macro '__constraint=
_read_0'
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
2'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:63:9: note: in expansion of macro 'arm_smccc_1_1=
_hvc'
   63 |         arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:418:59: error: 'arg1' undeclared (first use in th=
is function); did you mean 'r1'?
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                                           ^~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
2'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:63:9: note: in expansion of macro 'arm_smccc_1_1=
_hvc'
   63 |         arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:59: error: 'arg2' undeclared (first use in th=
is function); did you mean 'r2'?
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                                           ^~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
2'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:63:9: note: in expansion of macro 'arm_smccc_1_1=
_hvc'
   63 |         arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:492:21: error: '___res' undeclared (first use in =
this function)
  492 |                 if (___res)                                        =
     \
      |                     ^~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
arch/arm/mm/proc-v7-bugs.c:63:9: note: in expansion of macro 'arm_smccc_1_1=
_hvc'
   63 |         arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
      |         ^~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:243: arch/arm/mm/proc-v7-bugs.o] Error=
 1
make[4]: *** [scripts/Makefile.build:477: arch/arm/mm] Error 2
make[3]: *** [scripts/Makefile.build:477: arch/arm] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from include/linux/arm-smccc.h:8,
                 from drivers/char/hw_random/arm_smccc_trng.c:20:
drivers/char/hw_random/arm_smccc_trng.c: In function 'smccc_trng_read':
include/linux/arm-smccc.h:485:29: error: '__declare_arg_3' undeclared (firs=
t use in this function)
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                             ^~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in definition of macro '__CONCAT'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/arm-smccc.h:485:17: note: in expansion of macro 'CONCATENATE'
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                 ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:485:29: note: each undeclared identifier is repor=
ted only once for each function it appears in
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                             ^~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in definition of macro '__CONCAT'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/arm-smccc.h:485:17: note: in expansion of macro 'CONCATENATE'
  485 |                 CONCATENATE(__declare_arg_, COUNT_ARGS(__VA_ARGS__)=
);   \
      |                 ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:417:38: error: 'arg0' undeclared (first use in th=
is function); did you mean 'r0'?
  417 | #define __constraint_read_0     "r" (arg0)
      |                                      ^~~~
include/linux/arm-smccc.h:418:33: note: in expansion of macro '__constraint=
_read_0'
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:420:33: note: in expansion of macro '__constraint=
_read_2'
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:418:59: error: 'arg1' undeclared (first use in th=
is function); did you mean 'r1'?
  418 | #define __constraint_read_1     __constraint_read_0, "r" (arg1)
      |                                                           ^~~~
include/linux/arm-smccc.h:419:33: note: in expansion of macro '__constraint=
_read_1'
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:420:33: note: in expansion of macro '__constraint=
_read_2'
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:419:59: error: 'arg2' undeclared (first use in th=
is function); did you mean 'r2'?
  419 | #define __constraint_read_2     __constraint_read_1, "r" (arg2)
      |                                                           ^~~~
include/linux/arm-smccc.h:420:33: note: in expansion of macro '__constraint=
_read_2'
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                 ^~~~~~~~~~~~~~~~~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:420:59: error: 'arg3' undeclared (first use in th=
is function); did you mean 'r3'?
  420 | #define __constraint_read_3     __constraint_read_2, "r" (arg3)
      |                                                           ^~~~
include/linux/args.h:25:24: note: in expansion of macro '__constraint_read_=
3'
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
   26 | #define CONCATENATE(a, b) __CONCAT(a, b)
      |                           ^~~~~~~~
include/linux/arm-smccc.h:489:32: note: in expansion of macro 'CONCATENATE'
  489 |                              : CONCATENATE(__constraint_read_,     =
     \
      |                                ^~~~~~~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~
include/linux/arm-smccc.h:492:21: error: '___res' undeclared (first use in =
this function)
  492 |                 if (___res)                                        =
     \
      |                     ^~~~~~
include/linux/arm-smccc.h:526:33: note: in expansion of macro '__arm_smccc_=
1_1'
  526 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __V=
A_ARGS__)
      |                                 ^~~~~~~~~~~~~~~
include/linux/arm-smccc.h:563:25: note: in expansion of macro 'arm_smccc_1_=
1_hvc'
  563 |                         arm_smccc_1_1_hvc(__VA_ARGS__);            =
     \
      |                         ^~~~~~~~~~~~~~~~~
drivers/char/hw_random/arm_smccc_trng.c:73:17: note: in expansion of macro =
'arm_smccc_1_1_invoke'
   73 |                 arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res=
);
      |                 ^~~~~~~~~~~~~~~~~~~~

Presumably caused by commits

  93e9856955f8 ("kernel.h: split out COUNT_ARGS() and CONCATENATE() to args=
.h")
  fceebffabbb6 ("arm64: smccc: replace custom COUNT_ARGS() & CONCATENATE() =
implementations")

I have used the mm tree from next-20230717 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/T.R3Mt1SR3+YabFEHW4FJpQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS11rEACgkQAVBC80lX
0GwsPQf9E1lFuQ/NbqcR6xRPue9a90H4FWot0ew6EOdM6ziS+hxQTu7p4++wGI4A
/H4H2cvYhJxg6O3LTLPGX98s9NyoYlkRXBZzPfACwDO7iPrjcRAo57+Mo08Ph+Ww
Z5TCUwyyE2EU7j/SOqt8Lq/eLtwyvCryHEOGMFyE4J5yUn9tMsfukSe3u+/612wn
UskZQb/cGAe1Pud/QnTxLyo4vRDcYdxniPNA6dfJoivskvjr/lvrBTHZQAE8A/JM
9z9b5OF3E+b/cmT3h1w5dsfCxQ0DWtZVA4PWuYaNQh8QretS5v6foYxeDi/Lo5aZ
HjvjtpMZU11G5KBIwQtWu1g2qi6zaA==
=QjNp
-----END PGP SIGNATURE-----

--Sig_/T.R3Mt1SR3+YabFEHW4FJpQ--
