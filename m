Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9677C8594
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjJMMUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjJMMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:20:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B41A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405524e6769so13094245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199625; x=1697804425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QuEY/BkA+iusTWA196/qwz28yJ4ApeauEOwS+0/N8s=;
        b=D8qzgYHiNF/lgJbOa2PMZ3d23/VDO3zyFWMNaMo5Iz0L8LYBDgq7VibqLaQtCtU9nF
         /3EK4STOnaL2H6Bz1tCgUeheqr/WrxnAUv2QrYgEBFn3vqtHc+QXc7oa4rPrfRtJX7LA
         423lMkxOjZHhI7HkkWUnXIDykBSlfNlFY3ZLhN6hSlV8u3hbz1YmtV+it9DqlSikPl+R
         73Zhh24zGNbpB0sg/2JLElmJRBUUciXD1O+32fvU+XstF0O47Yur2OtaYYdFLbblO9GY
         xQr669jQ8YYQfIIBnSzI3McBikV7BN3NF/D1CN6KCHs4rwpNq1P/7KcBF/a49I6dOIND
         R0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199625; x=1697804425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QuEY/BkA+iusTWA196/qwz28yJ4ApeauEOwS+0/N8s=;
        b=ld0TreXYcKx1CkTeGg18bO4vAcUXNrYu1Ucty9Nz9cnO37f92dfrMIJB84l0gBpEYh
         77m3MxHm4rRweXUN8+IW44ChKnOudopux+dnMAuXcbTJdhwB662ZhQGVzmTmOw9uWKEh
         FsER8CbNp61s/YwIxFXV2tViHab8GF0utVEjV4MvIfpOUtFq1H8ql5Q6VBFhXeoUKikG
         XntUOMQB9S+QuHrDhqhY4wT8cW/eIVxGDXTloMs6RF7+H8LPbtnGIXe0/DOM3cPz6TCC
         x52SUY96D1rksgBzLvCy+wDHcdWnVDKXvPi4hXbl1rJ9mJ40IpDwdTknLfMkOhyYbw/q
         CyJA==
X-Gm-Message-State: AOJu0YxJEHZOX/F/+4nWMunWaYlbvTqGSzg9Qj2/ZsKYpevWi9Z4ENAW
        1jjRr+wQqvg9TVaDvQWs7LD2eA==
X-Google-Smtp-Source: AGHT+IHFLpSbfdncO2+7arwCNpRJ/rZnCljjzSY8Yv0yaL5+TFf5xY0UMhGELTHE3/2ev2DEKbrWoA==
X-Received: by 2002:a05:600c:4f51:b0:403:aced:f7f4 with SMTP id m17-20020a05600c4f5100b00403acedf7f4mr20823575wmq.12.1697199624750;
        Fri, 13 Oct 2023 05:20:24 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b0040772934b12sm1806751wms.7.2023.10.13.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:20:23 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] misc: fastrpc: Unmap only if buffer is unmapped from DSP
Date:   Fri, 13 Oct 2023 13:20:07 +0100
Message-Id: <20231013122007.174464-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
References: <20231013122007.174464-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=K17Bp8aGP1xLD7b1/oIdzDEEQgA3+HQufQZkkoSYOj8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTX3NPlR1/eK5BGogepyP/eWtTfO2D+ZHHsCl wqhugmKm9WJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk19wAKCRB6of1ZxzRV NwhyCACbUWWkkJSoDSlF0ZVBBB3/WmCdIBUx1qeyEjOVO8ymP3DNJvr+NMaIyk5eyQ2dWQJJ50d WHSu8J2kopVo0zM5E8QGI3d7AzarGtICBwc8JD6rB2kK8zvdk4YzBcNaaoBbaT5nvaad3bN7geb o9twsMMfZRtfdcqJcwkD+IuEI8CeBsVfuKqL30SxSaPiB5bQs03GwJbUNWrOPKcZ287HlmiU69p htHZDzITiEZ7JwklB9NFD2OXqs7P8CVNJCais838T773ihv52NWlzoIZGsXoLncKypKfjiP1Fmp gkQu8B685mTEy5U0xvU1AzUVKTEf0+RN4WhHk0HQIKlg04q3
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

For unmapping any buffer from kernel, it should first be unmapped
from DSP. In case unmap from DSP request fails, the map should not
be removed from kernel as it might lead to SMMU faults and other
memory issues.

Fixes: 5c1b97c7d7b7 ("misc: fastrpc: add support for FASTRPC_IOCTL_MEM_MAP/UNMAP")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3cdc58488db1..1c6c62a7f7f5 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1981,11 +1981,13 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
 				      &args[0]);
-	fastrpc_map_put(map);
-	if (err)
+	if (err) {
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+		return err;
+	}
+	fastrpc_map_put(map);
 
-	return err;
+	return 0;
 }
 
 static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
-- 
2.25.1

