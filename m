Return-Path: <linux-kernel+bounces-72429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14485B31C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2182843B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33ED59B72;
	Tue, 20 Feb 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0S6vq3z"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A959B6D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411578; cv=none; b=k4xmlA3lbovpSmvMs8YpRN9lqgUGuE/aQn0ZZQzSr5IX94+AYgTepPSuvkmZveRbGZe1uJfWZ5+fSy3Iq+U4S99goQBlAXGqDX5upIiTeV3jA8G1ceTL63QiUQ+ZpWY+SFLbmRMrygcZB0O06oJ0cj0sOmkn9gCXdtU+gJTUEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411578; c=relaxed/simple;
	bh=xaxs0lWzIOn4Z3GjXRTNWVyVIDg5J6BAhDR7/LZc6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPxNlqBYxuhgiY4o78k68abdbyc/DQ9SHwjn7ShdK10PjUhYTBWeeEXdRBHNgcMWh6IhIj/IhBCe7yBZmzPrBgW3sGPThQyBYMEfvyI21s/9iBm+6kmjo1WJtlB8GPQn40VYy/lKXnsdVHweGK3jteXlJ7Id1KvV6f7EPp+k4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0S6vq3z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso34020431fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708411574; x=1709016374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/BRscnS3fYanJSOqXj3K5sJIDzE/4muCWGyGVTwI3s=;
        b=B0S6vq3zDMewjNvDLxd1ZOEaK/F/kocMIZfmfAEVhbqdWkz4byRQCMgxd2Agdu/XTe
         ipi4kRHrL0EXfb0ZlBmdVBtLeFYv4ZObkOdLGfxTFt5uh3OolCmSPZY/H1GCgCBn1OP+
         aimLC6k8Y0dNMJY8SVwY7crmfLgHUF5Wb7qCpTJ1MSOl0x2qsJo4CrxXRt2MgdW4julJ
         PyGSuqsIIBjHL81tSUhcaSH+UxqY6Ap+sbEoEteWHgNPqFNAs/9wu0jyLy/V4yC4Cmeq
         GrwZGLknCtm5dbiRyqCZG94WRDKefpDyoxgSwFgEN9UDZ660Gx+foMT6BnwZyD1ubTuM
         OmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411574; x=1709016374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/BRscnS3fYanJSOqXj3K5sJIDzE/4muCWGyGVTwI3s=;
        b=S10jl4XFKAoRNBBB4M4tyaSzM4lTcH39N8AFueK0jDS4DThDSHzvix/AE7gSMdj7Lj
         r1bSqwhAXZC8bJ3GQH9WnuxYDF9R5ZjLKNXTAo1SkmIJKHlJSFgI3L31uk62UKfbkOvG
         PRkfE0sQrq/F4YDV0NlpwJctEj5lCEkZEtEQ8HogkMOh9f7WYJGlA6gtpMF7pvpRAWiI
         QDpmIa6KJR25RQswGV0Cz1EV/pWOSsoQCUXAEAQIaMfX0EWavaEVvZPZrUGPLzjeG0Ce
         TJrD3SNpc8YhTfb7Bjzf0rIqZ1xGu4+qW+WhWqTbqoOpOekYjck8wy82z2rWMPrEqudk
         YHSg==
X-Forwarded-Encrypted: i=1; AJvYcCXtHKbrlzrkuHhbCk/U3pD3dfdHK+4Q32jM/OILVEbfUSHD/qAUR+E/AtuYzdb9KMW1ivWeAmnicRTYlKXKE8D6pKUI+yhCMfjTjsRS
X-Gm-Message-State: AOJu0YwjOiHl6Q3JUBzIf/Ag4u6yHKnGJLeZlOHoRCfnQg7XjzSfG1PN
	9p/htpJk7CHSVgG2+KFlYLEnxmvSZhkpg1Ou8I0pP9zehb/jGKTnt/wHX9i3
X-Google-Smtp-Source: AGHT+IEfBGquY4nS2OoxFXQ5kKCT/rbDoRFQo/AADoSU/aJ2in4c+ey3+AznijE+WvZPEdsljhAWWQ==
X-Received: by 2002:a2e:9782:0:b0:2d2:3d31:21fb with SMTP id y2-20020a2e9782000000b002d23d3121fbmr2808634lji.22.1708411574131;
        Mon, 19 Feb 2024 22:46:14 -0800 (PST)
Received: from lucifer.home (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.googlemail.com with ESMTPSA id t8-20020a7bc3c8000000b0040ef0e26132sm4454281wmj.0.2024.02.19.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:46:13 -0800 (PST)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"=Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] MAINTAINERS: add memory mapping entry with reviewers
Date: Tue, 20 Feb 2024 06:44:10 +0000
Message-ID: <20240220064410.4639-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently there have been a number of patches which have affected various
aspects of the memory mapping logic as implemented in mm/mmap.c where it
would have been useful for regular contributors to have been notified.

Add an entry for this part of mm in particular with regular contributors
tagged as reviewers.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6c5c92e49db..129a237b7880 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14121,6 +14121,17 @@ F:	tools/mm/
 F:	tools/testing/selftests/mm/
 N:	include/linux/page[-_]*
 
+MEMORY MAPPING
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lstoakes@gmail.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/mmap.c
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.43.2


