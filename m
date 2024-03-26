Return-Path: <linux-kernel+bounces-120124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EEA88D2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C41D1F3D0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2913DDB5;
	Tue, 26 Mar 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBx4wSrt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9C129E88
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494898; cv=none; b=bdijtRDNPwrbQU3qWLQ2Q/jFiVJE3C+E/wA9tENrzlmFnuoYxaQtRslBXvbNEwN+2VRZUwx7LvWmxBr0XGKSPmeOPxLWeB+h/bSQOelPP1XstSmqAws4F2gqLs4dpLBqvbgQOD7bCNinpDaesD3cndL3jexgdU89AFCYQGYqv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494898; c=relaxed/simple;
	bh=c7GiS2lL1M6QFhZBCgKPDkYwl2twMziOMb01Dd53dkk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WsmptBha/C7ZiTYRMy0eZ4Bqu+I733oaf9RPjmtgffZ3pKLwtljmbCxHs42WN1yljvNJ8uty31vXbPrBM/TYtuuR/53jrICmwfZ1rYFMI7rJNqIXBDVd93NzzGs08MRxfDO1grVxppdBZuErwVvWS945Ug/GBKFvADJ3PKjasvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBx4wSrt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso9039152276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711494896; x=1712099696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6H8BXdvAo3aUwOcUfRSL8bD/l3C7xPsH52O9f2s29Y=;
        b=eBx4wSrtmZq68VqgK8HyyJINFZALDy69C80/CJATLFHUNY2nS9thte8N/CIHm8PRa5
         LmFiSlacbny/sYOmKOswRouqbjQGA0/w1EY1nBFku2EF8tx02mlq7+jZGjVinz+jqoP/
         5qkPVzWcwyyqyc5+kK/B48HXYXmGiAISgDoU8/uK/JcjD/1cqzXg29ktKgkg8I2Pp1Li
         7xqLWrCsT2vphOlhwTveMSkShziEixj4nSkt8EgQUkESkBTcoZUl0+dVW7k1N01te6sJ
         bmAClPCBBpRr2ZTJ9ddTWhWc647oL6pB2Yk7LkRwl8jHRFrm8GBu9kFXtX1wlKGcvn/q
         t/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494896; x=1712099696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6H8BXdvAo3aUwOcUfRSL8bD/l3C7xPsH52O9f2s29Y=;
        b=IDzjHYn4r6DlYMQEZwHkgwvDG0eHYgas0OE2n6b/O56MSgEydHsjbr/ji0b9lzBhTA
         el1gVeGZIYdeTOD//ju5TVE0GRZJzKibHpD+FMH+nuwHooIgH8DX6Nw8tCuxPZzLgOu5
         bqJP9uBRI5FqbbiYvn7vo+Q66siGw/XOWwO9A9lUaKFtv6DO7lcL6W4i+5R+UQ7X+3sC
         cJhMm8V9IOcuNe5wFglgHLpi/ABltM+LPmwAUPSiHPZXw5C+YnmdpJM6B1JtOXlDhl1X
         v+/0zghUcZCJWYzbjA4StApPVcHmFQpVgnNKOr+L/dYfHC8gWWTT4Xp1OBGgP2gBAbyA
         QiiA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYdKkI/LnR0hCpX+g34kvlzw5+rlbptba0ODabkubDruMLS7Y60iFQmzZ+NguM3p3Rw8XNB6zrpuTQo9LFWTtFGQghfzcUq0Qt8sf
X-Gm-Message-State: AOJu0Yz7z+7jRPM1QCKOXJIKtrUKvKGMUGrGiE2xbhaarVVkkESSxyOU
	BsxTV6MnaVLp8qIpFnHstM62QJqiCQ2EXJNTQRZogai7hix2QplYhIfONNDZsyqUoZrZLH7ACNE
	HMQ==
X-Google-Smtp-Source: AGHT+IFNY6tAa+1ToJYyIL+cjp3MvXkNdG2j3VGFzAX5ixmO94loHzofu+cawroQnC+Pi4dXgwNBVtjCIDI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cef2:761:ad8:ed9a])
 (user=surenb job=sendgmr) by 2002:a05:6902:2587:b0:dc6:44d4:bee0 with SMTP id
 du7-20020a056902258700b00dc644d4bee0mr752686ybb.7.1711494895995; Tue, 26 Mar
 2024 16:14:55 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:14:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326231453.1206227-1-surenb@google.com>
Subject: [PATCH 0/6] Documentation fixes for memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, kent.overstreet@linux.dev, 
	surenb@google.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the introduction of [1] kernel-doc can handle _noprof function names. 
This patchset changes back _noprof documentation changes introduced in
memory allocation profiling patchset [2].
Changes are split into several patches, each undoing changes in a specific
patch from the original patchset so that it's easy to squash the fix into
the initial patch if Andrew wants to do that.
Changes apply cleanly over mm-unstable and are tested with [1] applied.

[1] https://lore.kernel.org/all/20240326054149.2121-1-rdunlap@infradead.org/
[2] https://lore.kernel.org/all/20240321163705.3067592-1-surenb@google.com/

Suren Baghdasaryan (6):
  Documentation: rhashtable: undo _noprof additions in the documentation
  Documentation: mm: undo _noprof additions in the documentation
  Documentation: mempool: undo _noprof additions in the documentation
  Documentation: mm: vmalloc: undo _noprof additions in the
    documentation
  Documentation: mm: percpu: undo _noprof additions in the documentation
  Documentation: mm/slab: undo _noprof additions in the documentation

 lib/rhashtable.c |  6 +++---
 mm/mempolicy.c   |  6 +++---
 mm/mempool.c     |  2 +-
 mm/nommu.c       |  8 ++++----
 mm/page_alloc.c  |  8 ++++----
 mm/percpu.c      |  2 +-
 mm/slub.c        |  2 +-
 mm/util.c        | 10 +++++-----
 mm/vmalloc.c     | 14 +++++++-------
 9 files changed, 29 insertions(+), 29 deletions(-)


base-commit: 4aaccadb5c04dd4d4519c8762a38010a32d904a3
prerequisite-patch-id: 1c2be401fcd818b167ef7d506a2fb87fea230835
prerequisite-patch-id: d3c1b90bc5ee32295962c5d30bd79dfb6eb774c3
prerequisite-patch-id: 25e37766c40250d564a0c198e2af01a9aae33c92
prerequisite-patch-id: ed3859d70637371a854c212aa08db8f28edbede4
-- 
2.44.0.396.g6e790dbe36-goog


