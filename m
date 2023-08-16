Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CF77E8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjHPS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbjHPS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C92D62;
        Wed, 16 Aug 2023 11:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3C5165251;
        Wed, 16 Aug 2023 18:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4A6C433C8;
        Wed, 16 Aug 2023 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210449;
        bh=Fg2XRsx4gyYp75jugZem87t39C7lGAKLhehiSRy0yPE=;
        h=Date:From:To:Cc:Subject:From;
        b=uBGQJT8EM5FdwmbALcSATSzwZ1asOC8rvnZWoKy5nxj+nC2k1P9eA0JXFmGi6rPbp
         YvgiImdy/e7sdRF+iSNGW9KiKi7uZIjtPj0XJGf8v7qvGvQ+qxOfVnbe3qxvIuotF6
         uLj3GnB+Ii1Tf++aO/gI1vo+Azi44l6dvkyzpk7fMxm1e/6ue5dfLsYrEH92e9gYPp
         En76RXbuPa/Szz65A5vgarSYK/iMGdyKNrZ1cyCzR5xUnsHo7i0pPuXaUXTaH+pnz7
         fVz/T5KSl8zt6a5gdVP7GqCklvdogVi5dUoV+wBxxkGI65AJDlbbhjp5X4DsmWM4mM
         niJPe7KmPSjQw==
Date:   Wed, 16 Aug 2023 12:28:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member in struct fc_rscn_pl_s
Message-ID: <ZN0VTpDBOSVHGayb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct fc_rscn_pl_s with flexible-array member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/339
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/bfa/bfa_fc.h      | 2 +-
 drivers/scsi/bfa/bfa_fcbuild.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fc.h b/drivers/scsi/bfa/bfa_fc.h
index a12d693065ce..1091aa428533 100644
--- a/drivers/scsi/bfa/bfa_fc.h
+++ b/drivers/scsi/bfa/bfa_fc.h
@@ -800,7 +800,7 @@ struct fc_rscn_pl_s {
 	u8	command;
 	u8	pagelen;
 	__be16	payldlen;
-	struct fc_rscn_event_s event[1];
+	struct fc_rscn_event_s event[];
 };
 
 /*
diff --git a/drivers/scsi/bfa/bfa_fcbuild.c b/drivers/scsi/bfa/bfa_fcbuild.c
index 773c84af784c..52303e8c716d 100644
--- a/drivers/scsi/bfa/bfa_fcbuild.c
+++ b/drivers/scsi/bfa/bfa_fcbuild.c
@@ -1051,7 +1051,7 @@ fc_rscn_build(struct fchs_s *fchs, struct fc_rscn_pl_s *rscn,
 	rscn->event[0].format = FC_RSCN_FORMAT_PORTID;
 	rscn->event[0].portid = s_id;
 
-	return sizeof(struct fc_rscn_pl_s);
+	return struct_size(rscn, event, 1);
 }
 
 u16
-- 
2.34.1

