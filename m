Return-Path: <linux-kernel+bounces-118471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7188BB71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6705EB218CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7A132489;
	Tue, 26 Mar 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2trDSC1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94112DDBA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438699; cv=none; b=GKgGKO9opS8AO/I9T/kKneHqRkOfypNAkUz8grzfvgx5KqGxJx6+HbiJNvIpIj9WgmYlh8v9her6EFySz2ebUlTHav9A2cy9a+xp8fssfzKGD3GsoWR4QxjPMHNcdN+0CBx6fKqWPkPSprvkZHUfOSdSCD9vF3R7SqWfEYkERS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438699; c=relaxed/simple;
	bh=9XJh0CzYDWGiCksBgfcLCO2dZJOCVan0S7tu1cQ1viw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mbV+VYcJlyPrLxu3Cw3egIvgnO3Qe+AF+YGvmMzwtbhLYFtp0PU6VrDB1872uWorxm5fJHxGtE3i1F2xiZWZioPmoJ0XnYfjdsDt9AFk4h3XbtnDBWkL7fjhpUFWpKzcXs16DhckYFhD/Ar55kjY6XdpiJuZCIKuRBQ49w8t5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2trDSC1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-611e89cf3b5so5046847b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711438697; x=1712043497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egxD8lhrCUbXKjoayD1s0sEl15YwV5GNDF5jJ/ZQHhc=;
        b=v2trDSC1H8X7t0d9eLGNTIX9pt7wsP2woiJVBvxY/WkoDWvx+INkFeP3jl6XzplKf1
         HnEK1PRaAqundtnPbKUajH5/6jNzxumXfz3/M40jnG9SrMzkMEgb6XmdSeJLtfYYvedn
         B3MCp0NJA0EBEN2aG9pl4TeWC8aURawOiQa6as4pRIRa1wLOxYraSQM4fX3PDiJ9vyX4
         yqyUhpRflgJQU5k4PIfLua8kWBTAS/tqNHcj+khJDvnvSNzE1U94Vh36CpO5vs8Ewf2R
         RNcbigq6CeHIM6Pq3eskPyReQm6BGe2iFM5flzS3PKphiNPoz7G2ceW4RN3yV90W28ZL
         FEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438697; x=1712043497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egxD8lhrCUbXKjoayD1s0sEl15YwV5GNDF5jJ/ZQHhc=;
        b=hSgAhTcwqQq5LqCUn6ZiQRINyVtj4nmrmVdpoe9DVuUJcV27WKDZHSg96PV+i9iu31
         VfibtzJ+xBnGNETIdd2Rc5NcnpHUv8/dS1sWOhvNgUga3McUjwH1ROVxay+8LpIepKXC
         bRuaGo5Ptv2AW3g21m6aKHn6nZPjrTX8eDrbyySmjk7043ARQqdi9e2JcCK3OrPrr2io
         ZQtJ0bmjg0VjF3gxX0ENYJjB49n+6qPUvwqMCUcM6nc8yt8/XFUxGdtkh/bHAzsn7RjV
         o7qHUb4igSk49l2P6oVMs3BOEJG9ue2ND6iMIQJo2ayQRDQ4upCwCaqXOGpyhIyB78fe
         edqA==
X-Forwarded-Encrypted: i=1; AJvYcCWlmP0Fhxc5QGyGs8Z4AIi28rBTplkA/2yxDQyVDxt2ooxYSEqP1CopRsGO9mlA6tc6PU2RJc3Iz8FBxC2LX/u65/ZBgvqYTse8t8Xu
X-Gm-Message-State: AOJu0YyB0G17zvDOV0zM+a1RxRWOd2F3yhRbEthnylfRpl5U3RAGUSxM
	TV+whwkQ1wLHWh3AdQWiB/WzJuy6liQHa/Z6Mvz/XwzvRhOCUVbfaYNLMA72mifiRbRb0mZedJ8
	8SQ==
X-Google-Smtp-Source: AGHT+IEd+5GPQZQNt+Hcw0OMk85Ig7li+vYOFhowC9mcnO8i7BoXvgnyYvR7c53gQ53uZs3OxbGiR0BbG+w=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f77:52ef:ebeb:2cec])
 (user=surenb job=sendgmr) by 2002:a05:690c:7303:b0:611:9c16:6cb8 with SMTP id
 jp3-20020a05690c730300b006119c166cb8mr531299ywb.10.1711438697064; Tue, 26 Mar
 2024 00:38:17 -0700 (PDT)
Date: Tue, 26 Mar 2024 00:38:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326073813.727090-1-surenb@google.com>
Subject: [PATCH 1/1] Documentation: fs/proc: fix allocinfo title
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, surenb@google.com, 
	linux-doc@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Fix "Title underline too short." warning in the documentation.

Fixes: d08b311b6d49 ("lib: add allocation tagging support for memory allocation profiling")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/filesystems/proc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5d2fc58b5b1f..245269dd6e02 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -955,7 +955,7 @@ reclaimed to achieve this.
 
 
 allocinfo
-~~~~~~~
+~~~~~~~~~
 
 Provides information about memory allocations at all locations in the code
 base. Each allocation in the code is identified by its source file, line
-- 
2.44.0.396.g6e790dbe36-goog


