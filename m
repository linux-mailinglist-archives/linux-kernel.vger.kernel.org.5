Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6930C7F9FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjK0MqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjK0MqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:46:01 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A3D5D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:02 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a12079162so16282776d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089162; x=1701693962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szORryW2l9J0pCg1kQG3OS6E1waFAt6BYGHK4qsw87M=;
        b=VAGhosd+z4xCejRdQEfPTtAgYbU0nVPbLa8Nq4RJjBNaj79B97hgFMQkObjHlqGfcr
         Znpb7txSt7DOV0k+R+G0cGz1HtkIuUJFIxd8VwpJrWG9rJul8rprB19xwhcyyAP1SxAq
         aDnUoo7auy4+MM78SavGy4XVDMpSo0ExF5M5R7nPY5ooj6+MqhR2IKb/oMz2hqx3mATW
         sa7P5U1ZougXN6WWfVXrwNnITBEIg5TaQoEGr40P+jUtjmV8merK8RhOrZ34/zQMhKjw
         2KtYHfkU1rQR8KtaLmPNWZGqSkgNzXoYm8LBAPzPSZRXPE7G8P8S5opVdC9G9ozna4Ur
         K83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089162; x=1701693962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szORryW2l9J0pCg1kQG3OS6E1waFAt6BYGHK4qsw87M=;
        b=i8HegVR79/m6PwXRQFAGT5Ctk76ZFVIHL6QFjlIB/NyIQO8XgzWBzpFiSJuOkwf32X
         I0zhEBh5zCZcHzJlF0Hr5hqTKuLvxaTFqlaM9zaXTnskrMUdYF32t7Gmnz+Mo4ydxmzc
         zE/n8jvEtO9FWMiUJxJ/2us2nd4ZQY++cIi52C4fBJXv5xWzK14WpXOyII4YCHThEpvk
         YH3uEVT97iLYgIeaFH54zZJ1HxKCQM/MmZoR969zB6rkjQ91GkMiTsdy7MCm3/6GOQMa
         hvFMbC6m/ljpCT179M1Pttn5Toqd9lGoRrgZMV0bo6hgpEpn4SpaAomHgr0r4uUrE0Li
         N9/Q==
X-Gm-Message-State: AOJu0YzBPF2fOukjAQTOTvz4rjl3zCbkElgf/7lX9zHq/pxXr0Iku18w
        RPggvTJJ6Jmn643dYIeJg11S
X-Google-Smtp-Source: AGHT+IGNZ+5w8hg9MvVkI8DO0QPnjtjCxvmdxlHAK2q1lIEDQmZD7Ge/AJWS0HSg8+MEFEMaOLLfag==
X-Received: by 2002:a05:6214:5596:b0:67a:191f:2872 with SMTP id mi22-20020a056214559600b0067a191f2872mr12122455qvb.11.1701089162091;
        Mon, 27 Nov 2023 04:46:02 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/9] PCI: epf-mhi: Simulate async read/write using iATU
Date:   Mon, 27 Nov 2023 18:15:24 +0530
Message-Id: <20231127124529.78203-5-manivannan.sadhasivam@linaro.org>
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

Even though iATU only supports synchronous read/write, the MHI stack may
call async read/write callbacks without knowing the limitations of the
controller driver. So in order to maintain compatibility, let's simulate
async read/write operation with iATU by invoking the completion callback
after memcpy.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 34e7191f9508..7214f4da733b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -234,6 +234,9 @@ static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl,
 
 	mutex_unlock(&epf_mhi->lock);
 
+	if (buf_info->cb)
+		buf_info->cb(buf_info);
+
 	return 0;
 }
 
@@ -262,6 +265,9 @@ static int pci_epf_mhi_iatu_write(struct mhi_ep_cntrl *mhi_cntrl,
 
 	mutex_unlock(&epf_mhi->lock);
 
+	if (buf_info->cb)
+		buf_info->cb(buf_info);
+
 	return 0;
 }
 
-- 
2.25.1

