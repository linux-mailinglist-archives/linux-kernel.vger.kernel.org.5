Return-Path: <linux-kernel+bounces-43646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FDC84172D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F211F239DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088953811;
	Mon, 29 Jan 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAaIK0AY"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13451524BE;
	Mon, 29 Jan 2024 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572670; cv=none; b=Jv+xnHE9iMkiz2/UCxXAkoz8Laxy+4kHouehS6rO7tUtWl003dKepQl+6DdnUBPrSRQCkv3AOmurL0zgF/nkEUr/79BPA8pjxiDvNm045bNFUHN+r7DjJtvd2KyCEEB0AAGXLRVkM6gwuZgu9opk+Wna6A3Gs++w+Vs1Fzk5q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572670; c=relaxed/simple;
	bh=PBDXmdd3YDxYwPmfBhHPk0eaWyRH9yNEjDQBzLi2m+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftDN2zpi6E97N0mCp8KsU5TfAQcz4qL7X6fXgjYvtTzNgobPKr6vpriOdoBLD4u0o2bHS/SZItXoxEX/uGQqKbgC8iSL9R1ycmdCLD/8Q8ZprKl4MhMJXxUtQymfWPJD7P7H1EB3OLTxIxKcUMMIw4M9r6TjrWS+x2mXCXkC3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAaIK0AY; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68009cb4669so26393436d6.1;
        Mon, 29 Jan 2024 15:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572668; x=1707177468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=14qTSl6VfeinFYRyn647RZT0gaoCHxy/3Nvp5uLMb9s=;
        b=JAaIK0AYVN6wECwc7tS/gRSRZEKI4REZWvvnIqZWImZ/bvx82lmbwIS71Uxsa5L9OA
         w2ucAxGnyXuGRgDztGn5s6BRRU2U8HrOPSeLTfT6MrZF+G0+GKfvFNF/+YaXX7orM8GG
         n8KfBYBRPgB3TGcHF9wQ35o9hU7zJZivZorxD1bku2DNF1+p4HO2gm/A6y/LgkoQVt3U
         mA2NPYRDsgpl7LvK7z/wuC/SoZOW+HiOhcsr9kiEXc+vxLmXEVU5kuQUu1/RWi+RHv8o
         kIMaYA80U2hdLmw2eB2BaZD3NjM8yb2vOPb+bpIYmcNRjprS/l50jifwWIzMiShRqgCR
         c46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572668; x=1707177468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14qTSl6VfeinFYRyn647RZT0gaoCHxy/3Nvp5uLMb9s=;
        b=ITeucGGTPNGaFlGitbnhXEZyB5FXzx+T5+ocXSlp1wTVz7HRVB+Kb+7ns1sEaCssau
         bXBUDnyg+9vlqv+FZvzyEsjgiTYXMstDgvk2tiE8YQLIPyj0Vtat3R/dryhAVnnehyl6
         Myds3Ce4EIbHO/+1rDJ421uT6+DzoTOTG5UvLeSqx7A3MwsmSPDnSdYfWtkZq3FC6SWz
         xLbozYbOMHeaeW4CTVkPMHIXbr4oJcl4k0Gz0WHJ3BRp4QeTI42f5u69frb9BRF/b0YU
         Im4a2i9Zm4F1UPtJovl44RCagk+/6Wd6Zl40G8FrdFkXVS6nJhfdMCbMMaGSquXwIy0u
         3eHA==
X-Gm-Message-State: AOJu0YzxJ1KzTAqD9B0PfGUSuw1CXo3btFETJC0tuSv5SGFYKZW9laZK
	unkNBvbWnbcUhsKF6bJVsmXukP7nMpwt9vDqXpLKKUejLrrWEbLgTHe8VvAR
X-Google-Smtp-Source: AGHT+IHrKfz3NI4gVsaaT68ogyT0ew61errkO9fev8dG/RjOxrMAwCBGLsttIaGizWl44FqyMl653A==
X-Received: by 2002:ad4:5d41:0:b0:681:14ff:3e82 with SMTP id jk1-20020ad45d41000000b0068114ff3e82mr8163338qvb.41.1706572667941;
        Mon, 29 Jan 2024 15:57:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsawbcW1WHIiDjg+6OI9e5bLE+byHpRwFzVaDVfv+BzD1TdKRd2NLldqOQMcVWLemNlCLFrl/piPX7XrzcFxLfJmJ7
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id kf4-20020a056214524400b006837a012417sm3920599qvb.51.2024.01.29.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:57:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id EDDE127C0061;
	Mon, 29 Jan 2024 18:57:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Jan 2024 18:57:46 -0500
X-ME-Sender: <xms:eju4ZSAShUC_6pOjCbc6UWolo_OMJ56CK4WNaZBiPFQ-rB4Flgs-Dw>
    <xme:eju4ZciTZ8TYUKypY19mfJkEVEYwFpmH55ml7qknGO-QU9OKSmcjche8rGsWwF1VN
    9SAvc-APIR_Oo_XIw>
X-ME-Received: <xmr:eju4ZVn0n1KFencSt60ulXeRaLaPepCu7ubElR--zPoUrX9IMG0k2IbRjkwjBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfftddtkeelvdefleeghfelleevge
    ffteehheeljeejudehueejhefggeevfeetnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:eju4ZQxskpiPA-yutd2d3ZbAyj-gC1Y_b0rukLbOHlA5kFoeUqg1SQ>
    <xmx:eju4ZXSNvsJK2kFDQEhNN6LTioQu5F6bZ_vcy9VDTC9V_96Ttd9ETg>
    <xmx:eju4ZbYOD573c8BL5uG2InVDTMxRtCTxCLSm7bGEv8n4iPEh5z1YLQ>
    <xmx:eju4ZSdV-q7yQsguTsW2VOYLYIvTMoiPXPLsPTJUv5MjZwxe-XkO_w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:57:46 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/8] Misc RCU update for v6.9
Date: Mon, 29 Jan 2024 15:56:33 -0800
Message-ID: <20240129235646.3171983-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains miscellaneous updates and fixes from RCU v6.9.
You can also find the series at:

	https://github.com/fbq/linux.git rcu-misc.2024.01.29a

The detailed list of the changes:

Frederic Weisbecker (2):
  rcu: Rename jiffies_till_flush to jiffies_lazy_flush
  hrtimer: Report offline hrtimer enqueue

Jiri Wiesner (1):
  clocksource: Skip watchdog check for large watchdog intervals

Joel Fernandes (Google) (1):
  srcu: Improve comments about acceleration leak

Onkarnath (1):
  rcu/sync: remove un-used rcu_sync_enter_start function

Paul E. McKenney (2):
  tsc: Check for sockets instead of CPUs to make code match comment
  rcutorture: Suppress rtort_pipe_count warnings until after stalls

Qais Yousef (1):
  rcu: Provide a boot time parameter to control lazy RCU

 .../admin-guide/kernel-parameters.txt         |  5 ++++
 arch/x86/kernel/tsc.c                         |  2 +-
 include/linux/hrtimer.h                       |  3 ++-
 include/linux/rcu_sync.h                      |  1 -
 kernel/rcu/Kconfig                            | 13 ++++++++++
 kernel/rcu/rcu.h                              |  8 +++---
 kernel/rcu/rcuscale.c                         |  6 ++---
 kernel/rcu/rcutorture.c                       | 13 +++++++---
 kernel/rcu/srcutree.c                         | 24 +++++++++++++++---
 kernel/rcu/sync.c                             | 16 ------------
 kernel/rcu/tree.c                             |  7 +++++-
 kernel/rcu/tree_nocb.h                        | 22 ++++++++--------
 kernel/time/clocksource.c                     | 25 ++++++++++++++++++-
 kernel/time/hrtimer.c                         |  3 +++
 14 files changed, 101 insertions(+), 47 deletions(-)

-- 
2.43.0


