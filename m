Return-Path: <linux-kernel+bounces-31679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02236833276
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89061F2272E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E810E1;
	Sat, 20 Jan 2024 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rlojni0V"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D0EBC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705718412; cv=none; b=JcbEkF91k9mIt2kUk7AAAfmzZX04dYcpKrMX5xoonL+GBLI5I9Io7T81T+jf9XLz6c6apKEEnT/JLx0secSixUadvhL0aOiC2BerVBsPog7pCQwNGdk6jfKXX2S8S/APDtxKUjHg19n6iLAkC24cMK1Batjxwa0Oiz8e80KX5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705718412; c=relaxed/simple;
	bh=KSbnvy4sJIwSCyWI6YElLaEZDcNX9o4TzCcmRIx6GrY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DZoqGQZnkav5HPzu36XQA79tojYHyiTbd3clNaHvNNhcZ+NmjHx/wgA/4xClQSs49RTMIn65CG0DojCYSIEXb8d1TO/K7wgw0HsXlVduGE7cSepAeWGsB51l4ug2QUKdQgzjDP/4HNeNnCnSMuAmtT7iH0JabER0UlbVvBOLrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rlojni0V; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbcd9f4396eso2236636276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705718410; x=1706323210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nM+uM5keP1vVbVBzlI6j6cI4oG9iDGk+mwAqUBofyJA=;
        b=Rlojni0Vh69Dk3HyH4rbQ1LqiI05ArzJcu5zJIthyGVZ51H/5K1hf3DJ3gLGbm9ItX
         EruLnUSx7HV85Nqn06uxFxBb061LoysAZ5MV4nihqGt1pOEeLL7ekJpBSFrfvkgBO+D3
         5pychlrmz83vOyrPYVn4L7EWevx32/duW+kfRbWw0rX/e9O9/r3Ex6WXp7tUY+YX9Wnm
         Z6FuAlRXOayMh/Ake7gHQmBnL2VvJ4rXwNw/dwktyr9gKukz1RA8stTyTWPQJLr2iv16
         Igy3z0xGtrvABzHfu7Vj4EunF9iZyL33mPQ/NTjWYuXrYYc5cpYaMHaYek14K/4b8eUD
         3h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705718410; x=1706323210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM+uM5keP1vVbVBzlI6j6cI4oG9iDGk+mwAqUBofyJA=;
        b=TFPPE7je+l/CLxoHyT8mvvsW06gvHoDl7S1Mo7Ep70kiztkgKYl+9l544my1cTHJRH
         BBREFPZxzZ0LKNMD9waIfIB6PpbwKfiUhTd4izWkwNASCtNgOtiW7bCHi0zzlfSezZVo
         9nkyC5wDz8Z3snXJJ09EJDz/eukK+HWoruul4ZJJLaGKPRkVSdLDHhFegItNwTAAyU9Q
         9Env748Jw9LNi6L6okzMDf5cPQM38/qMXEsrdqZt9XO3/3lx5pE4R/x2gwEyM3UwLUOq
         V0mVVjS5chlK1oXNTXzH9lf8dPAc7E2nImgOlzImcrN5hdhygKMqrTV3M2BHIHa/UPeM
         o3ZA==
X-Gm-Message-State: AOJu0YxIbAY+ZQrg0+Xs9royCO8pBiOUDKO7fyJy5LNQHQoNakFE8H7+
	A9oiS+Uz55quq8vZGzXzy9wApUkWF2ughKwxFiJcp+DL77g9g2gktf0ZU+oOBe2aydjcbfPoCOZ
	a4/Mg18EC88EV5B6/fA==
X-Google-Smtp-Source: AGHT+IGzNqMl3DhRutX1zvjmGkt2LuQmWmEVi4658k8bSyLNrERdkq6ZmeK5EEpUZV+0XOc07nXSEFyjXLHNexLS
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:86:b0:dbe:a214:888c with SMTP
 id h6-20020a056902008600b00dbea214888cmr423251ybs.11.1705718410258; Fri, 19
 Jan 2024 18:40:10 -0800 (PST)
Date: Sat, 20 Jan 2024 02:40:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240120024007.2850671-1-yosryahmed@google.com>
Subject: [PATCH 0/2] mm: zswap: simplify zswap_swapoff()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

This mini-series simplifies aims to zswap_swapoff(), which should
simplify in progress work touching it (zswap tree split, rbtree to
xarray conversion).

Patch 1 is a code readability change in the core swap code that makes
patch 2 (the actual simplification) more obviously correct.

Yosry Ahmed (2):
  mm: swap: update inuse_pages after all cleanups are done
  mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()

 mm/swapfile.c | 4 ++--
 mm/zswap.c    | 9 ++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


