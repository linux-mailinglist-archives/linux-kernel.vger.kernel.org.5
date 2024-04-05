Return-Path: <linux-kernel+bounces-132424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233C8994C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D4F1F234B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D8224CC;
	Fri,  5 Apr 2024 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3vhFLU6"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64371CFB5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295315; cv=none; b=fD39HTonlkXGN2E+xLjGGoRKdNJ6Z1t6yKNfitK7FX61BFj9FHD5Dp10NsGZke3LHYyEbYz2VAndQ6y7nSBmf64e6dgFAJWfVjFkdTWIeLJWuna+K68S4vOxQQVfmflxPOBvHdj8t2CSuToZL7lvgye/vvMamIX/Y0ydK8ouwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295315; c=relaxed/simple;
	bh=q5VDuWl8hSpg5gl3571EiKbDGXBYnQOGRAOg9JqRxNQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CGSXzFkPojDR9h+ys3+RRim7+IgYiSujzN9hE8bTy6oaM4VXv5BFZH6laC7WriY19zXKETgu2jHU1HUuU6ayScdRzEPy2e/ByI2z0xfNdDyAvoqfdbzdH+rILcP9tFZxhDZtVBTspoxEjca2Sfhvj6r+4nXmymGzVz7A6/4hdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3vhFLU6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150dcdf83fso33288747b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712295313; x=1712900113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=06arm/eh/IG4MSYj80TJZLH0KdxVku2q8wYVAMxWBVQ=;
        b=I3vhFLU6kPFaK+QT6CVadF/EEbkd3M6ADrxy1ArvUTAeJP1aCd247HmYafmgYU1Hzq
         vIuK2fk+esrnHXylaLRP4opIJFQ3IQBqM8/qx203v48dg+ILB3k9X8xcIO1eweKo0mm9
         JaBX+UDrTyahK8aapVkMjobMjE26E+Y9dMYxnHks1AML8iR4BYvP6Ns0kp9yxNwVcnOW
         wePX8TKBMQoetSNxiBwLMq50xxXVv5be7AST5nDv0GFhqWiiuIXocU5cBdQJRICK76Qx
         e1f4A64/63SndIjZ9ZAZhybBVTILa7U7vXobH2ZS76dXZzEH+RYGEmD/sRfprPtvT1iA
         Uyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295313; x=1712900113;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06arm/eh/IG4MSYj80TJZLH0KdxVku2q8wYVAMxWBVQ=;
        b=jSwouPGjKJGFMFswTTgylug8OmHVoHGdnLNkR8l6VrxeOw3BkRh5tWcxS+80KO75L8
         dsjyZUeV8IKWVoedwtU1j3M0nuVxH2dDJWtZ6IWk8bd4/So4L/GpeJrTjlFUmK/NtRxD
         6CEQ586lZTNiDL52YO+xGV+nPLIyTQqndcSRfdACJ70Ynf31anjmxs5lspMqs/CGUh3A
         OMHXtzHJsvm16SYLakOCfK3r0xSyVZfRtQFsX+jP63Hdzm7RlMj09gwVd0j+VLaiap8c
         /MlEEkKomSQv2UofBH1GzOhME4GQpiHYNBw4PI7SzK2l3KNoPbNozzj39AvFv0/M5fks
         cYhw==
X-Forwarded-Encrypted: i=1; AJvYcCVGorBjjQ5fdCq2+k/jloDWtdh+K+3gAn3yaHG3VvVwYsDwSkA6iquXd+PI6Q6KEOAEwA4VcLEO8iVurTveSvCsb+tYKnAaIgFiaekJ
X-Gm-Message-State: AOJu0YyYOlBvv2I3p8S7Bjcble2ciV9Jc6zFlJl++1+53+52cxiQ/N/j
	XSuFQuE70ovHiXvQ+M4j7tZzHRbfwbUo7OYfIwg3fKN5vAY0cDwDdCremvwVAHxGdDtD3PYGFez
	Pnc794Fvk4ZjPXEX8xg==
X-Google-Smtp-Source: AGHT+IE6i3UnSDT7YnaXJXwXPWBurYQcKzrhShLF6qFVFGRFCLFOPVeeqF5U+RuUJhJL0d4AdzK5Z9K6mEfbnsob
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1207:b0:dd1:44c2:7412 with
 SMTP id s7-20020a056902120700b00dd144c27412mr106466ybu.12.1712295312807; Thu,
 04 Apr 2024 22:35:12 -0700 (PDT)
Date: Fri,  5 Apr 2024 05:35:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405053510.1948982-1-yosryahmed@google.com>
Subject: [PATCH v2 0/5] zswap same-filled and limit checking cleanups
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Miscellaneous cleanups for limit checking and same-filled handling in
the store path. This series was broken out of the "zswap: store
zero-filled pages more efficiently" series [1]. It contains the cleanups
and drops the main functional changes.

[1]https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@google.com/

v1 -> v2:
- Dropped the patch to skip limit checking for same-filled pages.
- Added a patch to calculate limits in pages only when they change, as
  suggested by Johannes.

Yosry Ahmed (5):
  mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
  mm: zswap: calculate limits only when updated
  mm: zswap: refactor limit checking from zswap_store()
  mm: zswap: move more same-filled pages checks outside of zswap_store()
  mm: zswap: remove same_filled module params

 mm/zswap.c | 169 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 101 insertions(+), 68 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


