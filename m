Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C271377BB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjHNOKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHNOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:10:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06FD7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso3902661f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692022216; x=1692627016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFC5befy1B0F6DaTi/N+wys/sVJv12I6nLzZb1Lm1oY=;
        b=cPKVpkQEqYEktCLwWmsl7dElFRWNgQ83LwXcWcdv2aG57Rm7xAi7ayvfYSK2Amr7IQ
         +9SybcureaL9WMkqBh0el3wTVH5tnjSuXHDXmwDLAWHx49wRwgHRuxzuEyyCrIlLKUI7
         zhz1OCUCS4GKZQ1pJ4SlzvoqlYzQKe7kH7s/UoyOYeLGzUMXyw+9GyuKwiCkj+0jPdpz
         4/kFd0FkWoOZlYRJF75Aa0LWjgytWMAPhI//itX7gWwzNLiFq5z7mzne5B8mkDOnaD8d
         L60SKIONXgYFxcEeyus5ClzOXVdh5gQj/5k60pcENKSEY3bx+MBxEV0wanNgbKvmVrUS
         EVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692022216; x=1692627016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFC5befy1B0F6DaTi/N+wys/sVJv12I6nLzZb1Lm1oY=;
        b=BYTBHxzJyCeMelcnG39PN9EZ7SyTizOHCG0OiElMDKzP7rTnxAA3w8ns9FdHFdyTWb
         Xot1ZVAYsq5ZBmnXqQmwIEORO959Cy9bFS42fhloyOhoW8B7hAw06jaDYGF962BsphWv
         qrQKAdRHOo0jfIjLzBPjd+rTPMKokjyToibkzNPfJlGFwTxIVdI2WgIigab5QBX4Iur3
         XhHhn50nAk+fP8AUAjHdYDg9a1P36DCUFzrxovV36OYEKUyFG8Z1EikNo6aj3GLoauap
         Y5tNvAFJ4AEMwDD5/T2JHrK+a1fQHqzlJY1WKOdsm5KceGVpJv98O182375SsY2gpSIt
         E1uw==
X-Gm-Message-State: AOJu0YwGvBXXbLqG9UeMgHKpCBMdWgFZrRNbW7K+/HkX32xMJMpk410G
        hTP6ZblHTYEB0tLDn7T9igr21w==
X-Google-Smtp-Source: AGHT+IFO0GUphsmeY5el5YxnUWWNjp5arO5PzJ5AcdjOaMW7ZfbCDoICC9lClYXWdk6+y2PHgNDk2g==
X-Received: by 2002:a5d:530e:0:b0:317:5ddd:837b with SMTP id e14-20020a5d530e000000b003175ddd837bmr8925978wrv.7.1692022215695;
        Mon, 14 Aug 2023 07:10:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm17232749wmc.24.2023.08.14.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:10:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v0 3/9] media: qcom: camss: Fix vfe_get() error jump
Date:   Mon, 14 Aug 2023 15:10:01 +0100
Message-ID: <20230814141007.3721197-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
References: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now it is possible to do a vfe_get() with the internal reference
count at 1. If vfe_check_clock_rates() returns non-zero then we will
leave the reference count as-is and

run:
- pm_runtime_put_sync()
- vfe->ops->pm_domain_off()

skip:
- camss_disable_clocks()

Subsequent vfe_put() calls will when the ref-count is non-zero
unconditionally run:

- pm_runtime_put_sync()
- vfe->ops->pm_domain_off()
- camss_disable_clocks()

vfe_get() should not attempt to roll-back on error when the ref-count is
non-zero as the upper layers will still do their own vfe_put() operations.

vfe_put() will drop the reference count and do the necessary power
domain release, the cleanup jumps in vfe_get() should only be run when
the ref-count is zero.

[   50.095796] CPU: 7 PID: 3075 Comm: cam Not tainted 6.3.2+ #80
[   50.095798] Hardware name: LENOVO 21BXCTO1WW/21BXCTO1WW, BIOS N3HET82W (1.54 ) 05/26/2023
[   50.095799] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   50.095802] pc : refcount_warn_saturate+0xf4/0x148
[   50.095804] lr : refcount_warn_saturate+0xf4/0x148
[   50.095805] sp : ffff80000c7cb8b0
[   50.095806] x29: ffff80000c7cb8b0 x28: ffff16ecc0e3fc10 x27: 0000000000000000
[   50.095810] x26: 0000000000000000 x25: 0000000000020802 x24: 0000000000000000
[   50.095813] x23: ffff16ecc7360640 x22: 00000000ffffffff x21: 0000000000000005
[   50.095815] x20: ffff16ed175f4400 x19: ffffb4d9852942a8 x18: ffffffffffffffff
[   50.095818] x17: ffffb4d9852d4a48 x16: ffffb4d983da5db8 x15: ffff80000c7cb320
[   50.095821] x14: 0000000000000001 x13: 2e656572662d7265 x12: 7466612d65737520
[   50.095823] x11: 00000000ffffefff x10: ffffb4d9850cebf0 x9 : ffffb4d9835cf954
[   50.095826] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[   50.095829] x5 : ffff16f813fe3d08 x4 : 0000000000000000 x3 : ffff621e8f4d2000
[   50.095832] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff16ed32119040
[   50.095835] Call trace:
[   50.095836]  refcount_warn_saturate+0xf4/0x148
[   50.095838]  device_link_put_kref+0x84/0xc8
[   50.095843]  device_link_del+0x38/0x58
[   50.095846]  vfe_pm_domain_off+0x3c/0x50 [qcom_camss]
[   50.095860]  vfe_put+0x114/0x140 [qcom_camss]
[   50.095869]  csid_set_power+0x2c8/0x408 [qcom_camss]
[   50.095878]  pipeline_pm_power_one+0x164/0x170 [videodev]
[   50.095896]  pipeline_pm_power+0xc4/0x110 [videodev]
[   50.095909]  v4l2_pipeline_pm_use+0x5c/0xa0 [videodev]
[   50.095923]  v4l2_pipeline_pm_get+0x1c/0x30 [videodev]
[   50.095937]  video_open+0x7c/0x100 [qcom_camss]
[   50.095945]  v4l2_open+0x84/0x130 [videodev]
[   50.095960]  chrdev_open+0xc8/0x250
[   50.095964]  do_dentry_open+0x1bc/0x498
[   50.095966]  vfs_open+0x34/0x40
[   50.095968]  path_openat+0xb44/0xf20
[   50.095971]  do_filp_open+0xa4/0x160
[   50.095974]  do_sys_openat2+0xc8/0x188
[   50.095975]  __arm64_sys_openat+0x6c/0xb8
[   50.095977]  invoke_syscall+0x50/0x128
[   50.095982]  el0_svc_common.constprop.0+0x4c/0x100
[   50.095985]  do_el0_svc+0x40/0xa8
[   50.095988]  el0_svc+0x2c/0x88
[   50.095991]  el0t_64_sync_handler+0xf4/0x120
[   50.095994]  el0t_64_sync+0x190/0x198
[   50.095996] ---[ end trace 0000000000000000 ]---

Fixes: 779096916dae ("media: camss: vfe: Fix runtime PM imbalance on error")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index dabfd613b2f94..938f373bcd1fd 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -611,7 +611,7 @@ int vfe_get(struct vfe_device *vfe)
 	} else {
 		ret = vfe_check_clock_rates(vfe);
 		if (ret < 0)
-			goto error_pm_runtime_get;
+			goto error_pm_domain;
 	}
 	vfe->power_count++;
 
-- 
2.41.0

