Return-Path: <linux-kernel+bounces-143519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81DA8A3A77
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72765283F96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DF14F90;
	Sat, 13 Apr 2024 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmPqeiFf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDE4C80
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975052; cv=none; b=KxTlwZSc7y+TteolLjwe0PelQuvsxdgZwuhIhlLYZtqj/lmVH1G8sPKSR5imCZKMBB0ooxeNdDmNyo5A5ADEzEipms+niq4nR0Tob5T9RIsnC77cUb63ZrfwoMPvUcmIc6ccO9XF2GR9dnFpIU08f9UkAxOY/+L7GGtSpfbHAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975052; c=relaxed/simple;
	bh=iOuKaXJuXWe6FL9V8ePoXz1jCW0Xp65IYVi+GkNqZ50=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RHMSgWMjwj+yw4vVXTFNGEK+ceRPs3dJwRRLYje+uJwUjyBhTHHAlwg0MlhaQoILEVjJJG+gWDRMdjaeQIPNUiJ76vRBUcHMiqamQ8zKWPeGEPyp4ylmQHY9Pg3fN5vhEVY66HNc7uGtr1GVv1LpTc4g84054+MyexR//Z9P7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmPqeiFf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd1395fd1bfso2657453276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712975049; x=1713579849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFFGQr1pf14z9aosyZeKotH6cupQu6AQgo5orkTHue8=;
        b=zmPqeiFfI7WqJygbbMsDDM7HMcePRgO2UMazIUPq33pE6u5krA8AeS0G0TUUpObsbd
         jArcMqN8aRK9DMoR7wO6Pxq9+BVjmH4bvKJuaMccigpopwn2mKZn9LKznECSut+siLcK
         dGYyFFcJzXDsa/qmTPcizfMv5xmImDfrHCJNqzITZkA0jCFKBqgDn+cWzPEmcEs4pp4s
         gYQaWCwyrIfWN6+JMpOrVWwQSl/kfQdQ+Qo9jyYxeeOxnEij81j6vNfhp36i2P5/ie58
         Ua0XuF+nvhfpOq4gJftSfzwVK4iv8rtiSW8Zwl49+gxKT7hxATxZZDS/7H91tDFXxQOX
         Rl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712975049; x=1713579849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFFGQr1pf14z9aosyZeKotH6cupQu6AQgo5orkTHue8=;
        b=NNSKUiWBgoZkvyZxsLYrpbUQ7H15OqPjJ69f2MmLoIm35eRG5ImsX8+7YQizTaMsQq
         wu18xh1IxVBFrCnFcq+oOwQwnDVCxycKQP5lmJBKoquVw5BCha1T0Q/XtchIQoKppUrD
         T2LjmcB8vVZhoOakDMFqeCGpoqd5SKTemKO3OIGA4MFXPxxsla5pYRH5HhncxIZddPSg
         cvQpKsxPn5vlxHMde1KgabxgTxCQ+DKpsao3kv33YyFPgJEeaoKsPXRNTRMn+L56+jQn
         QfrJJzgjmLbOA34OWNp5VRFQjQppMeVQmwzanqj4yc2VNAmxQwxVSNFmi2oO/Oa6rsTJ
         WuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz0msoCnHpAYYaiio/KF/RdjFwQYvV0sKnedM2ZPBoLyF5pokTysjc6K+0gwRQNgeV+/Qgrpy67376Yh4W8/lhduKvHej4qxwQfSqa
X-Gm-Message-State: AOJu0YyGZ9yNzlCr6VleAGPKJnHrVnY+jTsKXm2zefmpWtjrGfr+joXp
	l4qGqhSJg7Yt6EIWSpm2vIrx2Yd62sdEvrVqJMXwbAc7mPQ5x40+BlEKtZO/uR+zCNNokUORWvk
	CvGRHOg2xL1dpPVtQ1A==
X-Google-Smtp-Source: AGHT+IFRiWASJIbrkPdJYq5ZC05q0I8eCLRx/z5+EwF9l+oRPIVuyPKm+SFly7alar1UZwBBx/JXKNlwjQJfbCt2
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:18d5:b0:ddd:7581:13ac with
 SMTP id ck21-20020a05690218d500b00ddd758113acmr1288518ybb.2.1712975049669;
 Fri, 12 Apr 2024 19:24:09 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:24:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240413022407.785696-1-yosryahmed@google.com>
Subject: [PATCH v3 0/4] zswap same-filled and limit checking cleanups
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

v2 -> v3:
- Dropped "mm: zswap: calculate limits only when updated" patch after
  discussions with David Hildenbrand about the complexity of adding
  notifiers for totalram_pages changes.
- Restored "mm: zswap: refactor limit checking from zswap_store()" to
  the v1 version, and addressed Johannes's comment about deferring the
  call to zswap_accept_thr_pages() to avoid the division when not
  needed. Consequently, dropped the Ack and Review tags from v2.
- Added a separate comment header for same-filled pags in patch 2.
- Collected Acks and Review tags (thanks!).
- Rebased on top of the latest mm-unstable.

v2: https://lore.kernel.org/lkml/20240405053510.1948982-1-yosryahmed@google.com/

Yosry Ahmed (4):
  mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
  mm: zswap: refactor limit checking from zswap_store()
  mm: zswap: move more same-filled pages checks outside of zswap_store()
  mm: zswap: remove same_filled module params

 mm/zswap.c | 98 +++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 57 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


