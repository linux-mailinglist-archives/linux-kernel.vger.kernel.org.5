Return-Path: <linux-kernel+bounces-72661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8D85B6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C090A28A4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21660244;
	Tue, 20 Feb 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vxtFVh8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE955F49E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420141; cv=none; b=Lvq9WD3X90ihkmpjWQA0XfxHsCDCWshDMUblTHu0W7rYFDXT29AYjzaFtfb8qFllMaZvOL60axst7QgpcHj4WiJSsiu4qyaZ5rSY1p1UHGrsZTTgTobaT3ElpKdP/4/wH0bNCPaiQAgDa62iMrlM43q/V2z6/bq0vQcr3/nisKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420141; c=relaxed/simple;
	bh=mjn6EXTmSJZ+lGndYlrFuihk9Yh0VIx3guEcNtjlNRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AtHEzxHNJpkuH+SDGXCSa7NOqQWsRYv0UsLDTvuf3x5+sleYGZAhpp4O5BNTmtoz8T6/nONbUPeDoM98f4W/Hgn+tN8gGJn/Z8maVuEQ6bUwtsuiHoYWY+bgnBPg2CSoXefTPWgWrFhh/0ushxWNfn2nqQZFX2Prjzr6QHp4HtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rohitner.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vxtFVh8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rohitner.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5efe82b835fso113336767b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708420139; x=1709024939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5TIghhj81XJMhc6wHnIWYfJQESzheU3Zzvlzz3ZRZI=;
        b=4vxtFVh8jPunlq+rWV7bLChCNXukLTnUydEE7dP0gV2nheoPUSexQGr40fAt2fqwUv
         HkVE5L4Nex9dh1YhLFgpJ4HB6gZcjA7TW8s5D+z+bFwRnW21+l7MjVld/fcnY3Vnf+M8
         IZAVe6ziJIYPfYLE3+mVBnvB2SHoKHXR+kZDt3phDKTz1SECxZq+GSdixTaI3BdBj/Og
         YlM2p+nt7iysA8aFpslTPj8oA3+VNDJksnck56ojBMSzppBE5Uc3N1IWHMggKPM94pZS
         XJNk3Q+NM4rHHMpU+h28TCJwsnDW2pebdd/5zMGz3BfEYA6cHJ/PH6WcaaNl03tv9c3L
         +SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420139; x=1709024939;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5TIghhj81XJMhc6wHnIWYfJQESzheU3Zzvlzz3ZRZI=;
        b=Y1YK3FCx9YpLZhK+sOSzxw5mESox4qj7z/3u0H/AbLFruWrOD+xGis2U6fQKZA6R3a
         KDH2bAx8CvoQKLtykP3W6PO131Lzmq1yDOSokdQCVe/PdZky5kRSq0fpWmfPYhmfY/JF
         yUrZ6Nvf+hujici98+tybwwvziu7u2H6j5Gtgm5nWrSRpoGuef/I3V2MB4Cq66mzAS0G
         hHXUqI0z6hNxUWM8nn0RXX6Oipqqvcq8oyb7Hmml6bhmi3wgfaYkZmdSjH4czczC7waa
         xgmfDP2StFBGcxtw3UTKPGsLi7O/YlH80xqXJkhW1BrzpKbl12rqNT2Pb1su4A2ZWXvh
         w/vw==
X-Forwarded-Encrypted: i=1; AJvYcCWrhn7aprzF156pl87SxG5iHhuNp5Ro/nYEakGKqYQv6Uy+kGKBOPUgjOKUlEXiBN2Wn8vRSGEVf5GfWgXGsi/Ul7Yj5Xkz26e/5zZ0
X-Gm-Message-State: AOJu0YwqITtWne6DpDABe1/Vc4v2ob6Eva9LFKSDuQts7GwLR6ymsZ+H
	XMB3U7VroPp4n0FvOjZjb0lsx7V08tpM+IGXJLZKX2YYBDBK+ZzIMG1v6Q7p9WgYerrBtK9YFB+
	DXkyLrZcKlg==
X-Google-Smtp-Source: AGHT+IG16iYdwxjPu/OP7dYqpZzB3tGlLp7EWwI4fD6O1OWTy+dVK7SW8+z/9+vVjUDhz5eQsyy1nZQ7Tt/vmQ==
X-Received: from rohitner.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:413])
 (user=rohitner job=sendgmr) by 2002:a05:6902:706:b0:dc6:fa35:b42 with SMTP id
 k6-20020a056902070600b00dc6fa350b42mr4323086ybt.2.1708420138874; Tue, 20 Feb
 2024 01:08:58 -0800 (PST)
Date: Tue, 20 Feb 2024 01:08:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220090805.2886914-1-rohitner@google.com>
Subject: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
From: Rohit Ner <rohitner@google.com>
To: Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>, 
	Stanley Chu <stanley.chu@mediatek.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rohit Ner <rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow variant callback to setup transfers without
restricting the transfers to use legacy doorbell

Signed-off-by: Rohit Ner <rohitner@google.com>
---
 drivers/ufs/core/ufshcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d77b25b79ae3..91e483dd3974 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2280,6 +2280,9 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 		ufshcd_clk_scaling_start_busy(hba);
 	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
 		ufshcd_start_monitor(hba, lrbp);
+	if (hba->vops && hba->vops->setup_xfer_req)
+		hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						!!lrbp->cmd);
 
 	if (is_mcq_enabled(hba)) {
 		int utrd_size = sizeof(struct utp_transfer_req_desc);
@@ -2293,9 +2296,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 		spin_unlock(&hwq->sq_lock);
 	} else {
 		spin_lock_irqsave(&hba->outstanding_lock, flags);
-		if (hba->vops && hba->vops->setup_xfer_req)
-			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
-						  !!lrbp->cmd);
 		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
 		ufshcd_writel(hba, 1 << lrbp->task_tag,
 			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
-- 
2.44.0.rc0.258.g7320e95886-goog


