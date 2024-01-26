Return-Path: <linux-kernel+bounces-40777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7D83E587
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479862823D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96325EE82;
	Fri, 26 Jan 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="IL2Xz/FQ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFA5BACE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308314; cv=none; b=ubCXLEZlCJNkO9sZ1wK8ouCF83z6opK9b8/lctQZCBUaPLoAf6fZDHhlLufcY8W9EoTAoNqmPpZlGN/AXpDPUFtCJ+GHvMJIA+sMQ8nzdbsP8tRZ3ghYSnCSN/0Q8zVw0gINwLfBHEZwWPz+Kr5BoG3SlWyi3n4yGxflOCSHigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308314; c=relaxed/simple;
	bh=oDyTQMAlYFK13GRbBx5p2vaeE+EpzyLeiAyEXuNjTCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGcVpW9UzOlxs01ZHCx3H4xdvxjYoXhHGHlQzNQlOPtcH4WuPvCpmpN7BpihAOGGel6kmxRndMzLWVVAQq61uSp07MIoohUxG9V9j5gnGSCXogJh5liVzuxZafD85+e98y0Ok0ew9eRq9BMS3xOv9kBawMuCil1Yt7l4vnDDjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=IL2Xz/FQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso589764a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308312; x=1706913112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdyNE96vOnHl+1TTP1qK9C3aETsrFzB3trLDWoyyaoE=;
        b=IL2Xz/FQ2Xwmb9cOlZ3/+EKGDGC0jwbabM++9oMZ7xSZKafUmGQqL/BegUgI6LlU3T
         /RYMa/BhYOYrjfJdVjoHmXtlO4yBTlZKHKTPzCxX5e6LF0U1eWNMMIyOqZQyTovKTc2u
         9n2lX2TbZsfcV64uwlH1Wkbibh0KxOvGsKq6mZPoGR078hjXKyh1cxawDG3cCnT8EN/u
         0q08txEsdf4iBAd8vzuKC4TNVXMiAPJgfN5ADo4zLeN3SjAdlSThztUP69cn3+c610jP
         tsF4P59CkhpguD2fDBQarqB//Uhx0DvoB1iKgI1kMuBXYd5/3dtCQ7w5FTNJy+n8Ahs1
         8Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308312; x=1706913112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdyNE96vOnHl+1TTP1qK9C3aETsrFzB3trLDWoyyaoE=;
        b=l8gjR7DgZ7d2hco17kfJ87MkutIFcScxEfoUV3qpSmSR9zrujTx63gUD/RSg8OUNTv
         kmFOpqdegF6Cj0gkjxr1nBIn7kss3GXmgswyKlY0XGoBROSbDvKBwcnxIkOhfBPz3g8T
         /DsCAXmRw7lm1tmORvCJlrNWOBa5okpWWmvd1o0RFoNeuIMqprrRdkhc5JMs0WGTsJ/5
         fj8aGvzqWpgeOdWhn8kMzyh97ZfpuaJISxKhR1ZHUHeJSk5xlW37kgDIlD/97eOA+m8j
         rW/ymlSzf96O0jvA49pZdg40CsgzrqfPUZfvQtLayfAlCHQQdkXbIPpBoxxOgptzXSQe
         bKvQ==
X-Gm-Message-State: AOJu0Yy7C1M+B0XKu18TwS8QSkUvogApiyMhiSm4svN1IO1M1S7eYZYA
	COFM1mjMu+A7uPL6lBAjRfI/DT7pPZ709Vs2tBfFnBWD6uoW2eb0Y4SI2urCNCw=
X-Google-Smtp-Source: AGHT+IH7tiCtgM3uxXYawFfDam1iA74z+Gol1a2InNE+j2+UrICJG1LaEiHkr4c5RtzkSqNZ3s10NQ==
X-Received: by 2002:a17:90b:180c:b0:290:393f:c8f1 with SMTP id lw12-20020a17090b180c00b00290393fc8f1mr539203pjb.66.1706308312089;
        Fri, 26 Jan 2024 14:31:52 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:51 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 18/18] Staging: rtl8192e: Rename variable bForcedBgMode
Date: Fri, 26 Jan 2024 14:31:06 -0800
Message-Id: <20240126223106.986093-19-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
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
v2: No changes.
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


