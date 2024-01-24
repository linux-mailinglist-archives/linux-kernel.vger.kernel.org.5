Return-Path: <linux-kernel+bounces-37783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCC83B4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB521C2354D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368D13DB98;
	Wed, 24 Jan 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="EQMsrt7x"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E913D503
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136314; cv=none; b=nTzEoe+blxqtMuaEy6N8TfRRLtx2SCXsjq+nopDM6UGLbTQt3csoluUNK/qarelLdENTgs9Ddy72r+BbwKc6tzCHxCo74+HWEcL/yzdxX8QstTUb7DMWO34OID3GRxvonk7DrrMM9SgcxqgKub516MK0wO+hEIS8FBUoboc7HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136314; c=relaxed/simple;
	bh=AscnLBC/gI9vMHyhNJgjD3txTicaELoHziKudejDUBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KKs2M30b7/mRDfU/J1vVPiZibwsTqy4PeZ6cwv+2+0RKhw65Yh0ZvAswt2YaR6S9Ec0dboZR1lLEkRB0lrNi7pOMJ9a5D/AvLZ4JMjmlyCPnSg7KrCfeLiZQFKXUx0QLvlAEFdtReNE/qnbVWXx5Rh3w6rYKqeXI9cMqy/rEdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=EQMsrt7x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d427518d52so1290835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136313; x=1706741113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdqPBUNZraqL43uan7u+LFep+ywrWr8czcYGFA+EC7o=;
        b=EQMsrt7xqBohIDtZCVlxBgrVA2w8XNmg4Phnjrq1IcXeNTRz0kA82zjZp6RYWV5gN+
         oXluSUJynTSssskijZFjQcUOeD1ZEGi8MLYGqGqnQN1oT6vP13RL3x+1jVN5UTvtrbrD
         3Gz+LyH02bunoN/bamAFBgPMR6HMj8OW4uv2Of/DNHcnUZDcqEjBfCSvCoyDEVNmRtmF
         Vzp+SoWEu83w/hhhn3qbNr70tejS+spq4+3Igv8BWBMCWXdpJwnyPiWgceyfDF0BAd+J
         bnXW9eGZrWOx/GWccdm5aB5zF3OMSMDIqkmLV+Ojjhxx+4uv0CLfxzEztlKNHGQOoXqR
         tJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136313; x=1706741113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdqPBUNZraqL43uan7u+LFep+ywrWr8czcYGFA+EC7o=;
        b=FyfOyyWQdgg29SKxtKGXdAoBoGtWRDnZ7X0CJ4s269x3PkZQcPUGPf3T8iOioeZisr
         khiHmHXaJpzUOLodJZVMsUvZeTnvMr5NKnFuqAGIHKwcHKl2HWCOg2R3yBuSpQMWvDEi
         P++tZdAkl21msaE7j5v3eN29tmufdS2p9WAgiFusGWnSuAb43o4DOokTb9/VIV7k55Q9
         oyg+C6iA/W89IofPA0G7yD/n5FGxRLrciTVA8iZ+hsoqyYLe5wBEiyrcLaAVi8EEvwhw
         cFx9jBsvmBP4hRVDg8H2pUdCcvgbxi1fvvLoByuS8NJWnmJ5heyy2eTm7aZ6UFpdMthI
         Khog==
X-Gm-Message-State: AOJu0Yz538svWmulXwNnPcwXXgbpqu4IDpMdzrJVa7Cp7J8N8iqXfXJe
	Z0W+qjiLULo/tjyGcF9nrzJsRdfgiPlqK2AAXe031ygyq3GvHez11qE6LSTZtrsO94Bh7RExZRU
	c
X-Google-Smtp-Source: AGHT+IEWAtVzCHwnAwLVcDAG+VKM2RHUDYDuxI/3BFfm0YN83ZD+clW9UYbGq0hNYqoOAoUwfpKI3w==
X-Received: by 2002:a17:903:594:b0:1d4:ceab:58b9 with SMTP id jv20-20020a170903059400b001d4ceab58b9mr66432plb.40.1706136312992;
        Wed, 24 Jan 2024 14:45:12 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:12 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/18] Staging: rtl8192e: Rename variable bForcedBgMode
Date: Wed, 24 Jan 2024 14:44:52 -0800
Message-Id: <20240124224452.968724-19-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bForcedBgMode to forced_bg_mode to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 07a89d1af86d..348644998744 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1193,7 +1193,7 @@ struct rtllib_device {
 	u8 *assocreq_ies, *assocresp_ies;
 	size_t assocreq_ies_len, assocresp_ies_len;
 
-	bool	bForcedBgMode;
+	bool	forced_bg_mode;
 
 	u8 hwsec_active;
 	bool is_roaming;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ba35714f83af..2545ac8963c4 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -721,7 +721,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if ((ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & SEC_ALG_TKIP)) ||
-	    ieee->bForcedBgMode) {
+	    ieee->forced_bg_mode) {
 		ieee->ht_info->enable_ht = 0;
 		ieee->mode = WIRELESS_MODE_G;
 	}
-- 
2.39.2


