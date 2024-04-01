Return-Path: <linux-kernel+bounces-126463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522489385C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2695B1F21378
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43038947B;
	Mon,  1 Apr 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H92hmDxG"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D0946C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952857; cv=none; b=OU3FSldrb+FhkI0UHWPrFsaaeKoUBPzEOGQrtUG+CMy1NNQ8UDx833N7EfbQkJL9HXrpWkZTKkMdnHi+oJZZUq2KpCxvr2mfnNGLn/UqgQoWxGlj48AToaAy7csFqOHvnDLh3BQXe//NHe85zDPgVQkIh20MphZdXycvHg5pkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952857; c=relaxed/simple;
	bh=bYen6EInXgg5D07KDCpAr/HoyWpGFlKsSfSo63G0Cpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CW2gv+yMYX4Lh3mVq1kWq6k8sNiN/YyoH9kkLWdc7hQqY0TSL5/0nZ5G1bsvKGkVKG8ng8TsgcGkisejt3SHj9dJq7YOynLZqi1Z163Vd0Ju+Ye/dZXO9VV3AsOW6/SbpOKqhVd9ULX6wNhwd/lXBprQ2Wce3kQXuv5YlfhBwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H92hmDxG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e125818649so1759652a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 23:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711952855; x=1712557655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjntkn8+XAnauVrJHZ4ew0LUHQ2GaW9HCb7KV1S8FAc=;
        b=H92hmDxGl53TVwZ1N4DX3WLQ7g5vGFcVt5zAC6E6QUOZfCqcaXwHvU+xMsFOXBJHw4
         Aio0lIjauGAQ4W0/d/p1VzeX6J+DUaVrElq30uZ2Eh/1wpQh6Zz/jTxtEyGp4gV4Bs4L
         51vehPsCTvxHVWTumyr5cfiOwTDTldcWef66t9cScGXkP1CivhyHAEmlGkbous+vNZ06
         GqGTnNTzBaVdMseViWzyQENmH2RRN+GLTfKzHYK3iuQ5vsl9xlOzViZbiXIhrja5NYAR
         qbcgZc9hGJW9hBMgZ6K4s48nNTExJTch2XbSPYZ6AIPVpvIiyTXQNsQ1uGseLIBUyfg8
         +vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711952855; x=1712557655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjntkn8+XAnauVrJHZ4ew0LUHQ2GaW9HCb7KV1S8FAc=;
        b=pjofJrO7TQ8+kQMskVHrIvRv4mkq04sYfnk1mqQqysrY8Gs4EZlRuoEyoxWigg04mP
         +G3YBJqyINyZnGW8RDlgb2JKpyUjzrprYpR8oawBQQWi/9YFf584x0/VaZhmEzZ3o2H0
         bej1Js58VZwx1anrO7M2FiGs3nmLDVpKCuMXUEzApKDh6agSHLFECUTmeNxro373hKOQ
         pfr6bVPxNAm2JCd712mH4NvxG1/h8o2G3HRmfIBWmKdmVOABYbHJDbkGPvIHSIe+rIfo
         6CG4Zg/dgcx/0T/wG6Cpa87ges8qYyNbPYUkTsNFaktzFvDONhCM6J4OgA3lERzJBjQz
         yIkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTNSz481rHtZorx8xlVvs+lK5jiwOga+laXsFJbecHV7u8gAwYoEb+dSZ6SnIWLDeb+pNVVr0ICj31XB6+Bppp4ZP/ai9sMHEMnV9V
X-Gm-Message-State: AOJu0YxUKTOx46exsiG5u8JycJkw+h1Ws33TxiWuYbq3uct9rmkeR0ip
	PhtCMiiC5yIV4DFRvU8bUQAkHrXaT208ykAxIdBYzyEtJaE59mxVTQBSEAjw+0c=
X-Google-Smtp-Source: AGHT+IHtTIXybRYNrUZK68VVa+sMSpkU4KHrKithTKF/QhaEB/xGeBR8SBmGHIcCDfsAqTKHXNMpYg==
X-Received: by 2002:a05:6808:1792:b0:3c4:2f37:f158 with SMTP id bg18-20020a056808179200b003c42f37f158mr8927497oib.30.1711952854964;
        Sun, 31 Mar 2024 23:27:34 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00038f00b006e6b2ba1577sm7102001pfs.138.2024.03.31.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 23:27:34 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/2] perf sched time -g/--call-graph option & perf
Date: Mon,  1 Apr 2024 14:27:22 +0800
Message-Id: <20240401062724.1006010-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
 - patch1: Add Reviewed-by tag from Ian and fixes-tag
 - patch2: Add Reviewed-by tag from Ian

Yang Jihong (2):
  perf sched timehist: Fix -g/--call-graph option failure
  perf evsel: Use evsel__name_is() helper

 tools/perf/builtin-kmem.c               |  2 +-
 tools/perf/builtin-sched.c              | 11 ++++---
 tools/perf/builtin-script.c             |  2 +-
 tools/perf/builtin-trace.c              |  4 +--
 tools/perf/tests/evsel-roundtrip-name.c |  4 +--
 tools/perf/tests/parse-events.c         | 39 +++++++++----------------
 6 files changed, 27 insertions(+), 35 deletions(-)

-- 
2.25.1


