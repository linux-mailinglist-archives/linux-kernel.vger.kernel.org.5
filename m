Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA52C797993
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbjIGRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjIGRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:16:53 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D010F6;
        Thu,  7 Sep 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHAuo4DW7cBgkh5lqPsBFjVkMghpsGo0LMPcPRiTjug=;
  b=NCzPUjIUDBkTU3IqNaEJDelTSxB59TFGgVvVq/9K0DvPwWAR5tqexwVa
   Up/qLsfCT/1i+KAiseYkrZwoyLUZm2zcdTCgtSrz0Z/8CLL2c5mYK8ydi
   JlK1udUOTlGEQ12lX3laNNnRi1waQ6UzKrtHGmsg9kNg8vtC4ZO73s3UP
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324663"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:31 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] powerpc/kexec_file: add missing of_node_put
Date:   Thu,  7 Sep 2023 11:55:16 +0200
Message-Id: <20230907095521.14053-7-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_node_with_property performs an of_node_get on each
iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/kexec/file_load_64.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -u -p a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -1138,11 +1138,15 @@ static int update_pci_dma_nodes(void *fd
 			continue;
 
 		ret = copy_property(fdt, pci_offset, dn, "ibm,dma-window");
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(dn);
 			break;
+		}
 		ret = copy_property(fdt, pci_offset, dn, dmapropname);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(dn);
 			break;
+		}
 	}
 
 	return ret;

