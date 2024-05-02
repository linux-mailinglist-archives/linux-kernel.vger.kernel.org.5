Return-Path: <linux-kernel+bounces-167074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F28BA41E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C3D1C22D77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A63184120;
	Thu,  2 May 2024 23:36:55 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30C181CEC;
	Thu,  2 May 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693015; cv=none; b=huIv+M6kKKgJKlSNRdmp08KKAcliRmlU+ghyJYF38bTRdTfMl/VyAYu5DK0MwA6zE9Jkmb2+u72W32XvzNJE/W2cdrcJ9w3SaYfQcYYF5ghpb7zQ8yosGy36/tn48P81vwb4a8jA2lRdyYDoOS6vDnwjtM53FW2j4r92Gi1tfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693015; c=relaxed/simple;
	bh=NUzH0xLjYug2wA1GsDRruTxJ0XL95zyZdLIf5ZhzrS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=FoIZ0xcML0sXuPM09v6CINwvnB64EYlo/nbw1kV0M03n7amm/B7Q1tl0UnJjigpPFkeyCY0eWIcAdjClsyul2IYdl20r06URVAEOzds6T0MU3b6RHHZeiV2sxcwfyZJYfdkQSjT6n98O96DxQgCPnfNUIeTEl8yxahqHqNvkM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.179.227])
	by mail-app2 (Coremail) with SMTP id by_KCgC3ZqZwIzRm7PwDAA--.6463S3;
	Fri, 03 May 2024 07:36:24 +0800 (CST)
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
Subject: [PATCH net v2 1/2] ax25: change kfree in ax25_dev_free to ax25_dev_free
Date: Fri,  3 May 2024 07:36:15 +0800
Message-Id: <81bc171fb2246201236c341e9b7d799f509d7dd4.1714690906.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1714690906.git.duoming@zju.edu.cn>
References: <cover.1714690906.git.duoming@zju.edu.cn>
In-Reply-To: <cover.1714690906.git.duoming@zju.edu.cn>
References: <cover.1714690906.git.duoming@zju.edu.cn>
X-CM-TRANSID:by_KCgC3ZqZwIzRm7PwDAA--.6463S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw48CFy8GryrArWDArWUurg_yoWfJFX_uF
	1kAFZrXw4UJr1UCw1rCFWrJry7Ww1jgw1fJryfAFZ7t34Yqa4UJrWkWr18XF1UurWUCr4I
	qr1rJr13Ar43JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbdAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
	x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
	0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
	AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
	cxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxw
	CY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_uwCF04k20xvY0x0EwIxGrwCF54CYxVCY
	1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPDG5UUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUJAWYztgkCSgAKsm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The ax25_dev is managed by reference counting, so it should not be
deallocated directly by kfree() in ax25_dev_free(), replace it with
ax25_dev_put() instead.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 282ec581c07..07723095c60 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -208,7 +208,7 @@ void __exit ax25_dev_free(void)
 		s        = ax25_dev;
 		netdev_put(ax25_dev->dev, &ax25_dev->dev_tracker);
 		ax25_dev = ax25_dev->next;
-		kfree(s);
+		ax25_dev_put(s);
 	}
 	ax25_dev_list = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
-- 
2.17.1


