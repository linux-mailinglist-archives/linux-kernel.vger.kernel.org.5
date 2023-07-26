Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651B2764185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGZV7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGZV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:59:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D32109
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:59:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686b9920362so284649b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408770; x=1691013570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUoFgr64KB2UpVOFBQdb3fXLboqR0/gHMpW4+RbUqpk=;
        b=Z8HPE4tqux9CyxPkz0DHpPIV7emD+YjrccBOGvQagV7m7zeQd2XhmCtleXsSrXP10+
         CJ8CgHxSFMBDD23UH3Cy+teLhQOyLyPCtRuFjm9xCfYTqmd97r+/lQau0sibEkb9El5z
         U5+fhSKGcuRphkEJC1usPgP3Jwjq73Y8LJJxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408770; x=1691013570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUoFgr64KB2UpVOFBQdb3fXLboqR0/gHMpW4+RbUqpk=;
        b=kITfJ44cI015USlXEwf9PRMvgEJBsYvCja8W9kxFUx6avJ+gLLnwKe+k7ZzVreQNms
         zURRthvXftOxP7LICkTub51aO7onIx2AkTd6UyAGFyOSNyuvNSHWvw+hJCoCMpDOHJeV
         K82K3RB8mx+mbnW/UNeD84hSrauiSTzii4xysbrt1Blaq65CfizXOYf0+faCwKbJ7hUK
         S1TOD0/T6s9I19M0wzIN7OSGaHRQDmpwxfxznDjOaS7clUro2uO8/Cy+5ldLpjLIyUgh
         Le1Rp8RJhHz1twrHGZu1cesVts+W/irLWjufFYuygMIN5kAyBnY8EJo8RUsmYNPQsCxD
         BKFw==
X-Gm-Message-State: ABy/qLaka4rv+6nFJR13Wns6KyhGVrP+tDiiAqgC3MP5yGPgN1QCB6p2
        VE2xlDymKbJ1mJ7SajGy/vJj9Q==
X-Google-Smtp-Source: APBJJlGMtsTkQRl3Q1kEtlVd9gtXD6S3B4tZ440ZJALLEHm9Mb0ucbFdNihZsWC4Nc83LlcQbiyrmQ==
X-Received: by 2002:a05:6a00:1591:b0:66c:9e97:aece with SMTP id u17-20020a056a00159100b0066c9e97aecemr3488579pfk.10.1690408769927;
        Wed, 26 Jul 2023 14:59:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78c19000000b0064d57ecaa1dsm94401pfd.28.2023.07.26.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:59:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ocfs2: Use regular seq_show_option for osb_cluster_stack
Date:   Wed, 26 Jul 2023 14:59:22 -0700
Message-Id: <20230726215919.never.127-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QIxFftlsiJNNbEL1xf2v27ZfHLWZozkFWk4Q3E+r9mM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkwZc6HYN97c9dpESG5p2eAapuOSApu4iE/Li50
 W9KrMtx9X6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZMGXOgAKCRCJcvTf3G3A
 JisRD/968M7Y3iHPE7qmqIHWJy71IXr+3Ge8eIMJRB84Sid3S2QsPFDA9ACIx7IBLLbNKGSEUyj
 j94Tsb6DnhkiwlfUiuwZriheWyE/JB7th/vMT0kWogUaGnGdzewknJ0V18LbRh2pL9W6/5d7I16
 zI2JEg7hsPb2OexXnUIWn9LbF81I5LbO4vY3/Ht2haYNwD3ZBZbA52LfGK58uSUcdZ/7yvAVjOq
 5wOxIlqep3pUzsav9fHzPMicAN2E8vBYcueDmLVQlLhqZv3jaXOL4ebzQMoTM8noevWmdM2P2eV
 9Lne391jiQ9U8JWyEte+d1UBkNP4CH3eYvBHiHxeX4LufJZfrZi0YsJvTlTD6R8TjU6+Q9qA7y9
 Xcms//Uf4lqBrXWjtMDGqKazEW7167S6AxiQU3RVVWgu24msDJvPLlDLjeFVMVG+1QcqswUkodH
 Qq2KjDGO3ZEnlFtw8aAPPPxt0p9x9Vm3Psqf1B5OOfLuvxpJVAcXCzxc2nSZTDx53nbPaft/ho7
 Nsqg3p6kViO+OCDCYXFoELhGkNnK1QbTUcWivcuSE9WqeS8lXDWdwHZ80AUHPI1Z8S1rpTOqDQC
 e8sNn+41gfUjWobfsTXhXlyQdh4PyXLGYjubbq1Y86vFVOFdHhVAiI1wZ8mMsKuL1r2P0sVM+IG
 ZJcx0ti m3+rCGBw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up seq_show_option_n()'s use of strncpy, it was noticed
that the osb_cluster_stack member is always NUL-terminated, so there is
no need to use the special seq_show_option_n() routine. Replace it with
the standard seq_show_option() routine.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ocfs2-devel@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
---
 fs/ocfs2/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 988d1c076861..6b906424902b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1517,8 +1517,7 @@ static int ocfs2_show_options(struct seq_file *s, struct dentry *root)
 		seq_printf(s, ",localflocks,");
 
 	if (osb->osb_cluster_stack[0])
-		seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
-				  OCFS2_STACK_LABEL_LEN);
+		seq_show_option(s, "cluster_stack", osb->osb_cluster_stack);
 	if (opts & OCFS2_MOUNT_USRQUOTA)
 		seq_printf(s, ",usrquota");
 	if (opts & OCFS2_MOUNT_GRPQUOTA)
-- 
2.34.1

