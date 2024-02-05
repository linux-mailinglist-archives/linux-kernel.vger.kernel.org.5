Return-Path: <linux-kernel+bounces-54020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DF84A95C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8851F29E61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9FA1EB45;
	Mon,  5 Feb 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="mEbSyERp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA5C148
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172435; cv=none; b=sTOHUjw5gd8GDzT/5ms6DBmQb1uAFNwgsKNlnyzUJDsm9B1bdOZ2Vj02XXaV38p3S/71RY4FAgRYPN4PxmH/H8gj9yonc4l9cpFXLGvE/C0ez3NqNYxkR/CBNVvbRt4eY+/b7bymb8pazdjJZ1Sn6RLSYE08FbG1TDwfX1VJKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172435; c=relaxed/simple;
	bh=oNNAS403WLiBr+jO1UJPGHbjrbcZ8v1K77Kbe41vSO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o9wJ10NPPfYWfU/k+FoTw0D6s7ZJ/MytpbSVGcIIzT1vFE63ln7N6UOqoP5CcCuT4MnqkMvLPTbZhojUK4A+h9wnuFe/nqfZytgKLB9cggdAe1jG9yRg0FncRYJneahbQEDmyfQXWf9+NxnLhs3jMmnMXnswjVx6Xr/M+fEi8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=mEbSyERp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so43486025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707172431; x=1707777231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7hCjIP/ZlisYj2P8Ny4Ne49EXNdosYOS8ChSNNIKhc=;
        b=mEbSyERppPrSoKxqkSOrPjDmN3Yu8X5R0PXD+HFfs/47VTwySuP3MyEjWGUYMv+3r8
         rR409cqOWnEZPtLpfGWsLfn+96w6zFBbQtMdb0DslxXeoxC5getndASh7yDA9HhC8FYj
         0ZTSb2zY/wZ0v6SPO/tNi5NM0N+smnMptEsy1o9bxvz+zmx2LUGy7Dq3kZUbIbQCxWnd
         mObEgNRxSTWQzBOKGIE3iQqoC+R3XFp4Vzbt/pXoFU3ZlcNuJdWlyDcab4ojVsbMVY6f
         /UKWiDOdwtrwoge/H0nEztNFXp2QHQSnHi5O6F8Hty4Vvty/jSRAo8zOEAKLhLXEq1Ht
         sjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172431; x=1707777231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7hCjIP/ZlisYj2P8Ny4Ne49EXNdosYOS8ChSNNIKhc=;
        b=LzCMHtdQsCFWA2dbBp0EQ3JmPLHa90fO2ETfvzu8R0Jb4elklkNqDkUdxRdW7Dggf3
         Y/d/MWkWlUb/sODSkKe0LJQz0BQlnb01Ty6FfTPWgESQtLXv4stiJf8EKaJELVzrwwft
         Tx/5HWubg7LKEvtNKs7D5Hg5mH8jsMRtDe8b9BZZXmUg+LWr+JPT711tQhJ6xFdzz2X9
         Sa9HE28p4yXwzFA4nKm5W3xrcDEqhsNUrQoPHOalujIflwbqoDONR5cg4gYy1vLmB+3O
         IHozNqRf2V99UA2GfhVOdrMyEWYgVIDy2Q3JRrDyq/tr+oei8l3cMhGFGhZuoWyt6Zk5
         dnog==
X-Gm-Message-State: AOJu0YxA96hFSJb2SBeVjAryDPhcrhlcFqQrYDG4Cwoe+1yAgmyZc0yO
	KAwnleJf9hHnjv0uEXh891ICfm2yicRpzAzeyyK3HkDsQtoQOvsIyX5bEhFyqBE=
X-Google-Smtp-Source: AGHT+IEKG3sjly5rHKJKxraq3hz1EdfX5tVNDnYKrdCdUlIwvkZ01953THmSUmTQrPT0ljIrVqKTcw==
X-Received: by 2002:a05:600c:4f03:b0:40e:fc29:f527 with SMTP id l3-20020a05600c4f0300b0040efc29f527mr905653wmq.31.1707172431355;
        Mon, 05 Feb 2024 14:33:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWRAltZ67oGm+W7mHC52B7tZS1OWBX6FP0z1tBIUvPvMQzrG8tXVQfAFJo8R2r9Ltxkmoxg/DSPk3iRM2Kz6JvwL3EIxZB+MYP9465/T+9J4HaGkVSohT0Z8lQQQSIQMV905oE3wyPC1uD+0+SWpnmoa6ICxwn3veKOCM80V8eHgMngDv8uOGbL+rXV0j+Awsam8BI+Z3ywrra6uHBbmw+lFtuwzl8hYdaLrPt4WFf1e46a611jcYCc0eurkLtjTDZlYqdQvuBaZxUoGHewdObPBMLLlMlEjnEvr9Jkpw==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id hi2-20020a05600c534200b0040ef702a338sm9683135wmb.25.2024.02.05.14.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:33:50 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/3] sched/fair: Remove hardcoded fits_capacity() margin
Date: Mon,  5 Feb 2024 22:33:41 +0000
Message-Id: <20240205223344.2280519-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is split from [1]. I thought it might be simpler to split the
series and address the intertwined problems separately as some of them are
easier to deal with than others.

This series focuses on migration margin only, or the check in fits_capacity().

I realized that I had a bug where I am not taking invariance into account. This
addressed now. Commit message in patch 3 has all the details. Patches 1 and
2 add helper functions to convert between time and util.

I have issues with my test setup so didn't collect proper power/perf numbers
like I did in [1]. I didn't see any bad power impact from preliminary tests.
Perf numbers are definitely better.

I hope to get some feedback to ensure there are no howlers and I'll collect
more data for the next posting.

Generally I think this is a step in the right directions and, as I find out as
I fix more problems, there are a lot of areas that needs to be revisited and
improved but it's hard to fix them all in one go. Particularly the definition
of overutilized and improving our energy calculation in feec() and balancing
work at wake up and load balancer.

[1] https://lore.kernel.org/lkml/20231208002342.367117-1-qyousef@layalina.io/

Cheers

--
Qais Yousef

Qais Yousef (3):
  sched/pelt: Add a new function to approximate the future util_avg
    value
  sched/pelt: Add a new function to approximate runtime to reach given
    util
  sched/fair: Remove magic hardcoded margin in fits_capacity()

 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 42 +++++++++++++++++++++++++++++++++++-------
 kernel/sched/pelt.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  3 +++
 4 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.34.1


