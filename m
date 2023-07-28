Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E79766CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjG1MNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjG1MMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16160269E;
        Fri, 28 Jul 2023 05:12:49 -0700 (PDT)
Message-ID: <20230728120929.888713412@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+1QBA7VHZ0Y4GyIw3wTYa2EiSrzVOoXvVDOvnVaT6BY=;
        b=fWvBZAtr1+b7OwhEu0kVqpNM13lP2fyyhOFWfJTTI3uFnsBcnEq3eWD6OPi0V/kdIofsBD
        IWlcRLGqiQ/cmiDi0EWkLzMTw7phJe7v9wjk0XrBX6BmAdVHcGsNlg6jQbzGWWexfHKtzF
        1ZmgunT47P0OUI+815tf6BjkrRuo61gkVY/iLx/rwtXMN0raoQQF/OKZaVhT4HDEOEXpPq
        BRVVv+uYxU6BrAdcgmdY1/9zX3XSj0YrSFhHjjb3+oPf3o46Aq8HPQ7lbDb/2a6Nv9ROoe
        HgKdL4a2ald+wdDQ83SGgrWPMDHY7aGmYhZMEV3mbjhbTuF7BNUmQBhO6tVs5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+1QBA7VHZ0Y4GyIw3wTYa2EiSrzVOoXvVDOvnVaT6BY=;
        b=L4xnuGbjTILMT48eR30EY7wea8T/sKtJtOh08OVrf89pbFR2Vv/khTIC6uOE4LxgEQoM+Y
        Xg2ntVr6c10qiODQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 04/38] scsi: lpfc: Use topology_core_id()
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:12:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided topology helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
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

