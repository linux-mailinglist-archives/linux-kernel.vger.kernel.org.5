Return-Path: <linux-kernel+bounces-167073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CAA8BA41B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B8C281DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9ED18130B;
	Thu,  2 May 2024 23:36:51 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8CB4CDE0;
	Thu,  2 May 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693011; cv=none; b=MivoRU4yCbYSxIcokDEVmGkspRBUL7iDZSgVoOt24rncZfX84Dmc6zS0ak0TSBCreY+MdXzU4aJ1Bu6ETh6TpKM2mVe8YKlVm2fnW3oyFkDggt2c5Cjzk8SMiOXhrv1mrYMoAOUP5WnovRYV8tx8ZGBmne0xzXhEae4BSFGtLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693011; c=relaxed/simple;
	bh=Fjn0sWcJSSpaNhOq3cT/DmSa0Heykx1LsFKm4zCLDGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=hgvwzWqroqzZSiaMC8XvKoOQ6C3yhymT39WQplQouS3jU61UfnZHN2n3GGhq9/19ZJrwXVXg0bxlztKtQlz8YwHopYs4fxTFcMNIxQrOLqcCbi3QJq3ND3IB3MW22NE7FM9RVZHac+GP+od6DnDhffxxEgIVwMePLHHEZM7HcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.179.227])
	by mail-app2 (Coremail) with SMTP id by_KCgC3ZqZwIzRm7PwDAA--.6463S4;
	Fri, 03 May 2024 07:36:26 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	jreuter@yaina.de,
	horms@kernel.org,
	Markus.Elfring@web.de,
	dan.carpenter@linaro.org,
	lars@oddbit.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net v2 2/2] ax25: fix potential reference counting leak in ax25_addr_ax25dev
Date: Fri,  3 May 2024 07:36:16 +0800
Message-Id: <74e840d98f2bfc79c6059993b2fc1ed3888faba4.1714690906.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1714690906.git.duoming@zju.edu.cn>
References: <cover.1714690906.git.duoming@zju.edu.cn>
In-Reply-To: <cover.1714690906.git.duoming@zju.edu.cn>
References: <cover.1714690906.git.duoming@zju.edu.cn>
X-CM-TRANSID:by_KCgC3ZqZwIzRm7PwDAA--.6463S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWrAF18GFyrZw17XF45GFg_yoWDZFc_ua
	s7ury7Ww1DJr1jkw1rXF48Jry7Zw1vgwn7Ar1ayFZ7trWYqa47JrWkJwn8XFyUWFy7Cr4S
	qF1rGrW3Cw4SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbl8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6FWl42xK82IYc2Ij64vIr41l4c8EcI0E
	c7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUbE_MUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUJAWYztgkCSgAMsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The reference counting of ax25_dev potentially increase more
than once in ax25_addr_ax25dev(), which will cause memory leak.

In order to fix the above issue, only increase the reference
counting of ax25_dev once, when the res is not null.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 07723095c60..7c2ea7309b0 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -37,8 +37,9 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
-			ax25_dev_hold(ax25_dev);
 		}
+	if (res)
+		ax25_dev_hold(res);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	return res;
-- 
2.17.1


