Return-Path: <linux-kernel+bounces-105882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E287E5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E43CB214F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166222C1AF;
	Mon, 18 Mar 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKCCgfG7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B02C182;
	Mon, 18 Mar 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754463; cv=none; b=n3GR/R9HU84d7cbzE3z3MSndIWm54kBOA93fl5mLH1Z6/srcNuk0vnxi4dbfF07pTeHNC80QZqxCqseVkhIv3GJERz8oRhWhaMwKTSrRt5ywKlZCzz7VWyJ/ClNfTVwJgJGmD7Vye8Eo6rqAhphOtlzQFL6ewGnjdhP7Pb3JUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754463; c=relaxed/simple;
	bh=6AyKLpRcKkRDkIZr+S1qFOTIVYlNkvLKzX5JENB1lbo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YIy80u8jVb3uMrKS9JuS4mntEYQSQtuSJL16REczehqu3TH9/lMq/9Ihe4ZoLRymW8mD3N4CxhE3gV9AjRY362eAbkWTIjPeYMx8UU2n8Li1dvcZFDLjokxb3TxRuQ1RiKivokjMGs3ARU89/Qqt6qiLBct97yiKk1EE5pqFY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKCCgfG7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dff837d674so9800655ad.3;
        Mon, 18 Mar 2024 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710754461; x=1711359261; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adinmBVba3UjUo0y2Vt4MDWMOxKBsL9CbIO6W0txqlY=;
        b=PKCCgfG7G85OCO/VQmzSFyUvx93X9Y2ZjtJS2b0JvUdJUThI+hQw3MSgcFMZXzzwZy
         Lvv3+m/EHylGp24zaAxNUAvq1a/U+zwb6SUoy3+NVDKZuhegx9kgjBME4mbKHVvCmazl
         G21dwKqrl4r4FVr+33tgOYHLzqrHi8/EyDqL8qwHrOktSbaih4lG5XVUKXXuY4bDgcKo
         ac5Dh3DnqLsxbwjMNXphZj0R/jGsVm/6Z7dHy5sriMWsAYGB7GYDmNVjNGFMQVgvqcSZ
         kgKZ65EFawvz2BVz6ZTioDJutEKC47Ea/1fH2OheH8h/vzWF7SPj03WfIc8972iXhwen
         2nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754461; x=1711359261;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adinmBVba3UjUo0y2Vt4MDWMOxKBsL9CbIO6W0txqlY=;
        b=bjk7Oc2dEK1+uzhS/sCrZKaPAy3f82IGp+gTYBKFTTkk1ZWK7m9B0YGhbYKgX/HZnB
         1oRcV+auLZsfx/Ni08cvp51rOBG+J51b/BQoCVYFChBFzEdmb5xzqvBMZH79ZWrqDPRj
         oQIRClA+676fixMIVAMsAirPxbCNP5GU3LUisbQgQ5P+JpZ+zlUF+pmkbI5RATcYl8pu
         rGkoPVfT+k7IlwjOzx+Pvouo5Z/DCJxTUeY7C+Pmo36HXzSvTiydI2WChpiIAeqK17Bq
         OvdFrswqvmnaKBSCNbu86oqhqcKFTIwZXFNoiGkCJzZv/mq/LnEp8UU2UHG/wHgTJMLM
         NfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0oWnsslSDRttkOMlHPU9RpdsbItLKF2bm4VmR2xOwt00TYAYkhTFt5G5Ni0e+ph+WPZ/3ykq6hmcqsqe4a2e0nIC0g4V3NTXwGrGoPF/XQmYJaP617GIG/ztk8PY762G+
X-Gm-Message-State: AOJu0YzHg3pNHghaIxjwSO0HuApIf1ZvXrPqlToQTq/T61KGOgxSMZ9x
	mnYoCGA2HdWh6EOPT4vOknvEdNyTBLGZB1eo5iMzAGzcCfZhTCHIknFUW/C3
X-Google-Smtp-Source: AGHT+IEfsKypoxveI21W3BGXvt5E6C8atOplw7lviuM8adq8z1POAc99erw1bfFngj8SdrlsUJ6QbQ==
X-Received: by 2002:a17:902:f60a:b0:1e0:2995:c330 with SMTP id n10-20020a170902f60a00b001e02995c330mr1793421plg.63.1710754461355;
        Mon, 18 Mar 2024 02:34:21 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001def777afc5sm5828025plg.77.2024.03.18.02.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:34:21 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Generate get_gp_data method to print gp status of different types of rcutorture tests
Date: Mon, 18 Mar 2024 17:34:10 +0800
Message-Id: <20240318093412.17258-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit is mainly to enable rcutorture testing to support print
rcu-tasks related gp state, and remove redundant function pointer
initialization in rcu_torture_ops structure's objects.

Zqiang (2):
  rcutorture: Make rcutorture support print rcu-tasks gp state
  rcutorture: Removing redundant function pointer initialization

 kernel/rcu/rcu.h        | 20 ++++++++++----------
 kernel/rcu/rcutorture.c | 38 ++++++++++++++++++--------------------
 kernel/rcu/srcutree.c   |  5 +----
 kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
 kernel/rcu/tree.c       | 13 +++----------
 5 files changed, 53 insertions(+), 44 deletions(-)

-- 
2.17.1


