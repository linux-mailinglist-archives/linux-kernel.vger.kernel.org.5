Return-Path: <linux-kernel+bounces-71913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5785AC72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15191285A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248ED58AD7;
	Mon, 19 Feb 2024 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="gC6mwSDK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C45823E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372194; cv=none; b=H3s3uJYHEHTJjcDaLpphovkaGViNg8B0m12NWZg8dJ1r6ll2b0jiiZF2yvnN6aQ/vLYl8DEnKrVbLW4i0Rqg65cxowMsgW5SP2zI4xdNNxZxb+dCoe0iCMYGazAjrA2L5HGJOdvlRup5gFlUE5OPVNob8rexy8IE9i2IfGaY/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372194; c=relaxed/simple;
	bh=GDlMaaEvH+4ZAzww1vS7qaXzwS3hQNyr2z3KYzcZF6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uX+Obvx59SInN60qWCRDXgA/bh8WsgLP6q3mUfq6dWiIoP4qY7nnz/MUDHEqnouaG1AOaqcUDqBOcMFD3XguWNBSpIlw74C2CWmw7+VVKYjn2EKPXdl7oBFNo+8g2t+GuxdT9UFy3I3BqI/ssZSJOSswUkJ3AG3KH7zHpaSudaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=gC6mwSDK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso2329303b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372192; x=1708976992;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5cxuExblNc4ySUrOXZT/i60BTkmMfHliWWRnxN2LN0=;
        b=BPuuSCXMG23HCY1nK8PF3cvowgdGI7+kuq7ETx3MjnMhfeLOtkDUXU9t3PIaEY5XOM
         MtO6wkmlpVwVihsylWC0MeNDxLD9itUBEKyXxPgyohTLQUG7F95RavPerXxwTnfD6W71
         l4ccEiCFHWFKz1H3mVbYA0Tq7hFdyxocd1RB56Oan/4KD14OVeXMLK74UB9Q+QvUYYfy
         o3Qvfz2GofuFmZHEJMWNe0QXSXiGm0rdqYlin1XltAqybjFuc7096HUNE59vIROix0wQ
         QFPSMcgajrvx4ZXehH+cgXbBBOi18/sKkTaZY9a8LioEC5BnzUgq/U/UYANqUsWAG8Ef
         BIeg==
X-Gm-Message-State: AOJu0Yy5TIUw4g8LzqfV81zbogchS0Ysxv4Hi8TvFAMESqHsj7Y8y/GM
	yzMbwLN2EV4JrUQ0zj/kFWvCZJqd4D1o4YrxBbEy2m0GhV3cXVfKWEKWygd6weAcww==
X-Google-Smtp-Source: AGHT+IGvsR7nZpZVOpqJkCXeoQYcILZJpPdLLwQ/k4cmbk/+DDsoYDjLvz2mvGPBaCPNeqiROxL1bg==
X-Received: by 2002:a05:6a20:b21:b0:19e:48e7:e664 with SMTP id x33-20020a056a200b2100b0019e48e7e664mr9473062pzf.31.1708372192022;
        Mon, 19 Feb 2024 11:49:52 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fn15-20020a056a002fcf00b006e324e33ab8sm4725779pfb.218.2024.02.19.11.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:49:51 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708372189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5cxuExblNc4ySUrOXZT/i60BTkmMfHliWWRnxN2LN0=;
	b=gC6mwSDK9c9cN6GPiykq7vRl+LAoRpYgTdRUePG27mXZ2pK+jYfVPzuFRDUwrTuGgtMykc
	9QIaA7gI+M75pSJuU8myQfrmLsT+qHgi4DD2xHiK0Vdj38k0EsmaoQFdggrViHsRVGvKvR
	jtsV4m1Bv3x+4M+1KY24DQgOJL4BkwJ5EM9o/c8scWEBoWz3ld1tg95c+eSAql0+ym9uvt
	daqMYyqJhF9NRIQisWzpsZ3LSGDcCfQvSo7ulXZM7wyvt8wVQ+K72HlkmDEeWJuK33kHG3
	lhTXtuB90C2gTjbQ3Xd6oZYbtJ9aUbCtMewSXjuxyvp37SLWpkNpwyefBjPgVg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:50:37 -0300
Subject: [PATCH] parport: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-parport-v1-1-1d2cac6c884b@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAyx02UC/x2MUQqFIBAArxL7naBSoO8qj4jNtloIk7UiiO6e9
 DkwMzdkEqYMv+oGoZMzb7GAqSsIC8aZFI+FwWrbaGu8GosUqA8rYTySSihpk10NqBuHrvXGOyh
 xEpr4+sb/7nlecmVQuWgAAAA=
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=GDlMaaEvH+4ZAzww1vS7qaXzwS3hQNyr2z3KYzcZF6Q=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07EN8OvcjPJ55hQE7ATHXtY8ZqD3qv9/MYzUZ
 OBE8ZdNDzOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOxDQAKCRDJC4p8Y4ZY
 pkzJEACloxmdXukC3F/8+gcU19/wbX3/xddgxXrmH0cv5e5DVSSpx7zyUaN7QoDSN8fRy1m2KfF
 71a3AuszvKo2/4sjxiveHD54BRcKMKzMnrV5DWtVk4yS/PO/KLFDxcwRHUZXTH3IytF10HcDPWH
 SQfWSU9r4D1jtQrIo1QyzIKilEPHXLhMhy14ZcwHGujY7ivEB3kEYj3uesgm6A+Gw4hVBj6dDZx
 p0rLGpUpUa3rMe2BxNBG/BDgsNmc+W8Oa7/ugcIAth4mAhV3ka7CekULOc5KhRje0zPx4vIsdF9
 QH85dn4bzorAU2ogjCqRsESs9dTYjFtOgt8EBNuTXeNLPNeTxzuKzgAtm017DM/z4iIfhHk1PbF
 SJ+CO/x5yaOLS4KP+nuBltwsEWemhWFBkNu9/w5vsMHdfa7s3wzVztu/WMErMK9obiati9uwIF1
 ZoV4MGBhI+C+YP7fQyK+BL8MAd1XqzmD37K/hsS+tI0+ic7wSIX57mbr3Ibi7cpalPfmPO8jf1l
 4oeDh8go0T/hzRL6Ha7flO0abSFaC+eG0bWslJyfVLP/5rPQyE+um6VcrZkyojjmDcmyomI6n4d
 3cPMs9f3HhREEi/f5WOgS5/xtCeQkrCqmtcKdTRICpZ8jxfzA7rPuTCpx6v/4Fjo8DI2TCs1gxf
 c8bBLeTscqMPWPw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
parport_device_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/parport/share.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 49c74ded8a53..33159392d70c 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -101,7 +101,7 @@ static struct parport_operations dead_ops = {
 	.owner		= NULL,
 };
 
-static struct device_type parport_device_type = {
+static const struct device_type parport_device_type = {
 	.name = "parport",
 };
 

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-parport-ba048a859198

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


