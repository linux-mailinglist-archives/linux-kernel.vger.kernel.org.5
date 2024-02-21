Return-Path: <linux-kernel+bounces-74067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19685CF80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBEBB227D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23639AFC;
	Wed, 21 Feb 2024 05:17:57 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5E38F94;
	Wed, 21 Feb 2024 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492677; cv=none; b=ZQKndsPtpggR5ZLEU6JFo3k775v4FKOblpIzArPyGNb15ZOIAg0uffmwtMtS8Xr7zQcfAhc1Z60XhFvc64bnjopE9ieiM5e0nL5Li0yUjs9/PtHzXTwSXq8FE22eh4go5S7g4zOV5UZN6dvxerVSl3vMRPiNv3DOqc6K4BdSDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492677; c=relaxed/simple;
	bh=iHBwZX9fq4NPi4ewd6W0I8ZpmLGL7SlhEO1Yq6UFKJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MyIidC6WtVmZMfF8E4Ifffixh7KqgFiepoqtYX+kFQUezetVhvk71vhVB52UZVlvED3xiE/W7uoP2JlKOOhu/dleyKtPDBqwZNu7HNytg1fjgIvEpyxGBYo9rN6sRTdPFwh8YJkrqrPyFLusIGLCFEna8FVHnJ951sbiFZfCi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [122.231.253.174])
	by mail-app2 (Coremail) with SMTP id by_KCgB3na11h9VlKjj_AQ--.18492S2;
	Wed, 21 Feb 2024 13:17:42 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Yu Zhe <yuzhe@nfschina.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] media: ttpci: fix two memleaks in budget_av_attach
Date: Wed, 21 Feb 2024 13:17:04 +0800
Message-Id: <20240221051708.3165580-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgB3na11h9VlKjj_AQ--.18492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xKF13Ww4UAr1fZry8Grg_yoW8WFyxpF
	WFqa4rAry8ZrW0vr1kX3WYk3W5J3ZagFZ8Gr4Fqw4avFyfZr1kt348W34UAFn5Ga9rAa4U
	Kr1Dur4jgw1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When saa7146_register_device and saa7146_vv_init fails, budget_av_attach
should free the resources it allocates, like the error-handling of
ttpci_budget_init does. Besides, there are two fixme comment refers to
such deallocations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: rearrange the release order to the reverse order of allocations.
---
 drivers/media/pci/ttpci/budget-av.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 230b104a7cdf..a47c5850ef87 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1463,7 +1463,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1472,9 +1473,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
 		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
-			/* fixme: proper cleanup here */
-			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
+			ERR("cannot register capture v4l2 device\n");
 			return err;
 		}
 
-- 
2.34.1


