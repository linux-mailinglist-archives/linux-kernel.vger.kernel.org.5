Return-Path: <linux-kernel+bounces-61074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C24850CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F628809D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EDC79CB;
	Mon, 12 Feb 2024 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WPnvPf4x"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE707464
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706532; cv=none; b=II68Yx9biVkL/gPu6SZ3LDV3y0Z5M4Y1J7SU01aw4WqJYSGC6oaIq6t2HngQNS9UjG4YXDALxs0vbAdsKpibfarigREKRsY/vHhAuS0TZMRnGa3KRgRpC1EtgJe1DQyKL1XQnXyNioIEPtMkBJg0eRiLIkGI/ADX77LmEFGYD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706532; c=relaxed/simple;
	bh=WkAKPWuL+r1eF8GrLEKJsJifXUEWEnC/4MD/tiMKrOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIEG5yRDnsAkKZjoLp9Rcc/hog5Nl7mqrPvN/EETPmqzW0p/duPO71DYkww6O55bY0TN6iriANG6V2RhLkEi/Tp+bzNmo9rr5a5RI6M8/B4DlhbxwIDPkrRaJXk/JYD+nuhBpzeJp8aoqWYvjSkrioVmAZKi/Z2yn6dm2TQzDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WPnvPf4x; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dc13cbce45so2034112a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706531; x=1708311331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3AYwIFOJHMYB8Yfmr8ZbFJXyCyieMlwYjbQspEUaOQ=;
        b=WPnvPf4xYLlRUWE9AgMRXvIpEdSs6TwcQaAjFRasbxfJyp5YCV22j7DFTfKkMl2A8M
         AFKkq7nQUb/b5bmjUHV/mNFYlAnF54jNmc1XDxAXeXf1CNrn7zYormDo6VIgRseZhzTF
         b+sdizrxsouQhdSpg+d0Ere1wGaWREIu8GA4CX0PLCaoJs/YY2eAgYF0kgsErX1QjTsJ
         Mp/04DZ/w1jZ2VBBmJYK91SZ5wBCS6EoGahIVUBFEdqEencwtUyWVzgl9h0IzDAOJGGH
         z/mGrolEVsVaNPEWDvLScUrwuLW5OX69GUDhX552vK8rTo1YwWSBS+8JiFOx1SpRcWWJ
         1xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706531; x=1708311331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3AYwIFOJHMYB8Yfmr8ZbFJXyCyieMlwYjbQspEUaOQ=;
        b=afuvNy5AsxLE2nMRHNx8Yqq9tvsJCEjtirUgjAdAJ/GDdtqSZnJ+zSTlCVhOwAXEkG
         yJbkWjdJ1uGwNBcUirWx7cFS7yR4ZL+o7o7XWYcTgJAAvFxqJaQ1f33oTTveBJwt4csy
         wRYTQwlxw/x2Ly8bb0DWbVBAbOvDDwYNg+UnAtMeiHiaLNoeI+POTvDtn9tT3U3FIg0y
         I2gXvD6JdHzKyXlei9sc3wDxqKdQ6XoaY5yle9xNTzZl83Z2EUNcxpAGNIGePAzDN2bh
         YKcqVCKh2667vyjAkFiVD+4hfAjgWtLVJKsryaAeGo/k/bDgxGp8O47HqFvnFlcBka2Y
         dyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxr+4hn5YRnxPNbzeNmIlY2aN78cFut8aautycRuldzvna67FqMlHf1dCBn6YtUQURSWfKDTGbgZqqw1mlXRCS7iXeyYDVbc29NU1y
X-Gm-Message-State: AOJu0YymkJtoP9AN2sGbvFekvMs30LBSCdTt37ttO0j1hykE7/NAPkSe
	XfjMq1XHk55YceW3rX79TJ4MOX6uYDrIKgC53lWO3mswjH/9R6xvVQXlwvg5rYA=
X-Google-Smtp-Source: AGHT+IHVn7UkxQepioSD8cVRqZrIIQSswaGmUNp79rrmDndGmc4Za0zL6SwNiLGJaepituGreaaXfA==
X-Received: by 2002:a05:6a21:2d06:b0:19e:ce71:bb4d with SMTP id tw6-20020a056a212d0600b0019ece71bb4dmr1428086pzb.38.1707706530764;
        Sun, 11 Feb 2024 18:55:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXubKrZzmTdYnKgYksIC7LF2/jitJmpI+rEZAZrqZuUjsezx4fnGP7PrHim6TxQgYg9CzDkcf5BKGh6Sl4hezML4bnOvHsiFNmcnuaq3saQlA+MB9ECyci5CiQpHbTD5wYMtKZJg3FRfKih0ClvVW3Ujf/ANaZw1HuPMprQCa0Aovx7xxtiuVRAi5DhAmIMei32ZkE2QzM1TrU3ttGZC8j8bNHbQtKjXYqTlKGiJtNuXqp4lmEE7y6PuwiVwqwBGM+zgSXq/dwMtveTxZncY1lTI8otEtdvXr+zniNmxzocK/KpTm3oTTBCkEECu+yLu3L79Oijm1Y=
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:30 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org
Subject: [PATCH 0/7] riscv: Various text patching improvements
Date: Sun, 11 Feb 2024 18:55:11 -0800
Message-ID: <20240212025529.1971876-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a few changes to minimize calls to stop_machine() and
flush_icache_*() in the various text patching functions, as well as
to simplify the code.


Samuel Holland (7):
  riscv: jump_label: Batch icache maintenance
  riscv: jump_label: Simplify assembly syntax
  riscv: kprobes: Use patch_text_nosync() for insn slots
  riscv: Simplify text patching loops
  riscv: Pass patch_text() the length in bytes
  riscv: Use offset_in_page() in text patching functions
  riscv: Remove extra variable in patch_text_nosync()

 arch/riscv/include/asm/jump_label.h |  4 ++-
 arch/riscv/include/asm/patch.h      |  3 +-
 arch/riscv/kernel/jump_label.c      | 16 ++++++---
 arch/riscv/kernel/patch.c           | 56 +++++++++++++----------------
 arch/riscv/kernel/probes/kprobes.c  | 20 ++++++-----
 arch/riscv/net/bpf_jit_comp64.c     |  7 ++--
 6 files changed, 56 insertions(+), 50 deletions(-)

-- 
2.43.0


