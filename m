Return-Path: <linux-kernel+bounces-72759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AAC85B863
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4582B285F23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC80362158;
	Tue, 20 Feb 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFDKxKR7"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D360EC5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423030; cv=none; b=EL8lcmVrESqKWL17A4+XEH6uw9+617ThU/veFIwe497vRJZYoFoVhiTkFBQOrNvv6hi7Mo1RIQE7i8cCbB6NG/LLqZToE1aN4flTEqo7yj7Znv5Bz98n3yvuLwRtyZYQu/7NCUOCNlK5nCeiBXVHr3ClXz6joDpokW+44ueQ7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423030; c=relaxed/simple;
	bh=5i6IUnS3HBED35I/Esul/eXWCBL7mQMHTbaMIBPY3/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XRed4CWGUWLLO0S7WNfT5X/Q18HtRIP+4uRO/jae7ET6dvovJQT5wA6+B0cC0dv8hrKNPhIpvHERkHeDjXZd0wi+PD4aUbsQwNphRqU87ENgwDH/atTtgMDV3EDgYFVvpparFjpke3wC6tB/K+rp3TCgtIucwtW33w7lrSDnFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rohitner.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFDKxKR7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rohitner.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so5074440276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708423027; x=1709027827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsP9YAs3ATUDlmKMnOUj5SyinmDzqfFQjHSuoj373s0=;
        b=EFDKxKR7D4dtUIB7j/QVOZychSCpZUP0V7KNJiVwvDdJwi/Hoxx0TVnJUQ+ECoU//n
         Z8mcScSdvHPqqFOSpibOh5l3v2iKE8Xesop9jIL77tM95Z2Rl9LfqQwXfSH2ySdagqYI
         EM581J0scyOA8wR7Mc0BX25P0SvqChLAzad5fzS7rE02aobncF6RfwF81Lzvj0Zkq4V2
         N+eZIRDyv3HVCmEjKXraVE1k9B01CfAscK9Sveli8AjeLTiNARH+WJicvBjA4Rbqdeod
         0d7yEFWe5YZBntyv0naRPIIGPw6up2LmJztkDdRISfBPhvSGErxWLennWPHHpPS8ootu
         SugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708423027; x=1709027827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsP9YAs3ATUDlmKMnOUj5SyinmDzqfFQjHSuoj373s0=;
        b=Yn63LryKnkRb0fxMftlVKvb0jmt8ikluGpLLbc4e1szSCHXlrYNxiOpAgsRpbieQlG
         JV0YxYq3aioSsEnCZ0QuUsPCrK7ZtLo/zqNxE0V1zKjkIl316PSTzVrHqqcDjxsSHEb8
         19oqi/zYVVG0+ALbjiEDKDO9PHdn0bfzKXSrwS7rZf+ILgbW1WZPg3nLLDgvRJsW+u2/
         TuYyaheYPj45ddVLk+A8hb5Agi6IZMz4Fcc4INPktq1aMF02q0Uhpte+SOUA5xSuHNKK
         hZ3OTMJuZz++V8v/RqDH3zSmmDSklx/ewgrjL+/C1Mh9cIpxf362OllFsjQvWmXxSFky
         QoDg==
X-Forwarded-Encrypted: i=1; AJvYcCWCjhcJk+cetaGFf4kqhaRgh6LOgM/OkcF7aVkGdmXBHFkrVpbLSUu5gAZLD+RYn2gSBCIfZpObXZ+ucQmJcQ8FY44mcF4In36RmLvF
X-Gm-Message-State: AOJu0YyOQSsfWY+9ZUwVzA2XdMEHilOKC//DEc2P//I6Tqg9zBHmp3o7
	gulEbxaIVkDjpno7cbhoOMpzR0ETkmNIOF8L6oq6WA1to6QwAtXEFTiNab3fU9G+jkqhMVzQ1dC
	/TIomBpIyGw==
X-Google-Smtp-Source: AGHT+IGWHnoKqIgrolTQgf5G9nztGiC237V0zeGlvpymEJ4Z2eYkitdQni1bkFaWyx8oCaZUqO6kFe8y2fm/cw==
X-Received: from rohitner.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:413])
 (user=rohitner job=sendgmr) by 2002:a05:6902:1547:b0:dc7:3189:4e75 with SMTP
 id r7-20020a056902154700b00dc731894e75mr552327ybu.3.1708423027641; Tue, 20
 Feb 2024 01:57:07 -0800 (PST)
Date: Tue, 20 Feb 2024 01:56:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220095637.2900067-1-rohitner@google.com>
Subject: [PATCH] scsi: ufs: core: Fix mcq mac configuration
From: Rohit Ner <rohitner@google.com>
To: Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>, "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rohit Ner <rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"

As per JEDEC Standard No. 223E Section 5.9.2,
the max # active commands value programmed by the host sw
in MCQConfig.MAC should be one less than the actual value.

Signed-off-by: Rohit Ner <rohitner@google.com>
---
 drivers/ufs/core/ufs-mcq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 0787456c2b89..c873fd823942 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -94,7 +94,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
 
 	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
 	val &= ~MCQ_CFG_MAC_MASK;
-	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
+	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds - 1);
 	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
 }
 EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
-- 
2.44.0.rc0.258.g7320e95886-goog


