Return-Path: <linux-kernel+bounces-43739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D6841884
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046EB1C22B76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED236135;
	Tue, 30 Jan 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nDVlW2aU"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EF36114
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578938; cv=none; b=LNvd6ert1XJ1EeOj053SHPui5eZlB3urxpYSAehwrQmA1HQx4Oz3VuZjgkGf3bGWQvtzQGZ5RutRieiYhLYtav8paUfQG6nfTpoCxYda8AkAv3KctfLG5NBKYBLZPErYQSpgNNQM7l6LNpEWoGuoJFnF2kldFg4iL7tFy2H2IrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578938; c=relaxed/simple;
	bh=irGILLtZ+B4v/jX46BOE8oPtbTKGTNQJoE3QMc3gHIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eR5d5nZUK9w5qU0a3iZPTkwRTvtEe0oMHLTSJMe4urjNvwVvGmMYsFbNJNO8+boxL15zK/0/Q8CchZRw7MJNzztPTHWArcb8OnWG2Pe0HY+iT548hYwSFqJD+kDjWhXYD4MDg3M89FVW2tysDoNm3LQmBWXAjb0Jkq7b2sEhJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nDVlW2aU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783e22a16d4so159868185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578934; x=1707183734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irGILLtZ+B4v/jX46BOE8oPtbTKGTNQJoE3QMc3gHIs=;
        b=nDVlW2aU8IsgJfnxkmTL+FjojkVIVcMr6WXI1i5jAFmAe6XYLVXiQFkmUeg+2iq1FV
         pIzER7FDxDNoxzzJVnwBa6eFE0bxdmlWf0V7e5PsMnXSHYjIyDPU0EGV1vXkSS9FXByv
         kPcfkF9tcd1btft2hSpI/2+8FVIKDwdQ+WWzVlMZ7lCxXyRUFFo/6lQxMor9POEJbCiC
         /UAx7veeHEA63xO4MnvvvZeVorP2tQmgao461YarVZZ4/xyvL6B/8BwISZTpMEdf9Mgi
         8e/JUC3YiKpfg6p4zIi21M3j0jRGDXGS0b4m731IWqaK+iNXdNg35KKPL4BIiBPVW/d5
         Nz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578934; x=1707183734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irGILLtZ+B4v/jX46BOE8oPtbTKGTNQJoE3QMc3gHIs=;
        b=PLLcN6PWkfz4iftU/2JvdiyVDB5bKRvkOpcJdEbwCeWi93DwH8jtzCzLBYO/AprfuJ
         oxntEWB/I/N3lf9honzonnXqQ+e4lJL51RS3gwuC5014TJ//5OXkxon6RAmTGw4c9HWS
         a4ZHRZ1f1vjDqreapulp2dlxcnQiVj5ZZG+BjS9bfekpFaValejFo+S4E5wjBKMDhWsx
         HF2j86nI6MVuyvAoRJR+KesVj2ab3j8An6gmVaLayD5zeG008UrbiZsEEBcfojtPPlyu
         dfpyKqC0jkauOlQClmmW1c5zSyIRHiiVUIkQm9HjMHWBiYgr33R+i41V50vLb0jr6seR
         t8Ng==
X-Gm-Message-State: AOJu0YxCp/ZA6KgOhwIOvDveZETrAIfDBs65sTHO3Tj73/e/7s0YKjg0
	qLoJEVAhSbA4xBGa5VtBzzQjD0Sg7JfvOtoIvmw89eLl/GreXEmwbFx0W7s71mU=
X-Google-Smtp-Source: AGHT+IEX8Cke0DmVSl+0NJn936xSvz0Om3dfqXiFMnqrScdLh1V+u80AKZlKzzeHYwJUjRaAxUhXuA==
X-Received: by 2002:a05:6214:2aae:b0:681:97f5:7e9a with SMTP id js14-20020a0562142aae00b0068197f57e9amr276487qvb.47.1706578934096;
        Mon, 29 Jan 2024 17:42:14 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id c25-20020a056214071900b006869dae6ef2sm2407584qvz.106.2024.01.29.17.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:13 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] mm: zswap: cleanups
Date: Mon, 29 Jan 2024 20:36:36 -0500
Message-ID: <20240130014208.565554-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanups and maintenance items that accumulated while reviewing zswap
patches. Based on akpm/mm-unstable + the UAF fix I sent just now.

 mm/zswap.c | 1961 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 971 insertions(+), 990 deletions(-)


