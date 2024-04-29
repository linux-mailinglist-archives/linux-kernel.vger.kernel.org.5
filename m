Return-Path: <linux-kernel+bounces-162962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C28B62C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634441C20B06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D013C3CF;
	Mon, 29 Apr 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0Xozhv9"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CE13B2BC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419827; cv=none; b=SwcV8kaPGRF/qOGDfrE5HKfqfOeSSg19zDo95ZbdWjNalzz+cfOKQ0nK5EKoiXGE7+HDY+2xjzY+x2OeDTlWUdhnZIrwuQjqFP3w1gYmnCfZZ4rM3lTjQxVP7lxC/41yhmQ7MGQHpRFO3uZ3m0mIeAJah/WfoC2E4kOxdmkw1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419827; c=relaxed/simple;
	bh=VIy9QVTN2qcxjefTX2tH+Yz/iQIFnIJTdKGucOLxoMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nRmTz+ky5+/BZx6f69RAVusNcwy41GJYkunC5YJblBU31Ytm2q06+hO4qLfeTM3z61iSSUoNDs3zs0dR5rGGOuPzdpjwkd/eIUJLYbENbDOOZQ9zqT2NAzhl+GrpTLpxVY/8u6scYDSv1e63OrHyHLdl1f5kHRriEMwRZ6zRbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0Xozhv9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso4381729b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419826; x=1715024626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKDr4fJvmSW109ZvoEEynaQf9bTi64PsX/IPJzqOlYI=;
        b=P0Xozhv9RS37ym5xZoGikRXXzF6BUvw0DwbemdHtvrjLOJqiDY4GPt88PKHzzWIR+Y
         j2aeg8Y8PnXxjiUdM+M3O2ZgXDoaqZl9DAZOUoqOxLFuXFiI+HVbDrbhnOfbHnJsT0Zl
         wTSIFhO0ITK8YcwFbumzZDus+C8g07vF/jloo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419826; x=1715024626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKDr4fJvmSW109ZvoEEynaQf9bTi64PsX/IPJzqOlYI=;
        b=hIbRdA9TfGsNuYqKLr2HOnNv9li3L7JSNoFIqLHME+3YtEAtIgNhLEK5v/lqWvnzqd
         uC6Ilz/EAfZERM0VJp/kHr4g6GcynIid7WANZ3EkQvErp8jK9TV9qoA6zYXI8xT6g02S
         a0b4F7nT8deu2xlRfxYwOYEBrcHdDa23QjLCIe+OE0eRBdhSPCDOb43D09frP9S+0V9G
         eqcm3gR1VLKlhf3nhqbJb0/rEWNXyWweBM1z9JvvHoEc9mZueyXcgre4V98cupszcb2N
         fq1uGh9TL36JTBclWqt9cNwOuid/BQLZsQt0TiMKxjIu25S8UN10/sOEMjZ0Bg11UbIa
         1w/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoD0293PRzgkBOKsNdh/C3yfOt2/av7MXjQa7c+jDbwtHXJulO2gzU4ARV0j0B/701j73HARty2ga7bKJWV/2B1QN8AVxRDYFka6/s
X-Gm-Message-State: AOJu0Yy0yZ1qMI8g2CeCHNhc1VZHzMZGFURE+Kj5thImDWl4nwqnT4Am
	IAWA9l/0NbdiDn90fVc2Z4dWQtcLVTRhIE8i1qXF6tlF9vxCC+l7W0moiO5U/w==
X-Google-Smtp-Source: AGHT+IFWtiHj8a1VoRQm0nq5ioH7+C0b5unkMry0uVptPw+otkKozDcxw0l++LwQvQzuijATx8uqug==
X-Received: by 2002:a05:6a21:1f24:b0:1a7:91b0:4f14 with SMTP id ry36-20020a056a211f2400b001a791b04f14mr627637pzb.23.1714419825750;
        Mon, 29 Apr 2024 12:43:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id px11-20020a17090b270b00b002ae071346a2sm13389365pjb.36.2024.04.29.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:43:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kunit/fortify: Add memcpy() tests
Date: Mon, 29 Apr 2024 12:43:38 -0700
Message-Id: <20240429194019.work.664-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=604; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VIy9QVTN2qcxjefTX2tH+Yz/iQIFnIJTdKGucOLxoMk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmL/httbmsQItvMY0uFd6j4hYaYCstXS3BgqKHL
 p0ncvc8EceJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZi/4bQAKCRCJcvTf3G3A
 JhLKD/4w53qKNAGkHRjVUlL3JoDVZHy+a4JqhPXqb8GmjsPB4621MjVd4rsZ6XmiKcwk2fnqbvU
 CHS6xbdOUc1AC9N6Xwmghk9x0r0l54IHzLMMXm1MqQNIl4syp5uc0i5xcqjwMqzpkHC+3ORQqTZ
 OrASafSnHzJxAfEgOQpZO8x3vejG6/2xBt46twYfrddMXXcENntF2TYjrM0LMzZAdex20gJbKtg
 kkgB/j4LxAfKQAoioOafYY35vvRtpoGQkjQBc6qVDxSTg1qRqmjDRe03GiKtW4rYxxzIZziJPE7
 3d4e2V7wIjOIvjkIs+bpgPUIfGEbgonoQ+hVW2FZvsHdtOLuxxlg40j15ZM6le+MFMAnUTWrUen
 YQVUmTJHbWU5nl4QYNajhO8rmiezNiTGw6qkDpQEL3WaflIM41qzHlF9PHY2GgtleDA2ZB/gEKm
 pJP1d8SthelDtscHXc1yri6Ha1XHs0SM7kT7ZiAysCx+QKZt0HhpZYCq0HP4sfrEJvqOZcxCKMU
 rm8+rIz5i3GGrBR22svxrMoCNobGpwBl/6/pHgJBByu6o9gkLI9bm5JUf83f7Tnhxl01W8/XEsz
 nP9czNbmvxQDBov3/YqO2xukp4Ajn1ufJ+Nudhx5M7xhQFWv5V8+WEQ/7T8+6TSGmqNl0HLREoL
 r1PEON62 rLiag4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This adds memcpy() fortify KUnit tests, similar to how the others
were done. This is in preparation for removing the 0-sized destination
exclusion now that we seem to be in good shape now after removing all
our 0-sized arrays.

-Kees

Kees Cook (3):
  kunit/fortify: Rename tests to use recommended conventions
  kunit/fortify: Do not spam logs with fortify WARNs
  kunit/fortify: Add memcpy() tests

 include/linux/fortify-string.h |   6 +-
 lib/fortify_kunit.c            | 174 ++++++++++++++++++++++++---------
 2 files changed, 135 insertions(+), 45 deletions(-)

-- 
2.34.1


