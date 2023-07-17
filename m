Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79315756E37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGQU3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:29:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2C188;
        Mon, 17 Jul 2023 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689625779; x=1721161779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8jjGorvvakFNZSiXbU5g+XQSAuUt8rUfwsivIw+/D4=;
  b=ItJ1Dy1niyG7hjHIbgFk/+ao9cg+xuuEfllINT6qFABopX/zytE+9GWC
   2rgxulZUYU2JW8IH7G8lZSoRJh4/27sQFZg2JZ3IclvAMWe5vhi8eJItg
   nX4jtR7ewYjPGQi8Eq1a/kxNK2kzpKUj+bxY3hz/G+dfnuZuOrSm789xS
   +GzcMhLX/DHES3ZrkMetuq59AaFJKNkR+Rw31QIv6KOmGmhIRSBpXARAU
   maHjF+Y3HK0njKD4Tq0HIpukeCc5GW/ijfD2Mpqx7YsvMk1SpJw9W7qP+
   bsAU83pWsMUOvdQ2dM9EtZsXYsMoackEJ/1U/pa4aUVw9o8kn7JMgQCgb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345625644"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345625644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 13:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866838387"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 13:29:39 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Haitao Huang" <haitao.huang@linux.intel.com>,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: [PATCH] x86/sgx: fix a NULL pointer
Date:   Mon, 17 Jul 2023 13:29:38 -0700
Message-Id: <20230717202938.94989-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
cgroup worker) may reclaim the SECS EPC page for an enclave and set
encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
the SGX #PF handler without checking for NULL and reloading.

Fix this by checking if SECS is loaded before EAUG and load it if it was
reclaimed.

Fixes: 5a90d2c3f5ef8 ("x86/sgx: Support adding of pages to an initialized enclave")
Cc: stable@vger.kernel.org
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 25 ++++++++++++++++++++-----
 arch/x86/kernel/cpu/sgx/main.c |  4 ++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2a0e90fe2abc..2ab544da1664 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -235,6 +235,16 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	return epc_page;
 }
 
+static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
+{
+	struct sgx_epc_page *epc_page = encl->secs.epc_page;
+
+	if (!epc_page)
+		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+
+	return epc_page;
+}
+
 static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 						  struct sgx_encl_page *entry)
 {
@@ -248,11 +258,9 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return entry;
 	}
 
-	if (!(encl->secs.epc_page)) {
-		epc_page = sgx_encl_eldu(&encl->secs, NULL);
-		if (IS_ERR(epc_page))
-			return ERR_CAST(epc_page);
-	}
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
 	if (IS_ERR(epc_page))
@@ -339,6 +347,13 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 
 	mutex_lock(&encl->lock);
 
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page)) {
+		if (PTR_ERR(epc_page) == -EBUSY)
+			vmret =  VM_FAULT_NOPAGE;
+		goto err_out_unlock;
+	}
+
 	epc_page = sgx_alloc_epc_page(encl_page, false);
 	if (IS_ERR(epc_page)) {
 		if (PTR_ERR(epc_page) == -EBUSY)
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 166692f2d501..4662a364ce62 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -257,6 +257,10 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 
 	mutex_lock(&encl->lock);
 
+	/* Should not be possible */
+	if (WARN_ON(!(encl->secs.epc_page)))
+		goto out;
+
 	sgx_encl_ewb(epc_page, backing);
 	encl_page->epc_page = NULL;
 	encl->secs_child_cnt--;
-- 
2.25.1

