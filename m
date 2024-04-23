Return-Path: <linux-kernel+bounces-155317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067F8AE8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C6328252E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F203136E21;
	Tue, 23 Apr 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3QL1llP"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534F135414
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880604; cv=none; b=tEJzEYyeXa9v3xWfXCw7W70X1HsfUR1IR7aD2bG8fCcbss4H8RXlP3JDO4naCa61Ee4V5Wy3thWKINK5pYifoE5fX9NKzSjIElsh7G1puyQPwqQeE9ijjEuu5lM02zCIkpNMCl/62xH3gRRcycl0URTKMBZW/pgh5g9RnvbYYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880604; c=relaxed/simple;
	bh=eIDuK7Btp+udf2fVv94JzYZMy4NbqqbriW7Pgan3wkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDh+COAu7jkMWHueFxwktezpctvgOpMagDhoklBd5cIfhT7PkuhLk1Wp7NlFryirijQ1av8xIbZSh9EmNb+BbAJv6v0SAFXp+LG102rTTBVgeR8+0ENzXsbQr8xudors5kYRpOZC1nqHNoR9wvRi4dvkMjiw0J34tdH53S+35N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3QL1llP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so3898254a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713880602; x=1714485402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQk5FyVP0lAkjPXrseFZ4aW2TL7nmZurojICLrE1sJU=;
        b=C3QL1llPHVNesFaFRxCoejLZbYYnNlXsJw6zcDDr0h/cVhyyUeSAHp66gG8LxgikrB
         4ZKnx+vdAWpTBXGH6EB67O3bll9Q7XFRp5fSag3kNNhDW9NbMQwhrhbxiRBV9hrQZnyK
         VhJyBp9M0r38XYgZyIr57QRnLva3qtsu4H8z2OUTHD4Cu/UhorzZ47rwpQ6GM/iXCl1I
         CVdXlHfxfsUqm3OrtIV4L5wY3SgPLrnItEK/t/h/cjLdXp/w/PwBBZj3MCdhy/KPKLAd
         bSCepC7XSJhwSZzmU3WDRKxwGHeEn43cPFGhhhWmzsZVh1Gv6Zh6wnsUTfmqNpRgApJh
         wyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880602; x=1714485402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQk5FyVP0lAkjPXrseFZ4aW2TL7nmZurojICLrE1sJU=;
        b=YE48RjqBy5gov0hP8bg4MYD3C0J8pfQDGptlV4aVKGTHL1NlPvZeULTPR2zEV/1vkD
         g+zREKCiH2/auIy+36JNmzBwIvz206B+MW9ep2MTvd4GMKHvT8BHcN53uTpwSkydTRXp
         Q0C0baz+euHdKDSuLogYajHdv0MMNXZwqZX3gwgV84PooqWvnXJHnVCkCRUg004VwAUI
         EWalN5WW+RXNCTIMDDSy3VV0gc8jQzY0yLnerRSQZwEMIhb/2kDO2EiU3XRbUh/VzWUC
         rCxoWAgn4hnw49n2Rl1JI0CMgL77K/oq+fLKu/lAVavP1dTfiq8ei++KgJSvxxk7BH26
         Dzsw==
X-Gm-Message-State: AOJu0Yyv7eeAKph+2AOvP/jNVxA0WJCW6KbocvlmzilwfoiEX8kMXbqA
	RBy9UJdCxYbtfSUDF7fax03Gjf0IAX3wB9v3DTlVMlEPR3hPRe+TJNwJh6s1
X-Google-Smtp-Source: AGHT+IHi14oq6oMq0l+SgcZtnVF+lL+zvoONhe6aIpyGBgnH9ORlQ9qYr2zloIHU1A4q2j4SyGCYhQ==
X-Received: by 2002:a05:6a21:9102:b0:1a7:8a55:b070 with SMTP id tn2-20020a056a21910200b001a78a55b070mr17991393pzb.37.1713880602157;
        Tue, 23 Apr 2024 06:56:42 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id fa19-20020a056a002d1300b006e57247f4e5sm9623570pfb.8.2024.04.23.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:56:22 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] percpu: simplify the logic of pcpu_alloc_first_chunk()
Date: Tue, 23 Apr 2024 21:55:25 +0800
Message-ID: <20240423135525.36872-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the logic for hiding the end of the bitmap, there are several places
where the same value 'region_bits - offset_bits' is calculated over and
over again using different methods. Eliminate these redundant calculations
to improve code readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 mm/percpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..2a051f00f68d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1421,15 +1421,13 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 	if (chunk->end_offset) {
 		/* hide the end of the bitmap */
 		offset_bits = chunk->end_offset / PCPU_MIN_ALLOC_SIZE;
-		bitmap_set(chunk->alloc_map,
-			   pcpu_chunk_map_bits(chunk) - offset_bits,
-			   offset_bits);
-		set_bit((start_offset + map_size) / PCPU_MIN_ALLOC_SIZE,
-			chunk->bound_map);
+		start_offset = region_bits - offset_bits;
+
+		bitmap_set(chunk->alloc_map, start_offset, offset_bits);
+		set_bit(start_offset, chunk->bound_map);
 		set_bit(region_bits, chunk->bound_map);
 
-		pcpu_block_update_hint_alloc(chunk, pcpu_chunk_map_bits(chunk)
-					     - offset_bits, offset_bits);
+		pcpu_block_update_hint_alloc(chunk, start_offset, offset_bits);
 	}
 
 	return chunk;
-- 
2.44.0


