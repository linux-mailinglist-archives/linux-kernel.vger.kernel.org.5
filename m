Return-Path: <linux-kernel+bounces-155958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78908AFBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DD1289FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63E25753;
	Tue, 23 Apr 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etJ3xW4T"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D229429;
	Tue, 23 Apr 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911423; cv=none; b=MWt7OAGk8cQ93ix3ggsVNXFgMhsvufO8hmBDmwdmikR0jdlKmCaykZwg0z2b4YAUwVcc6Y3+i0f3PzWYFrQ38u+jZteJFjKIdwZdZibO3KRcztNp8vKZaU3o331w0tK0FB5k5dADJkO1E57ZuBamSlDAn68qbQJ0n1A8P5613Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911423; c=relaxed/simple;
	bh=AuQ+SQkDeUgELtorzKrgNQtQFOOdwGtzbtOT14WSWCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kbuOz/hSC1Of5wsXJ5+QYnLZPVOT/SoOMR+6SIPNXBpqJIvhHwgEqNImKaBI6aqXdRDv/mW90imjwpEssDpWV9xcRYRNG/LCWbm/S5VrI+6ql4SLeLQhYIGPmKnjva+gok4qp7tQwcfb5HIBi2lNB9OydcrNOReWidNg5Vbzzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etJ3xW4T; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso4949033f8f.2;
        Tue, 23 Apr 2024 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713911420; x=1714516220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66Uz4GRic3IGdZE7sf+U5tu1ETLXCRIKBepd9JZ9A+U=;
        b=etJ3xW4To5Hr1hBCnDjA1Ju3lMGhp5shghLfUeZZiNupNOT9L4MUudbMp8oLOVU4xb
         ijMxftHza828H8pOZ2aHYOLapxsmupy4/q48rq6y1sQpcd9gM3jf240NCVfORAG2KpCr
         P88P27svM8K15EyqlgcgqWdBPsnr/PU+MGV11Y+dAX+KPWAhhM80oHT+sL6hGKZD4DD3
         ExlCq4wNdYtXeMRhEo5+DrncoTwhbcTGDo/aDGXbD/1l4q7pb2YnVFd6c1BPxUj8ow4c
         o/tdr5CUYV3TlhF6qOHcYPHNFDnS+kSUBBSFidEJpr5XESNXKjUSb33KfTI/2gWXlK2/
         A1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713911420; x=1714516220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66Uz4GRic3IGdZE7sf+U5tu1ETLXCRIKBepd9JZ9A+U=;
        b=JxMW+QDswYw9uxYwh6Ssi+9CtQC6Jr3ljlbF7nnf4PIG7e+7n/570yjMaRSRqAwyU+
         18jSFsMHpXzeRr0tf54zfHhV3aQuZ4JG19E52uH4atrbwGH5MkPhl+rE/Y5fZFnzUGOp
         5CBZWYXETAe1n1TM5y656M3SZ+G9yNxoj0BckUzjtmN4BSpOlAwexKJPp49+6Wow44cQ
         MYRyRETCip1DNhvYDMjCW8Ezo+NAJo4y2vlNnt+bvPNtt0V4qqeJ3U6OH2c872EwxEff
         M6BrMNd4dBG2jslOOB33zWEwmQumsSKM9Ad+9V3N0UppWOm8vJQBeXubqYTtczjft/wK
         j/rw==
X-Forwarded-Encrypted: i=1; AJvYcCUHq2kExFJizKyNpHQgfBqZ+ttC2VY/nibg+lRUidL9cxDYZCQgGjubIYFTqoDDY8Fd3l3w1JAU3D+zUbMvf0topXEQ8GcxPItsTrlZ
X-Gm-Message-State: AOJu0YyKpPcCV101YWB8gigSLBGAHv7vYmtAwplc61GEsq12moeszCqv
	+a/S55VSjlmUze6//otnfyXQUiujm8L1bNLUoMPZz/GsUr1tU9/R
X-Google-Smtp-Source: AGHT+IFcYjeSexBiXa/qAM2MmNnEH9f267vXL2TPkUjnoVI7tPI8s28Zm3TvA6aFiqv2VAgFYFiNTw==
X-Received: by 2002:a5d:5691:0:b0:341:72b8:83b9 with SMTP id f17-20020a5d5691000000b0034172b883b9mr368623wrv.68.1713911419577;
        Tue, 23 Apr 2024 15:30:19 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d6344000000b00347363b77dasm15466238wrw.33.2024.04.23.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:30:19 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Heming Zhao <heming.zhao@suse.com>,
	ocfs2-devel@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ocfs2: remove redundant assignment to variable status
Date: Tue, 23 Apr 2024 23:30:18 +0100
Message-Id: <20240423223018.1573213-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable status is being assigned and error code that is never read, it is
being assigned inside of a do-while loop. The assignment is redundant and
can be removed.

Cleans up clang scan build warning:
fs/ocfs2/dlm/dlmdomain.c:1530:2: warning: Value stored to 'status' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ocfs2/dlm/dlmdomain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 2e0a2f338282..2018501b2249 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -1527,7 +1527,6 @@ static void dlm_send_join_asserts(struct dlm_ctxt *dlm,
 {
 	int status, node, live;
 
-	status = 0;
 	node = -1;
 	while ((node = find_next_bit(node_map, O2NM_MAX_NODES,
 				     node + 1)) < O2NM_MAX_NODES) {
-- 
2.39.2


