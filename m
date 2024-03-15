Return-Path: <linux-kernel+bounces-104773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F887D36D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CFF1F219DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7D4E1B5;
	Fri, 15 Mar 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EBmaaAzM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84954F1EE;
	Fri, 15 Mar 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526330; cv=none; b=fNKTJOnYXYRI++Z6GQiRkAjphEq2AfTl0RRX6YHdFCwBX11rZrWx2bvoA08BEy/P5/fVNK5i45tWNiZtTc44ao2Ftw3JS7J/SDqH94e5Dt44owbeYx0/F7X+f7WIhwe9rHQfm59cSuLYRKKw6FFhr0i+8M8C2Jl8XM8w08Kxu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526330; c=relaxed/simple;
	bh=0e2hTLzqSzWSLW52Z9nltO5UKSGGXIc9zzq/LGh+H/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t5z4DoCKaREiwBiNfKRZExF+UOgMLZ3VsXMVwdJ1Oemec/ilaz7vtV8JpMJlijXCYB+U0rDbRzB0NZ/JmtLZb2k7L56huypNd7ek0We53/uqKsp9KRHPsaKsMcVUF7iB4Npw7jqxXtmktPNW+NDAo5X1M78Td+N2rAu78tkut4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EBmaaAzM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a461c50deccso303813866b.0;
        Fri, 15 Mar 2024 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710526327; x=1711131127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YocCyKVkREiO6SEkYbFtG3eZAFhKtO/ltd371FGqMMc=;
        b=EBmaaAzM22HZ3h2mUD7iqSm4N8VstY6fVnb7SUS0/RxyHjDcOVP5cmmFsVThhR99vk
         h2hjdAG+8lT4L6uQ9/pOJ4rNiV4+XZDsu/sYunMAwLCvYR3uAFh9zkvxsO7TS8qmFG4h
         WvtOjHaPhPX1l0Dxgay1mfN6KyfiHcZUd2fXvimt6NjUqvkKVqeuGN7MZ/F1WM87YkKB
         aeI19H36OZQWGhgya/tEUtMy1rGDcNpE+BcAINJxvleqcHiYBFvaCcdTL6gGbVNRR/g9
         OBDH+ugGayNlKLcjJUn8IpT6/im03vEer3Nm+Zl/og3POdJGdc8PWydAKT6AQbv018XA
         0xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526327; x=1711131127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YocCyKVkREiO6SEkYbFtG3eZAFhKtO/ltd371FGqMMc=;
        b=AD4yk6dgJqEak/UNxu4OR1NoUfGtwAGqEwAEQKhmqdBCibKIKkDOB9IzddUVlzy9wH
         NP/Q0WNJ1hGIEAYMH2TmpLoQ9WrxRFY78hx1EPwJrabftJfqEVu/yvhzcKkG784dfTRV
         xfZ+ziky7GC+tv/ht91zAkDTNUmSJdmO8KVp3AbwOahKrUy3UP5fYcqxIClIL8sZ8jmY
         GcrkKLx2iuEXeCKY9dEq1Hk5INY/VzrSTSEdRW4g+DhTCG70Hj5cayHHU8Zt67msd7Zw
         QMwsVkortsCWnLivIZCRhNPxW+I2/Gb1HXF6XnnLINtxjvKZZqgKUmK8GQz9ghOySVZ9
         WMeg==
X-Forwarded-Encrypted: i=1; AJvYcCVs2LHYBnYECo5+RRxaYamrWUGetFoY9nmjCHBL8qaOZcFkvyp6F8BJKvN7NVvhS7nAJGn7NYViKwuv2UWwzwyDUD+blwa5GPy/ZYYJ
X-Gm-Message-State: AOJu0YztGvrEdOdwsG/EwrF4VQhJh3X4DF6iRSDltTHCoV2ai8oTyaxw
	eNlTxG33IGE/PbmMbcz8jge6DlYDNOk4z9fDWMUdUdIoH0cHYsZcbWESSlCgpqBU5Q==
X-Google-Smtp-Source: AGHT+IHkiHOlyaF2CCvrzBL2FiDyb0mSCQv703B1AwmSl6Oa+P7muTJf0VbnAXzaGUoH3C80G0YqOg==
X-Received: by 2002:a17:906:c30f:b0:a46:2a85:b37b with SMTP id s15-20020a170906c30f00b00a462a85b37bmr3441990ejz.51.1710526327041;
        Fri, 15 Mar 2024 11:12:07 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id jy5-20020a170907762500b00a4675490095sm1650064ejc.42.2024.03.15.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:12:06 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selinux: optimize ebitmap_and()
Date: Fri, 15 Mar 2024 19:11:55 +0100
Message-ID: <20240315181204.647182-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Iterate on nodes instead of single bits to save node resolution for each
single bit.

Similar to userspace patch efcd00814879 ("libsepol: optimize
ebitmap_and").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  apply format style
v2:
  fix array size computation
---
 security/selinux/ss/ebitmap.c | 50 +++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 67c1a73cd5ee..47cb90106118 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -78,19 +78,53 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 		const struct ebitmap *e2)
 {
-	struct ebitmap_node *n;
-	int bit, rc;
+	const struct ebitmap_node *n1, *n2;
+	struct ebitmap_node *new = NULL, **prev;
 
 	ebitmap_init(dst);
 
-	ebitmap_for_each_positive_bit(e1, n, bit)
-	{
-		if (ebitmap_get_bit(e2, bit)) {
-			rc = ebitmap_set_bit(dst, bit, 1);
-			if (rc < 0)
-				return rc;
+	prev = &dst->node;
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 && n2) {
+		if (n1->startbit == n2->startbit) {
+			unsigned long testmap[EBITMAP_UNIT_NUMS];
+			unsigned int i;
+			bool match = false;
+
+			for (i = 0; i < ARRAY_SIZE(testmap); i++) {
+				testmap[i] = n1->maps[i] & n2->maps[i];
+				if (testmap[i] != 0)
+					match = true;
+			}
+
+			if (match) {
+				new = kmem_cache_zalloc(ebitmap_node_cachep,
+							GFP_ATOMIC);
+				if (!new) {
+					ebitmap_destroy(dst);
+					return -ENOMEM;
+				}
+				new->startbit = n1->startbit;
+				memcpy(new->maps, testmap, EBITMAP_SIZE / 8);
+				new->next = NULL;
+
+				*prev = new;
+				prev = &(new->next);
+			}
+
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (n1->startbit > n2->startbit) {
+			n2 = n2->next;
+		} else {
+			n1 = n1->next;
 		}
 	}
+
+	if (new)
+		dst->highbit = new->startbit + EBITMAP_SIZE;
+
 	return 0;
 }
 
-- 
2.43.0


