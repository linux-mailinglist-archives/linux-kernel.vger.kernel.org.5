Return-Path: <linux-kernel+bounces-39227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BE83CD11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D19AB25EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB411386BC;
	Thu, 25 Jan 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="gM6y+qqC"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD6137C58
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212885; cv=none; b=VRPk4ha9owFxvdv9HM8ppAcZwWutDnj9TJk7j7Rf6H/2OTjhLz5IECnWZlLgLTF9keBKiowuiqvOoG0a5DIq5ePNs3HAwBHb/PJYWQ6Dpu4BMDqL5id5wOdEYzARuU2xoz4fZOhsnxgiXPBd8dK3tqg6iEgyXRwNxXbWDXWdRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212885; c=relaxed/simple;
	bh=NPFHNug34QGjbE4L0tIiot7F6XxQaEm1ADq7Q6JJW8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqb39UihjkJkna2a+TZH/aFkkyWTim3Igg+dIrXnBEj0itXRLQ0rApGvJW2/t3LRWcku4UEuGGvsDbIMwno3zFLrJ3u2dgzM/3UOSSDpqXsbjXd4Ycz7OVb6hA2uoPmRtGS4cvUnDqN5s+ekclNqphezWAWQVsxLd4BW835JIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=gM6y+qqC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a30e90ba9dcso70842866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1706212881; x=1706817681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI2TUBrWsibpggLWuO+Eog4ByDUTome4h9IXAkq4JHg=;
        b=gM6y+qqCInMPLiugKTwplVm8OXPWxgFqrwRAfTDflHF6mX4G/FSWZ91TmmhonLGuqN
         qepWep9auu6Fmks3OHOUrxR0/gvwRwGUy2p2KyjA9d75j0Z/8brmZ2WFloL1cQfsmi4k
         Uc4psliXehC+THPs9sCtcaJMa9Y5XgRIiT9UMSgtf2hAu1wx50YeKgEsSiyE5nguF9l4
         c2AHsJa6BEBYuiunLRyI7tgu11rL42rW/s/LFG+1sJLQwxkIAooWNm7pl31F6rHQbf62
         PP8EqAaC0hJFQZVUvchreb+XPwYkaDRZ3dqJFw1ye5SZOWiq7QXMJAiIqFgKe8T+TnJL
         OrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212881; x=1706817681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI2TUBrWsibpggLWuO+Eog4ByDUTome4h9IXAkq4JHg=;
        b=ae7iLLnfVtb34m2/u2dGwAQ5zBXS2qHlXIg+BxyAIIBYv6YQGgiW5KWbAkP13unwxg
         MPOYYNgTSgTWfI6oILPlMBvtXwQqDX3FVDKtRB8ZAris4EKi4pHLQjlejhUbTkUs1b2h
         4Mw8YCtSDrEcHrtLNeEHtID9f/dVZU8DshJdPNMk/H0u7PjLk75mNfCD14kc+oXRr6EU
         78aoIhhj7FvihM/3jILbrNantl4sKmd0Qo6Ifja7VJ7cs0P/t/IUcfhuNKJQ0Py+o4E3
         mCnkaOeIb8zwl12XgRRaovcB0ehz3dSbf5nCLqls+GsLla8RNoGDuH8UJX8oTX2Jmcvv
         Wjfg==
X-Gm-Message-State: AOJu0YwSA7Zfap8TSCCiJZrfYXM22IBsbH2+LdxLH+HhooYOxQ/yRhHj
	rcTfusrVnM2hH2Jl6xyelpq6nNSzHJLeIcQUhPPt+wbfc13aVHF/MATZqLTRzgE=
X-Google-Smtp-Source: AGHT+IH2rF8eHuhiaQIwI/Xc+DXpK654R/gK9VQE4TxudoFLQcJX4ThR2HuNQxMZHhNWur8zy1OTlw==
X-Received: by 2002:a17:906:80c9:b0:a34:95ac:65b4 with SMTP id a9-20020a17090680c900b00a3495ac65b4mr132618ejx.1.1706212881683;
        Thu, 25 Jan 2024 12:01:21 -0800 (PST)
Received: from pikachu.. ([105.225.45.176])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907c01100b00a3496fa1f7fsm195577ejc.91.2024.01.25.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:01:21 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-mtd@lists.infradead.org
Cc: Chuanhong Guo <gch981213@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: spinand: esmt: Extend IDs to 5 bytes
Date: Thu, 25 Jan 2024 22:01:08 +0200
Message-ID: <20240125200108.24374-3-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125200108.24374-1-ezra@easyb.ch>
References: <20240125200108.24374-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

According to the datasheets, the ESMT chips in question will return a 5
byte long identification code where the last 3 bytes are the JEDEC
continuation codes (7Fh). Although, I would have expected 4 continuation
codes as Powerchip Semiconductor (C8h, corresponding to the parameter
page data) is located in bank 5 of the JEDEC database.

By matching the full 5 bytes we can avoid clashes with GigaDevice NAND
flashes.

This fix allows the MT7688-based GARDENA smart Gateway to boot again.

Fixes: aa08bf187f32 ("mtd: spinand: esmt: add support for F50D2G41KA")
Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---
 drivers/mtd/nand/spi/esmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 31c439a557b1..4597a82de23a 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -104,7 +104,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -113,7 +114,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -122,7 +124,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D2G41KA",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-- 
2.43.0


