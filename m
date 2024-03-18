Return-Path: <linux-kernel+bounces-106579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1387F092
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1BE28198A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DAA57872;
	Mon, 18 Mar 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCCzlCrM"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97C57866
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791420; cv=none; b=udQ+TlkvX3rnNl+9r1Ez20iPWR/nD0swYwHsPzwwZ5Ex7n8yZq3vLZTmujBQv2/FueKeJz69b7sCfsL6O/PVGs2q71t1eNTIaLPHEBTrMZvTRY16/E0FQbhU0TsaV8ZFYuYLyWExIT8JXLO7hTdOR3h4/0G+aAIe0bMVPmx8Qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791420; c=relaxed/simple;
	bh=KZ3rIV5HMKqyM/bNYA6ICEqFK4FA1/+/ftfgAoqZXqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUfinkxQf5EjAI+Ec6f9cFurgNOJOLMb+XcDVDoHRye2UI8vKfasRalgkW6SDfjWyC30oXgbu7/No4PmG7XAiIQan0NRKHj5Jt+pirBwzVJLQ+BL2TpFjK9vLURL71/5GHWnSLD4VM6Ss5W+ZEUzSvs6JidsGR7TaLO4XzBUUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kCCzlCrM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0000cdf99so16719605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710791418; x=1711396218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC1qwydc9xH+y2vdl2+XzzOC/d+jLN+PsRUWImtjlRY=;
        b=kCCzlCrMkngQZmLTnbmxT1k3erbm3ZoRwY7dgZGHhF/thIF12hyhj0jZgGLf5Pi174
         p2yUFodtX9LTr1u4cDNolJk2H/PkLXBh7/ULIRWBgJu/5EYn8NemJT00NJR8kT7Idd+C
         LU4jLJcVeIo125iPz1Kj7BrD/9hzuejZslDlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791418; x=1711396218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC1qwydc9xH+y2vdl2+XzzOC/d+jLN+PsRUWImtjlRY=;
        b=f+Y81TB2IW5/VzMXZEfmoJncIvkwU6F3zVGKuS4QBWRxxdt6r+FLzx6Tt63R4hmMG3
         Gn+ScXjgFkx3BSfIxe0mIED9ZiQ08IYxLdMNhnWhhtOI1hLylX1vD7ztdWEpXpReAHKf
         DO+qABeODjMswLlRXgW3+ja0/ZsJj5hiUbPPLrFRojTVSGpeyJTAAFT3b1i/nDwNVp6v
         uoHNSA68KlVR2Kh4boIDdIwOj9Pvlbw5AldqomzH4x8xrGc5Go+czALBLrpmykQ0ZgIR
         br6vwwnsrw1El9DA0DSSexk0Fo43DgNeRAy56kNgVRUmlfNU8mivbREozYMHlI5U/8Rg
         mr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+dIJEWbkU3+G65zWl5t0f+a6pvGE97o+7phwnzpRRSTGTGbpcNhPLs9zNaoa/QEz9VaehhiD7Eer9Pfd3/3vGOMZXTaVWkGNnCRa9
X-Gm-Message-State: AOJu0YxehoWyLRwvtX27FAsEu7zJT0cpHQqBj9pCBe/CjI9uHU7/CFfS
	6mh3x/bdtpWYIOXVQCYTks6STr7tH5VoooBcyR0mfxkQ1jSigCIpwPf6+RD58g==
X-Google-Smtp-Source: AGHT+IG8+lPsfxHZ+zVWOGguTuaZgsiUp2vtqHikGI8aqsjtFgNyHq71mM9ZLiwKKhCawCorAmOYww==
X-Received: by 2002:a17:902:e5c2:b0:1de:e026:1b8e with SMTP id u2-20020a170902e5c200b001dee0261b8emr16615202plf.41.1710791418685;
        Mon, 18 Mar 2024 12:50:18 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2a3:200:5620:6f64:dfac:61dc])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b001defa98b03fsm6476916plk.101.2024.03.18.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:50:18 -0700 (PDT)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH 2/2] iscsi_tcp: disallow binding the same connection twice
Date: Mon, 18 Mar 2024 12:49:02 -0700
Message-ID: <20240318194902.3290795-2-khazhy@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240318194902.3290795-1-khazhy@google.com>
References: <20240318194902.3290795-1-khazhy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iscsi_sw_tcp_conn_bind does not check or cleanup previously bound
sockets, nor should we allow binding the same connection twice.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/scsi/iscsi_tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index e8ed60b777c6..8cf5dc203a82 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -716,6 +716,9 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 	struct socket *sock;
 	int err;
 
+	if (tcp_sw_conn->sock)
+		return -EINVAL;
+
 	/* lookup for existing socket */
 	sock = sockfd_lookup((int)transport_eph, &err);
 	if (!sock) {
-- 
2.44.0.291.gc1ea87d7ee-goog


