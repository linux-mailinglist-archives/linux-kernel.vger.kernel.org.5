Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDE7FC62F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbjK1Uu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbjK1Uty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:49:54 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4A52102
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:56 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a338dfca7so21119846d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204595; x=1701809395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iygGvNb1KE298FiVkmeH8gdBVxeTTuJw4eGKIF/nIuM=;
        b=TWRnXEVXJruv36LJOKHOhLjpODPbkfmbkFVGiyOwKEshA3y7p2vwRpd/5C7W+qNM23
         D6nv4XMHyxnItPBrp6yg8UyDYHblV+lzf/h7za7iL8ugRhzV9JfxwzHqKyxe7Xk8Uh/q
         PfP1iVJT2M4KQ7WfHjfApsQ4nZZ5x/pPJmPNH0lUx2TYkwjM3yON0sY4b8BF3B3MuZSB
         Qt9E/+FEDDPITVyILclLHYXmH6fhFO7Gd2aA+9IIMCVoLtHGobMgBqUWIWUXm9UbZ2uR
         3PNpdpfkE6bslU98p/cRIQNaPtkG0vRMRtFyvh7U6nqZ2q0hT6WszqpUe9YACfO1iDi/
         Dbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204595; x=1701809395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iygGvNb1KE298FiVkmeH8gdBVxeTTuJw4eGKIF/nIuM=;
        b=ExkWjVhgMW3WysRcKlFNLyJ8y93iVW0rjQ0hqW6tMN04fD2+OM7EndlSdO6YvE5PiF
         9f1PHyJdJme2fWg40xBVC29onnKdJw2zdM/EYsxdrBNuSTArdUnJbx+equUEBcf6xEPS
         5tEFA6lbtdHsM8+ao8CsAn5l1rRB9rlI1Yze75znuoJCmdH//mjE/Hibc+CkAy7JP9y1
         z1AR++Xpns1Yb78PJMvQp07JJcDlyIChbnPkuWMPJpDCoQOUb6+oao4XEI0wQefoh4dZ
         E1IBV+710+EzATFgYAhSrQQpFyCm474Z8JUe7VDQH7QcyKEe0kzkFea6UtE52rny9Z1q
         edZw==
X-Gm-Message-State: AOJu0YwUv3Z7qwUeEJQtKRKDWEryN/TmUDha6cBl3os8Z+nY4G0CvtiA
        t9Vn4GbT9oIpmgbcXQnzw/2ydg==
X-Google-Smtp-Source: AGHT+IE0Jl3QLEggdMt0xv2T8AyvhzkahJgD3VRGmfbhI7sqHJ8Aa/AdHKiYq6E8wbv77IBFZbLYmg==
X-Received: by 2002:ad4:5dc6:0:b0:67a:21aa:6513 with SMTP id m6-20020ad45dc6000000b0067a21aa6513mr18119809qvh.17.1701204595440;
        Tue, 28 Nov 2023 12:49:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:54 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        pasha.tatashin@soleen.com, paulmck@kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: [PATCH 15/16] vhost-vdpa: account iommu allocations
Date:   Tue, 28 Nov 2023 20:49:37 +0000
Message-ID: <20231128204938.1453583-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
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

