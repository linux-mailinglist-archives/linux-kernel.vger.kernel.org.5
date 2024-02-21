Return-Path: <linux-kernel+bounces-73933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D885CDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B651F24CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970EF7490;
	Wed, 21 Feb 2024 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wdp4NnZS"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568866FBE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481211; cv=none; b=SVfIK74kamIt4YlgtcoOtjNCV2Hq7aSKppzprBT0sbsbGp2MvjoaSko7yajsxAR9vEtyH7DjEMUILZgVnamBIA560Db9FbypA8m9gz8U2ykLsbziEJKaMUfKvEtcAVDg6Cn6DEkVqgFRAUMi2HE2kd0AzM34Zyj9+TjUHoQfU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481211; c=relaxed/simple;
	bh=nQQwbZd7w+TdXbxPmBTMKI41ZFTqLXxkk1KsZxJEf3w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TJgvRe82CNIoBiA34s2+tyPis7zN6QkhaQlvv/FV8Ooskv0+V2aHRWOgObQCqNnu0HgyDSeO46pze9+GMaVyqh3Qo74x2fukb5uYObOiVynPOq9dl+fyK9a+5Ny+n6gI91KoWrcTdDBEVSqj7E9sghNICrZmVLN94cSJqne5zAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wdp4NnZS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e3c50997a2so2769267b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708481210; x=1709086010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgstNCUbrnmqEZYy0cHgu3Xis6IzzivxnlRx+bQ7zy4=;
        b=Wdp4NnZSvMOijU//KaPyEn3S2EjsSpOMMgLTUtN3Lt4EUsDRIIGN/gmGpjs9VN7yvC
         8/sO4Q2UQPq5fBLXD8ToH59ebcKtDI9x5cHzRGQG4iYCACXxqfr6oMRk2yQvsgyjJtq9
         Vf+ZsFrhvyhh9rwU/ZKDd0qIuzRQ+BIrgn8BgP8rxtuAVv5l85kkOwC77ICgQ+m17AA5
         +l010pDNu03po5YmSU2c68HJ857sDcwDFFF9pubEKlZN3HZnh5wk7cNCDIKxEDjQGw1O
         b9PAi6NIbWQUcp3AJCkowDQNj7LrhjzLweiz+IqDf4/t52aGHxtd+aGd+qFmdjFFI6tc
         A0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481210; x=1709086010;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgstNCUbrnmqEZYy0cHgu3Xis6IzzivxnlRx+bQ7zy4=;
        b=w9GWkqYTHAXscxTmvapYNj2eXBakTAdV/AtZdhSIY4GnmsVOTSCwRJob+Vz0AYExjV
         03I9DehfULwjcWsE201OCm8hVWnWbuu7+KQuAHe4Wp4/Z+CNeyIH2ZFdMfVi/yqyR4R7
         hvHPn9p9bMYNmP15QC+QRsAnkxSUcLYa1s/aBQPOrMkFXE7H6uTdttoGTJLXqBcsiGK7
         hlrkzdXi8x4v7uiz6YKGRRDxp6sqlWIbsuJ8ThtCqAbc/vaDTQgjHUOtZmoTKuPnekTD
         ou7Z8YqvTGqWt5GGHLXb1mWl7AraOoXEbsxH8w9zWElsBKLFpAgeliPSN0a8J7sjf432
         b0mA==
X-Forwarded-Encrypted: i=1; AJvYcCXnECdLRxokSWW6GHbVrPXT/sQSvAPHICMbKOmcYaVnwZrLBdhUi4Ve1nPjyYuCSaKH0zE6qNzAK/cplYseb0yiEBJ6OUZLXC5iPy+o
X-Gm-Message-State: AOJu0YznvZMWFM3IgmCTUGn2AIuPQsAjwfAb7hhYRH/U/o+FVS9y3vn3
	cj39y1ebw3eualmFJJFIo8PJVu6f+jt7MTjP/EA0rngTjX6Vly2+Hd90vUfbSqIuldz+V13pKvw
	Zeg==
X-Google-Smtp-Source: AGHT+IEtEI8jkWe5k2HTwu30Yt6febdEU1pRxRzkRV3CgSwMjJNDBDv4dG/0i9O7XC/gur74m3DcbtKKxxM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1248:b0:6e1:142b:6d49 with SMTP id
 u8-20020a056a00124800b006e1142b6d49mr250313pfi.2.1708481209568; Tue, 20 Feb
 2024 18:06:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Feb 2024 18:06:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221020646.2540408-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.02.21 - No topic
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No topic for tomorrow, but I'll be online.

Early warning, PUCK is canceled for _next_ week as I'll be unavailable, and for
the last two weeks of March.

Future Schedule:
February 28th - CANCELED
March     6th - Available
March    13th - Available
March    20th - CANCELED
March    27th - CANCELED

