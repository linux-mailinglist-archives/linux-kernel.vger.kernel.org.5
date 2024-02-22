Return-Path: <linux-kernel+bounces-76405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAD485F6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9A21C23324
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5045953;
	Thu, 22 Feb 2024 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILh4bB7T"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A83E468
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601269; cv=none; b=loz/7Seh8XUbh5MLy2VhOlvrb4+sZ5B+Y6S8FssEIEXb2IQf+dV8vXfLAdudawburE6GwPiOHWFAhZkQ29YrqMRRDnJ7wckblUoum7lDrceCQTshoiW052izI3nVnuTR3/p5QHI09VogOsWzp1fgf51YwODsjGCZZJBhwdowsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601269; c=relaxed/simple;
	bh=DG4XrtsqgphYVsnmeLdkLtDdcGvur1lDat2Ig6P6zi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3L5Q4FbTfFuZdz625po6hQzMqhEPKg8fygmZda0NzoemruD6CoDt+u5T+jlphi5m1t+R1dac1DZ39NpuEDVk8ojTVllKcHSyEOwsA+YiVwVZYHZXdwGGY9h6qHQSIIEZBkpYMb3q42A/DrJscQHMVnlzYnZ7dMJGcDCgLHyJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILh4bB7T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so10371434a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601266; x=1709206066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALsJyHwdi+2qR/Va23biwRHOywzsGpcHTh1aUvggZuc=;
        b=ILh4bB7TWG2OEDC66c3RpIQDvRNS4A3jICotovfzQo4RcBab9qu7S6FR0S5IZ52lR+
         Ntb8uiC4CFyKR2Vuy1n0gI3vIxO7s7Sury2OBSmNl9SicJpCp8P0rc0q/tq+/uiXjGik
         K7Bqt3D+i9Oxslaoq4m5yrcU8eu1f5xfX+oGnJmcoi4pIsg0pR9muRxp1MYE64y3AW1E
         /Xxu71sUBXdK+pAVCoZ712UxQtQtqSc+ASBhmJmyo2oVhOQ5lU4muB97jwhlNmF9nEtV
         Nhun5hDAO8C6IA+1cRc3Hk0qnBNbn6ZOM/6lFYRxnFy/26tjpukD2y8Peda0goZI7TuH
         pmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601266; x=1709206066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALsJyHwdi+2qR/Va23biwRHOywzsGpcHTh1aUvggZuc=;
        b=N7nIXV+ikRjCSMFABgUbcK0OUPUfWZAFK7DMuh4NE2hiACDIPgpZaeQyHZV8yGxigg
         6LP+RCvEhit5hfBEZSt2flqG7BFeAHbSGnttUdbA6eb8YV814WqxzH3lvWwQkHbckn0w
         ejBLMysD/1NCSTqNvslXmFhszEtHGfVJR5u37zeZ38bbOmx4RWsdqBnznt5f3ejGqz6B
         mC7PvzKaJN1AGYSmO40xu37oZNQpguouHu5722taW06MchB/uYIQZw8mr5O3Pz7UT9uq
         uYxOBn1Jk93dke+0/1Go/WcbnFuAnfCzNMBGYpfBGv2Sq9etL71rR8uk9h/qY+AYPEfb
         5jFw==
X-Forwarded-Encrypted: i=1; AJvYcCWjMDbJvMEjC2y5+0EOoKb0qLja70qKAsDqM/1J7vOMttIniyN9IKgBiBEF6E1UDGt1YzZzeqkJ9W7Ykysl0Jsl+oH6GTRwiVolyTh1
X-Gm-Message-State: AOJu0YxL+TetGRkWFgtviGlkBTEPvBGQa+9+htvpm962sMei7TGRkZw9
	69HAVCw9lPrhis2G7ujVba8zDNRlBtLCtJvFW+5y18HP/wi8XI58
X-Google-Smtp-Source: AGHT+IH0aJIT1HFwj4QA1KMRPq4lg7hQfp6qn4cgB7VR+7USZ/uYp2Z1PaKBMqnYQiKkuS0p+ATxJQ==
X-Received: by 2002:aa7:c886:0:b0:564:46be:5e0d with SMTP id p6-20020aa7c886000000b0056446be5e0dmr7514772eds.21.1708601265524;
        Thu, 22 Feb 2024 03:27:45 -0800 (PST)
Received: from localhost.localdomain ([95.90.186.51])
        by smtp.gmail.com with ESMTPSA id ck8-20020a0564021c0800b0056452477a5esm4338524edb.24.2024.02.22.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:27:45 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: rtl8192e: coding style cleanups
Date: Thu, 22 Feb 2024 12:27:20 +0100
Message-ID: <20240222112723.18428-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another small series with coding style cleanups.
Compile-tested only.

Michael Straube (3):
  staging: rtl8192e: rename rateIndex to rate_index
  staging: rtl8192e: remove empty cases from switch statements
  staging: rtl8192e: rename enum members to upper case

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 64 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 29 ++++-----
 drivers/staging/rtl8192e/rtllib.h             |  6 +-
 3 files changed, 48 insertions(+), 51 deletions(-)

-- 
2.43.1


