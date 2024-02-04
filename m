Return-Path: <linux-kernel+bounces-51757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A13848EFA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014FB1C21E39
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A2922615;
	Sun,  4 Feb 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wem4/7TM"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BCB225D4;
	Sun,  4 Feb 2024 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061514; cv=none; b=FLGksgNVCoSQk1PuyA7P3ccB0341EX1IOWwl1+OefebcCdKGH5LwEtsyA8RlHEc6zenHrAsSM7Y2KSyZgl6eklu/pnypiBKIM+PJQc7WYx3TzHDnQ0QJx45etEm+zWx4cSCAxx1nH90kqapjrO7OeOvaeEQOGuBB+tNNC/brMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061514; c=relaxed/simple;
	bh=X0WZl01M04vKAE6e5fKNFcPAKq0K9IQbxUjG3GRobpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmmdVLK7FYDXCWMNI32Ax72D2jtYxpbSrt6ofl+4xcPcLkyAgjr2sxJkVlqdDh3g4G3qjy287/VlhpGs13UXdGmO0fzofGd5f2/sDL4dBKvOMm6Y4joqxGxC+m0uCsh92uvIHSnNtP3GwZAovFsbHcbcR0wEuP9wjEliObSYV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wem4/7TM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2909978624eso2054709a91.1;
        Sun, 04 Feb 2024 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707061512; x=1707666312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T89ni4EzY5w7dyl+NoNR8dZeAoG6qyzh4j7CcOWYREE=;
        b=Wem4/7TM9BlyxAnc6+X2nZy70HJzRiBbAmVyxpUF6qVwO5w7PSxDZVvPr+brBQsTwy
         7+5VqeXdLvp7N1PwssMEaSI6dP/sSa3vnK6nPhMMRHGORil8cPobGl2v5MvFFFl1NNfq
         2VncHF78gPe0BB8c02EawofKoM0Boels/SiYvEtnsjISaZygnWHy/qzu80StPGJSebU1
         pb42R6R6KCOl8CTndBV9zwAQ09+OsF/8c9ByKLhsHz7ns8Zf0KWXp8ZoSHtfhUBq38He
         ANLQUSUjWpK1E/flaIqFEK70qxd8Bzkm27j+Yw0nrzOY0VGyezZyl+lyGF3xWS61fSw6
         Q63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707061512; x=1707666312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T89ni4EzY5w7dyl+NoNR8dZeAoG6qyzh4j7CcOWYREE=;
        b=PtAvF0TQwaCn5d2c2oljYVTWCgFKvWso8nlhWStlbpH/9SSrDEHU6l6LE7NWXwxHfS
         w/6+zNKII3QyefWtGOtD2Sv0M1B4S01qGkB5eiuNlc72eFA4o32QGfzlW1O/WxvlcbW2
         ZhLc3Q2JwJmUl9fxHz/jN8H58SN86YqSNO94+Fmz5UbHkbqVd3AYOG13Yx+EnZYdWYbf
         kcKp2wlRKc2oJKHjAyi6+XGeXOz2Hbgzb4wy+2aFcW6zYu9I5CEJCbM5zCGtUXOGhmoS
         kcJAlJF5IRg9uKe8iVbpIEt5S1rsfp2LDptQ8qaMF/mEy/qHXAISV2cVIJLvV/gVW4Dw
         vlOg==
X-Gm-Message-State: AOJu0YzO+JbVdI9ft7/CimH4rQgMz5Unnr5RY405GfjrFOyLwTnNrZKj
	55RtOQ0hPXtTrOT1d3sZEtiOeaGdstb/GaYeLrGY7JmEjhXAMyHl
X-Google-Smtp-Source: AGHT+IEgvL92tjQ/gTIzTcYVoxFksNkah14vLpe5Jmhbe9m0pqzYa5Cj6rpfqSPOCTGt+a4jgFX6qA==
X-Received: by 2002:a17:90b:120a:b0:296:1343:c79f with SMTP id gl10-20020a17090b120a00b002961343c79fmr8883744pjb.39.1707061512513;
        Sun, 04 Feb 2024 07:45:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKASF+c48bzBWV+HZGIqvYj/Nf8Ry4mx7dIASSUav5W/y0AfcQt0lasYyFCffMk6fGVf5DU1/gBlVSfSuAMjF/HApCEBvClEIevXH5PSgGRYndujQW5qLKXax/M0UNPgfVTqTsh9M=
Received: from kernel.. ([2402:e280:214c:86:6632:1f1f:62f:40f1])
        by smtp.gmail.com with ESMTPSA id lj2-20020a17090b344200b002968eb4fffdsm779273pjb.24.2024.02.04.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:45:12 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Remove the @multi_cs_cap to prevent kernel-doc warnings
Date: Sun,  4 Feb 2024 21:15:06 +0530
Message-Id: <20240204154506.3561-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/include/linux/spi/spi.h:778: warning: Excess struct member 'multi_cs_cap' description in 'spi_controller'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 include/linux/spi/spi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 600fbd5daf68..0b0616b2a9f9 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -422,8 +422,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
- * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
- *	more than one chip select at once.
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
-- 
2.34.1


