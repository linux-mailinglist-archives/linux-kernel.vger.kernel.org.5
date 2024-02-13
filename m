Return-Path: <linux-kernel+bounces-62940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDE852825
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95A0B25159
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A811C88;
	Tue, 13 Feb 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j0RtezKw"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611A11723
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801218; cv=none; b=AMxibKxXr86hMq1EjVSMNLF3qXdKJST4cXDeLoMXHHP1T/5z5ga+mRzYO06cJbEs5GKn5trRWtqe0AqeOfr9DKspXn8GGmVUb9j4KDu2G0He81Zk5jf/f8pNGWTve4sPAQE5zIHk6h1lUORJg1n5HViK/+8WMo5DbeA3kVHvLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801218; c=relaxed/simple;
	bh=DWFcKn1l9Sn/hd+zC927DFkvDijnYn0PyBhaocjqmPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QYdvkd9ZTlQ6CuVyAYHTtt4M+IKU89HMJy8fXWLbOR6Tft8uzihjdj1O/5MjFb6ZUmalnUZb0u1CuBZj9A8c/I+pn6J6sy/pACgixC/WaNH0r4mMFkgL8zmd3GP3e3bUtXpHgchFgfb05R+Nq4akPQVZe2+j2LKK3WRUEhYVYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j0RtezKw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240213051333epoutp01cc33bb93c0dd23faa6c28938bd41944e~zVCfVxCzu1138111381epoutp01F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:13:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240213051333epoutp01cc33bb93c0dd23faa6c28938bd41944e~zVCfVxCzu1138111381epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707801213;
	bh=dqPFTyfLpIiOwNn2UYQocQjz2kFlkgOBWnJcMM8k5K8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=j0RtezKwFfQt2vXITpkL1UhwRCJzuaenC7uSrN+cJbVYnkFR+j4lL13/9bPFKMl8W
	 IymepB0g8RL9uzbNCUexWdiCUeE5vzqIsTn8cG55bckPHAMWc4SRKWVQVUmO02u01C
	 NNpEJOi6XEN1HDC2mI/ofhLb7tJrYPzNNYB2a7sQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240213051333epcas1p1283e6c855368c394ace15522c9136aec~zVCexj1yQ2686026860epcas1p1H;
	Tue, 13 Feb 2024 05:13:33 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TYqH05tM9z4x9Pv; Tue, 13 Feb
	2024 05:13:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.B8.08572.C7AFAC56; Tue, 13 Feb 2024 14:13:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc~zVCd_duAW2685026850epcas1p1c;
	Tue, 13 Feb 2024 05:13:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240213051332epsmtrp2d80db3c4e9ba94969b78a7d530bc6104~zVCd9xIvc0269502695epsmtrp2m;
	Tue, 13 Feb 2024 05:13:32 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-07-65cafa7c6b12
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.20.18939.C7AFAC56; Tue, 13 Feb 2024 14:13:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240213051332epsmtip1835b0865323701a316e6a73933c4c37c~zVCdt2vdC1628916289epsmtip17;
	Tue, 13 Feb 2024 05:13:32 +0000 (GMT)
From: Seunghui Lee <sh043.lee@samsung.com>
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, gregkh@linuxfoundation.org, avri.altman@wdc.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	junwoo80.lee@samsung.com, jangsub.yi@samsung.com, cw9316.lee@samsung.com,
	sh8267.baek@samsung.com, wkon.kim@samsung.com, Seunghui Lee
	<sh043.lee@samsung.com>
Subject: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Tue, 13 Feb 2024 14:17:16 +0900
Message-Id: <20240213051716.6596-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmgW7Nr1OpBiv3aVq8/HmVzWLGqTZW
	i33XTrJb/Pq7nt2iefF6NouOrZOZLHY8P8NusetvM5PF5V1z2CyO/O9ntGj6s4/F4tqZE6wW
	x9eGW2y+9I3Fgc/jzrU9bB77565h9+jbsorR4/MmOY/2A91MAaxR2TYZqYkpqUUKqXnJ+SmZ
	eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
	S1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izzt85yFowX6zi3p2z7A2M
	O4S6GDk5JARMJFrnvmcBsYUEdjBKPOyq6mLkArI/MUq8mXcWKgHktH/igWn4MukXC0TRTkaJ
	vVsamCGcz4wSk4/PYwepYhPQkpi+aQsTSEJEoI1Rom/FY7AWZoEPjBK/+lYygVQJCzhKvGo+
	ywZiswioSjT0PwPbxytgKbHrzEp2iH3yEn/u9zBDxAUlTs58AlbDDBRv3jobbLWEQCOHxJnz
	xxkhGlwk1s59yQphC0u8Or4FapCUxOd3e9kgGpoZJdoavrJAOBMYJV4seMUEUWUv0dzaDFTF
	AbRCU2L9Ln2IbXwS7772sIKEJQR4JTraoKGnLPHy0TKoTkmJJe23mCFsD4nL63vZIIEXK/Hg
	ySPWCYxys5D8MAvJD7MQli1gZF7FKJZaUJybnppsWGAIj8vk/NxNjOAkqmW8g/Hy/H96hxiZ
	OBgPMUpwMCuJ8F6acSJViDclsbIqtSg/vqg0J7X4EKMpMFQnMkuJJucD03heSbyhiaWBiZmR
	iYWxpbGZkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MXasnH3yzWGB9a43J1NNxTttSNidZ
	NYcHChXv7LBp3RSs2cdmeE7UfouCHVuP2WbONV/Uj7gtcF10at306MXWQVoePfdTcplMZnlM
	MglKvCOQKJFhJbn3ab+iznGexx2ppQuF5rzedyj2yGO2vn7ZmuvvmPQ4quU4eiODolY8W7/f
	+Szjvkc7X/itePVQ0Orjm4sXXx1UaGuXdn/GffrIrcQLbn2dB9t1/Kzub5tkqvP0srz8rtK4
	Tesa2WImb1npFJ+YuKMr+ftShpPK2nwLve5Ia823M/DbnBTSp8m0LTTj0vdI8e1th+2F592d
	Im9TZM751LVn+a49j+8dWipv8Lt50c3Hev1+cwzj3D8psRRnJBpqMRcVJwIApklihisEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnG7Nr1OpBst+cVi8/HmVzWLGqTZW
	i33XTrJb/Pq7nt2iefF6NouOrZOZLHY8P8NusetvM5PF5V1z2CyO/O9ntGj6s4/F4tqZE6wW
	x9eGW2y+9I3Fgc/jzrU9bB77565h9+jbsorR4/MmOY/2A91MAaxRXDYpqTmZZalF+nYJXBnn
	7xxkLZgvVnHvzln2BsYdQl2MnBwSAiYSXyb9Yuli5OIQEtjOKHHi9TZGiISkxOJHD9m6GDmA
	bGGJw4eLQcJCAh8ZJb5tDgGx2QS0JKZv2sIEYosI9DBK9O3KA5nDLPCLUWLH1GVsIAlhAUeJ
	V81nwWwWAVWJhv5nLCA2r4ClxK4zK9khdslL/LnfwwwRF5Q4OfMJWA0zULx562zmCYx8s5Ck
	ZiFJLWBkWsUomlpQnJuem1xgqFecmFtcmpeul5yfu4kRHOBaQTsYl63/q3eIkYmD8RCjBAez
	kgjvpRknUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqY
	HNybDl2pdNt3KNj726eGqd6m/9j+X59roO9pySzexmYVG/SsL8TghNSUpy6xS55uO39g74y7
	ew34d8exH35Y+WLTfJELaarNS61W3Vp/Vovh4pnCncpzFpVH/CnQ+3voQdKfCZz1r9a3zmHl
	b22wvjFftSbI+86ls2sn/fkjF+rPdKeMb8epjeXFtlocfVufM6UcXLydfd4x+2jX6g2/ZhgW
	yH77VlKVfGPa6uaslosinRP2/W+6t1rFO+zJhFkbpZc6mTJ6W+78fCfcM7pDhTs+2EqHf+2U
	yvk/S8V+pZxb8dZ2zbN4pq6Ug44CtQsuH36w1m6jrH2qvaLnukqTaw3nl/dmt6nGp/wv8I9h
	UGIpzkg01GIuKk4EANd3Ui3fAgAA
X-CMS-MailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>

In mobile devices, suspend/resume situations are frequent.
In the case of a defective SD card in which initialization fails,
unnecessary initialization time is consumed for each resume.
A field is needed to check that SD card initialization has failed
on the host. It could be used to remove unnecessary initialization.

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/core/sd.c        | 12 +++++++++++-
 drivers/mmc/core/slot-gpio.c |  1 +
 include/linux/mmc/host.h     |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c3e554344c99..f0eb3864dc24 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1410,6 +1410,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	bool v18_fixup_failed = false;
 
 	WARN_ON(!host->claimed);
+	host->init_failed = false;
 retry:
 	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
 	if (err)
@@ -1752,6 +1753,8 @@ static int _mmc_sd_resume(struct mmc_host *host)
 
 	mmc_power_up(host, host->card->ocr);
 	err = mmc_sd_init_card(host, host->card->ocr, host->card);
+	if (err)
+		host->init_failed = true;
 	mmc_card_clr_suspended(host->card);
 
 out:
@@ -1803,8 +1806,12 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 
 static int mmc_sd_hw_reset(struct mmc_host *host)
 {
+	int err;
 	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sd_init_card(host, host->card->ocr, host->card);
+	err = mmc_sd_init_card(host, host->card->ocr, host->card);
+	if (err)
+		host->init_failed = true;
+	return err;
 }
 
 static const struct mmc_bus_ops mmc_sd_ops = {
@@ -1891,5 +1898,8 @@ int mmc_attach_sd(struct mmc_host *host)
 	pr_err("%s: error %d whilst initialising SD card\n",
 		mmc_hostname(host), err);
 
+	if (err)
+		host->init_failed = true;
+
 	return err;
 }
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 2a2d949a9344..93d081c7dd53 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -33,6 +33,7 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
 	host->trigger_card_event = true;
+	host->init_failed = false;
 	mmc_detect_change(host, msecs_to_jiffies(ctx->cd_debounce_delay_ms));
 
 	return IRQ_HANDLED;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2f445c651742..1d75cfdbf981 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -467,6 +467,7 @@ struct mmc_host {
 	struct timer_list	retune_timer;	/* for periodic re-tuning */
 
 	bool			trigger_card_event; /* card_event necessary */
+	bool			init_failed;	/* check if failed to initialize */
 
 	struct mmc_card		*card;		/* device attached to this host */
 
-- 
2.29.0


