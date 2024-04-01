Return-Path: <linux-kernel+bounces-127026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD68945F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1AEB220C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552D53E1B;
	Mon,  1 Apr 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg/MLcK6"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4147A53
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003218; cv=none; b=i2YzOHbxzi41QtewvIJFjWfIy/yFgdGnmkfpd7vMpJ8mOWPBu5a8e9BufAMBlrNSOStmVbzTeR0bXwTQ9Lj863sw+6qZW/WabU+njgliLm32RCbEtvDc5fN0bbUDr3n1DkhlLVueKWvsU/US6Xu1VYhQUbQhXiVSZhB33+FlT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003218; c=relaxed/simple;
	bh=l+FOtxe9VxY0K0yOiwlzpYMjiw2iTas9i+u9zy9rYgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPJRBGKEU7H9YnwvWncOV2275DB1ZmMuQuqEsxscyAWLMxbbZp5F4nzHstFpEzf7gDxa2K4lvfiXvHXwyKAtURrHscqUcHSkjP95pGkhAqim+qSTSfSGObzxLY9rzLMmMg3CVIdCXpxqbLf9OXF8nS+bQOY8UsjB7VAMeXEDiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg/MLcK6; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61453963883so33310837b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712003216; x=1712608016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3w1qxaNxZIdwI9NavJWkwaLl0QOhoYQrMhbubFtt9g=;
        b=hg/MLcK6f/EMJuMOSMp002l33mhvCZWpUudP9DAd5ek/C4LDc5sJGHm1N/Zb2Polwq
         q+HbtWmQUhCVcXvTYdsESsKTsrd1NTvgv/b0CRY+y1OvWGkAZ4RiJU2noKT8ejwdBzh5
         NYO6l9JKYI9hvHY0gqG2QWYsg0o2o0Xx/zjqiTri+YZCrj5AbvB2Xij7jmtojMoPGJ72
         84YFxzF/D+Lo9EB1lImp9ouGjKm5IHnIhMUDtgRGnkch6g1ko9AYBV6VhRl8onlGRyln
         ttpRcYfqh/gtYk4jz1pNIs4O5JZ9DaFezpBlsn+kTcNrctLYpYnGoZo/730Q+YHs6Z4Q
         ZobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003216; x=1712608016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3w1qxaNxZIdwI9NavJWkwaLl0QOhoYQrMhbubFtt9g=;
        b=MMK2maxa2qe0488flcmk9SLf1gObyR2g+LGFMLwJQxWtWlq8tHr7NbFwgIKFQiEjvu
         bfeoW5Rdny4PjhekOo8mTcZ0lEbLxVALKi8911fyZkRCFq2kMydgts6hUMkOKDaUyNew
         jO4vSacpyNUPA83+6wz2nHSWwVyK6iCldIXlM6nz9DULjS0l+ZH3N0GXEtBbGMJcwZpW
         ThqiSGBilOmPkpfNllQIlKgNTyw6K6UkSDQRV9ttNpTfuK/zMvuW4WHYmBfpmdLLqpY7
         045KzubWPJw8Z2GnXTltnG5pcN4F4w0Ps8+E67xFkHPIIVK+L2pi+CJGGIfxC+rlNzNq
         YCXQ==
X-Gm-Message-State: AOJu0Yxq/rlSE2wXQmGDKkDZ1VKiY7pC5b/vflzm68EU0ilxYpKxPmUa
	mVr4ZE16jmplTln0xOJHXhHTY+QQ+V7vaeONzckjP+AjhrXUeecV030lS1hM
X-Google-Smtp-Source: AGHT+IEmb7k4YRsZQUzxuwntHaXrMyAJKhIBr6lf4K92Ji8HKVVSDGbbfF+JCZ/IxfgkYTVrqTqSdw==
X-Received: by 2002:a81:4987:0:b0:615:16a1:4a04 with SMTP id w129-20020a814987000000b0061516a14a04mr789351ywa.31.1712003215911;
        Mon, 01 Apr 2024 13:26:55 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:2f7d:1800::23])
        by smtp.googlemail.com with ESMTPSA id y72-20020a81a14b000000b006142210a31esm1171181ywg.23.2024.04.01.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:26:55 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/3] Hugetlb fault path to use struct vm_fault
Date: Mon,  1 Apr 2024 13:26:48 -0700
Message-ID: <20240401202651.31440-1-vishal.moola@gmail.com>
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
----
v2:
  - renamed patchset from 'Define struct vm_fault in handle_mm_fault()'
  - Dropped patches 4/5 - These allowed vmf->{address,pgoff} to be
    modified, but that allows misuse of these fields. Converting hugetlb
    to using the same address/pgoff as generic mm is not simple, so that
    can be done later.

Vishal Moola (Oracle) (3):
  hugetlb: Convert hugetlb_fault() to use struct vm_fault
  hugetlb: Convert hugetlb_no_page() to use struct vm_fault
  hugetlb: Convert hugetlb_wp() to use struct vm_fault

 mm/hugetlb.c | 194 +++++++++++++++++++++++++--------------------------
 1 file changed, 95 insertions(+), 99 deletions(-)

-- 
2.43.0


