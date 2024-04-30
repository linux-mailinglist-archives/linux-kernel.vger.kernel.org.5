Return-Path: <linux-kernel+bounces-163941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C968B765E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF7B28538F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5B171661;
	Tue, 30 Apr 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cAgPPTG7"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDF17106E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481747; cv=none; b=SqpC5dFTUiuJIwb0qpPdbbMw7TQGExi98LMTJ2IA6bCKg/7BiMBeEWp6gVZda9/ogO/0EVnSMmuTU3tl36yuOkCruEkOz4YhbZPidNsVxxQeuIz1YVSqsPSJ5UBCZkhRWpC0l04llMwfXU7HebcfWUl7q8cM2fWvQBIsBU7mHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481747; c=relaxed/simple;
	bh=ymy/fp5mLT/4kJF3dKBCd+P/myDVkF1uuerplReb058=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HIPrGw9uucGK/Y2IiaNoOEdKfULXkdsK4ZHi3Lxtn5GqQWSrzVYYzJtPjo0XrsN0HmCe+RVo5wXou6rugpZblruC4YjucYOU1WCh7eENPtdEmCadsTpEPLEhKgqMhzXtKz3rEG6eXrKJEtS3kl+yynApA3vSshS45cZc+qQjtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cAgPPTG7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ef88ce8701so136960a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714481745; x=1715086545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CgeBm0XdaNuxr8uEfhJTx7AIAXMg8xhP5MTh7KQNKBI=;
        b=cAgPPTG7G9muNdfmnhy1g7k4Rf9Tb3p8iRnGJ88dE4P1FQIdStEXiCIqkJyAJB4Hse
         KgkL+ishkx+b1+DDFMpdWgq3icf2FINY2n4JfwxeqvqpDvpzyGVj6+ITg/+6EPHRhYfn
         vvVNuQIeFDC0sx9jCAfADfAxgWAyZVThc8OLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481745; x=1715086545;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgeBm0XdaNuxr8uEfhJTx7AIAXMg8xhP5MTh7KQNKBI=;
        b=htBEKyxiFD3ruGOpXv1brEJVrJsMlOE+q7PdKY9/IdUMVlG5ZkhfRoT6/7OdWNAFoQ
         u5D4GYrvIOQ6hLTHk+STr2KUKYZ3uxybJHkx16avgk5XupajoBXCfVii21Pn7qUtKebV
         ttuZLqjJYZRLP6j7rof7Y5lerRUnRsg8VYtXWWIgV/Pkl+VpOes7rAE6xZafvdl9o8Jw
         /KwflKS30xfuTguLP6aILoLrlVOiOqGcR9BmGK5g4ORk1hO50XtP9iMNYo0OsP9LyOng
         3mmkjOryT8QnxoiCNCg/XlHPpcFfK5AdLHPrQQU0WjHH4NDXssYvX7QFjojb4ODZRUVh
         z0sw==
X-Forwarded-Encrypted: i=1; AJvYcCUIBhoGEnaUVU+qgcHs38frRXv4RzLzY3u9aOq1JUGVi9X7uuMDxzeMmfWXrN0acD6QD4PLCbGOpUZxPCvfllX2ZzxyI+7bP9mzLFeU
X-Gm-Message-State: AOJu0YzEJQisqegAbI5UAIIzrEJ275KiTxaEk95Z3jq2pu79U4VCItzf
	FI+gyVtGyngmDSJCPQEwIO0JtPM3uJJqHZZUZA7yVt4w+vzuZPDskl7+O0DNXA==
X-Google-Smtp-Source: AGHT+IHK+UkEoJUcRYPQc5IQrFxF4JRM1NST0KtJqc0AbuUvxkd2lOUWQ9hQXkwgdZ+rMSMra/Xocg==
X-Received: by 2002:a05:6830:a4e:b0:6ed:e67b:8699 with SMTP id g14-20020a0568300a4e00b006ede67b8699mr9740879otu.18.1714481745272;
        Tue, 30 Apr 2024 05:55:45 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a111000b00790f90ffc32sm1553667qkk.22.2024.04.30.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:55:44 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/4] media: Fix compilations with !ACPI !PM and !OF
Date: Tue, 30 Apr 2024 12:55:32 +0000
Message-Id: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETqMGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE2MD3bTMCt3MglIzXQuTFJMUU1NDUxNTIyWg8oKiVKAc2Kjo2NpaAFD
 7SptaAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The current media-stating has some errors when configurations are
missing. Fix that.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (4):
      media: bcm2835-unicam: Fix build with !PM
      media: intel/ipu6: Switch to RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS
      media: intel/ipu6: Fix direct dependency Kconfig error
      media: intel/ipu6: Fix build with !ACPI

 drivers/media/pci/intel/Kconfig                  |  3 +-
 drivers/media/pci/intel/ipu-bridge.c             | 66 +++++++++++++++++-------
 drivers/media/pci/intel/ipu6/ipu6.c              |  6 +--
 drivers/media/platform/broadcom/bcm2835-unicam.c |  2 +-
 4 files changed, 53 insertions(+), 24 deletions(-)
---
base-commit: 1c73d0b29d04bf4082e7beb6a508895e118ee30d
change-id: 20240430-fix-ipu6-84d4d5515452

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


