Return-Path: <linux-kernel+bounces-24430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD282BC74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC1F2836ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40F53E23;
	Fri, 12 Jan 2024 08:43:10 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2139AC8;
	Fri, 12 Jan 2024 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app4 (Coremail) with SMTP id cS_KCgAXHy98+6BlXum4AA--.47709S2;
	Fri, 12 Jan 2024 16:42:38 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Hsuan <hpa@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Brent Pappas <bpappas@pappasbrent.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: ssh_css: Fix a null-pointer dereference in load_video_binaries
Date: Fri, 12 Jan 2024 16:34:19 +0800
Message-Id: <20240112083421.3728017-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgAXHy98+6BlXum4AA--.47709S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw15uw1xGrW5KF18tF17Awb_yoW8CFyxpF
	48Gw1Uur1UZrs7Ca17G347uF90g3sY9ay5Ww4DJa4fZ3Z7Aas2qF15KFWYgry8ur4fJ3yD
	tryjgFyYvr1FvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

The allocation failure of mycs->yuv_scaler_binary in load_video_binaries
is followed with a dereference of mycs->yuv_scaler_binary after the
following call chain:

sh_css_pipe_load_binaries
  |-> load_video_binaries (mycs->yuv_scaler_binary == NULL)
  |
  |-> sh_css_pipe_unload_binaries
        |-> unload_video_binaries

In unload_video_binaries, it calls to ia_css_binary_unload with argument
&pipe->pipe_settings.video.yuv_scaler_binary[i], which refers to the
same memory slot as mycs->yuv_scaler_binary. Thus, a null-pointer
dereference is triggered.

Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index f35c90809414..eb43f4e99d02 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -4936,9 +4936,10 @@ unload_video_binaries(struct ia_css_pipe *pipe)
 	ia_css_binary_unload(&pipe->pipe_settings.video.video_binary);
 	ia_css_binary_unload(&pipe->pipe_settings.video.vf_pp_binary);
 
-	for (i = 0; i < pipe->pipe_settings.video.num_yuv_scaler; i++)
-		ia_css_binary_unload(&pipe->pipe_settings.video.yuv_scaler_binary[i]);
-
+	if (pipe->pipe_settings.video.yuv_scaler_binary)
+		for (i = 0; i < pipe->pipe_settings.video.num_yuv_scaler; i++)
+			ia_css_binary_unload(&pipe->pipe_settings.video.yuv_scaler_binary[i]);
+		
 	kfree(pipe->pipe_settings.video.is_output_stage);
 	pipe->pipe_settings.video.is_output_stage = NULL;
 	kfree(pipe->pipe_settings.video.yuv_scaler_binary);
-- 
2.34.1


