Return-Path: <linux-kernel+bounces-41526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594083F3B7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1481C20E86
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE16F5256;
	Sun, 28 Jan 2024 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsDweI7/"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B5469E;
	Sun, 28 Jan 2024 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706415585; cv=none; b=UedSX4UxHNSssfcAiGfInpEPR56lA9e5OjvumT0HQo34wY2S8Dy3bmczTgBCZU4PnCouRZ98d3TIom+1ANSBwQDBCPSq9YJxk48LnqvaS5ri+cxFU/pMAy+/tUS5c27z++TzFmi0aHHpsd2658bWbjPx3NoAN5wCPG0nNfA9ldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706415585; c=relaxed/simple;
	bh=ouvRLb+Ds//L/skH9q1zWlfq8nHjlpo/XAlc5ITQhLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bU7wTswN9YYMrqmTuDiebxCgyhdyQj71B7mTF4qAzYzdY8KDiYEq13360HsNHfJ7J1Ei+JsTk95CeQ6hgEXSrmhBL7IUYs2ONT/qh4QMrE/wX1++7Noqzuk73sCGgOz9OskP7057bFYx02bKULztan1co6agVdQwXSnLkiCDc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsDweI7/; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59502aa878aso887244eaf.1;
        Sat, 27 Jan 2024 20:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706415582; x=1707020382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15t886RIABr313J9wigXhAHcQ7ucTJcHxOCOzS75ZHE=;
        b=bsDweI7/nGrXbmx3KMtbaaTJzJPPb1ag2iHaFAARU3rZEB+6eLkuG11MGygoP8ksuD
         dFfwgZFl38jLezGlJ7oM4m7QNcjv3ruVaq7K4alC1s+ogBc+HU1cnDRxRRF2j1SYzWaJ
         wgG58MIISfrbR8Epg/e7oli2q2wPp5Ac0MjeKRVLxmJE1lom+ko4k6o6MdYLDfckRYgc
         9NEB3fgbu4hqDBeoUQmAjtfjYvBhcL0SYRCR0A1eWOJAl14OmaBARFoKGQzHkyqvzC4y
         A8CWfsE7yaniEFktQI+ArsfpJgR/RIyYOIthGt4GeTGS2xNMPPF7fsdlNViOSDwH2BEa
         kZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706415582; x=1707020382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15t886RIABr313J9wigXhAHcQ7ucTJcHxOCOzS75ZHE=;
        b=fD9/yp+bKc7p7Lvy+Wnx4TPH2nfxK8P5DFPKW26FgXwOr2c7tkyvrgAMwT1B55Jx+y
         YC1+V/B3s2cZ7RfCBmN/muycb4QTvT72s/OOFNNlsvdVJOg2heOMcNlrXdCAVvKKxT4I
         mgxnuaFUaHlaYrF0u3cS1EkVnhiV/t1wwlOYh2R0rx3cfIz2t1dG87rPVzsVvMQ9a2t/
         7icyU6r/f11uQXfG6ZRf5heKukQpnagDqfbCKcbYu2Tdy14HLbH8GjfmmAZQc3E2FRDh
         u5+NofUJ8M2Buio6K2hOzyp431KHiQBvhRXeNRnmOXWwgTMZpo7GrxVcfdlz90I0Rf/g
         5NqQ==
X-Gm-Message-State: AOJu0Yy6F206bBonPAEzyQy7nf7NKHp4qZZV+MSUrFEL3rKI/wT9/vV0
	GXhGixLOG9CAaVv+MeEZQ/tvdJMcTKyJJORYcDXIN0UtpHJ14cnl
X-Google-Smtp-Source: AGHT+IEBSQgi7IiC6vD8LPU9eld5W2djGlEuzGvkzp59fjqExYM58z4CUAPqsm22eW81t5/Baln3DQ==
X-Received: by 2002:a05:6359:1501:b0:175:c16b:126f with SMTP id jt1-20020a056359150100b00175c16b126fmr2599450rwb.56.1706415582367;
        Sat, 27 Jan 2024 20:19:42 -0800 (PST)
Received: from ubuntu.localdomain ([219.143.159.9])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a164f00b00295210e5a9asm2442047pje.48.2024.01.27.20.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 20:19:41 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: peterz@infradead.org
Cc: jolsa@kernel.org,
	wangnan0@huawei.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] perf/ring-buffer: refactor code of reading the value of data_tail
Date: Sat, 27 Jan 2024 20:19:35 -0800
Message-Id: <20240128041935.513800-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tail variable will only be accessed when overwrite is 0, so we can
put the assignment statement in the if branch.

Fixes: d1b26c70246b ("perf/ring_buffer: Prepare writing into the ring-buffer from the end")
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d1c29e..86b150a822b7 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -194,8 +194,8 @@ __perf_output_begin(struct perf_output_handle *handle,
 	offset = local_read(&rb->head);
 	do {
 		head = offset;
-		tail = READ_ONCE(rb->user_page->data_tail);
 		if (!rb->overwrite) {
+			tail = READ_ONCE(rb->user_page->data_tail);
 			if (unlikely(!ring_buffer_has_space(head, tail,
 							    perf_data_size(rb),
 							    size, backward)))
-- 
2.25.1


