Return-Path: <linux-kernel+bounces-36437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F5283A0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A7A1C216FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D467FC2D9;
	Wed, 24 Jan 2024 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzxvyZg/"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A0C2C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071878; cv=none; b=kE06mtymuoIfpHKu7ed1qoiyaV/6VTTfo4gmZesn77/z8W5TezjHQe1IZKI9+tN/FFFBkqriYojBbLGtKY93gT+fE9E5WlxqFK7UIbu1Kk/gB1mtiaPvRl+65Vo0hchiD1EsC1Telmk+q5ASqpDev0EGgjzSLcGpqrC5LqS2uD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071878; c=relaxed/simple;
	bh=ie+we1nj+mw7e9ONK+IgxcW9mHL0I0DPXCgErXIomSA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NBG653NEP7hFwA5Mvk6yItW9RLbn32jGrecDJn9vJP5oXRfsNj9uXM7m5erbH/bDm4jxwYa3BW23caDtNsQPmY0fqhMeW78IdVSFeyzwRdKC5+e+n9IBCvjhniind4Es7ENNq9plmCYXDSi2eyPhvbUPLgvPm+U1wl4KCnANdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzxvyZg/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc60902da2cso481639276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706071875; x=1706676675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TID2fOsjU/jpHwDMlLW9FAqgk4WlE0mPeuj0sjEkApw=;
        b=OzxvyZg/Ika2zgqCROsW02XTv9ThAlwtL4ept2K/kvOkomx6fhm68rsrTY6gaHjuB1
         /joVwN7/zLJwjxMrNV4n7YdCzIracRkKQcymSfs7mqansyzH50ZMpspanLveoB+Eez2c
         cJ4nYleeo8/+W9yFUv5we9Rwju88DMeH9xwv33Q/u03yzMj4WkvQUUD6jRZY1Q6RswNU
         Vw5pQm7rz1JoPpVP7im3DNVNRWtXfYzjqIrIkp/OSVXVoBoi2ceWaIMmDwIkwOsAMgJ1
         tSVi3Ahr/rz722WjAOvq2VVYsAW+2jsUoOQRUWTUWDiwRNlInw+8u0WIuVqGtSKde+7P
         V/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071875; x=1706676675;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TID2fOsjU/jpHwDMlLW9FAqgk4WlE0mPeuj0sjEkApw=;
        b=O06X1qgnNcFdvkYXWyQH4DHF2jl7qmxj58TEScLGhagprTORjbTRo2epqTtN9b+L7z
         CaEDDllqTbql58CaEH8VN8KPYvHNMZzgvQq3cDxy90kuSv+1Y4AEEgvOMOkrCr7ZOzv8
         LanqWKyVGZQvvHWW7g4iguXuQgn76Jc2eyt6TeZ3TVtaZRl+Z5eAMHAjzXrhiK+Y3X3k
         LJdmsDCFxNz1+UDuh88BfUeGbjvS8FkWCZlEfkK5mh6KnibkYscslmpsSEgeVVn/8oS2
         sjygq87pYupl7OwHiOhyYx4f0wBAxFks8HoYKcQ8AVSviz8ZoJ4bx8lW2e2610mzB/Wh
         Olyw==
X-Gm-Message-State: AOJu0Yz2ESUYWt7j50iXbGRIU4Po/cJRrVxTpM4Qr8K0YqhLWw90JhS5
	KQX+qTgTIiLsQ1qHmP1TbV8wqT9BquOtK9rqBWZnGHrMir1brVc4p/5MLMHoxyvyvzlcQ/0ZDmV
	Rt/apwnvUPfRy2PNMZA==
X-Google-Smtp-Source: AGHT+IEKHRkvZtEqQFYQePKvwjkaz0hLWiFmv056VOKUYgz3ApLJR31SjOkQJQJuNissfgTKaLWLZOPKt3b2VyqT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:a8f:b0:dc2:5237:81c7 with SMTP
 id cd15-20020a0569020a8f00b00dc2523781c7mr151808ybb.3.1706071875767; Tue, 23
 Jan 2024 20:51:15 -0800 (PST)
Date: Wed, 24 Jan 2024 04:51:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124045113.415378-1-yosryahmed@google.com>
Subject: [PATCH v2 0/2] mm: zswap: simplify zswap_swapoff()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

These patches aim to simplify zswap_swapoff() by removing the
unnecessary trees cleanup code. Patch 1 makes sure that the order of
operations during swapoff is enforced correctly, making sure the
simplification in patch 2 is correct in a future-proof manner.

This is based on mm-unstable and v2 of the "mm/zswap: optimize the
scalability of zswap rb-tree" series [1].

[1]https://lore.kernel.org/lkml/20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com/

Yosry Ahmed (2):
  mm: swap: enforce updating inuse_pages at the end of swap_range_free()
  mm: zswap: remove unnecessary trees cleanups in zswap_swapoff()

 mm/swapfile.c | 18 +++++++++++++++---
 mm/zswap.c    | 16 +++-------------
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


