Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18F67A4720
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjIRKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241329AbjIRKcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:32:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2612A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:32:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdf4752c3cso29743595ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1695033137; x=1695637937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PooVB8ngJw9Rniuqdt8EKuLfY8FdpeQsGGOl44BWDC8=;
        b=GdpC3KzHwKqtjrNnWMA7uiikLqW6hmrKHLrsQc4EFuGYr8oOmzzHv4NV3Yrg08V0Yq
         NH7IKZKL8Roe7mf8E1rs4+8HTGIyQI1gBJ21d4tjCXLsWwlQpwldI+nlIb//JDPpT+1l
         eYhIVGlRYaOIh3EGSLj6dHI+82+UfNwLnuwpqi3DjNiNc2atdBKZwSY9L22jcEGs0TDD
         hZ9l3+j8AzCjBPVlsp3tLzfCVYqTDwF5NA0OsyJdY38uMuEToV1h23K53tI7/SoxABOI
         6PWbHd4A1VmsfYrMY+XzPPzzebhCxwo9LdWNNHngznFesTM2C9y1TH48lJpe7haWAYu3
         psIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033137; x=1695637937;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PooVB8ngJw9Rniuqdt8EKuLfY8FdpeQsGGOl44BWDC8=;
        b=TYWOT9e7BYfg47EzuAPXH9HLA8AWGK0eTwaiFyFvSO5bC/7Vk6+Xno3JZqqDExjChT
         ghqDCOf5QzRrSkOv5q8GNKqLjKsHS0s+okbQgHljZ9d7/hfuuKZ2EYlMUBRi3Vbp/x9a
         twmIqEpz6xEnKOzIYRYoizX5A6n1lJE+xR4D27H85CxVVJXT6W7/2nv15vLqVmMj5PaG
         Bc9UKG7nc05x92+RxcM229hLCH1+nj6Tr556d+3Er9S8CNEL0odkdChoMmFY/dt3cik3
         gfPL1QN8QwOPjLc063WWvG4TKrM0SgqAZwM7TmLldy77+59WwVP/4SzZdE8tBO252IWT
         b72Q==
X-Gm-Message-State: AOJu0YxQZhIUztuNrJ6C4elyuojFwWcuy0UAoTOcM/c4tNy20Wc6Xwh5
        G1YZAol6QuQfwylEXFHHUZzfTA==
X-Google-Smtp-Source: AGHT+IHUylLTQw4v8LZYGC0dL3n6OFnm/Pfqcmd4ZC/boUXx2+f0ntP7ckucFvf25olsqw8pb5RyWQ==
X-Received: by 2002:a17:902:eaca:b0:1bd:f71c:3af3 with SMTP id p10-20020a170902eaca00b001bdf71c3af3mr6817839pld.32.1695033137210;
        Mon, 18 Sep 2023 03:32:17 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id js10-20020a17090b148a00b002744cd7e687sm1296170pjb.1.2023.09.18.03.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 03:32:16 -0700 (PDT)
Message-ID: <a4d1318b449b9d1483fcf51d37dfeb45de66a49d.camel@areca.com.tw>
Subject: [PATCH 1/3] scsi: arcmsr: support Areca ARC-1688 Raid controller
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Sep 2023 18:32:17 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch supports Areca new Raid controller ARC-1688

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h
b/drivers/scsi/arcmsr/arcmsr.h
index ed8d931..8c0db11 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -818,6 +818,23 @@ typedef struct deliver_completeQ {
 	uint16_t	cmdLMID;        // reserved (0)
 	uint16_t	cmdFlag2;       // reserved (0)
 } DeliverQ, CompletionQ, *pDeliver_Q, *pCompletion_Q;
+
+#define ARCMSR_XOR_SEG_SIZE	(1024 * 1024)
+struct HostRamBuf {
+	uint32_t	hrbSignature;	// must be "HRBS"
+	uint32_t	hrbSize;	// total buffer size(must be
multiples of MB)
+	uint32_t	hrbRes[2];	// reserved, must be set to 0
+};
+struct	Xor_sg {
+	dma_addr_t	xorPhys;
+	uint64_t	xorBufLen;
+};
+struct	XorHandle {
+	dma_addr_t	xorPhys;
+	uint64_t	xorBufLen;
+	void		*xorVirt;
+};
+
 /*
 **********************************************************************
*********
 **                 Adapter Control Block
@@ -929,6 +946,7 @@ struct AdapterControlBlock
 	char			firm_model[12];
 	char			firm_version[20];
 	char			device_map[20];			/*21,84
-99*/
+	uint32_t		firm_PicStatus;
 	struct work_struct 	arcmsr_do_message_isr_bh;
 	struct timer_list	eternal_timer;
 	unsigned short		fw_flag;
@@ -937,6 +955,7 @@ struct AdapterControlBlock
 #define	FW_DEADLOCK			0x0010
 	uint32_t		maxOutstanding;
 	int			vector_count;
+	int			xor_mega;
 	uint32_t		maxFreeCCB;
 	struct timer_list	refresh_timer;
 	uint32_t		doneq_index;
@@ -946,6 +965,10 @@ struct AdapterControlBlock
 	uint32_t		completionQ_entry;
 	pCompletion_Q		pCompletionQ;
 	uint32_t		completeQ_size;
+	void			*xorVirt;
+	dma_addr_t		xorPhys;
+	unsigned int		init2cfg_size;
+	unsigned int		xorVirtOffset;
 };/* HW_DEVICE_EXTENSION */
 /*
 **********************************************************************
*********
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c
b/drivers/scsi/arcmsr/arcmsr_hba.c
index a66221c..39d3b10 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -747,6 +747,51 @@ static bool arcmsr_alloc_io_queue(struct
AdapterControlBlock *acb)
 	return rtn;
 }
 
+static int arcmsr_alloc_xor_buffer(struct AdapterControlBlock *acb)
+{
+	int rc = 0;
+	struct pci_dev *pdev = acb->pdev;
+	void *dma_coherent;
+	dma_addr_t dma_coherent_handle;
+	int i, xor_ram;
+	struct Xor_sg *pXorPhys;
+	void **pXorVirt;
+	struct HostRamBuf *pRamBuf;
+
+	// allocate N times 1 MB physical continuous memory for XOR
engine of Raid 5, 6.
+	xor_ram = (acb->firm_PicStatus >> 24) & 0x0f;
+	acb->xor_mega = (xor_ram - 1) * 32 + 128 + 3;
+	acb->init2cfg_size = sizeof(struct HostRamBuf) + (sizeof(struct
XorHandle) * acb->xor_mega);
+	dma_coherent = dma_alloc_coherent(&pdev->dev, acb-
>init2cfg_size,
+		&dma_coherent_handle, GFP_KERNEL);
+	acb->xorVirt = dma_coherent;
+	acb->xorPhys = dma_coherent_handle;
+	pXorPhys = (struct Xor_sg *)((unsigned long)dma_coherent +
sizeof(struct HostRamBuf));
+	acb->xorVirtOffset = sizeof(struct HostRamBuf) + (sizeof(struct
Xor_sg) * acb->xor_mega);
+	pXorVirt = (void **)((unsigned long)dma_coherent + (unsigned
long)acb->xorVirtOffset);
+	for (i = 0; i < acb->xor_mega; i++) {
+		dma_coherent = dma_alloc_coherent(&pdev->dev,
ARCMSR_XOR_SEG_SIZE,
+			&dma_coherent_handle, GFP_KERNEL);
+		if (dma_coherent) {
+			pXorPhys->xorPhys = dma_coherent_handle;
+			pXorPhys->xorBufLen = ARCMSR_XOR_SEG_SIZE;
+			*pXorVirt = dma_coherent;
+			pXorPhys++;
+			pXorVirt++;
+		} else {
+			printk("arcmsr%d: alloc max XOR buffer = 0x%x
MB\n", acb->host->host_no, i);
+			rc = -ENOMEM;
+			break;
+		}
+	}
+	pRamBuf = (struct HostRamBuf *)acb->xorVirt;
+	pRamBuf->hrbSignature = 0x53425248;	//HRBS
+	pRamBuf->hrbSize = i * ARCMSR_XOR_SEG_SIZE;
+	pRamBuf->hrbRes[0] = 0;
+	pRamBuf->hrbRes[1] = 0;
+	return rc;
+}
+
 static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 {
 	struct pci_dev *pdev = acb->pdev;
@@ -837,6 +882,10 @@ static int arcmsr_alloc_ccb_pool(struct
AdapterControlBlock *acb)
 		acb->doneq_index = 0;
 		break;
 	}	
+	if ((acb->firm_PicStatus >> 24) & 0x0f) {
+		if (arcmsr_alloc_xor_buffer(acb))
+			return -ENOMEM;
+	}
 	return 0;
 }
 
@@ -2022,6 +2071,26 @@ static void arcmsr_stop_adapter_bgrb(struct
AdapterControlBlock *acb)
 
 static void arcmsr_free_ccb_pool(struct AdapterControlBlock *acb)
 {
+	if (acb->xor_mega) {
+		struct Xor_sg *pXorPhys;
+		void **pXorVirt;
+		int i;
+
+		pXorPhys = (struct Xor_sg *)(acb->xorVirt +
sizeof(struct HostRamBuf));
+		pXorVirt = (void **)((unsigned long)acb->xorVirt +
(unsigned long)acb->xorVirtOffset);
+		for (i = 0; i < acb->xor_mega; i++) {
+			if (pXorPhys->xorPhys) {
+				dma_free_coherent(&acb->pdev->dev,
ARCMSR_XOR_SEG_SIZE,
+					*pXorVirt, pXorPhys->xorPhys);
+				pXorPhys->xorPhys = (dma_addr_t)NULL;
+				*pXorVirt = NULL;
+			}
+			pXorPhys++;
+			pXorVirt++;
+		}
+		dma_free_coherent(&acb->pdev->dev, acb->init2cfg_size,
+			acb->xorVirt, acb->xorPhys);
+	}
 	dma_free_coherent(&acb->pdev->dev, acb->uncache_size, acb-
>dma_coherent, acb->dma_coherent_handle);
 }
 
@@ -3309,6 +3378,10 @@ static void arcmsr_get_adapter_config(struct
AdapterControlBlock *pACB, uint32_t
 	pACB->firm_sdram_size = readl(&rwbuffer[3]);
 	pACB->firm_hd_channels = readl(&rwbuffer[4]);
 	pACB->firm_cfg_version = readl(&rwbuffer[25]);
+	if (pACB->adapter_type == ACB_ADAPTER_TYPE_F)
+		pACB->firm_PicStatus = readl(&rwbuffer[30]);
+	else
+		pACB->firm_PicStatus = 0;
 	pr_notice("Areca RAID Controller%d: Model %s, F/W %s\n",
 		pACB->host->host_no,
 		pACB->firm_model,
@@ -4096,6 +4169,12 @@ static int arcmsr_iop_confirm(struct
AdapterControlBlock *acb)
 		acb->msgcode_rwbuffer[5] = lower_32_bits(acb-
>dma_coherent_handle2);
 		acb->msgcode_rwbuffer[6] = upper_32_bits(acb-
>dma_coherent_handle2);
 		acb->msgcode_rwbuffer[7] = acb->completeQ_size;
+		if (acb->xor_mega) {
+			acb->msgcode_rwbuffer[8] = 0x455AA;	//Linux
init 2
+			acb->msgcode_rwbuffer[9] = 0;
+			acb->msgcode_rwbuffer[10] = lower_32_bits(acb-
>xorPhys);
+			acb->msgcode_rwbuffer[11] = upper_32_bits(acb-
>xorPhys);
+		}
 		writel(ARCMSR_INBOUND_MESG0_SET_CONFIG, &reg-
>inbound_msgaddr0);
 		acb->out_doorbell ^=
ARCMSR_HBEMU_DRV2IOP_MESSAGE_CMD_DONE;
 		writel(acb->out_doorbell, &reg->iobound_doorbell);

