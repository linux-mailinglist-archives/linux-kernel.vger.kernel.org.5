Return-Path: <linux-kernel+bounces-56034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23684C52A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE691F26F83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E81CD35;
	Wed,  7 Feb 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CkTAmr4S"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464901CF99;
	Wed,  7 Feb 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288720; cv=none; b=c2Y15W0IE6o+7QMUWPUSTg0GHjR/Zfu5er5ndlV6hPi6jDyrojBmc2IUdceKYePcersbitYqddMQH45RQQSlxTmQuc3qs5Xy4sfhi6s1OHxYtHhGuXQ9M9mnxtSwh+J228tJcCFHPJ6iyAgj+8ycNE9lE4xPGjDSwJvNpxvgM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288720; c=relaxed/simple;
	bh=xfJuk5EK3kY+kaejXnInyfN61eHdttxUa2l2rdBDTco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjS1n55T+yfLmX4bTq0zZTH94spJM0svKOVyUDYWAlJLlKLS6zcOKlWm4n+3omo0wUcDobdfIRuPML1crprwwQ6orITxcyjCoiNUB/ssuOk8YKFXG3G/aum69gT8W+mgb6eIufiORiebLmc42psESMlED+YMSA+Tq/6Uky7MdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CkTAmr4S; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8FEBD4076729;
	Wed,  7 Feb 2024 06:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8FEBD4076729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707288709;
	bh=pLGumPzf4SnkMMXOZxsu4fQpASfZpE+/MTtI3Z2JftY=;
	h=From:To:Cc:Subject:Date:From;
	b=CkTAmr4SSItmwJIz7i0JJOF8It2sn5ADcCKXh6nsZdkDzt0hRJBDM0OEerEGNY6Ns
	 0xYSPX7fudoG0hxj6zctyd6JsTBskxtlMonpsSsIN/vzp1FDkD29pD5wCKRGfWLM4n
	 K9lN0CCKxV0U46Fz80I9mYQCHvvDFS2Cv7JriuRY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Sujeev Dias <sdias@codeaurora.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] bus: mhi: host: free buffer on error in mhi_alloc_bhie_table
Date: Wed,  7 Feb 2024 09:51:36 +0300
Message-Id: <20240207065136.18316-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

img_info->mhi_buf should be freed on error path in mhi_alloc_bhie_table().
This error case is rare but still needs to be fixed.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/bus/mhi/host/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index edc0ec5a0933..738dcd11b66f 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -357,6 +357,7 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
 		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
 				  mhi_buf->buf, mhi_buf->dma_addr);
+	kfree(img_info->mhi_buf);
 
 error_alloc_mhi_buf:
 	kfree(img_info);
-- 
2.39.2


