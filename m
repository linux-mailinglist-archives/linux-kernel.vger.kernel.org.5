Return-Path: <linux-kernel+bounces-10027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D181CEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547921C22B53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBF2E651;
	Fri, 22 Dec 2023 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdjLErtO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D082E643;
	Fri, 22 Dec 2023 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so2371306b3a.1;
        Fri, 22 Dec 2023 11:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703274054; x=1703878854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgevCgufJPPvCi62nf9pb7fjA62h0EtwHE1dYgT7BS8=;
        b=BdjLErtOmDmCivljMOBye0n+5s3JL0u0zgvngLRkH2+6QbqZI7uJmZTbAgA5s7Vqrq
         btMfkrxvYtH02RkbnoFvD6M9dwNsV/Vxc7JefLclOmFaqTVMpXKdZ6BKGuggBMpxQhvv
         x9GqxW+XIcbPYGAUN6xrSQFMWzTfknW5zRL4LSIohxLWYkaw64uZ1L0+ijvn9npcPvQv
         k0jnEj/v5g6rk1g1T0Bw8DmpoV9gAScmRDqRwwZ6r5IEG+PFMsCnFIuElq4B0N1CGrfb
         ZYyXzRiuosD0HqhSLCfHKzM1ZDltSptglxdNgnbrcV/FqrqKmoFYGyVhJGrcNiGlAiXq
         +VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703274054; x=1703878854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgevCgufJPPvCi62nf9pb7fjA62h0EtwHE1dYgT7BS8=;
        b=VlkP6oTy/NobRmSSyi16y1fEeBI5J+wajVV0OJRNZ7I6N0YiPQ4aWvpKXF2hDRDAla
         NL315K4GwzqRiE52huPC6QrRen/M9DPlEgfGJkxRlbZEVpj9bgHOvPc2POOZ2pn1woG9
         CK8C0BPKtO4j6h+XfyT0b4mj8LPrAdB0VBNkpDe3sINE1pV5RuecfxtG5uDnMDNfIS+s
         3H8WgWy9IbG56zs8E4BT3nGOUmAmkse51GJg1NyMAKwj7yf481RE9zKtQ4/ZsUx92typ
         lLtAXVevD0dxSiePbFVZBYA4pmZ7VFZlb6anysUY/agBhfy9Jvu5zFd96Va33fs5B4CY
         MZ1w==
X-Gm-Message-State: AOJu0Yw59/7FGro5I9jgkq+EHMWXV91qIha6QOKwVHnSzq8fN4vjX/pp
	cfqmGwaFtTts+lgqD7Da2DE0YMJlt+dHHg==
X-Google-Smtp-Source: AGHT+IEChco+TUdIxGydxRNJBv8sAOqipeg8/E4HlGZdHD5+cDoRWB0XW8k9CliFNZgR0E964Cc1mw==
X-Received: by 2002:a05:6a20:7287:b0:190:38cf:15b5 with SMTP id o7-20020a056a20728700b0019038cf15b5mr3663674pzk.20.1703274054099;
        Fri, 22 Dec 2023 11:40:54 -0800 (PST)
Received: from ubuntu.. ([202.166.220.102])
        by smtp.gmail.com with ESMTPSA id h24-20020a631218000000b005c6746620cfsm3630831pgl.51.2023.12.22.11.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 11:40:53 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: media: atomisp: pci: isp2400_input_system_public.h
Date: Fri, 22 Dec 2023 19:40:35 +0000
Message-Id: <20231222194036.1984-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script checkpatch.pl reported repeadted
word 'of' in isp2400_input_system_public.h
as below:

'''
WARNING: Possible repeated word: 'of'
/*! Read from a control register PORT[port_ID] of of RECEIVER[ID]
'''

This patch removes one 'of'.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/isp2400_input_system_public.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h b/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h
index 447c7c5c55a1..523c948923f3 100644
--- a/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h
+++ b/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h
@@ -163,7 +163,7 @@ STORAGE_CLASS_INPUT_SYSTEM_H void receiver_port_reg_store(
     const hrt_address			reg,
     const hrt_data				value);
 
-/*! Read from a control register PORT[port_ID] of of RECEIVER[ID]
+/*! Read from a control register PORT[port_ID] of RECEIVER[ID]
 
  \param	ID[in]				RECEIVER identifier
  \param	port_ID[in]			mipi PORT identifier
-- 
2.34.1


