Return-Path: <linux-kernel+bounces-164982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B475D8B85D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AD328494D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85E4CE05;
	Wed,  1 May 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R72Ps/A5"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF777F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714547815; cv=none; b=aPFAxx4ggAMxdkaEeKPxCnMrDg+ICvqVG2uddARg4In2VA22qOWOf5CCjV37x1TB+Yv8Dw7/3GNHcrNzpG1ILms0pOn1jsXK+aoTCYooHtoOdNw7Ykv+QSRjolEvTIRIrxvMMHXyi8VFXLcPEetnQc1YHn8XPThT6eyaLIr6RZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714547815; c=relaxed/simple;
	bh=Zm84AHCvnxyt0o9X5wJgcVYkS6CuOacEzpp703KiPlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B90x3KC6WCNFxT3XLsiJTOY3kYzYGjx6bTv636wS1zrunMzBF6hGsnUzZpoX0XBlq63DYIkZE71X2UIw1waEa9gX6DGcyaEKS3cM0KnftLfRqSja9cpGZ1QkXkOqouDF2q/0toB/9aVSnPcPyMme3YyEV8K0iZNACUFB1Zg/26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R72Ps/A5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so1709956a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714547813; x=1715152613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDDxn3nwJ8dBAImdY1763gW4+1BGtCWCipXwkVUV11U=;
        b=R72Ps/A553wIPQl1nHc16FsneHUt0RrqrFpBo1xgYEk463o/wY6QVAKO0nJbcun/bA
         BtfQ4gZjK+36kW60j5BAVD+GjwLPtvvHlMOkpzuZByAKVp8gfabGspSH/3Ez3Cikkbrc
         faM2QveFSfBUqADcgX3aj+bp7qjbRdQMIONNAS8qm3+CvV0AYEwoqhDqbhja3OcPOwHo
         IDVTV3/CkCh8VjUpKdcghj4Te4GS0drXXaVehsZTQfAETMJTeLAInZkad9njLY8g6kOI
         J3+X2cWv/YsNZ0RBrIruDIZjNZlHa+Z3dKm25lYE+5mlAXc+8AOdME8oGeVmIF6eSwLG
         PqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714547813; x=1715152613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDDxn3nwJ8dBAImdY1763gW4+1BGtCWCipXwkVUV11U=;
        b=lPgaIulouwUNxV6gC66IKQrdyWts6V4dKWnapTKZkcRzpEoXhrf5/hfc0HDNt+ZuPA
         yNxk7oHw0MkcMS8wEZaNa27uOQ5xWqoW+AuhR896YkgdDOKxAw46YiZvZ378wYQ4sRVK
         za336LoMLyN0JNhoPKk9iqfOYMR+XemAp6aQK7bA0eeLAXj9MxEeLHXfkPSu1D45z5PP
         2OEblFqO5XYmk0DK26lus+HyFuDKVmi2bsR3XMnt+Yac5qa/aY/GtaNWFg5FqpP/vaPK
         f4cPYWFWKven1lu0LbH5ymutzusHTOWiC44xIcBpsKyDNByFgZLlD5clU7SUDLgXBEO2
         X6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVZL5biCSxg46fpB/qdZfhnZgDBTj22LVPXaD7d6P8mWlGwZ0E2/RVDrX7mNfjHb28V52Xu3o7sKMdCCIdcBzGRsjuM3qwMnyILEMX7
X-Gm-Message-State: AOJu0YyQalGPHc+RXM2LTY8ZyqVznPwCyKX2BteAv6xzZR/KkMv32pQi
	gwIngDz2hrm4vI1IFN4Rds6z6cpLQuzt7raTitIiUro3ps/rBRkym40sSYLq
X-Google-Smtp-Source: AGHT+IF+od0jDHg4PHJIXXxulS7QTmqm3YDpqlJ+MFZX/L91D+r1B9i1Cq23VIlX7mtIj46WJlP5gQ==
X-Received: by 2002:a17:902:f546:b0:1dd:da28:e5ca with SMTP id h6-20020a170902f54600b001ddda28e5camr1772321plf.0.1714547813459;
        Wed, 01 May 2024 00:16:53 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170903070e00b001e560db091asm23523013plb.72.2024.05.01.00.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:16:52 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/2] bitops: Optimize fns() for improved performance
Date: Wed,  1 May 2024 15:16:45 +0800
Message-Id: <20240501071647.10228-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series optimizes the fns() function by avoiding repeated
calls to __ffs(). Additionally, tests for fns() have been added in
lib/test_bitops.c.

Changes in v3:
- Move the benchmark test for fns() to lib/test_bitops.c.
- Exclude the overhead of random number generation from the benchmark
  result.
- Change the output to print only a total gross instead of each n in
  the benchmark result.
- Update the commit message in the second patch.

Changes in v2:
- Add benchmark test for fns() in lib/find_bit_benchmark.c.
- Change the loop in fns() by counting down from n to 0.
- Add find_bit benchmark result for find_nth_bit in commit message.

Link to v2: https://lkml.kernel.org/20240430054912.124237-1-visitorckw@gmail.com
Link to v1: https://lkml.kernel.org/20240426035152.956702-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  lib/test_bitops: Add benchmark test for fns()
  bitops: Optimize fns() for improved performance

 include/linux/bitops.h | 12 +++---------
 lib/test_bitops.c      | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.34.1


