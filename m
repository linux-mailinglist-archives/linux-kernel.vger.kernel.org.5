Return-Path: <linux-kernel+bounces-86061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81986BF16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AB01C214F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE73A8CC;
	Thu, 29 Feb 2024 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ZFtBw2Oc"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE5381AF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174620; cv=none; b=X/GpC42swrzvEvkEadyobRCO3z2JL2+ukD5Rlw1lgUN8Qdk1NbmSX8HERlSPS+vupdXs4MavlZNQThVMvRGezK+APSCGJpdLd5IxtrGgzUqgH2NMcWW7Czfzm2lNtDZ/1pyEbibI7RHL+CTgk00ajJp5usc4PzULudpRhOBpCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174620; c=relaxed/simple;
	bh=cMCQopxYgTxYu/0amwMiu8cgPaQ+iKgRIdpZaTrEX2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIu6XUj6VMBLkJHZXc8hUorTWrPY+EZfSUloq62j9K4K5R6AkUd0oX+w0W8AypIYJTv0WlbDWzg1rHRoHFkNJ9GU7/sKYVhTzfh+PKUIIjmpq9ZrpGzsiaqOfc/F4eZecmZyEiywzH7skfl0JJRXh0y4jF28zngOmIBDJde4HfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=ZFtBw2Oc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e581ba25e1so329204b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174618; x=1709779418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SNh7/XczwlcyfoaJTDElDItVS6jS2b6ony9kQsRUro=;
        b=ZFtBw2OcxI6t2KAhSTYju0slhpgFpu3oFL+EI++I3qJfV2+fU2lXini8uLgSGp6fce
         /EZeTI9q8uhFyc9p9G1gVhWQc9vP2tgLrWG4itsuvC0TOrJ+seYlJwz5FncafcIuM5zm
         cbs2X9qAOo/kCCbVotdzXKRNntyhrnkVPeLvPyO67OR5Ta38u2esI6dOwvrXMPdoNGvr
         kYIkDXdZIiTJH/Fy0k1K7R8IVvuH1NGDfnhy70w1t6WA3eERlrYu8Ye795ZyjfvXDA+0
         dNQ+Zoe1ikQ06i4axlkep6EpjBMwiZdAkJVMGteSPnDMx6s0lpBIMXshA8VUCXByr0Ib
         xAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174618; x=1709779418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SNh7/XczwlcyfoaJTDElDItVS6jS2b6ony9kQsRUro=;
        b=RSBcDX6YYt60hUXOE55eP9f00JMow8t8anZ25x0je9jftQgfDNww9fKn+rUVUfPUHv
         2STzRQWc3XvVzTEzWyP7FJYAMMTabTgURqzQrkI0hyVcJpwiI8hnqSoBtvkab0/fOFHw
         y3FjsW8vTuLwkOwsgLN5NO0SZ3NZ4hHKd9Be1enaLbfpQy/TlwqDp2GrKGcVmb3WPJ7r
         vaQgrhHsJL4s+v6FF3alGa4HjmeYykYy7VWO1mAphJdSfojw07sTCjzdrYFOvmLb0p6i
         5q2l57bpMRydcDGlfw17XOl0C0ZT2BJWbOTXrIQB5QtiFcjTXQnwYH0WJ8+Y8ldwdtmF
         lpPg==
X-Forwarded-Encrypted: i=1; AJvYcCVu2E2cuKOyVMsWClpkxTFVQaQapmkOl4ksBwfVBzGVBR7hbnmloz+zQbXUWdwbdHQmfQkDicJ3Br+urU2EetOqoYlMZKV/VZ9Gqabv
X-Gm-Message-State: AOJu0YwFVdIQGnuRYH/XwZ1YI/MOZRIfG/1gxwx+sE9hDi3WpX6RFRfL
	j3NfhT8mqIby8pcWp4TV62UV/4Ya+8/9s8P2sZJImVUYsImq6BJ4ZlzEdJCg7Zc=
X-Google-Smtp-Source: AGHT+IFsh139gp84sHUup4ne0/pwHtdEtWANtNZz0UyWr8AIPlsZpo8fAZ63XIJ14ye3oYU8wy91LA==
X-Received: by 2002:a05:6a00:22d0:b0:6e5:9688:8025 with SMTP id f16-20020a056a0022d000b006e596888025mr115514pfj.6.1709174617867;
        Wed, 28 Feb 2024 18:43:37 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:37 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 6/8] Staging: rtl8192e: Rename goto OnADDBARsp_Reject
Date: Wed, 28 Feb 2024 18:43:23 -0800
Message-Id: <20240229024325.453374-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename goto OnADDBARsp_Reject -> on_add_ba_rsp_reject
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a3a2fe72d644..0581ed1e9ed1 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -334,14 +334,14 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			    ieee->ht_info->current_ht_support,
 			    ieee->ht_info->current_ampdu_enable);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	}
 
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	}
 
 	ts->add_ba_req_in_progress = false;
@@ -358,7 +358,7 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			    "%s(): ADDBA Rsp. BA invalid, DELBA!\n",
 			    __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	} else {
 		netdev_dbg(ieee->dev,
 			   "%s(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n",
@@ -371,7 +371,7 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 			ts->add_ba_req_delayed = true;
 			deactivate_ba_entry(ieee, admitted_ba);
 			reason_code = DELBA_REASON_END_BA;
-			goto OnADDBARsp_Reject;
+			goto on_add_ba_rsp_reject;
 		}
 
 		admitted_ba->dialog_token = *dialog_token;
@@ -384,12 +384,12 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ts->add_ba_req_delayed = true;
 		ts->disable_add_ba = true;
 		reason_code = DELBA_REASON_END_BA;
-		goto OnADDBARsp_Reject;
+		goto on_add_ba_rsp_reject;
 	}
 
 	return 0;
 
-OnADDBARsp_Reject:
+on_add_ba_rsp_reject:
 	{
 		struct ba_record BA;
 
-- 
2.39.2


