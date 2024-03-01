Return-Path: <linux-kernel+bounces-88794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D086E6B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E1BB26A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569985CAC;
	Fri,  1 Mar 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gh7jdSsG"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBC27473
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312579; cv=none; b=Yy7gD81z1fQOQxmvRxEqeLO69wX4Bune/ejYOSrkz+TIzIosUPMLDZTA5ODta0ie5m5Xvyhc4ddVw2Tiwrv4uLSVhU8oeDUIJfmvoWWF/HPQz3zUr1DYfWI4yEnbelpOMmWg65t77i3rFp+OIvJWO+5BAsmUOeZhJiJz2LT4gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312579; c=relaxed/simple;
	bh=/qdWvtusvoG5pkLxxqc07SePTR8XmELOkvNg8Hp39Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tY1TO0Bvvf4eZEMDlcDYLLmIdfNVKT3AwgdqfqKGrpvdndU+ScfYPeL28e63WJ+vYp00p1U42AW+TZt2iKOtSkZ/7F0YPl7mGhmJ29yJNSdEBXHc/VgwjcoAN+ubNNGIJiRePRp7/fzUUTf8wE9N+RTGt3OB7U4KSFQpP0zgtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gh7jdSsG; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-365be6563cbso6859465ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312575; x=1709917375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSgSXfgxd1HBfN5s8xR+nxlbFslYXN/BhixB/5WxxqU=;
        b=gh7jdSsGYjXOuYFKoANHE0wsZskNVVbYqiFqpBMJy6rVbYkqlqeZ+EpIpkPn84s7jh
         BSP9rzgS5N4qFbllbYATDV1O95+RL7D68FUyQPzIZXbeWzgX7FyUTH92I0DvS+nybIfZ
         ObZCh7+Lg6lVlK17DcyNxnaFMObL4YlWP++xUcRxOomdsXGxDDj7djldHhO8FGtrxgov
         bQtqaAJd1kOtGutYuScCeIwWLKq7ShGx0Ws5f/iBLEW02wHZczQ6dYI/YmjNs8PiW2q3
         7mrNZBdSwbGXHN4lNZMAUv2vvrvwnFWkEagseMHhRLD+UPuUY/7y+S6SjMKEQtljklXP
         fw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312575; x=1709917375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSgSXfgxd1HBfN5s8xR+nxlbFslYXN/BhixB/5WxxqU=;
        b=LnBqxdEFz3/W1GCTvPOKddVqRVzyKJuIw9zer6Cqr+S80nc67U3hEKBW6LJ53AzGiR
         L1/zavtewT0HCjydRPXfjg2aCSWR3mwE1mxglAlrlX43vB09gtfFT2K+7q76GrB3T86X
         /utqNcCqJLopGXvChv0i7LkqDTZ6e8X0k71J136U6tepKT4PBCCUhpxFqIpx/RYzuZaW
         hekLfurxq1E/Y2DjMMQtmvVzOSOpv5vG8tinfmmaFtrq/06nJZ7NGGZTi8pS5n7NYEVr
         a95WN/aLaXilDf1um3bLYshn2k46soz/8Jzzc1i5wF222VUKKMzWSYQGkk00Q3Ap1xB7
         yr3A==
X-Forwarded-Encrypted: i=1; AJvYcCXl6htuaNKkLaiUAZvJK9tmI5eRq7f8y5N3ZXH9oDRBS7+vt6xv7Qjnpng+3ioebxBDus/HjP3Fiof+i/wtap6AlF2EacKwWUERlv/2
X-Gm-Message-State: AOJu0Yyx7RcUbMVytNXXZAmKOMK2o66tKWatBfdRFGhkhgUeflNV/jeD
	p/OoLW/CF7z/GafRxRIT9NGJol4cb3I/r9Oo7joXb/BARoOOUCD2IxYIwBv45Y0=
X-Google-Smtp-Source: AGHT+IHmakldIhnZdACh8Xb4eLoG//3+9m5Nq3xOh/kIo6weL9MH/PftUqX27mbS1GoJ+9Sp5GSylQ==
X-Received: by 2002:a05:6e02:1c22:b0:365:44:1ed6 with SMTP id m2-20020a056e021c2200b0036500441ed6mr2643355ilh.5.1709312574873;
        Fri, 01 Mar 2024 09:02:54 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b0036581060910sm991430ilq.6.2024.03.01.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:02:54 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] net: ipa: don't save the platform device
Date: Fri,  1 Mar 2024 11:02:42 -0600
Message-Id: <20240301170242.243703-8-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301170242.243703-1-elder@linaro.org>
References: <20240301170242.243703-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPA platform device is now only used as the structure containing
the IPA device structure.  Replace the platform device pointer with
a pointer to the device structure.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa.h           |  5 ++---
 drivers/net/ipa/ipa_cmd.c       |  6 +++---
 drivers/net/ipa/ipa_endpoint.c  | 29 ++++++++++++++---------------
 drivers/net/ipa/ipa_interrupt.c |  7 +++----
 drivers/net/ipa/ipa_main.c      | 13 ++++++++-----
 drivers/net/ipa/ipa_mem.c       | 24 +++++++++++-------------
 drivers/net/ipa/ipa_modem.c     | 14 +++++++-------
 drivers/net/ipa/ipa_power.c     |  4 ++--
 drivers/net/ipa/ipa_qmi.c       | 10 +++++-----
 drivers/net/ipa/ipa_smp2p.c     | 13 ++++++-------
 drivers/net/ipa/ipa_table.c     | 18 ++++++++----------
 drivers/net/ipa/ipa_uc.c        |  9 ++++-----
 12 files changed, 73 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index f3355e040a9e1..334cd62cf2866 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -21,7 +21,6 @@
 struct clk;
 struct icc_path;
 struct net_device;
-struct platform_device;
 
 struct ipa_power;
 struct ipa_smp2p;
@@ -31,7 +30,7 @@ struct ipa_interrupt;
  * struct ipa - IPA information
  * @gsi:		Embedded GSI structure
  * @version:		IPA hardware version
- * @pdev:		Platform device
+ * @dev:		IPA device pointer
  * @completion:		Used to signal pipeline clear transfer complete
  * @nb:			Notifier block used for remoteproc SSR
  * @notifier:		Remoteproc SSR notifier
@@ -79,7 +78,7 @@ struct ipa_interrupt;
 struct ipa {
 	struct gsi gsi;
 	enum ipa_version version;
-	struct platform_device *pdev;
+	struct device *dev;
 	struct completion completion;
 	struct notifier_block nb;
 	void *notifier;
diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index f1419fbd776c3..39219963dbb3f 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -174,7 +174,7 @@ bool ipa_cmd_table_init_valid(struct ipa *ipa, const struct ipa_mem *mem,
 	u32 offset_max = field_max(IP_FLTRT_FLAGS_NHASH_ADDR_FMASK);
 	u32 size_max = field_max(IP_FLTRT_FLAGS_NHASH_SIZE_FMASK);
 	const char *table = route ? "route" : "filter";
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	u32 size;
 
 	size = route ? ipa->route_count : ipa->filter_count + 1;
@@ -204,7 +204,7 @@ bool ipa_cmd_table_init_valid(struct ipa *ipa, const struct ipa_mem *mem,
 /* Validate the memory region that holds headers */
 static bool ipa_cmd_header_init_local_valid(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	const struct ipa_mem *mem;
 	u32 offset_max;
 	u32 size_max;
@@ -256,7 +256,7 @@ static bool ipa_cmd_register_write_offset_valid(struct ipa *ipa,
 						const char *name, u32 offset)
 {
 	struct ipa_cmd_register_write *payload;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	u32 offset_max;
 	u32 bit_count;
 
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index afa1d56d9095c..dd490941615e2 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -233,8 +233,8 @@ static bool ipa_endpoint_data_valid_one(struct ipa *ipa, u32 count,
 			    const struct ipa_gsi_endpoint_data *data)
 {
 	const struct ipa_gsi_endpoint_data *other_data;
-	struct device *dev = &ipa->pdev->dev;
 	enum ipa_endpoint_name other_name;
+	struct device *dev = ipa->dev;
 
 	if (ipa_gsi_endpoint_data_empty(data))
 		return true;
@@ -388,7 +388,7 @@ static u32 ipa_endpoint_max(struct ipa *ipa, u32 count,
 			    const struct ipa_gsi_endpoint_data *data)
 {
 	const struct ipa_gsi_endpoint_data *dp = data;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	enum ipa_endpoint_name name;
 	u32 max;
 
@@ -606,7 +606,7 @@ int ipa_endpoint_modem_exception_reset_all(struct ipa *ipa)
 	count = ipa->modem_tx_count + ipa_cmd_pipeline_clear_count();
 	trans = ipa_cmd_trans_alloc(ipa, count);
 	if (!trans) {
-		dev_err(&ipa->pdev->dev,
+		dev_err(ipa->dev,
 			"no transaction to reset modem exception endpoints\n");
 		return -EBUSY;
 	}
@@ -1498,8 +1498,7 @@ ipa_endpoint_status_tag_valid(struct ipa_endpoint *endpoint, const void *data)
 	if (endpoint_id == command_endpoint->endpoint_id) {
 		complete(&ipa->completion);
 	} else {
-		dev_err(&ipa->pdev->dev,
-			"unexpected tagged packet from endpoint %u\n",
+		dev_err(ipa->dev, "unexpected tagged packet from endpoint %u\n",
 			endpoint_id);
 	}
 
@@ -1536,6 +1535,7 @@ static void ipa_endpoint_status_parse(struct ipa_endpoint *endpoint,
 	void *data = page_address(page) + NET_SKB_PAD;
 	u32 unused = buffer_size - total_len;
 	struct ipa *ipa = endpoint->ipa;
+	struct device *dev = ipa->dev;
 	u32 resid = total_len;
 
 	while (resid) {
@@ -1544,7 +1544,7 @@ static void ipa_endpoint_status_parse(struct ipa_endpoint *endpoint,
 		u32 len;
 
 		if (resid < IPA_STATUS_SIZE) {
-			dev_err(&endpoint->ipa->pdev->dev,
+			dev_err(dev,
 				"short message (%u bytes < %zu byte status)\n",
 				resid, IPA_STATUS_SIZE);
 			break;
@@ -1666,8 +1666,8 @@ void ipa_endpoint_default_route_clear(struct ipa *ipa)
  */
 static int ipa_endpoint_reset_rx_aggr(struct ipa_endpoint *endpoint)
 {
-	struct device *dev = &endpoint->ipa->pdev->dev;
 	struct ipa *ipa = endpoint->ipa;
+	struct device *dev = ipa->dev;
 	struct gsi *gsi = &ipa->gsi;
 	bool suspended = false;
 	dma_addr_t addr;
@@ -1769,7 +1769,7 @@ static void ipa_endpoint_reset(struct ipa_endpoint *endpoint)
 		gsi_channel_reset(&ipa->gsi, channel_id, true);
 
 	if (ret)
-		dev_err(&ipa->pdev->dev,
+		dev_err(ipa->dev,
 			"error %d resetting channel %u for endpoint %u\n",
 			ret, endpoint->channel_id, endpoint->endpoint_id);
 }
@@ -1817,7 +1817,7 @@ int ipa_endpoint_enable_one(struct ipa_endpoint *endpoint)
 
 	ret = gsi_channel_start(gsi, endpoint->channel_id);
 	if (ret) {
-		dev_err(&ipa->pdev->dev,
+		dev_err(ipa->dev,
 			"error %d starting %cX channel %u for endpoint %u\n",
 			ret, endpoint->toward_ipa ? 'T' : 'R',
 			endpoint->channel_id, endpoint_id);
@@ -1854,14 +1854,13 @@ void ipa_endpoint_disable_one(struct ipa_endpoint *endpoint)
 	/* Note that if stop fails, the channel's state is not well-defined */
 	ret = gsi_channel_stop(gsi, endpoint->channel_id);
 	if (ret)
-		dev_err(&ipa->pdev->dev,
-			"error %d attempting to stop endpoint %u\n", ret,
-			endpoint_id);
+		dev_err(ipa->dev, "error %d attempting to stop endpoint %u\n",
+			ret, endpoint_id);
 }
 
 void ipa_endpoint_suspend_one(struct ipa_endpoint *endpoint)
 {
-	struct device *dev = &endpoint->ipa->pdev->dev;
+	struct device *dev = endpoint->ipa->dev;
 	struct gsi *gsi = &endpoint->ipa->gsi;
 	int ret;
 
@@ -1881,7 +1880,7 @@ void ipa_endpoint_suspend_one(struct ipa_endpoint *endpoint)
 
 void ipa_endpoint_resume_one(struct ipa_endpoint *endpoint)
 {
-	struct device *dev = &endpoint->ipa->pdev->dev;
+	struct device *dev = endpoint->ipa->dev;
 	struct gsi *gsi = &endpoint->ipa->gsi;
 	int ret;
 
@@ -1983,7 +1982,7 @@ void ipa_endpoint_deconfig(struct ipa *ipa)
 
 int ipa_endpoint_config(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	const struct reg *reg;
 	u32 endpoint_id;
 	u32 hw_limit;
diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 7399724160a89..c3e8784d51d91 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -110,14 +110,13 @@ static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
 	struct ipa_interrupt *interrupt = dev_id;
 	struct ipa *ipa = interrupt->ipa;
 	u32 enabled = interrupt->enabled;
+	struct device *dev = ipa->dev;
 	const struct reg *reg;
-	struct device *dev;
 	u32 pending;
 	u32 offset;
 	u32 mask;
 	int ret;
 
-	dev = &ipa->pdev->dev;
 	ret = pm_runtime_get_sync(dev);
 	if (WARN_ON(ret < 0))
 		goto out_power_put;
@@ -240,8 +239,8 @@ void ipa_interrupt_simulate_suspend(struct ipa_interrupt *interrupt)
 int ipa_interrupt_config(struct ipa *ipa)
 {
 	struct ipa_interrupt *interrupt = ipa->interrupt;
-	struct device *dev = &ipa->pdev->dev;
 	unsigned int irq = interrupt->irq;
+	struct device *dev = ipa->dev;
 	const struct reg *reg;
 	int ret;
 
@@ -281,7 +280,7 @@ int ipa_interrupt_config(struct ipa *ipa)
 void ipa_interrupt_deconfig(struct ipa *ipa)
 {
 	struct ipa_interrupt *interrupt = ipa->interrupt;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	ipa->interrupt = NULL;
 
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 3125aec88e6e1..57b241417e8cd 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -7,7 +7,6 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
-#include <linux/device.h>
 #include <linux/bug.h>
 #include <linux/io.h>
 #include <linux/firmware.h>
@@ -114,7 +113,7 @@ int ipa_setup(struct ipa *ipa)
 {
 	struct ipa_endpoint *exception_endpoint;
 	struct ipa_endpoint *command_endpoint;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	int ret;
 
 	ret = gsi_setup(&ipa->gsi);
@@ -858,7 +857,7 @@ static int ipa_probe(struct platform_device *pdev)
 		goto err_power_exit;
 	}
 
-	ipa->pdev = pdev;
+	ipa->dev = dev;
 	dev_set_drvdata(dev, ipa);
 	ipa->interrupt = interrupt;
 	ipa->power = power;
@@ -953,12 +952,16 @@ static int ipa_probe(struct platform_device *pdev)
 
 static void ipa_remove(struct platform_device *pdev)
 {
-	struct ipa *ipa = dev_get_drvdata(&pdev->dev);
-	struct device *dev = &pdev->dev;
 	struct ipa_interrupt *interrupt;
 	struct ipa_power *power;
+	struct device *dev;
+	struct ipa *ipa;
 	int ret;
 
+	ipa = dev_get_drvdata(&pdev->dev);
+	dev = ipa->dev;
+	WARN_ON(dev != &pdev->dev);
+
 	power = ipa->power;
 	interrupt = ipa->interrupt;
 
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index d7df7d340221d..709f061ede617 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -88,7 +88,7 @@ int ipa_mem_setup(struct ipa *ipa)
 	 */
 	trans = ipa_cmd_trans_alloc(ipa, 4);
 	if (!trans) {
-		dev_err(&ipa->pdev->dev, "no transaction for memory setup\n");
+		dev_err(ipa->dev, "no transaction for memory setup\n");
 		return -EBUSY;
 	}
 
@@ -218,8 +218,8 @@ static bool ipa_mem_id_required(struct ipa *ipa, enum ipa_mem_id mem_id)
 
 static bool ipa_mem_valid_one(struct ipa *ipa, const struct ipa_mem *mem)
 {
-	struct device *dev = &ipa->pdev->dev;
 	enum ipa_mem_id mem_id = mem->id;
+	struct device *dev = ipa->dev;
 	u16 size_multiple;
 
 	/* Make sure the memory region is valid for this version of IPA */
@@ -255,7 +255,7 @@ static bool ipa_mem_valid_one(struct ipa *ipa, const struct ipa_mem *mem)
 static bool ipa_mem_valid(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 {
 	DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	enum ipa_mem_id mem_id;
 	u32 i;
 
@@ -291,7 +291,7 @@ static bool ipa_mem_valid(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 /* Do all memory regions fit within the IPA local memory? */
 static bool ipa_mem_size_valid(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	u32 limit = ipa->mem_size;
 	u32 i;
 
@@ -318,7 +318,7 @@ static bool ipa_mem_size_valid(struct ipa *ipa)
  */
 int ipa_mem_config(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	const struct ipa_mem *mem;
 	const struct reg *reg;
 	dma_addr_t addr;
@@ -394,7 +394,7 @@ int ipa_mem_config(struct ipa *ipa)
 /* Inverse of ipa_mem_config() */
 void ipa_mem_deconfig(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	dma_free_coherent(dev, ipa->zero_size, ipa->zero_virt, ipa->zero_addr);
 	ipa->zero_size = 0;
@@ -421,8 +421,7 @@ int ipa_mem_zero_modem(struct ipa *ipa)
 	 */
 	trans = ipa_cmd_trans_alloc(ipa, 3);
 	if (!trans) {
-		dev_err(&ipa->pdev->dev,
-			"no transaction to zero modem memory\n");
+		dev_err(ipa->dev, "no transaction to zero modem memory\n");
 		return -EBUSY;
 	}
 
@@ -453,7 +452,7 @@ int ipa_mem_zero_modem(struct ipa *ipa)
  */
 static int ipa_imem_init(struct ipa *ipa, unsigned long addr, size_t size)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	struct iommu_domain *domain;
 	unsigned long iova;
 	phys_addr_t phys;
@@ -486,13 +485,12 @@ static int ipa_imem_init(struct ipa *ipa, unsigned long addr, size_t size)
 
 static void ipa_imem_exit(struct ipa *ipa)
 {
+	struct device *dev = ipa->dev;
 	struct iommu_domain *domain;
-	struct device *dev;
 
 	if (!ipa->imem_size)
 		return;
 
-	dev = &ipa->pdev->dev;
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain) {
 		size_t size;
@@ -528,7 +526,7 @@ static void ipa_imem_exit(struct ipa *ipa)
  */
 static int ipa_smem_init(struct ipa *ipa, u32 item, size_t size)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	struct iommu_domain *domain;
 	unsigned long iova;
 	phys_addr_t phys;
@@ -595,7 +593,7 @@ static int ipa_smem_init(struct ipa *ipa, u32 item, size_t size)
 
 static void ipa_smem_exit(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	struct iommu_domain *domain;
 
 	domain = iommu_get_domain_for_dev(dev);
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 1d1be92fbebcb..c27ca3f27f7d4 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -58,7 +58,7 @@ static int ipa_open(struct net_device *netdev)
 	struct device *dev;
 	int ret;
 
-	dev = &ipa->pdev->dev;
+	dev = ipa->dev;
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		goto err_power_put;
@@ -94,7 +94,7 @@ static int ipa_stop(struct net_device *netdev)
 	struct device *dev;
 	int ret;
 
-	dev = &ipa->pdev->dev;
+	dev = ipa->dev;
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		goto out_power_put;
@@ -158,7 +158,7 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	 */
 	netif_stop_queue(netdev);
 
-	dev = &ipa->pdev->dev;
+	dev = ipa->dev;
 	ret = pm_runtime_get(dev);
 	if (ret < 1) {
 		/* If a resume won't happen, just drop the packet */
@@ -322,7 +322,7 @@ int ipa_modem_start(struct ipa *ipa)
 		goto out_set_state;
 	}
 
-	SET_NETDEV_DEV(netdev, &ipa->pdev->dev);
+	SET_NETDEV_DEV(netdev, ipa->dev);
 	priv = netdev_priv(netdev);
 	priv->ipa = ipa;
 	priv->tx = ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX];
@@ -396,7 +396,7 @@ int ipa_modem_stop(struct ipa *ipa)
 /* Treat a "clean" modem stop the same as a crash */
 static void ipa_modem_crashed(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	int ret;
 
 	/* Prevent the modem from triggering a call to ipa_setup() */
@@ -443,7 +443,7 @@ static int ipa_modem_notify(struct notifier_block *nb, unsigned long action,
 {
 	struct ipa *ipa = container_of(nb, struct ipa, nb);
 	struct qcom_ssr_notify_data *notify_data = data;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	switch (action) {
 	case QCOM_SSR_BEFORE_POWERUP:
@@ -492,7 +492,7 @@ int ipa_modem_config(struct ipa *ipa)
 
 void ipa_modem_deconfig(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	int ret;
 
 	ret = qcom_unregister_ssr_notifier(ipa->notifier, &ipa->nb);
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 0f635b8356bfb..41ca7ef5e20fc 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -238,7 +238,7 @@ int ipa_power_setup(struct ipa *ipa)
 
 	ipa_interrupt_enable(ipa, IPA_IRQ_TX_SUSPEND);
 
-	ret = device_init_wakeup(&ipa->pdev->dev, true);
+	ret = device_init_wakeup(ipa->dev, true);
 	if (ret)
 		ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
 
@@ -247,7 +247,7 @@ int ipa_power_setup(struct ipa *ipa)
 
 void ipa_power_teardown(struct ipa *ipa)
 {
-	(void)device_init_wakeup(&ipa->pdev->dev, false);
+	(void)device_init_wakeup(ipa->dev, false);
 	ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
 }
 
diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index f70f0a1d1cdac..65c40e207802a 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -96,7 +96,7 @@ static void ipa_server_init_complete(struct ipa_qmi *ipa_qmi)
 				   IPA_QMI_INIT_COMPLETE_IND_SZ,
 				   ipa_init_complete_ind_ei, &ind);
 	if (ret)
-		dev_err(&ipa->pdev->dev,
+		dev_err(ipa->dev,
 			"error %d sending init complete indication\n", ret);
 	else
 		ipa_qmi->indication_sent = true;
@@ -148,7 +148,7 @@ static void ipa_qmi_ready(struct ipa_qmi *ipa_qmi)
 	ipa = container_of(ipa_qmi, struct ipa, qmi);
 	ret = ipa_modem_start(ipa);
 	if (ret)
-		dev_err(&ipa->pdev->dev, "error %d starting modem\n", ret);
+		dev_err(ipa->dev, "error %d starting modem\n", ret);
 }
 
 /* All QMI clients from the modem node are gone (modem shut down or crashed). */
@@ -199,7 +199,7 @@ static void ipa_server_indication_register(struct qmi_handle *qmi,
 		ipa_qmi->indication_requested = true;
 		ipa_qmi_ready(ipa_qmi);		/* We might be ready now */
 	} else {
-		dev_err(&ipa->pdev->dev,
+		dev_err(ipa->dev,
 			"error %d sending register indication response\n", ret);
 	}
 }
@@ -228,7 +228,7 @@ static void ipa_server_driver_init_complete(struct qmi_handle *qmi,
 		ipa_qmi->uc_ready = true;
 		ipa_qmi_ready(ipa_qmi);		/* We might be ready now */
 	} else {
-		dev_err(&ipa->pdev->dev,
+		dev_err(ipa->dev,
 			"error %d sending init complete response\n", ret);
 	}
 }
@@ -417,7 +417,7 @@ static void ipa_client_init_driver_work(struct work_struct *work)
 	qmi = &ipa_qmi->client_handle;
 
 	ipa = container_of(ipa_qmi, struct ipa, qmi);
-	dev = &ipa->pdev->dev;
+	dev = ipa->dev;
 
 	ret = qmi_txn_init(qmi, &txn, NULL, NULL);
 	if (ret < 0) {
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 831268551d9a7..aeccce9fab727 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -84,15 +84,13 @@ struct ipa_smp2p {
  */
 static void ipa_smp2p_notify(struct ipa_smp2p *smp2p)
 {
-	struct device *dev;
 	u32 value;
 	u32 mask;
 
 	if (smp2p->notified)
 		return;
 
-	dev = &smp2p->ipa->pdev->dev;
-	smp2p->power_on = pm_runtime_get_if_active(dev, true) > 0;
+	smp2p->power_on = pm_runtime_get_if_active(smp2p->ipa->dev, true) > 0;
 
 	/* Signal whether the IPA power is enabled */
 	mask = BIT(smp2p->enabled_bit);
@@ -152,15 +150,16 @@ static void ipa_smp2p_panic_notifier_unregister(struct ipa_smp2p *smp2p)
 static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 {
 	struct ipa_smp2p *smp2p = dev_id;
+	struct ipa *ipa = smp2p->ipa;
 	struct device *dev;
 	int ret;
 
 	/* Ignore any (spurious) interrupts received after the first */
-	if (smp2p->ipa->setup_complete)
+	if (ipa->setup_complete)
 		return IRQ_HANDLED;
 
 	/* Power needs to be active for setup */
-	dev = &smp2p->ipa->pdev->dev;
+	dev = ipa->dev;
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "error %d getting power for setup\n", ret);
@@ -168,7 +167,7 @@ static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 	}
 
 	/* An error here won't cause driver shutdown, so warn if one occurs */
-	ret = ipa_setup(smp2p->ipa);
+	ret = ipa_setup(ipa);
 	WARN(ret != 0, "error %d from ipa_setup()\n", ret);
 
 out_power_put:
@@ -209,7 +208,7 @@ static void ipa_smp2p_irq_exit(struct ipa_smp2p *smp2p, u32 irq)
 /* Drop the power reference if it was taken in ipa_smp2p_notify() */
 static void ipa_smp2p_power_release(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	if (!ipa->smp2p->power_on)
 		return;
diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 7b637bb8b41c8..a24ac11b8893d 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -163,7 +163,7 @@ ipa_table_mem(struct ipa *ipa, bool filter, bool hashed, bool ipv6)
 
 bool ipa_filtered_valid(struct ipa *ipa, u64 filtered)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	u32 count;
 
 	if (!filtered) {
@@ -236,8 +236,7 @@ ipa_filter_reset_table(struct ipa *ipa, bool hashed, bool ipv6, bool modem)
 
 	trans = ipa_cmd_trans_alloc(ipa, hweight64(ep_mask));
 	if (!trans) {
-		dev_err(&ipa->pdev->dev,
-			"no transaction for %s filter reset\n",
+		dev_err(ipa->dev, "no transaction for %s filter reset\n",
 			modem ? "modem" : "AP");
 		return -EBUSY;
 	}
@@ -298,8 +297,7 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 
 	trans = ipa_cmd_trans_alloc(ipa, hash_support ? 4 : 2);
 	if (!trans) {
-		dev_err(&ipa->pdev->dev,
-			"no transaction for %s route reset\n",
+		dev_err(ipa->dev, "no transaction for %s route reset\n",
 			modem ? "modem" : "AP");
 		return -EBUSY;
 	}
@@ -327,7 +325,7 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 
 void ipa_table_reset(struct ipa *ipa, bool modem)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	const char *ee_name;
 	int ret;
 
@@ -356,7 +354,7 @@ int ipa_table_hash_flush(struct ipa *ipa)
 
 	trans = ipa_cmd_trans_alloc(ipa, 1);
 	if (!trans) {
-		dev_err(&ipa->pdev->dev, "no transaction for hash flush\n");
+		dev_err(ipa->dev, "no transaction for hash flush\n");
 		return -EBUSY;
 	}
 
@@ -469,7 +467,7 @@ int ipa_table_setup(struct ipa *ipa)
 	 */
 	trans = ipa_cmd_trans_alloc(ipa, 8);
 	if (!trans) {
-		dev_err(&ipa->pdev->dev, "no transaction for table setup\n");
+		dev_err(ipa->dev, "no transaction for table setup\n");
 		return -EBUSY;
 	}
 
@@ -713,7 +711,7 @@ bool ipa_table_mem_valid(struct ipa *ipa, bool filter)
  */
 int ipa_table_init(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	dma_addr_t addr;
 	__le64 le_addr;
 	__le64 *virt;
@@ -763,7 +761,7 @@ int ipa_table_init(struct ipa *ipa)
 void ipa_table_exit(struct ipa *ipa)
 {
 	u32 count = max_t(u32, 1 + ipa->filter_count, ipa->route_count);
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 	size_t size;
 
 	size = IPA_ZERO_RULE_SIZE + (1 + count) * sizeof(__le64);
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 7eaa0b4ebed92..bfd5dc6dab432 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -127,7 +127,7 @@ static struct ipa_uc_mem_area *ipa_uc_shared(struct ipa *ipa)
 static void ipa_uc_event_handler(struct ipa *ipa)
 {
 	struct ipa_uc_mem_area *shared = ipa_uc_shared(ipa);
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	if (shared->event == IPA_UC_EVENT_ERROR)
 		dev_err(dev, "microcontroller error event\n");
@@ -141,7 +141,7 @@ static void ipa_uc_event_handler(struct ipa *ipa)
 static void ipa_uc_response_hdlr(struct ipa *ipa)
 {
 	struct ipa_uc_mem_area *shared = ipa_uc_shared(ipa);
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	/* An INIT_COMPLETED response message is sent to the AP by the
 	 * microcontroller when it is operational.  Other than this, the AP
@@ -191,7 +191,7 @@ void ipa_uc_config(struct ipa *ipa)
 /* Inverse of ipa_uc_config() */
 void ipa_uc_deconfig(struct ipa *ipa)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = ipa->dev;
 
 	ipa_interrupt_disable(ipa, IPA_IRQ_UC_1);
 	ipa_interrupt_disable(ipa, IPA_IRQ_UC_0);
@@ -208,8 +208,8 @@ void ipa_uc_deconfig(struct ipa *ipa)
 /* Take a proxy power reference for the microcontroller */
 void ipa_uc_power(struct ipa *ipa)
 {
+	struct device *dev = ipa->dev;
 	static bool already;
-	struct device *dev;
 	int ret;
 
 	if (already)
@@ -217,7 +217,6 @@ void ipa_uc_power(struct ipa *ipa)
 	already = true;		/* Only do this on first boot */
 
 	/* This power reference dropped in ipa_uc_response_hdlr() above */
-	dev = &ipa->pdev->dev;
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(dev);
-- 
2.40.1


