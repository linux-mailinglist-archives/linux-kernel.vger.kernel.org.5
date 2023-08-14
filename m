Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4185477B4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjHNIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjHNIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:53:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2CE91
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:53:46 -0700 (PDT)
Message-ID: <20230814085112.446856860@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hQfYcdF7GQaITly9hGbfzZYC7LCrnAubPlWj7Dl2pNs=;
        b=a06S/CTtgTg7k5HXPKYcjhkOC7j8CkGJCLjd3yNTUf/sN5z7ru0X+R0oJejG1j71n45ivp
        Z+h5p8XPsnEPBwmihM7Or3jxjS+vujgWHkM0y3d2xH4FMHqKL2fHNZY2g97vQ8PMQ7RLoN
        xToev2bErj5+lR2EM1nxgyTjViN/WQaqB8oZ/2asvZByYTobSk0RRoOzOFi4kLxMi1iroa
        XhIuug3pGSBHtrPT6jwKgyNhq7NV+Xi/6mz4lYVspdurKWZ8z5HmIbcm5tP+x6kULPVewe
        Efvnvw8HbuSjAaGbhSrN84S1sKYpKJxS8KTwdoi/EdjUX+GjyywYcGNDJfjg5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hQfYcdF7GQaITly9hGbfzZYC7LCrnAubPlWj7Dl2pNs=;
        b=CHeAtbWEWvTSrsFCBOIlqm0BdEDeRkq6FgFnmiPLGp/r8LSwyL1JQ0y1GNpKF4fVvX0npg
        JCuOoE7kEVPc2WBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 07/41] scsi: lpfc: Use topology_core_id()
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:53:44 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided topology helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 drivers/scsi/lpfc/lpfc_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12442,7 +12442,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba
 		cpup = &phba->sli4_hba.cpu_map[cpu];
 #ifdef CONFIG_X86
 		cpup->phys_id = topology_physical_package_id(cpu);
-		cpup->core_id = cpuinfo->cpu_core_id;
+		cpup->core_id = topology_core_id(cpu);
 		if (lpfc_find_hyper(phba, cpu, cpup->phys_id, cpup->core_id))
 			cpup->flag |= LPFC_CPU_MAP_HYPER;
 #else



