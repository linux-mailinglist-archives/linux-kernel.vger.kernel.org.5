Return-Path: <linux-kernel+bounces-146761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E98A6A81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16E1B216E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3512AAD9;
	Tue, 16 Apr 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ji+xg/sO"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D1DFF0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269736; cv=none; b=hIdUdyD83JyIToyoUK3lKl+XyvXWEiqprAMbzft+/KBiX5pi7yK+fmTZGnD430POuPk/jiPfG0YsnntSDuPN1gCjswPzYcUTwHiiO1OxnUJEMCLHPH3c2nLtALgOyRwuYNbyD9E/chTZdv+aWVphWYQALGM805ECe2ww8u1f3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269736; c=relaxed/simple;
	bh=K/ETl1rVlEjB5zEMZnhystO6wyJXlUxisvkFVchro5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWv5LeGDfW5O8O56vbxuFkBUN0y/aoWgHf0Drlnb2veiTjZymB63A0NUaa0KjsHVs31Bi5ENdqlpsLADUNWefFPoxQ1jGb4IEemX3jDxL38pf5nor7CfzZS5hC8ckmSk8YorHmc17sV87ZHDE9jYz7fq0OVXkhoSCIBdhg5WUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ji+xg/sO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2be2361efso7338205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713269732; x=1713874532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HqBDoHFaHmgL74bjhrrJNzXbrQTy6GMh4NzhsBu1sLw=;
        b=Ji+xg/sO45SJwAiSgL2rPHaN4SjbLQhh7XkAXazwIXu5Yl+Qgo4dvvJ9duhU7j4NW8
         hPfNGswQcAMKj5Xdc4pVKEiDlYmnkGuE3AJg2G3bw903lRdM1QVtMHyYvSsSNU5qFGyB
         XteM0v8puJezyR6w7hqwc+zUMES2JxikrJb/7sS02GI029gV6aSkv/w6GFEonHbvi9up
         Lg75eVaW6Woe/fSizQQy/UABYrx/HljgVQL3R9wyU8+0aybh0Nn6oBTcBL7bqyAI7Uwy
         Ql9mSp6I05lSP8Q9mPx9KKufJU3hY53KjBxVnc/WEasB6SToQVGVPnwxV27RnRcWoDD/
         iDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269732; x=1713874532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqBDoHFaHmgL74bjhrrJNzXbrQTy6GMh4NzhsBu1sLw=;
        b=KbE+8Vdr8Pju1OMKrXvhPb9IJDOjq9sG71VM1lIn1sWDYmeDywBG8+9dN3SzRseHAN
         BL0I8pgTXsRIdCXVKkzH19V33zlq1fae+tpdfRYd7g9w7pkpYkJ7gFVJX/YEqBq14heS
         7se1FKJ4jTZvdb0ZyfctcGsQCAM15uygI0xWhQudbmQGWsOQo77IcNZsap0EQK2/7oVt
         lybNmQoVlABSv16vKbCPaMs9tb6uIhJ1u5kG5say1fvlkvLB5qaGbJBc8lJ+HnmeqjrS
         /6qeYi4sq1lLonOf+pAbgUYB1spMZ3SGmGtXcMCXu+RDsyA3c+6F0u5b7Yni28tB5x9B
         SsCg==
X-Gm-Message-State: AOJu0YzFZrflmjEdcZrTRguFs4sGMjGFqPcJkA8vzmIqFTEd7qhiN+Td
	DNa3qDkif63TkrWdKFhkN6KlKo/0H0Qocz9N6PLoZgV23KZJ7vvUwl5K6mYVKPf1D3ug4GxJZt7
	f
X-Google-Smtp-Source: AGHT+IElaJYhhufAv4mALzTLsCbG5Uvl2WeEkRs94MjAJazTJMSTUoAh+pguA+Wn0NgM5GNwcPO1Mw==
X-Received: by 2002:a17:903:1c1:b0:1e2:6d57:1012 with SMTP id e1-20020a17090301c100b001e26d571012mr14879289plh.5.1713269732053;
        Tue, 16 Apr 2024 05:15:32 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001e43576a7a1sm9584693plh.222.2024.04.16.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:15:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de
Subject: [PATCHSET v4 0/4] Split iowait into two states
Date: Tue, 16 Apr 2024 06:11:17 -0600
Message-ID: <20240416121526.67022-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v3 of the patchset where the current in_iowait state is split
into two parts:

1) The "task is sleeping waiting on IO", and would like cpufreq goodness
   in terms of sleep and wakeup latencies.
2) The above, and also accounted as such in the iowait stats.

The current ->in_iowait covers both, this series splits it into two types
of state so that each can be controlled seperately.

Patches 1..3 are prep patches, changing the type of
task_struct->nr_iowait and adding helpers to manipulate the iowait counts.

Patch 4 does the actual splitting.

Comments welcome! Peter, CC'ing you since I did on the previous posting,
feel free to ignore.

Since v3:
- Move to an atomic_long_t and drop the locking required by encoding
  both the iowait and iowait_acct state in the same variable. Suggested
  by Thomas.

-- 
Jens Axboe


