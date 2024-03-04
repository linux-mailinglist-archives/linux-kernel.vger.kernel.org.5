Return-Path: <linux-kernel+bounces-90477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD286FFCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60A11C2130E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77059381CF;
	Mon,  4 Mar 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cvhY+2yH"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E0376FD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550490; cv=none; b=Ts+dLyTj4yLVoj2KH7RvXvUzE1ULSw3yxSaz5PpRE1yNQCb6lOUpYHFeXVnTMp35tRYEmAK6rp6c7Tcd6Fsq2VobZlG/j69Ge+9TIIXCobDl+CqYot+FwJtiOgWAjV+l04HZs5yk76zWQFvPUKkBZKWEb/H871oqR+cdRpY4MVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550490; c=relaxed/simple;
	bh=n+ORGLPWsscytBavNsEjXESwpZOPq7HEsk0jq7q66WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H4nLRuOZ810II3WiEXN42yOgrvCkZ/Rp0rtDGsQC5s8H5yWIRB5P/IJ/br+bX0mzl2ZaXMzmKrMeQkkkt7dtasCIornP+lLsYhKEMoma7/dX85mrDyrcHqajmjfk4EGIHAjWGu/hwJoGv3wSX5wFNafyyUndJgiJSaTIFgadKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cvhY+2yH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29a5ed64502so562681a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709550488; x=1710155288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMhY+Ysn3pgkNN53RXDJC69kYsS5QWPZaTpHTXLl49k=;
        b=cvhY+2yHesiOcUN0qV3uWUjlqM1I9LjRTQd9gbq7Te+908L1BZwEtbRliE36NX9nEI
         ctkW+VYyAFk6Kcyukv2YrRHYAgu5oyKVw7XpCdUcWVO3fHCACzwF3H2IopqWreGKF/he
         LlhgF0nNpUeDNNRoRuxwfo68kbv4L4ib/lbyPrd/HkFJFYGqAP2pbu8N5Qw/KJKFl7/l
         LtYSEIUX/U9A7kY/TRt3ERpE4aGlyOu8h+rmwytEIltOJdZMLHPx9p0yDhRT6ky6H+TL
         VYly6+TlePJ9XGHXk+wtYno5Ab2evQ0nDZ5Fzm/KIHDzgiwdfEizp3aBsD4viXUfoyzx
         /FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550488; x=1710155288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMhY+Ysn3pgkNN53RXDJC69kYsS5QWPZaTpHTXLl49k=;
        b=j4bGoC2lLQxt7Y8x2rASrY1o+x+M155M1w8DYzBis6J9mzbd1McdhRLeYLViuLVTUQ
         yNeGXrgDCBznfMIo89o8G9gIiddYLB8AQETmblqk+jZ7WyuVlu9XaHKSLNVz0TQhXR1J
         wDZD9xcdCBkDIIo6YWMiXdINQKooRj8EBrGhx+X9P8JH97j+3KmQ13fz1qo4JHMIwqU8
         CtsBwb/iXowxcL13rB7wjGyQySxoehCNzukT4BiHEXI1brzRUNrhtjk3kDrdbJRqHl4i
         zlRM1CjNt9jsV9u8cH8/6ht3H9TvECoj01VVZ4o5M1FHJP0QGrX3JkFTKx3TztCriM/X
         wP1A==
X-Forwarded-Encrypted: i=1; AJvYcCVOrL3yidmhZeoV05gFyamyYxdg/3OY3tUiV9xgFtdYlO5XLf0IiSyrMG5RZ85TAXkpGDVIYAS8oWv3stbeQbskFEtu9J5W3ehdELtm
X-Gm-Message-State: AOJu0Yy7d4ndYsYK51t4qzhdrqhR9pk0LAX92hsGgQXVr4pkvnpBbdBo
	fUf/RAswoT49ae2eYY12Ts4RpgQ9ILiBnZ9sbByaUOFJ4Dgj0Plj1+G71wKpNf8=
X-Google-Smtp-Source: AGHT+IGOQo94WHV25YlaAOI9/UAmp0PGzV50hgsbaa2czYbAz8D3PyKNmMokKRXChQR+lciYWR3eFQ==
X-Received: by 2002:a17:90a:db81:b0:299:c3d:c00e with SMTP id h1-20020a17090adb8100b002990c3dc00emr6910032pjv.3.1709550487816;
        Mon, 04 Mar 2024 03:08:07 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090aca8500b0029b59bf77b4sm587410pjt.42.2024.03.04.03.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:07 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	hughd@google.com,
	david@redhat.com,
	rppt@kernel.org,
	willy@infradead.org,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/3] minor fixes and supplement for ptdesc
Date: Mon,  4 Mar 2024 19:07:17 +0800
Message-Id: <cover.1709541697.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

In this series, the [PATCH 1/3] and [PATCH 2/3] are fixes for some issues
discovered during code inspection.

The [PATCH 3/3] is a supplement to ptdesc conversion in s390, I don't know
why this is not done in the commit 6326c26c1514 ("s390: convert various pgalloc
functions to use ptdescs"), maybe I missed something. And since I don't have an
s390 environment, I hope kernel test robot can help compile and test, and this
is why I did not fold [PATCH 2/3] and [PATCH 3/3] into one patch.

Comments and suggestions are welcome.

Thanks,
Qi

Qi Zheng (3):
  mm: pgtable: correct the wrong comment about ptdesc->__page_flags
  mm: pgtable: add missing pt_index to struct ptdesc
  s390: supplement for ptdesc conversion

 arch/s390/include/asm/pgalloc.h |  4 ++--
 arch/s390/mm/gmap.c             | 38 +++++++++++++++++----------------
 arch/s390/mm/pgalloc.c          |  8 +++----
 include/linux/mm_types.h        |  5 ++++-
 4 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.30.2


