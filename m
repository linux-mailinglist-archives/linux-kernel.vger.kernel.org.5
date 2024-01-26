Return-Path: <linux-kernel+bounces-39579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DCB83D32A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E79A1F21B87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E7B66F;
	Fri, 26 Jan 2024 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N79/ZHOw"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F98BEB;
	Fri, 26 Jan 2024 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241553; cv=none; b=O5GQ6DYuzvSW2HSJxqIGBUYFfGMyXH8fySICXogLqlppZVKl5YCDzBzvUnVuB1tA7l9yKscYOxHUcQcgAjqFaORTWNNdHGLAYfXAkix0FtOWr+TxNSSBk+7ND5Fb+67ODRQHAKXjJCMzAlN1CS4iOo5MaW6m8AYboLn6kRrkR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241553; c=relaxed/simple;
	bh=9PGZnr9DqncF9EDvC7v/PimAr8ip2S49EjXBXBPDjPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQkFQpOd5RrK6WySqv45c07m8HI3qVVHG5YB8h8GoMOxB/j9ZXKrfiXbapt3h7rOaEOS/bPIu2Y7KsKtYbMUMAjKFOFH4JN/V2wwFsGNgW9EnOzE1ZmvJmnTba3ZEZdrk1GKARhOvzim6+jHDtd0XSL+lQ7N2yzN2izQpLb0x7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N79/ZHOw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783cfbfb3bfso11892785a.0;
        Thu, 25 Jan 2024 19:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241551; x=1706846351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ckkYXVSZxHt6wdec865f1qzS+f6zHaco8fzhz6qTjJs=;
        b=N79/ZHOwY5dOephcUcYx89lq+VzVwXH++JYYJvdLSY/NiaoehjgStZLvCLtJ4rg+8V
         zts574uT6GLI43rrQehslQd+GzcMe9gYQrCAzHeEWHJBWzXbWz7IDbCELRzdq5TbtCEE
         0UsraPuSB0+tXrhvUaOLP7unN7pJd7iQD2pywTE9jNeuU7ovJaAIkFtKIIKU7DNYQ7zK
         P0TpyrB3H4F8VQbnUzqNhdhF04sxyWD5u2UyQy1Fu5e/XHFa7CBgbG9cXCJSsPKwva6c
         rrTMVNLXvDKsEXsSkY9dTnBbiAf2+1ZCQRQX64BZUUXb/k1Cl3zH/Ar5njqVnNw/7/JE
         5kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241551; x=1706846351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckkYXVSZxHt6wdec865f1qzS+f6zHaco8fzhz6qTjJs=;
        b=Ch4GA+qaauORaTCKUoztsB7prgAIsuShRMNCtMi1ZjLps0Ul0zPaOaygmCo+N1A83Y
         UnEuykTObLRcrQ//8Yig4+Z0IawqlS5cy5qvwyQaUvOvuZ0A+MuXhL/Bb6JWWsdD0DGO
         nZKS/8ZuCXrD+ClmSpO52bd1n47df4TPCpzkENaYOrNFPMthbACOp7Ei44UPkZN4UKkq
         INvNPBCvIxvtMZVcNMJ6q7cXuFs2KS5JmdpqYbwDd9NhD0JdWSMkuF7S2ozKHK+cG1/6
         py1ilgv2LpNuvW2pRdB68SzgqrwYUM8S7GeGBxfTd87PPsmnz38XsRpLcay5ivCaLMwG
         Q1bg==
X-Gm-Message-State: AOJu0Yy2GSI6hzcsKU3IvgZPYzZCtaFqVNS2d5r7OIDLut3Ap354jSad
	1cDuqpBtDN9zFr74XWuYDAiSxJHTfxBwgBsTJRyKFjKkDRmc/5iU
X-Google-Smtp-Source: AGHT+IFrygunn1NWMjRlqH1G2TOLSSh5C4VKgQLb8M/SL7/o4UpQHEaqOLic5jL3NRS7+1ThpIXgxQ==
X-Received: by 2002:ae9:ea17:0:b0:783:b568:257a with SMTP id f23-20020ae9ea17000000b00783b568257amr878746qkg.39.1706241550602;
        Thu, 25 Jan 2024 19:59:10 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a166900b0078391bc0fddsm206949qko.77.2024.01.25.19.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id E4D2527C005B;
	Thu, 25 Jan 2024 22:59:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 22:59:09 -0500
X-ME-Sender: <xms:DS6zZR1kX0HIIvCtmn0Q2cCtAGJTDGMm9gmsNl-zPJO5cIgByWD5eg>
    <xme:DS6zZYHKQULaTiOD465BEYoJbHzUOKaDt4Jy3ybCJlkkQKImvFgw6AcfNZ2aNEcF4
    MR38Ju67bOSosTNnw>
X-ME-Received: <xmr:DS6zZR53P9Zp4CjTx-Gjs4Y9zslIIK9-9IY2Yj7qK8r53zaVJ4GfJHoaYfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdttdekledvfeelgefhleelveegffetheehleejjeduheeujeehgfegveef
    teenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:DS6zZe0XllaekththDHvMYlAVRo6VYYi_ns2XUKWLW6_XZAVENiedw>
    <xmx:DS6zZUHiJohxwBYpNSlVQc48V4MQyt88SX4OYWUN-d8HRBAQ1iOYZA>
    <xmx:DS6zZf9Xp1r0qdI9fnyBrbWUKbTnFfn_QrKnKkLTNRZuJEkqGZUpiw>
    <xmx:DS6zZQicgAkyTi2o4wUhxlJTlpvmhVyYJ9QstrIC6DnlhX0oskRzFg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:09 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/8] RCU doc updates for v6.9
Date: Thu, 25 Jan 2024 19:58:03 -0800
Message-ID: <20240126035816.3129296-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains the documentation related changes from RCU for
v6.9. You can call find the series at:

	https://github.com/fbq/linux.git rcu-doc.2024.01.25a

Th detailed list of the changes:

Paul E. McKenney (8):
  doc: Spinlocks are implied RCU readers
  doc: Make whatisRCU.rst note that spinlocks are RCU readers
  doc: Make checklist.rst note that spinlocks are implied RCU readers
  doc: Add CONFIG_RCU_STRICT_GRACE_PERIOD to checklist.rst
  doc: Add EARLY flag to early-parsed kernel boot parameters
  context_tracking: Fix kerneldoc headers for __ct_user_{enter,exit}()
  doc: Clarify use of slab constructors and SLAB_TYPESAFE_BY_RCU
  doc: Update checklist.rst discussion of callback execution

 Documentation/RCU/checklist.rst               |  32 +-
 Documentation/RCU/rcu_dereference.rst         |   5 +-
 Documentation/RCU/whatisRCU.rst               |  19 +-
 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         | 484 +++++++++---------
 kernel/context_tracking.c                     |   4 +
 6 files changed, 293 insertions(+), 252 deletions(-)

-- 
2.43.0


