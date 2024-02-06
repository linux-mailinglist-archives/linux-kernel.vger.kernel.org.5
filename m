Return-Path: <linux-kernel+bounces-54426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E833684AF16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B39281FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6E12883C;
	Tue,  6 Feb 2024 07:38:21 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1320C2C877;
	Tue,  6 Feb 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205101; cv=none; b=s/q3w0W/48EnrOwadBXBLnex8XP/TYwMaQfcI5WH6StqQHieWylXC6D6aQQ9nbuQgDafSTIj/bgopMekFy3Ax8+hn4WtSEI9Sp5X92yVFVZy7oLaYx19+0DjONbYCvxB4V4AJFbXdWyoFezC60Rk9lEZEuvKBaCykBnlxVTDJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205101; c=relaxed/simple;
	bh=TY6CKuc56ilxCQShfvIczFkUwQACgH40x6+RS1ysuBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eK08ke+/TTFmsdSO2DQF2i8crpYBCAxhhri+OS8eQpPcdg2WF/ldMbe+fZ4kywqBZAz2nn28mnPC5pGB75FC/7Kai1LaTSdQTNZGOdiq056yqjOKOuv7/AJrS2OPncsY96K0Aby7DQLwjNPX/deu1qyMK+iWJdZcHKrkZELBLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [115.200.229.48])
	by mail-app2 (Coremail) with SMTP id by_KCgDHCang4cFlG2tnAQ--.21117S2;
	Tue, 06 Feb 2024 15:38:09 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Yu Zhe <yuzhe@nfschina.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: ttpci: fix two memleaks in budget_av_attach
Date: Tue,  6 Feb 2024 15:37:10 +0800
Message-Id: <20240206073719.3133481-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgDHCang4cFlG2tnAQ--.21117S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xKF13Ww4UAr1DKrW8tFb_yoW8XF1fpa
	yFqa4rAryUXrW0vr1DX3WYk3W5t3ZagFW3WrsYgw4avFyfZw1Dt348X34UAFn5Ga9rAa4U
	Kwn09r1jgw1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbYLvtUUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When saa7146_register_device and saa7146_vv_init fails, budget_av_attach
should free the resources it allocates, like the error-handling of
ttpci_budget_init does. Besides, there are two fixme comment refers to
such deallocations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/media/pci/ttpci/budget-av.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 230b104a7cdf..4f897f848581 100644
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
@@ -1472,7 +1473,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
 		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
 			return err;
-- 
2.34.1


