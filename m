Return-Path: <linux-kernel+bounces-139522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57B8A03F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA231C21D28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D330673;
	Wed, 10 Apr 2024 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BhdhT/Y4"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E12286AC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791335; cv=none; b=fa2g0PVNEvacA9MLPNeuQiCE3+BZNoZES1hONhmYbheM12dWXRqAgsvhYFvrlqXRi0u6na/FEUouHZZwgb8iId7KhS62MVywXCfal+x6dDMZFJaPF48IzOY73Smg8FIxtlsZtfwyBW8ElTsE7ioqM22WQ7uJPEyKxOQ5MRloUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791335; c=relaxed/simple;
	bh=U5eRYierGIrZ3m0cDuM6SWVmTSFoe5fMEmZBX+ufVjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVD6zN1VD/uypjsXHMDPtDAO/nxFosV+f6C27ZDn0ykJ2276JO+ClF6Kv/lLHeAXoKTuFWUpCdjzAVw/x4RE9CPsCmwwijVZmcfNeduwL0/3E5zgOoSiGYRtcY37b7uIVsr7pbZ5dnUTAX7Af/HWFtcDUVVlQoAF8WoJhpMUhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BhdhT/Y4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so5774071a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712791333; x=1713396133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trgevhbBq0+TDj0d1Dc0cXDGsMQZyk7EvY7tkc5hFNs=;
        b=BhdhT/Y41zMTFWh9wPvuAukWPL1UOXKq0p7FUL100VOS9T9FPTRO3kpJA+deheMB5h
         wzpZGch6v91M7/AQlunTNskboPu9T1zoVskw4a8wY/ZHMGGLVX1PLBYuKBQbeEOjJdBq
         QIoI14Xg/pZvJAL5tFypD5tqztnDBMHhOUve8DQUj7Vj6Ou010TqO9lC67i4IcnO5qGd
         qJUb3ZlYCVJuxZOke8uSpHIYLtHDLiFm7Tp05pp+ZMTb8qthgw+mP76kkJUAFTERwJrl
         BSesZCLOKF5w10bpSJBKG4b64UfgQMSgxpvD+eW930qt3vS8P8WKXav9orWSfMvZ2eFF
         s8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791333; x=1713396133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trgevhbBq0+TDj0d1Dc0cXDGsMQZyk7EvY7tkc5hFNs=;
        b=DtlJ4kTLYVhuYJQcG/UBFHOHDgI9R49T+gnPCuz2bCapOOG3kBs/AyyFmMugs/sLuo
         eibBCSYQuLYgZkYc/0ayu3fYHZjQ3RK9JC7jEUTeFkk7WLHkfND0folDYapCa582FJKB
         fSeQBybzSt5ToDq/pD2Hc44kiLHJnnVdntsYwGg+MRO/yCFXF/z7TLUNEDRjgEL9m6vZ
         aSbUWpi9CecomW5EYVfl8WNKkRaxjFw3M5B+ILkW7A4Ykb6OUyupT0cxN7TBWbZteeQV
         p3ToLoevjx3KsusSv8N8X63rknwK0m2HrYp9dXYZ75wGv4DqK9kIMVvuHa09CncZyzAX
         bpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaiN37ut2V06spi+ri17kNQ3hV/1eGPNfB7U29LmYIvhXQG2oecirtIuUfJZMUyv8OroUdIKq+PKBBccydno5j0VgjLTM2UF/pLLae
X-Gm-Message-State: AOJu0Yzfu065duIMfMmrcIIWFHpJYTqUqiO6A7eIhZKEMsmrttA3dLuQ
	7oFIU7SyGmd35zxp+cmq1lyCVYoDjXl0OgxgmKGLanzSkYUA00GbAXs5JbC/R2I=
X-Google-Smtp-Source: AGHT+IHfuR5nYBeXCUVKf9eL8sfLmNp+gibcSRtdISaY0xcurdTfWsmMzXnjiiylmF14OyqViiGbIA==
X-Received: by 2002:a17:90a:43c3:b0:2a1:f586:d203 with SMTP id r61-20020a17090a43c300b002a1f586d203mr3576465pjg.41.1712791332987;
        Wed, 10 Apr 2024 16:22:12 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm161865pjq.40.2024.04.10.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:22:12 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] cache: sifive_ccache: Auxiliary device support
Date: Wed, 10 Apr 2024 16:22:02 -0700
Message-ID: <20240410232211.438277-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of commit c90847bcbfb6 ("cache: sifive_ccache: Partially convert to a
platform driver"), the cache subsystem binds a platform driver to the
Composable Cache's DT node. This prevents the perf subsystem from doing
the same for the new PMU driver[1]. To allow using both drivers at the
same time without conflicts or module linkage dependencies, attach the
PMU driver to the auxiliary device bus. While at it, prepare to use the
auxiliary device bus for the EDAC driver as well, which significantly
simplifies that driver. The actual EDAC driver conversion has to wait
another development cycle to avoid dependencies between git trees.

[1]: https://lore.kernel.org/linux-riscv/20240216000837.1868917-3-samuel.holland@sifive.com/


Samuel Holland (4):
  cache: sifive_ccache: Silence unused variable warning
  cache: sifive_ccache: Use of_iomap() helper
  cache: sifive_ccache: Export base address for child drivers
  cache: sifive_ccache: Add EDAC and PMU as auxiliary devices

 drivers/cache/Kconfig              |  1 +
 drivers/cache/sifive_ccache.c      | 94 +++++++++++++++++++++---------
 include/soc/sifive/sifive_ccache.h |  8 +++
 3 files changed, 74 insertions(+), 29 deletions(-)

-- 
2.44.0


