Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789167D064F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbjJTBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346860AbjJTBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:55:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA660182
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso2604995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697766937; x=1698371737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMzmo97xwNjH5jtNMKKmAOrNQfA+P+FBFZkUHoft9Wg=;
        b=NSGw8Rj6pZoLPxZ2/TKP1uiH3vKo6mc/PEgR+GamulJocczmf3Wj4bUDPdI5XLdRtK
         ZvmGqHj5wXyc1uIackwhKuUzZMDGm8VFjswaK2bt+FWDHgqkL72A0cnhB88R9d+ug2Mw
         mcU3uyKDK+ktxaaCxxRG5eDRjAO6h1ghbLvT62NaK7Pj9346JUmQGA9n8Z6QazIR415d
         HCxCVDvLLpAJNmRWFhXyaIRJM3pNDimryLYpTjBMDDn2rtl8/plC6mBy118xxC/E9Yji
         v+cF3Ioo0lscC90xgpwHdbz716EM/GTGTAJdwT8wFgjfayrjVcjiN4UmkIxhHdQzDLWQ
         lOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766937; x=1698371737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMzmo97xwNjH5jtNMKKmAOrNQfA+P+FBFZkUHoft9Wg=;
        b=I8eFN6jQ/FmDdlASR1goq6xYfMVav/JxxMVPElfnxGb77zUC9hVzUFIE+63q/Ht9xO
         zymTqMS6VPpIz8uW3+O77PUl8+9bRDg0Lz5qMQ094d+lj76836qlLsbhLzHAqMlSd7j1
         jAHst/JxIXohMTWIsRgx0uIKVxnR26+YSJ2XH8MZwNo6zSd3+y9WD14YFjINviku5DE9
         K/6mplWEdxtyJUbUAIAivRoeJL2Yu/dkn/34c29GX0Qz/uHqTvDS2zW3utZnxTkEfvyu
         HxoUrkUfhK+Uyxd/ohhvFS0I30orX0Tvm3XfarsKYrE9rLZGjR/KYxh5z5lk2MFV1SLe
         BLOQ==
X-Gm-Message-State: AOJu0Yw2SulIf13mWAnb546YCJYCK4WXI8mFGkYGzJ2cInGKxmETdmSA
        xjZrp9iYSVLmgBzIg4mzgGY=
X-Google-Smtp-Source: AGHT+IEuJG7Enp8orPswkJyxWi+u1vgII7qZFIjb75ydntgjSY50fp1yxUsNF25o7HCwTzCabDgQBg==
X-Received: by 2002:a17:902:e741:b0:1c9:c951:57f9 with SMTP id p1-20020a170902e74100b001c9c95157f9mr441368plf.68.1697766937089;
        Thu, 19 Oct 2023 18:55:37 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d3cc00b001b8b45b177esm355544plb.274.2023.10.19.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:55:36 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        julia.lawall@inria.fr, Andi Shyti <andi.shyti@kernel.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v3 3/5] staging: vme_user: Remove printk() in find_bridge()
Date:   Thu, 19 Oct 2023 18:55:21 -0700
Message-ID: <028725ebbc522f73c39f5b1ec4cc2bdbdf588971.1697763267.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697763267.git.soumya.negi97@gmail.com>
References: <cover.1697763267.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't log error message in find_bridge(). The printk() triggers a
checkpatch warning:
    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
             dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

It can't be replaced by dev_err() & using pr_err() is not helpful as it
doesn't give much context to the user. It is better to remove it.

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vme_user/vme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index c36c2dc095c5..5efcdf15a068 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -62,7 +62,6 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
 		return list_entry(resource->entry, struct vme_lm_resource,
 			list)->parent;
 	default:
-		printk(KERN_ERR "Unknown resource type\n");
 		return NULL;
 	}
 }
-- 
2.42.0

