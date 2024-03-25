Return-Path: <linux-kernel+bounces-118122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EE88B431
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0576A30131B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626EC7F7CB;
	Mon, 25 Mar 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAx7irOa"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B075817
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406024; cv=none; b=pG/i9uQfYsZ3emG/+2ybR1LiqrVbrKxeRoE4Vx8IlP7Hlz0q1bYW55xGe52NEJgjtgBqToxHoSk/TAiBE153H2J9rMfhp+aeJyhsk0sCQ+uTJaba5HK39rU9Hf2Fe/xfsgRhqcIVZYEe6hdXCtRRCeWu7OQLR+GqK0WdD9NFSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406024; c=relaxed/simple;
	bh=wstVDNOMQJ6gD1/2p2zgvI6ExDF80DIDFmUjwJMtQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmLFCZG4ozpSKdWfQSA6RykQWTIFTECDA9mRKVuDKjlO8UfG8OI+dOSRE4xFUREOBBOnEXPSFlujyIVZtzHsTWi5uA0lnKOALnIarRtM8iwpfVRHTGw4yqJ7qbw+9fdtPkTTK1XJNMVnqchp2P+aEuxce1XrrlmQOP7CliwbiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAx7irOa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so3878480b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406022; x=1712010822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VD4oe+80eJVWnx27kOvIUdEBx7y5g59wZUAd4Optrlc=;
        b=PAx7irOaUf5PsMzwWVx63oa2CTkJlbR3u0xk8Sid+RiANcUQSlfhe9GyTUzNZ7qCiu
         XFQpEEKfsTaRCmnDyn0zXB4qIcF46LbUtrDygBRuWWAp3lz8p+o59W5A3Cz0PXifqxxT
         sdNiMGAE62UuPVKKG3UEMoCOc4mpGelv7Z1x6LL9YvXkFJYpToqliAiKZhM7crQFMH1B
         CjNuY54ZQYy6dUGX+mp5+mSi3UUF9fGm/iTFFgZYQWd7lE24SjFOLTd2E6DEtPPapUot
         yhqoZlA+6ReeFv4C04n2a+Uhe/2//rG0D0qiW7AfNpKVi5+mtbf0mBU131ya1LW4Zh+2
         ejPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406022; x=1712010822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD4oe+80eJVWnx27kOvIUdEBx7y5g59wZUAd4Optrlc=;
        b=WUWmnKuYujgeL+U2oSYyzPg+tmLqS2ALNAk4fdInDn3Sy8uAvYnIpXbe55ZamRCcjG
         0Y4C15jt5NVeXSw132za5kAln8I9HtG0FW6vq7yzumZ5HQ63PI7gUP8wuOjxiSzADCLU
         bDuJcFH+rc8ObEkpGrYH8Zli9XVmq4AQdWrIoK7R6l8ZRPnwmcxMpGRhjJAk4PX+cQqp
         QwxR9MIsCghdEvtu1aijVRCDuYNErWoL3n6neZDP29sOQK5btuLUsHmsO003MadYh8Ba
         tsQ/w/j1QXy1EKZ45ZgTkzqer4b6zQ68kQV3xRgif6VO6r1oqgYdweQvtjP90HvU4lgA
         zA2Q==
X-Gm-Message-State: AOJu0Yy9wTSoPB54WAHQfArLR4ugw7CZHDOvhNYJmSqyoy9AXl1aaU2k
	6P4xdYCecG6LSbf6YNH0vbxYFPDA8its/4K803AP1UJCGMcC7oUL6S3EKB24Rho=
X-Google-Smtp-Source: AGHT+IEDYI/hEO/MH4IBp96JDUp7EjME5GHbJgaaCt8BBUdNxjDO4g1LhPY7HkHrtHC8PJ0W+nCrng==
X-Received: by 2002:a05:6a20:d90a:b0:1a3:71d4:cf3 with SMTP id jd10-20020a056a20d90a00b001a371d40cf3mr1244255pzb.59.1711406022485;
        Mon, 25 Mar 2024 15:33:42 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id sx16-20020a17090b2cd000b002a053cdd4e5sm4356173pjb.9.2024.03.25.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:42 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/5] Define struct vm_fault in handle_mm_fault()
Date: Mon, 25 Mar 2024 15:33:34 -0700
Message-ID: <20240325223339.169350-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset converts the hugetlb fault path to use struct vm_fault.
This helps make the code more readable, and alleviates the stack by
allowing us to consolidate many fault-related variables into an
individual pointer.

Defining the vm_fault in handle_mm_fault() and passing it to
hugetlb_fault() and __handle_mm_fault() has the additional benefit of
standardizing some variable names between hugetlbfs and the rest of mm
as well.

Vishal Moola (Oracle) (5):
  hugetlb: Convert hugetlb_fault() to use struct vm_fault
  hugetlb: Convert hugetlb_no_page() to use struct vm_fault
  hugetlb: Convert hugetlb_wp() to use struct vm_fault
  mm: Make pgoff non-const in struct vm_fault
  memory: Define struct vm_fault in handle_mm_fault()

 include/linux/hugetlb.h |   7 +-
 include/linux/mm.h      |   5 +-
 mm/hugetlb.c            | 228 +++++++++++++++++++---------------------
 mm/memory.c             |  87 +++++++--------
 4 files changed, 160 insertions(+), 167 deletions(-)

-- 
2.43.0


