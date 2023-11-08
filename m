Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675197E5487
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbjKHKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjKHKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:50:54 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873C4C34;
        Wed,  8 Nov 2023 02:47:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd20c30831so1253907b3a.1;
        Wed, 08 Nov 2023 02:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699440473; x=1700045273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbWdFo7miza+LJDE+FII5IkRlW+z6I8tgEOAp/fAi2E=;
        b=GwFfXdtI3flLgMpYFmUw+vDgxlxNNeJwujMESIjPeXEF2zIbAPoI/V8pm3Hh8/2aCW
         jPKK/gUPhWsXSfOBnjtcXmP4FEvYmncwk5qYdPRrXKDdKeC1Eoe+LvYvXRIj/XFFUBjY
         XTXhGTllhMcc1l4983UMzv/XgKm6DUF6glbm6S1AyjbKbj/q0/M7NmJkwuj3mlmlZwxc
         W2Vr81KFTIn+hC7J9E0w1aN/Gtud5RTsn26631boJwOwsV40I1I6k1gcaScPzg/E/HCO
         Z7SkPOZhufa861+h4KYBmjNSXam6dqHPy0zktUtK5qhBq5z/rTnIeiOGgPCci/X0QmEu
         VQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440473; x=1700045273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbWdFo7miza+LJDE+FII5IkRlW+z6I8tgEOAp/fAi2E=;
        b=HpVdu4Z020ZIYjDqzyPkMrRbNhVH/H1aqfrDCydwJ/5vBdyeKIHy8bw9cAXPEH80O7
         o1YRRch0vx0gt4w4o6Xm5Ncp7Np7kuePTW/rutoFkMT6sB2z1p0a07w1a2PoJpgppPML
         z2YMAajXTHCptJjeY6u/+Y3ML4YHhVyDKm3b4hR9Ae6tw7XL3cYtZsYd1eBWjSWXgKc8
         tQHzAEZAXRRumlmS5Z9906I6e6lQQnWhM/yh035DGt+TyvOwnxx7tKmOWf+niMGEG6y5
         tuyd+7aJA27iSmgtYA7VpRKhMIt2vrQaLs8bcqW0ogZbZ49OXYph7DK+Hl3PmiNbKDVJ
         SF0A==
X-Gm-Message-State: AOJu0YymcfQRLw8MHhHT+BJG0gzuTOkxjLcwv4qqe3i8p7+r2s6EvaV4
        YPRDyve1tUDAkCz5mEafBOE=
X-Google-Smtp-Source: AGHT+IEakTnfI52C8pPf0ICMAQ0OdKNwvumwvOelYpYlFppmk3T3eTha1MxYy4JkbmVoaKhG3s9jxw==
X-Received: by 2002:a62:ab12:0:b0:68f:c8b3:3077 with SMTP id p18-20020a62ab12000000b0068fc8b33077mr1611102pff.1.1699440472652;
        Wed, 08 Nov 2023 02:47:52 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b00694fee1011asm8617933pfb.208.2023.11.08.02.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:47:52 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] fs : Fix warning using plain integer as NULL
Date:   Wed,  8 Nov 2023 16:17:30 +0530
Message-Id: <20231108104730.1007713-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108101518.e4nriftavrhw45xk@quack3>
References: <20231108101518.e4nriftavrhw45xk@quack3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c       | 2 +-
 fs/direct-io.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3380b43cb6bb..423fc1607dfa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1128,7 +1128,7 @@ static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
 	/* zero the edges if srcmap is a HOLE or IOMAP_UNWRITTEN */
 	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||
 			 srcmap->type == IOMAP_UNWRITTEN;
-	void *saddr = 0;
+	void *saddr = NULL;
 	int ret = 0;
 
 	if (!zero_edge) {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 20533266ade6..60456263a338 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1114,7 +1114,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	loff_t offset = iocb->ki_pos;
 	const loff_t end = offset + count;
 	struct dio *dio;
-	struct dio_submit sdio = { 0, };
+	struct dio_submit sdio = { NULL, };
 	struct buffer_head map_bh = { 0, };
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
-- 
2.39.2

