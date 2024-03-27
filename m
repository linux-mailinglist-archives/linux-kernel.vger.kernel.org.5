Return-Path: <linux-kernel+bounces-120255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E588D4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC531C2312A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F5F225CE;
	Wed, 27 Mar 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5hCh7BI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5217545;
	Wed, 27 Mar 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509833; cv=none; b=GiI560JTOhroPUa0Yqgo8nWdGDAXJcLKuMEc7ZIla/5IlfAD8MJFYfWh0M9pKxTv2pakYTp9bgsU/9XjqOekmp5bTjXJcsxpOQ4qvKvGUvP1hiHqqcFJC3gu7eE1MI5XxQG9tit0/xuy/Zu7odgKvDTkjWU7ho1seYtXjVHybKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509833; c=relaxed/simple;
	bh=qM6iGV5jNuZ8RxUHGK1v73pIuVWWgfp6DGOZSTMzbnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BkMKjkQh9NPprnpB9WXODaz1GP6wPBN1ZpDRyzK1VxyuQ1kI8fz8JsCF2bQofciSpwtdc8NXEdVNGB15P5QOCdzGMyN7dRHL5xSGYD15Jgh9nm81UZRkMVUF1vt02AXLn06W0dDODtjpEXJrnGR0/HIF6W8UgQNhhmE8+jBUYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5hCh7BI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1df01161b39so51163805ad.3;
        Tue, 26 Mar 2024 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711509831; x=1712114631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=quchINbY6RElSjO1aqPi5tTjS1pbZmgP1zzsUpD/qO0=;
        b=i5hCh7BIVFVwrMDBnyLNvh7x+qVe56x3cu7Ac+KSpO2kVBT5IBuypW5F1SmblNMHVR
         oD9+c5pG6JL1hUVWe8n3Bk3UJ09X2cLGeTs4syyvDhH4Ym0hE7RArIjr8g/pHWG8oaoi
         w08w8RP0CTLbWloqWytR2emupFjVR+uCd1zsUSWZTzK7TN1C1JX7vXdspXvNCnxsG7Pl
         9nyqA+E4RcQlm23yrOpW3eMLs+ZuxJ6s4lpZIwLnc7koCpSD/trEVetkLrAoEpFHxXBV
         rPUua5N18N723v6q7l23Aq4Cic0xiKoeIPSykaly2AIiXKcOOV/+XJ3nnjbemGw9tSX7
         aqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711509831; x=1712114631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quchINbY6RElSjO1aqPi5tTjS1pbZmgP1zzsUpD/qO0=;
        b=DDH129cjLpRDSi8mJuPxs6z7FVfCn0SgdxHA8OUEJ4N75AoMIyIfCpcNJkUQz5qfI0
         uz57ic+5oJtQObUjGFU82RcHB0jrV17eiSkz8pCqSoJ5+eQ/kSa5w4kSLL0Wmdxl5+6R
         enSOTtfG0eY9S6r76bwQJFdlDak9eJFPS6E4GrjZpLCQ4HP8e2ZQxpQmeMhQ0FY5rJF/
         eKna8netLDzhjz3Arw21tCX5ps6wa5iGtCdOSRWNzfk7UhVWu7mzOWm/scXBq5HbUSnE
         1gfe9/6stIHPUJs+tcv+fJoA9qcoDN4+AouDjSe4e8OZkHhZZs4rsC/4dVw6ap4PG104
         Y0cA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVqdOEAnEwhWjB1x96TNGsPYBh7FZwHjAJY66KJ4VMhTUpyzdnr0lioQAjaDxUvvAuNZs9tpgkgTCD1RI75iHVqhBucCPd4q7GWVu
X-Gm-Message-State: AOJu0YwG2x5m5hYlHgVCo/3zHWqkgWKppZz4ctza2icitIcCbnoZ9WMS
	58H4EGzQvF5brTS8m9tUxCpzLF3tyKNDUCL9lsqd5gw2ITu2ymV2iMTePtL+
X-Google-Smtp-Source: AGHT+IGd6mGZb68Ym71AilGxnur6mTDmbwu0NzD17TxXGkZeil7mFdBYIowLvo6VOxx/gTDfxFEDYw==
X-Received: by 2002:a17:902:e748:b0:1e0:ab21:4e9a with SMTP id p8-20020a170902e74800b001e0ab214e9amr1795982plf.21.1711509831515;
        Tue, 26 Mar 2024 20:23:51 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090322c100b001e043df262dsm7729090plg.33.2024.03.26.20.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 20:23:51 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 0/2] In-place module initialisation
Date: Wed, 27 Mar 2024 00:23:35 -0300
Message-Id: <20240327032337.188938-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Introduce `InPlaceModule`, which allows modules to be initialised
inplace, as opposed to the current state where modules must return an
instance which is moved to its final memory location.

This allows us to have modules whose state hold objects that must be
initialised inplace like locks. It also allows us to implement
registrations (e.g., driver registration) inplace and have them similar
to their C counterparts where no new allocations are needed.

This is built on top of the allocation APIs because the sample module is
a modified version of rust_minimal, which would be incompatible with the
allocation API series because it uses vectors.

Wedson Almeida Filho (2):
  rust: introduce `InPlaceModule`
  samples: rust: add in-place initialisation sample

 rust/kernel/lib.rs           | 25 ++++++++++++++++++++-
 rust/macros/module.rs        | 18 ++++++----------
 samples/rust/Kconfig         | 11 ++++++++++
 samples/rust/Makefile        |  1 +
 samples/rust/rust_inplace.rs | 42 ++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 13 deletions(-)
 create mode 100644 samples/rust/rust_inplace.rs


base-commit: e0ff891dbadea6226042574a0cbfc24df0318b13
-- 
2.34.1


