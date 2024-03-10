Return-Path: <linux-kernel+bounces-98256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE3877782
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0651C20BC6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912538391;
	Sun, 10 Mar 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GFxCNZeo"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D229411
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710085663; cv=none; b=QESX7qT3KUSHtE7pX98fjcmqWneRa1ViGVMwkNCLxZch2z1vp3rsOMUU1rNPlCokDnZ9Fep7iqjwwsq7gvPoLzhTPmK3eIjMkr8kNSw/igsLZvDECWU4hIqD0yrUSA7HsMBArNiXPonOYXmqrO8D4E2FpPhdglD4OuRtGUX2YlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710085663; c=relaxed/simple;
	bh=Pujf88MSgeBgnVk3XoQ+u8p6dPOMYRawFtSeLnjfy6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDchaqfB/myLCOSpo4MGApLpYCjXaxyIi5HqgB/xqx11WJTk+uzN4ocmdjAaUbX7BlnZjMEbpPznoxFaB2UzuEUR+VWEOeC68gkGBCKhjyKPafDa6Xf/ioyCL25iETK1xEAH1yWarJDSXvbI9G0eWpwsmvHdIujH2RFuQ/hwpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GFxCNZeo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06F90410A7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710085653;
	bh=3x1QmuNCSkhKmOkbx/k9p+MANy4otdnhu0jXgm0Ki0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=GFxCNZeoYZlNK8OgdrKcwVlpzx2yP7Bg1AP4MEe3Sc8oghZpzjkUIeFCf9oLYwrOc
	 k4nqr8so8JleJc6nyAN5ZURa/jH/nsXva3iRPuaf8WoVZcmKmYjwRPsdFKqNpXVpRB
	 dEW3tEDe/IQPmwP6b7O90uX26AFwPNY94OaJQ/2Rim/LyL7T5N4uaDNcPadtiZV7Dd
	 0z1FqmW+OgCPXYBT7FABDBJC4IBZjYXgDA4pYrznG35VE6tW2nMNi0dqGP+A8LUM8z
	 0x+g5S6yACmfpd8O1jDiWDUDwODbC00f0DdsWZThwHJIkd/bK/1UZ7n1fF7UUMXIOY
	 rYncINFlgL5vQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a450265c7b6so216407666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 08:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710085652; x=1710690452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x1QmuNCSkhKmOkbx/k9p+MANy4otdnhu0jXgm0Ki0g=;
        b=OlS5UT4WktubinWLgBSUeWafTkF1ZRuPk+HEvYAfoKDf+2WwqVJ8f5S8cweHIuTzEK
         9WDmFG4vnTT0+Z1jvEiCactJjkTyp0RorAD3wN4RuCZCknmWGzJzsgQ5UtYRLdZGz4vF
         w5RwjVp1zHV05niVtKJxkZwvHrQX1S0yLFF1pv5x2pZNbd6cjgRgeBjsA2YuqkBjZkIC
         Y/i9a+O0JMTc4N8Q5TEp2DurbZql5AGcniwSJIDA+cOxqAY/VHu0t7oXm7m92tzT7P9c
         wHNu1w5bM+PGQ2ISVfpAHmh1/HQnBA624lixef0pbzl4Mx/IESFcJ71lxJb35tQnRaiw
         qliQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkHQ0N63EZtUCxx8OZBBqzUFZCJ4gpZ0cxrs5LDnUrYYc0OHjToq2LurDmA8QzH0H4YahcsnJoJlB1LZJrnNxb6IorxN0SttxZ4T//
X-Gm-Message-State: AOJu0YyvE5dml14yKtqnQE4SSpL/h8dMlSrbkRsYQ6w3iUXhpuSBeMjh
	KU3y1FrELQ/L26HpSgu9WM1Bt7kq3+WWjR1ptLpZkrJ5/uiZwycP1CsusxMKcv3F/ZD1qS17nzr
	iKQuxIKpUt42WYLEHk1B9c32yNSZEZ4zWkTF5AN1Q04t9rpiprdbWt4E2cWGlwZVBQRbwQeGlb6
	QmUIMcbKIrwlAr
X-Received: by 2002:a17:907:1019:b0:a45:e3ab:152f with SMTP id ox25-20020a170907101900b00a45e3ab152fmr2489396ejb.21.1710085651895;
        Sun, 10 Mar 2024 08:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENK7ttrDdst22S8NlzkTYOHuK9XdIpvxOY4BupgfkauqF6iuk+XsSwN9Rn7jDGuE0TrKQE/g==
X-Received: by 2002:a17:907:1019:b0:a45:e3ab:152f with SMTP id ox25-20020a170907101900b00a45e3ab152fmr2489368ejb.21.1710085651366;
        Sun, 10 Mar 2024 08:47:31 -0700 (PDT)
Received: from localhost.localdomain (host-87-21-72-46.retail.telecomitalia.it. [87.21.72.46])
        by smtp.gmail.com with ESMTPSA id l20-20020a170906a41400b00a46163be639sm1092417ejz.12.2024.03.10.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 08:47:30 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] libbpf: ringbuf: allow to partially consume items
Date: Sun, 10 Mar 2024 16:47:26 +0100
Message-ID: <20240310154726.734289-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of always consuming all items from a ring buffer in a greedy
way, allow to stop when the callback returns a value > 0.

This allows to distinguish between an error condition and an intentional
stop condition by returning a non-negative non-zero value from the ring
buffer callback.

This can be useful, for example, to consume just a single item from the
ring buffer.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..dd8908eb3204 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -265,6 +265,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
 					return err;
 				}
 				cnt++;
+				if (err > 0) {
+					/* update consumer pos and return the
+					 * total amount of items consumed.
+					 */
+					smp_store_release(r->consumer_pos,
+							  cons_pos);
+					goto done;
+				}
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
-- 
2.43.0


