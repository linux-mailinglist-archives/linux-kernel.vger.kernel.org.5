Return-Path: <linux-kernel+bounces-86208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A486C1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D5A289C91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ACE446BA;
	Thu, 29 Feb 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="dYmPl4IX"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6239855
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190705; cv=none; b=B1zRZ10nyPufhKYLr3sA1iasZQRcO2PFm+SOpQkfPeOZRosI5yRTCD3PlkAUADeJ34NHPmfb/HL/fJpcTXDDdtE/7ecMchoxcXmyJXRD8sLl5aipBGfwECaGJS5mC2F9KeECVH5w2oV+3FXzoh/onkucARz2WvxaRVQE5Cs6J/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190705; c=relaxed/simple;
	bh=7vAgu6TBZL7wP1Dtd6yaFXTUrfrzipiuyuEYGbCV1P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LpZgcw5z0FcT/ozGSUo0DCZ3X7yj+r4djImJuqbEOZKLZl/9zfPRJq3EWj05y05hZsTSM+/GCbjXNkmJyboKaHJBTvq8w70s9mgzyNaC5fFxqheRP6Sk0FdCGPDm1uEYkg0HO7NDTGT3P/Fk3x6OEQHozFlJiCW0uVj1HZUyoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=dYmPl4IX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5e152c757a5so365658a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709190703; x=1709795503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xkvwofC69rUn+/tUb8tSJSWKoL6A2axBP8LYZRaIO0=;
        b=dYmPl4IX441oFZYR0DhldlECYDULQS6hLSVzx2IyRD2hSfhuANctbtHHnokgsia/1N
         IGb190jZHU88vQRp2B1VW7bWmwM4KPdRB+zCZki6QhEMyyD4VDGCvKa1Zqh6Ht4z8won
         tV+Q0+dFSTLAzrTk2aB8Je9jKtMwwIikKTo9WoeRNF6aHfKWbOVGt3jHolPwLvNDjUjM
         TCZz13AghDTniQ0UcvhzpoJ8A/9qkDfaKMLM93aagjdnSowStUblErDnA35UpG+gIFNM
         HrsqWbKzOqJxPzvhRx3t2hOOqVPOf0xgyk5HG4+JqXrdjtQnTQ7GBWcXJa1mBGeOtjk7
         7WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709190703; x=1709795503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xkvwofC69rUn+/tUb8tSJSWKoL6A2axBP8LYZRaIO0=;
        b=PoXA2cjb+ACSXx7mYnhXND+IdpecwN6ZF3dbJbf6HTRO5ecJE2wg8El9p7U4KYiEA+
         KUXbWKsAfAfy5ggrQpyc2Es1hN8DKvU7aXt0GTn7G5d2x77DWCU+1hyybSMeM+h9ktIV
         +cLRIIBbAM7Sq/SPV0VF0LUFHB+YifRyW4N5RXHUg65sDrCedG3w/FvnJbLJkkGVaBZj
         cbjca75B+QU1En6S/kp3jNFA+M8N7BUXctud+25mUWbrE81/GC+u3W+1Pg+E6jW2I4h/
         2538GDh8hbJSn3T0njzt2CCn7c1TGsJ9/SY11zl1WEXqG65I2FXUOv8qivQ23o+m0m1w
         7IsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+ZzAgaGVBpxgoqK2TP8tugML3u4FGpbX0p21TdbCM/77UvPyoYIVyfhptD2RD/YXFuQVFVF2rA8Q/iDCIObjQafYjQM2OUnw0MbG
X-Gm-Message-State: AOJu0Yz2P3J4jIglgAXf/RhtiMuDqofgy22PsKvBEIjUH8qpLzkfDS/8
	sZiE7nqyHIdfeUFmlE6GMRWIl465cWJzdPKJEVKmwy+Nm7ZXD+UeodlFDA3jYMk=
X-Google-Smtp-Source: AGHT+IEQ2H0ctLrhNW65UhI/DSyWp0KM/Psk2LhoPNH1eSLgOJSdJDUzp4czSyjdmhJqPxdJFvn9aw==
X-Received: by 2002:a17:90a:49cc:b0:29a:9952:67b7 with SMTP id l12-20020a17090a49cc00b0029a995267b7mr1299423pjm.48.1709190703179;
        Wed, 28 Feb 2024 23:11:43 -0800 (PST)
Received: from seacloud.vm ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id gg12-20020a17090b0a0c00b002995e9aca72sm691659pjb.29.2024.02.28.23.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:11:42 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: james.morse@arm.com,
	fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo list
Date: Thu, 29 Feb 2024 15:11:23 +0800
Message-Id: <20240229071125.100991-1-haifeng.xu@shopee.com>
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
- Modify names used in the new tracepoint.
- Update changelog.

Changes since v2:
- Fix typo and use the x86/resctrl subject prefix in the cover letter.
- Track both CLOSID and RMID in the tracepoint.
- Remove the details on how perf can be used in patch2's changelog.

Haifeng Xu (2):
  x86/resctrl: Rename pseudo_lock_event.h to trace.h
  x86/resctrl: Add tracepoint for llc_occupancy tracking

 arch/x86/kernel/cpu/resctrl/monitor.c         |  8 +++++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 .../resctrl/{pseudo_lock_event.h => trace.h}  | 23 +++++++++++++++----
 3 files changed, 28 insertions(+), 5 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (59%)

-- 
2.25.1


