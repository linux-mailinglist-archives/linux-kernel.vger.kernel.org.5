Return-Path: <linux-kernel+bounces-84107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87186A260
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B588CB30335
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F131552F7;
	Tue, 27 Feb 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiDJBaky"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771E15442A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071929; cv=none; b=obSDNpkAA2pMDU9aqddUhToKmslvigUSUk5ZJ4euZWxq0aenPGQuIEHCGHnQHJ7UUZa/jmnxksA7ceWg+51Wut6YVIM/SYXgPl1BIPl1CMTLAN+vzda9La/YbKP4V1+mxtbzoWO33uhhoHWKK5I1e6yokuQ7wp14/CYsBMsQwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071929; c=relaxed/simple;
	bh=IdCiQBJhitT9Oq1nzunZ0J4RNw5mODISj+FFI6ItdDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VtlYYwwGAntZj6h1Nznalx0jWUEFNj1p/j+7D+KNmE/kuESyh34Khmk8uwkvWVHxSN0CLkIun5mxQdU3DayGti6eigXL4KYA6ey2jTOhtVEAgaua+qAl9OWa39+1UnEvq7MnO6QDuuDsjskEXzOrKlKErd9UyFP0D8hfACBvTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiDJBaky; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d568fbf62so2752173f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071926; x=1709676726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgkeChhdzdsl3VVE43LHMpQmdoDgIDk5tOvZY9oXyW8=;
        b=AiDJBakyhVLGc1ST9Ufdyx2843ccQ0M2J8ge+V+rxSOSvRZ5QUQxpNaD+w/F0kox2N
         v25lbvdnH3oKiZ5+KqCV3GVmC3kXN7xEzGWhpVoEZzc3gdh3sRU5z2GYA/ohGlODyoDp
         3C/QpaIsXOx8qNkyt59PPqNL6QrFahYCZJLMs/HWQPjxwMrcdJHv0JTjCCDdQ6hmZayR
         0E/6U1LlfcnGWipk+t1wBOUTuh7hnOZMHADJlnI5T4miA8EHxGCoMwovJwc7DuSo3B8n
         eArm7U7VX3ShspPwxMdNtfbbS+cwNrx8DhXNUMT/QRcKIumPGvGn7w6DmciFWv8dFKdr
         PRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071926; x=1709676726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgkeChhdzdsl3VVE43LHMpQmdoDgIDk5tOvZY9oXyW8=;
        b=JrzvwxaRud5SNcb0gvkuXLNiNFJRWwbh9nEVbqrinM6VMsiAH07bDoO7M1eTEa5ezi
         P6LRt8zjlcnLV1BxkHwgsPPTOpK13D2hCQJr5qDRTFiv9Kw9i6l0TXAHQVXg42PEsVfm
         GE+zAHfnfyfYC+JIy/k0E1pekoOdOdN5xsifaFCytXKBmuFvYWcvrj8Wne7mCJfMc+zn
         WnRPdJQDDY3g4bZUBkERVzvUfDMCdtfs0MNV3qrX7TvQl6VHRtVsEtJVy+BycFldWOdl
         we6kw9FIHsh72VPBoK9Sj4FozpoZuWhEtuxHhfjLB96lny8xF6RHrUqmhpFCqNoFgyVN
         /qiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqS37MdKTt7b22u4TRjBo6bmYYxGSTF4AUQ7pUTQScj1kNwXEkLP4dWCm9XhvvI67DS0aOLM+S+vIah96vaU8ftMJ1pPq1jYa7vqm0
X-Gm-Message-State: AOJu0YxZeTuznrdtH6cslcLB7fU9Yx5UNXK4/f3n3fxlZq55if27qZWz
	JYHkyEN1VegAD/pFMgUrt8VP+RIS4mEnlGdGdYaQ9zo0goEER6zH
X-Google-Smtp-Source: AGHT+IF+iWOAeHEtZ90X3s7ON6KoAn08gmOo67Z5rUI3PPzKbcrSF+ppTCZjKmC/a4cSiU1GZvDP3A==
X-Received: by 2002:adf:e689:0:b0:33d:afbc:6c85 with SMTP id r9-20020adfe689000000b0033dafbc6c85mr8817081wrm.8.1709071926584;
        Tue, 27 Feb 2024 14:12:06 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm12415560wrx.28.2024.02.27.14.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:12:06 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Fix defines in rf69.h
Date: Wed, 28 Feb 2024 00:11:59 +0200
Message-Id: <20240227221204.534131-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes several misuses of the define statement in rf69.h.
Duplicted defines.
Define in header instead of source file.
Unused define.
Using units.h macro to define frequency.

v2->v1:
- Fix grammer in commit messages.
- Use units.h macro to define frequency.
- Reorder patches to ensure no conflicts.

Shahar Avidar (5):
  staging: pi433: Remove a duplicated FIFO_SIZE define
  staging: pi433: Remove a duplicated F_OSC define
  staging: pi433: Redefine F_OSC using units.h macro
  staging: pi433: Remove the unused FREQUENCY define
  staging: pi433: Move FIFO_THRESHOLD define to source file

 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.c     | 4 ++--
 drivers/staging/pi433/rf69.h     | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)


base-commit: 455c5e12a3b7d08c2ab47b7dd54944901c69cdcd
-- 
2.34.1


