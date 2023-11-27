Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B37F9FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjK0Mqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjK0MqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:46:17 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB52D4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:12 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-777745f1541so238561185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089171; x=1701693971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0WeQVv6xDz1fA7FB+siaDKsF7jHm7RdEkvM6+sXcAk=;
        b=lZ6cKU83Ln+yT/quD7SMkjuwFY3qBG0aTEJS0eDJLPc+z7f10ZTOE9BTw5yPQsMu4B
         KjA05E+EIQ82KNtEcJ36VDnA78Sz+Pel8lJ1fOAw2dqzaNyxD2Uwfmot7VKOl8WwAtVC
         vWol2mFYS1sLZKRoplGwX7i4y+wYwYshYesxG7U/3G8fh+5x7vd33LULhwf8G9yXYGXv
         cJBGctkrKlqBTw0i2lrLUeQ4/sLTHFND19X7Nv+BzbZpvQ7UsNSfS/lLZd63BYfDszcW
         MLQw4nTqae/FSEK5EarttPP5YNwtAbXJckpVIq/bVSAddd5zD2r87JsLLJk4PeJ7sQG6
         2XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089171; x=1701693971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0WeQVv6xDz1fA7FB+siaDKsF7jHm7RdEkvM6+sXcAk=;
        b=oGEkHWSq6QTomEV6/QL8dkTxRhx20SynMNm/1w909cuI99tYl6yyp9qyJ0EaWU0jDn
         YvWldwlEx/xPW9oidiVZ6XCivp+i0T6yz7/r17UdS9h8Jd/rW7dEKz7vSCQ+jKoMGbAM
         mRcZbZQhXvpw9hJw7St1DZ/UPCmU3CgQ36+pWxUGH2ceYjbVf4jKiavoqCptZ9eYA2uh
         GpNDIp/KasKqlIDiqjATOru+n/07iG17MlElcQaFg3iKNW6Xrqe8t8uH42FN+Krcm2hg
         OQEyNja/YlwnrHJ8+/0g9luiee5sGnQeaLtK+xN9d5+7IvJFpNGD9OG+jr4wq68P4d7/
         RixA==
X-Gm-Message-State: AOJu0Yz8+edPOmSGVPlS4fPWxpkxpocksmCkkDVzJTsAO5B0xgr5Bx6b
        qGaV3cSqCxCKqTvJVoRW/qrC
X-Google-Smtp-Source: AGHT+IERxAcM9ld/cVONnYwD9Qw8esi9QM+/QvFXWK+aoyDNWVgo9aOd0jymm0Z4uVeT5EbnhzFY6g==
X-Received: by 2002:a05:6214:469b:b0:67a:35f3:4408 with SMTP id or27-20020a056214469b00b0067a35f34408mr9911296qvb.31.1701089170905;
        Mon, 27 Nov 2023 04:46:10 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Date:   Mon, 27 Nov 2023 18:15:26 +0530
Message-Id: <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that both eDMA and iATU are prepared to support async transfer, let's
enable MHI async read/write by supplying the relevant callbacks.

In the absence of eDMA, iATU will be used for both sync and async
operations.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 3d09a37e5f7c..d3d6a1054036 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
 	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
+	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
+	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
 	if (info->flags & MHI_EPF_USE_DMA) {
 		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
 		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
-	} else {
-		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
-		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
+		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
+		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
 	}
 
 	/* Register the MHI EP controller */
-- 
2.25.1

