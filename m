Return-Path: <linux-kernel+bounces-51982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A13C849249
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36E6282AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB1945A;
	Mon,  5 Feb 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="LlPgrLUO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C38F49
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099101; cv=none; b=K0iOJumGVvdzD7nXolLAZGVKzLo+C6tIF0FJ0mm7hBpM8LLbCN9g13Cfe6LYEqLQuEsJizsl2Ubo1yK9GCw4HGJ9ceDaJr7zG3QRdReFB1CRuM7n+lBM4qfaBnsGa9K/iFVGE+CYXk7Hph8lOd5e3uiwaIWVLws+reXpC08v3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099101; c=relaxed/simple;
	bh=2NgDJ8/HDNOwizSviQcXNeE9bKTPPWdbZ1pH9F5mHnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTa8LrClOF4ae4TqTrtp4ICVTCwSeCayP14knpMER3+PC2HbwhNslImihFwdr1XbwLxulmxORTs0zlmmvY1FFvvyGnaYO5GNuPueGdhcgUF4nux+n0G8JejhC3W1blBcodkRYySqAw8A3/2Wz9TedloJXehTMAtYuVqME6ffFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=LlPgrLUO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so27673015e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 18:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707099097; x=1707703897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMLDSwUmuCQOcnQUdhO7xQk8o6D05wkVH28BQsiOrHs=;
        b=LlPgrLUOGd8FTUZtQaLFiFWiA2gzUS+Inl1Ft/wWeZtnZbxyFAIfxFxNd056E3vR4B
         mWC5MSPZVZ0fM26rPzOPFXV4vjxb10X2IgpMq+mOgusBuB0dxOwEP7HiHyQ6l2NNGv+I
         G1aY0cVr6GVXmBmK43vptZbOd/6bXN0QB2Ks7B0mYbQ3ndr3zBdth9tk5XWhWrVeFFci
         t0zA/JUxc8YSLT5E3ohtuDQ8aYggftxFBR1mgafhZazPagWJ9GQSpJD4Co4uRuhKzQBV
         pwKzv+IRF/DrL1BoCcctTOZ019CH1ZnScIqf+c3ic09JspHQBDOFhww/NHzPo/3hsAxQ
         u/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099097; x=1707703897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMLDSwUmuCQOcnQUdhO7xQk8o6D05wkVH28BQsiOrHs=;
        b=jphVZi1I9CcBXr9J4N6N1twzlJT+cw6EAQ7UMe4Ncnhjzd/p8znIgEdGb3Tgp/duBF
         o6RxUxGBc98Js83ZnF3RMZIqx2XaMjliAbGx1TBaBuHKPAqUW9pJ9U8iydO/kYY+iX+9
         D826dLheilksiWWHQu4TzEKgAsx9uZJbTeKsAbDDYJxtOfZC0buC4W0xQ68hvxMtwphS
         bCy55GrSEPpD1cqPsj8q19/+E1sK0nHOtfmmWABkteu69PUzs+2riFt0yVWmBCSLzGa2
         bWeZ3HJgMLws8lnkOMBBE9fcX8gVsLo63QDYtflx4/EfR4XrZR0PeZ0AyDdV22I5kQLX
         Oo4w==
X-Gm-Message-State: AOJu0YxJtJilDhqSLFLkkeH3PXAOYbJiwBac18h2Hyvg6Kz0JCOo7JVy
	zCkIJZ/S8uu69H9ExvuH2i2K9VJySLhN1vygWCBTDzqUUQfsa2SdzLKroKLf+Bg=
X-Google-Smtp-Source: AGHT+IGMmEfGIcZmHgz0ioTYMg57cNjt7Miy7jydWMVCJELT9z9Ji1559VQqL6J4M3AbOzcHsXmh1Q==
X-Received: by 2002:adf:fa85:0:b0:337:b9ad:14d with SMTP id h5-20020adffa85000000b00337b9ad014dmr3766961wrr.19.1707099097036;
        Sun, 04 Feb 2024 18:11:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/9V0o5fbtCKrx6NURy7p4JhuSwwt9UGY+sg3iWKrfEyHCC5LbmqovegHEmtP6HkgZW1gRxs485qneeIu3rkgzUVFEL4DR5TdE7+ctwWNx56RgMEwFIWPCYub+r8DsHVVxoazRTLwYPUUvGKhqjIBWu/w+h2Up62ylUziKDrVszFnBebxP6/jgu0w+V3ZzZSiWTWtZNxGps9yDKxKdgUajggx9CEqQvw==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d4524000000b0033addeabd6fsm6999800wra.18.2024.02.04.18.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:11:36 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 0/2] sched: Don't trigger misfit if affinity is restricted
Date: Mon,  5 Feb 2024 02:11:21 +0000
Message-Id: <20240205021123.2225933-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v4:

	* Store max_allowed_capacity in task_struct and populate it when
	  affinity changes to avoid iterating through the capacities list in the
	  fast path (Vincent)
	* Use rq->rd->max_cpu_capacity which is updated after hotplug
	  operations to check biggest allowed capacity in the system.
	* Undo the change to check_misfit_status() and improve the function to
	  avoid similar confusion in the future.
	* Split the patches differently. Export the capacity list and sort it
	  is now patch 1, handling of affinity for misfit detection is patch 2.

Changes since v3:

	* Update commit message of patch 2 to be less verbose

Changes since v2:

	* Convert access of asym_cap_list to be rcu protected
	* Add new patch to sort the list in descending order
	* Move some declarations inside affinity check block
	* Remove now redundant check against max_cpu_capacity in check_misfit_status()

Changes since v1:

	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
	  through every cpu which Vincent was concerned about.
	* Use uclamped util to compare with capacity instead of util_fits_cpu()
	  when iterating through capcities (Dietmar).
	* Update commit log with test results to better demonstrate the problem

v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20231231175218.510721-1-qyousef@layalina.io/
v4 discussion: https://lore.kernel.org/lkml/20240105222014.1025040-1-qyousef@layalina.io/

I will send another patch to prevent failures to handle misfit from increasing
load balance as it seemed from previous discussion this is desirable.

There was another problem discussed in v4 that can cause delayed misfit
handling that is still being debugged and investigated.

Thanks!

--
Qais Yousef

Qais Yousef (2):
  sched/topology: Export asym_capacity_list
  sched/fair: Check a task has a fitting cpu when updating misfit

 include/linux/sched.h   |  1 +
 init/init_task.c        |  1 +
 kernel/sched/fair.c     | 84 ++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    | 14 +++++++
 kernel/sched/topology.c | 43 ++++++++++++---------
 5 files changed, 107 insertions(+), 36 deletions(-)

-- 
2.34.1


