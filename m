Return-Path: <linux-kernel+bounces-55433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B610A84BCA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E916F1C24304
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3834134C3;
	Tue,  6 Feb 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="iJ7+Rq+8"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC912B9C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242694; cv=none; b=edBwOzbU95WYN0Ok0m6iVe3MRwstIpbB6Gs6aaEN3rrcHevJVXy9ZrEI9MEFoq6/dbjcSnByFm8vS4MZ+9M/g5kAM2d7AIWKXI/ioWBsWVvdVEYgAi4EHody+77ult4TmjPnvo1Uvvtgk+pY+l/AgRjHcyNoPBaAX4lxpcVsEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242694; c=relaxed/simple;
	bh=csIGa+rd7lcNnhTQbpItKD6NpMqF39eNVB3gtdBsnA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eDNz5VmWittqgZiI4aKiXnLG83PT3l58pW65sYLBGKfhKq/XnKeR61bNRC5ySBnsQVsYa3PP2nQzmy/8hdo6N/SUYfo9n5QGXxf/qVMBvoCHxNL5MG/WAoKLdRy51o/hW1l/+s34cMJqN1W2DZj8dB+pQ5PR3/v6cZ0PCgnBM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=iJ7+Rq+8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7354ba334so51346775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707242687; x=1707847487;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/sMfQ4C2LqtKvqqdaWxWMsx/4R6rTjfiNR3jdV33D4=;
        b=uAO2tFm+vaUiy7yZAu346yuOkVLb6BDbb/DuCFgeHa0RWu4l6hcCclBm1DDEtzAqCK
         9BgMLlzh4sJY4b8JsiC1EssSekTdYdYs2/aDUFdChrB89BFaxEbhSdguCyVZq8dsdd+4
         AlmAk6UhKyFObBecQkae00gQxgi1eI6w4jVX82Zmc1+reRISzh+5bgXiueEINrtmoIkO
         oPCNEuzJDCsbBhhLTtIMXxaeSj903CSBKopHz3OldRBsF62Tjj9YqPLjHJG4CW5ltdPW
         U6UiTMo3VADXmnSWFRq92nwl5FYfiScOhAzeFsVAJZBwh5+zCEjWaLT3+leDo/isvPRB
         vscg==
X-Gm-Message-State: AOJu0Yx0Ryke9d597KmnS0Ohcsp7FDDSl+9spe+t4Hgr8Ca97JLSorjH
	Wk+KZrBVDRRIPeIc7jQRgX/VbnID0Tj/aKtHqChZexAnW2HSl4iB
X-Google-Smtp-Source: AGHT+IHSjJorv6QXrPS87peEQAaqIavUR6mhKePHO2aQ8PMY7g+yxHpac9ju+EldK9aQYcfgXMw95g==
X-Received: by 2002:a17:902:c947:b0:1d9:8082:4573 with SMTP id i7-20020a170902c94700b001d980824573mr3134146pla.2.1707242686937;
        Tue, 06 Feb 2024 10:04:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxfcDMLUogxRqr60AgcSVAEVfMDX8DLtD+DxKDIy4wagpYhynC42ozQ+xJlGI8S104oshUKFE71P9CVqUHbh/R0XVdX0hjyL1I3pMpFQY89HM7smgwaxFT2Zuc2FjRcqZiLJAB
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e16-20020a170902cf5000b001d9ce370415sm884579plg.90.2024.02.06.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:04:46 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707242685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6/sMfQ4C2LqtKvqqdaWxWMsx/4R6rTjfiNR3jdV33D4=;
	b=iJ7+Rq+8feZu+ukBnYYkMMivm+bNOMEs4M7eabGmy5IiTT36FSD5Y9+u24YUW6gY6eud84
	HsE+yJmqH2bZrfMQy2ckuwUaK0DYMwThA6rxPU0vmipyXN9V3A95gMuj0VCY/4n21cCUoo
	JnQPiIcwOGlrZXYLDyIbdkx7V8P4kBiouPd99tdJGfDxqPu+Ymbt9YDo4orr6qqiHWdUhF
	TSHALQNwM+OrYU+ovJoZw7YQvrUusoRBXKNsXyBAfSMHTTmPbUqajawwJY/PnwH7TGWFPZ
	2hE/x1YNn+iFTuZNrsxtWPaQM4LVLVtQ+8Y4/q+kCE997coHiWoTFoIo0cjVsg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 06 Feb 2024 15:05:06 -0300
Subject: [PATCH] workqueue: make wq_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>
X-B4-Tracking: v=1; b=H4sIANF0wmUC/x3M0QpAMBSA4VfRubbaZpvyKpKGgxMNW0PJu1suv
 4v/fyCgJwxQZQ94PCnQ5hJEnkE/WzchoyEZJJeKS25YF0Pbr2hd3Nm1+eWIGJEJrUqrjC7kICC
 1u8eR7v9bN+/7AfKWKkdnAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=csIGa+rd7lcNnhTQbpItKD6NpMqF39eNVB3gtdBsnA0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlwnTcwzfqVRHqZhUZNfw///fw0r9IwUn5joN6v
 J9nzqTZxf6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcJ03AAKCRDJC4p8Y4ZY
 psygEACo9A4c81fJKS97/6hziaVq+DgVpPtkloBf5QVMfzsuidx4Zr+l8UEWqlb+jXd+jLtGhzt
 1rf1RyQaW8U77kcdkx7jLq6kyHSI+A3ZiyZMdM9gCRFaVZ1ejZjniV9NtUXXgcINXp2wz+odFoR
 ulSuD558rj6b33Zw+Uu8luRmbQAqT+6RX8SxpLYMS7pqWWDwlejwJDgy0kGP9Wgwc1hMTtRGrgd
 IQtkMAJtfPZlXMHA9cZhQOiBnQ7dzt2to9q6zEoaFu0MGRxZtGyJTBmpfxKzV4rYFuoIXyvZBdM
 AD3tirU+beEh/3yrhO8Pgq5eQjQmzfc3S4cZMEoal7d44b3i8whe4Na4tgZa7BwKib7LMa4FoNL
 X8THbHsOQSZV0tR0bhdXPhGL+30uQzpQ/9vxTN1W78gTItQW/eI97xQfcTk6Nr1gFVYx6mKxHc7
 A92Hih/jhpPyXH7Q5UJGtE4mqrhg1k6TmcCXIN2BAcxoiVHxs4u1uftsdSeoPLsKokUcB2MwfOi
 KUUfARx/bo/jo5h4eNfK6OV1TEH09Viovqe2sTyHVXZTYC+YgI8MVTcLWcHGBx3pSdDFCC76OSW
 Ei2YPMiszy3DST7ISOVpVxi+lhoJH5kVusp9HHbmis7WQ9n28SadBFhhDrASJfjx0mZt6jxz9p3
 NXC6/tXW6DpsRXw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the wq_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
The maintainer asked [1] for this patch to be received through the
driver-core tree.
[1]: https://lore.kernel.org/all/ZcEeOueCbrltxr_b@slm.duckdns.org/
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..f1e062acd091 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6157,7 +6157,7 @@ static struct device_attribute wq_sysfs_unbound_attrs[] = {
 	__ATTR_NULL,
 };
 
-static struct bus_type wq_subsys = {
+static const struct bus_type wq_subsys = {
 	.name				= "workqueue",
 	.dev_groups			= wq_sysfs_groups,
 };

---
base-commit: f297a3844aa059c53be3f69be85ebc071b8a6d16
change-id: 20240206-bus_cleanup-workqueue-1547a46532d1

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


