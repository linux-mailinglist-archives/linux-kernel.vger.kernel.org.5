Return-Path: <linux-kernel+bounces-32728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D17F835F72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35932285D25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416853A8C4;
	Mon, 22 Jan 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyluCKqw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C63A1DE;
	Mon, 22 Jan 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918929; cv=none; b=eBrTsISb57J8cKQ7/CHnLB3qH67xLW8sLtsmyeI82N3XW8UD9i5u0s4BUbvT0uvGz7KYO7py2BijxS3B0D/kU/VHCwodxb++zBNlXg7USRTo3ZTCJuU3mRM3ftz7DXJML94QrCbFWu/3Gj8dypPHk+7Ujo+RkfTcQNwceyKlvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918929; c=relaxed/simple;
	bh=QR6932S2UYMK7gDrTWjHZ0UsuYjYIbFZTOK3FDlisI4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TymSWcKuRhiN1L+d8QQOeNpnCCl4lCzIzqL5pOsQ9KmfcBDsnaq1mKDwxIABbAfPnLgpZvBVcQrS0ZBL8g4+bRhxb0Vr/489pBq4dxI9bxwosjqCXstLhEtPYEvI9gq76dIJWUYqbxuB+x57mWrqY9dsX9hm5FKjdzZLNlUUG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyluCKqw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28bd9ca247so326868166b.1;
        Mon, 22 Jan 2024 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705918925; x=1706523725; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l3hpIXrtxKnx8RauByBgH/wM2mrQyb5OF4gwa22a14=;
        b=FyluCKqwPLiOj18d4x3vS4ub/+f6gftIOzp8soF0uEX+XCcmk9glzRWGeOmXfrFJfr
         xYaXR8ck45roy1MmQB991dPucUV9thOeGKo6absuajFUGkC4DkNMl2ODIwzzs1t0/smi
         zeJHW0HfFxWPl3dL1lIXqgVPeTAeWKiSPeMzOg/jyqkCqDKtkzajNnjSl2Q7NfFuCaGI
         ulTYY+UOqyisZnCNWQQcS5RddEP3IA9O4aXPqiJcF0V/uLV0eFq/4hnS+s29u0E+7NsM
         LoVUpXiwCklum+Gg8RoGcFKA/EOjq8Z/aMmTg567EjvQbrcjNpx4YLCUqit4qRI1cp4x
         /LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918925; x=1706523725;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l3hpIXrtxKnx8RauByBgH/wM2mrQyb5OF4gwa22a14=;
        b=oO3RVZYhcIGm5LchRo4JvuFH2VReNseFrpgrodDajQ8Aab6hcCYgVn9fUDi6aeomsc
         3wuxKVF+T1aOFKElUaysPQn6M0VEdqc14A/ufebPnFKpYek6b4whvokvz+ezqmgJaQ0J
         5T1iRZ4DLhURbL8jOu3/wv5PLbkCa/c7tL9TqL9c+IX5ARJLOdA3naPdeAQ08eFX43X0
         Wgslbhd7TFjoZsaqle71d6bZrv2hYe5QvIs6+yCRbkFyFD1/AfcDANq44XjVrwCvrwtw
         d8t6x+tslLiquBlrvzYIotO4tuUR9pTbre9GUX4AooScEX+Xa2GEdlwHiW7lvI1Z5n1z
         h+yQ==
X-Gm-Message-State: AOJu0YwHGX1izJt2YJnC+2jY0wGMcSZNc8JJz1PUWpyw2ZlUFC06+Omw
	Bl2XRKxWJfLNVAmEff6socyZ4iuTO4pcpnPJfq2J4v0EEwqXZc7O
X-Google-Smtp-Source: AGHT+IF/DWzpPmqhfpScAyTW781DslON0afk8yZy8yujCJxwx7eFh0os6G6EihsvhD4QzgMVGC5U7Q==
X-Received: by 2002:a17:907:8687:b0:a26:9534:92f9 with SMTP id qa7-20020a170907868700b00a26953492f9mr2783682ejc.106.1705918924985;
        Mon, 22 Jan 2024 02:22:04 -0800 (PST)
Received: from felia.fritz.box (ipb2191d3b.dynamic.kabel-deutschland.de. [178.25.29.59])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090654d500b00a2ad1182e36sm13241303ejp.9.2024.01.22.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:22:04 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] maple_tree: avoid duplicate variable init in mast_spanning_rebalance()
Date: Mon, 22 Jan 2024 11:20:00 +0100
Message-Id: <20240122102000.29558-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The local variables r_tmp and l_tmp in mast_spanning_rebalance() are
already initialized at its declaration; there is no need to assign the
value again.

Remove the duplicate initialization of {r,l}_tmp. No functional change.
Due to common compiler optimizations, also no change to object code.

This issue was identified with clang-analyzer's dead stores analysis.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 lib/maple_tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7b161802860b..82fb5195c235 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2271,8 +2271,6 @@ bool mast_spanning_rebalance(struct maple_subtree_state *mast)
 	struct ma_state l_tmp = *mast->orig_l;
 	unsigned char depth = 0;
 
-	r_tmp = *mast->orig_r;
-	l_tmp = *mast->orig_l;
 	do {
 		mas_ascend(mast->orig_r);
 		mas_ascend(mast->orig_l);
-- 
2.17.1


