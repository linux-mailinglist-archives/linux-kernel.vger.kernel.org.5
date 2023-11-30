Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508B57FFBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376574AbjK3UEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3UEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:04:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94A10F9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:04:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4239f5c1ec2so7943921cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701374690; x=1701979490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0QwjQQA2sBtrYbspl5aVVUOMzblP9BjaUBDTeLH4Y=;
        b=JWvcC1pal6xpzSMiXVKZ3LQWZozJh6A68OUbhMc5HRIydkr2zGclYGsoJMJXTZz/xs
         wBvXNrKMp+st2rF2sSrc4rm64ugrwZ6ftqedxwvgQcvemmg79FRklmKg33ZLoCybcAah
         DZSHbV3+bEYb0cFvieT7waWSk8+wi90inMdP+q29IYSfY6KgOjSDqdiENr34B2XtYvtm
         yB2gTK51h0fqJ8z31ZAhb7BcO3laOA0FGB1xwfLTh2Y2aa3hxOjBdgjdTXVGkqcpu7d0
         hDN/QRI+D7KA543aO91anP+nM0HHk5+pcVBuHKEDF0RgAohC9rYWJHld/+m1ZSoHeDiA
         bWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374690; x=1701979490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0QwjQQA2sBtrYbspl5aVVUOMzblP9BjaUBDTeLH4Y=;
        b=wQkciDjtulVZ/zYnL7BnIxaCdCR+VKiwfynhDbAaq0CNHlqQPoQi/rXwm044FRnYtC
         wI8yJO8hkDO6ngd88hmivmD61nk7C8oTJZgAn2c8waiNzakn29kmnr/S/IkkudrZDHDp
         GwXT2qqI1KYO+MUpfZ+GN96LCmWSRO3zErQ8RPML8oXvN1gmY8D9o7TyVfVKwfPke7Hg
         iw8xCnEH3TC7isWfx9BDctbFKZSkH3gdzP1eZGYUUpq8pKZgqK7IkX+baphTKeSA5gvz
         BcxUx01LR+ySLk0quSkDec2xTO5Cc8BkvIbS+xKOKpKf48NWlb57jk6atiIM+rqQqzfJ
         k6ZA==
X-Gm-Message-State: AOJu0Yxd/lYdFTvLDJJkeLUCpACoY3ywlqQ/tUeOW7rHZUJviod+m6SF
        NcwkFt5+JagJHr+AaMuSSp7ChQ==
X-Google-Smtp-Source: AGHT+IFTod/Py9hcH5oQn6ff5l7Gu58O8B3tXKspAhOROVnCb0qH7k4XfRrSgp2nr3dD/2mySscuWA==
X-Received: by 2002:ac8:7c46:0:b0:423:8e6a:f7a with SMTP id o6-20020ac87c46000000b004238e6a0f7amr26732427qtv.64.1701374690104;
        Thu, 30 Nov 2023 12:04:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id f27-20020ac86edb000000b0041ea59e639bsm787447qtv.70.2023.11.30.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:04:49 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        pasha.tatashin@soleen.com, mst@redhat.com, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-vdpa: account iommu allocations
Date:   Thu, 30 Nov 2023 20:04:47 +0000
Message-ID: <20231130200447.2319543-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

This patch is spinned of from the series:
https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..a51c69c078d9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -968,7 +968,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			r = ops->set_map(vdpa, asid, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
+			      perm_to_iommu_flags(perm),
+			      GFP_KERNEL_ACCOUNT);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-- 
2.43.0.rc2.451.g8631bc7472-goog

