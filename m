Return-Path: <linux-kernel+bounces-166851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F4F8BA0DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D041C20DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3779171664;
	Thu,  2 May 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARYplwbx"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7969D2F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676555; cv=none; b=UjKEdPyLaSGt92jUZ1IX5N8FodJqCPEVK2H4kPuyJGnU8nohSVSeGLKPW0xH6kCaFIqibc8bRJadHjNaCimvGF2qQf84TKYvJ+zI+US3dlypMeZprTX/MllfvwSnlSLnt5BK4LLKfwd9dIxeD84E7a/WJOZZfDrze8p4IANaSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676555; c=relaxed/simple;
	bh=dKAP99POAqyYPnhFZYywVYbkmuWguwDT00wJFjQ2YmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2GxXxXIOwegnlhyGwPZ5bhiVCzTVwDUivFBN+KnHB7LZ5VgN9MZdttpYVWVt+4bseGjmgHDK4rsHrUWFziPtbSswkRf4My9uKbDmiEsSqQOnzwKbiBb/repcUQt/85cZMku8zyKYJmzVDyDVb+zbekERoFEdnNpy2eNU+/9YNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARYplwbx; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22edbef3b4eso2185470fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714676553; x=1715281353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qf43ccYVyZU/hXzDBcoEbEvMHvQfl5Mx9Lbcsd/pruo=;
        b=ARYplwbxL1/q2pl3zjec7o/yXISUzPYCty4azijDe44SEivALReaJ4SlJOcxcogvsZ
         gD/s8D1YWQxyGKb1VXmQ2znQmHlLACG45UyLCE3uI2zIR8JwVmft5aRC1FMCW6AY0cy+
         48rAi07MH+8I/QtHaAWH6n8I8+5N1GOcOnxOYb8NT0Y4wzLVQFg224IBpk/forzpdNFa
         tQz5XkaJcCAo/3wiNs0uwH0I3bKsLZhYqi/dVbuX8cCsGrqjCtzLXFieqs4B/QJh6p92
         FLpPsfw/ZWpMHKUdNC/0a+QgVEHimr/9n7H0wEgkvMFsOfC4RFgqUVg366FfPQiCyWMP
         N2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714676553; x=1715281353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qf43ccYVyZU/hXzDBcoEbEvMHvQfl5Mx9Lbcsd/pruo=;
        b=xTZirWm5lH/2DKjbya0Rc9r+Y+2Jj+1VxtMFRiN36w77qPDTmUfYNlDVl9VLbFjB0p
         Wk9v4uoyUBdOsuazN53VB3DNiGErR6DIgNiZSvpDRJ/YPGrzDgxUd11ZUCo5jM0iCTbu
         7yb4NX9ZAwZ1i9U+qGinzwJo9/7UWDyaDbhD9p7GRkwiPjV3MYt0ZUugVx4LiLH3PXrc
         iVFcZcn9FNtf82arqpoj18vYL/UiBS0iSdIzW5ouIR0FjxZlXzPRiGwdPFLLFQZ0xlXz
         bsCj8pfxvsLHNNrTq9g15niTNX703QK3cd7zZOtn9MLq2BhW7mpRwI/CKies5geJE4YN
         5afw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Aoq8KuIfFF47P7+LgDLXyZDQ4SeHzmXbmdGw0Wy6a6qkt3eDtoSt7QvM9z0mP6gIU/1AUwoH3rFJBPXWo/5XDjsRQDTnKBtIcAsQ
X-Gm-Message-State: AOJu0Yxub1pO62dRUGqXbtk+PWCTldUniDmznDrxzcOaEAGVn4xlRGS8
	CSAiv8pqGi0785eupkuLKH0ZTxFQJWyaooWbJoTUaAA5PfbjXiFW
X-Google-Smtp-Source: AGHT+IHQonnV7qf4zQta5DKOum4m4xQJrQRdDU7HjUbtZXDq75nTIUuZUVsX3yLdgHr8DBB38OcouA==
X-Received: by 2002:a05:6871:891:b0:22e:d20d:1274 with SMTP id r17-20020a056871089100b0022ed20d1274mr901952oaq.9.1714676553085;
        Thu, 02 May 2024 12:02:33 -0700 (PDT)
Received: from localhost (fwdproxy-nao-009.fbsv.net. [2a03:2880:23ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id gb13-20020a05622a598d00b0043b15618a4asm728294qtb.39.2024.05.02.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:02:32 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 0/1] cgroup: add tests to verify the zswap writeback path
Date: Thu,  2 May 2024 19:58:36 +0100
Message-ID: <20240502190223.3975970-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initate writeback with the steps described in the commit message and check
using memory.stat.zswpwb if zswap writeback occurred.

v1 -> v2:
- Change method of causing writeback from limit zswap to memory reclaim.
  (Further described in commit message) (Yosry Ahmed)
- Document why using random memory (Nhat Pham)

Usama Arif (1):
  selftests: cgroup: add tests to verify the zswap writeback path

 tools/testing/selftests/cgroup/test_zswap.c | 125 +++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

-- 
2.43.0


