Return-Path: <linux-kernel+bounces-90094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9686FA43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28F4280ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6911729;
	Mon,  4 Mar 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ORR4JJ6A"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7AB667
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535175; cv=none; b=APtmgPGoSiSm2Tv1hb7UsaL9okfWyKYl2YIgCENIKY1UYQsA3gVxSKq4FUQn1Nbsy+Y+DPWBePR6gQ6k3Kxfqul0xBDkOz0i3x4YiAGDYeADk5keAJgZxpt21A1onYvv9yXiywdPr4ivYQBCBvL+xtNMCl6wCQuGLfBnEJxqR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535175; c=relaxed/simple;
	bh=cSlPucFtajFoSvNcpLUmF2ZoHtOq7wHrm8yvp8wylmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ovKbcB/ZDaRMtFhRSw3Pd1CBQDKvcIJFIxiarYiEikabgu9Br+pRsF6d8zatGQQT5hEBTFdL2yv1/UffYWvfWeXi6K+prWzcIxIbfxL5uzptG+kuqcKvoS1hFTKldHCsOQhYAYP6B1/EkoXVwrT+88OuUKk//oqfER6NPsui10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ORR4JJ6A; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5c81ccfb9so1570792b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709535173; x=1710139973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erMBjTI/jIfumSA4fKbj0G6FlmHUlS4W5+VpSdb/r1o=;
        b=ORR4JJ6A38Tr9HZmLj++ivypmmQwkQbIrgEhHZ9Qho5f/aIKe8xUvZY7SBPQADfVcp
         NmRnGtM0S0V6zyXwHkxFttipCNJ1HzE8ZzNOlOGHpSIWZy/Yo9i1WRyPWevmcv+1d/Cg
         p3tbtABFdmTyMETglejlUgvp/7KfoQ84Q3HBGtv+23RoyEV0wvKaEODsh99dSkGKiu+W
         41kdu+foWfXMPRhCEql4C1C8ZPFFn9goPp/QGuu7C7T9tFMl23+7r6W3Zvq1lWr0lqMl
         43JvEB2vh0TrBFomFG7hLl48Kw56EnG9qeAPy4nskJYu/sLMWx6LUYEUbJ+PTyo/dLKE
         6LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535173; x=1710139973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erMBjTI/jIfumSA4fKbj0G6FlmHUlS4W5+VpSdb/r1o=;
        b=rejR6KwWqd8mopX/xS95ylmOmnJmkNgu9aMPqGfIX1PkOGCciUb96Mgu73Uo4KlMm2
         YWXhv13nJI9oy+OodH/ZzaakZoig2vtdXD3xwnPH/paMtzbHSiSJ9XinCsevamvRI/1k
         uyYISi/Paco8H3MqASEf8GlZRuM77/BqAoagS3SsWkIqYbpCRu4pq28FeIwKMGc8UaxL
         a9mHhyO22uiU/Z2XkUfQmyNDX5MjNsXiQXLNEGSMXIfWcGLi2ZlwjVlN6kWtEQ5q7/sC
         1DdJJUgjkTnyT8CfotD/0vlZpVWy2DQQjpmsesPXpGDYVp8qtpB277IG8QU95pV+7J6g
         6nGg==
X-Forwarded-Encrypted: i=1; AJvYcCXWNrdatHXCPydxv60uRmFdL7yWyb61AxzxPCae2x1hQyZ3bMdOTkHCerMXZWcf8uIIRHJgxXYkz41m/kpG6mdSHnQT7xsLaPYEqtAv
X-Gm-Message-State: AOJu0Yxk1O4P+HJG56xk3fZxqH+nPIDaNlf/C8/eys+GiDyzBEilap4s
	lfc53jobLVA4H3s/WxXdLOWZ+lHKm4kH0xhwqTu9bbqwyVxV8H0F4zHHo87KTZk=
X-Google-Smtp-Source: AGHT+IEVKymbD8p/sRwY6mMMXGR6xSlR8jN4wA4xt/CQiCmU19Y5TivGbgi5ZYV+OqYtBkEA2s29Ig==
X-Received: by 2002:a62:c142:0:b0:6e6:fe6:3db0 with SMTP id i63-20020a62c142000000b006e60fe63db0mr2023369pfg.23.1709535173272;
        Sun, 03 Mar 2024 22:52:53 -0800 (PST)
Received: from seacloud.vm ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006e4766d31bcsm6554740pfv.184.2024.03.03.22.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:52:52 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v4 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo list
Date: Mon,  4 Mar 2024 14:52:34 +0800
Message-Id: <20240304065236.281877-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing a monitor group, its RMID may not be freed immediately
unless its llc_occupancy is less than the re-allocation threshold. If
turning up the threshold, the RMID can be reused. In order to know how
much the threshold should be, it's necessary to acquire the llc_occupancy.

The patch series provides a new tracepoint to track the llc_occupancy.

Changes since v1:
- Rename pseudo_lock_event.h instead of creating a new header file.
- Modify names used in the tracepoint.
- Update changelog.

Changes since v2:
- Fix typo and use the x86/resctrl subject prefix in the cover letter.
- Track both CLOSID and RMID in the tracepoint.
- Remove the details on how perf can be used in patch2's changelog.

Changes since v3:
- Put the tracepoint in the 'else' section of the if/else after
  resctrl_arch_rmid_read().
- Modify names used in the tracepoint.
- Document the properties of the tracepoint.

Haifeng Xu (2):
  x86/resctrl: Rename pseudo_lock_event.h to trace.h
  x86/resctrl: Add tracepoint for llc_occupancy tracking

 Documentation/arch/x86/resctrl.rst            |  8 +++++++
 arch/x86/kernel/cpu/resctrl/monitor.c         |  9 ++++++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 .../resctrl/{pseudo_lock_event.h => trace.h}  | 22 ++++++++++++++++---
 4 files changed, 37 insertions(+), 4 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (57%)

-- 
2.25.1


