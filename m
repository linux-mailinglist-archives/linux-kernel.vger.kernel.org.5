Return-Path: <linux-kernel+bounces-136383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77E89D37A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C777B21642
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA17D094;
	Tue,  9 Apr 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9/fRur0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD57CF0F;
	Tue,  9 Apr 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648616; cv=none; b=HDhRgwDAbH3ODa1Kg+jVons7+HPdSXhItJAz+YaE275YtPJdM8zqQZhcZdS/wdzfe7/ZMJLuZckEypcciVhYphcO2+HXlht9gMJ4xvamGMpClfO8Ndi4nu1uB5oEcAD0tbGuokT4mGim3iCFjX3h6wjcLXMUuixMf/QSEeDqSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648616; c=relaxed/simple;
	bh=RW3Vcu+pBuM8Ouz89hCFm3+7XrBJRg4T1ezg40F76/U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kbn8+lfSCe0JRjc2XrpyynC+vDhiQ4B+GCcnAFo//L4R4X1BZd7YF/LCo9YdFyj4UXZDTJO42OE40VvRnYOSvdSfbCp0M2Hz3yuF/xZvEl6ZCL98SmQcUVV2gSf9dx4vskIX6Dkgt+vbJY9zpAl8mvo+tKHdVoWFvQVOCGZ9HbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9/fRur0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3283553a12.3;
        Tue, 09 Apr 2024 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648615; x=1713253415; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh/VM2PvaWXby6D1nbK/G/Ihjx2YeKbQpPxdCvQ3goc=;
        b=Y9/fRur0cF9uw1YY5L882ESN1kKs/eh1hTAONEE8kpGPO1o/9nZuniPV9HSDC9LSxb
         nNmPebKFLHmjkpAvR0K5VVchbm6D6/pM/CDjbgfaUVy7du0bs1UXCpT1bmfWCjBy9Ydi
         VOSQJIHEyuywL1j6SReIlYT97Vms5wLoL5eu/oVwvwRoNMn5ADmCChofoOMAz9mRLfH+
         xLWJ4vw5+5/cK3xROsGVwXtGsnsr2Oe6pIb9FFUaAbvfKB/GjtzFyBwdNTu2Tcv2yRpp
         D8UHuH6G5XB3JJtL8rJKQl4zTYT2POeb0Y4sSyob+bX3D6soYA8I5HcfHvMsyx6fsHIW
         Jjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648615; x=1713253415;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh/VM2PvaWXby6D1nbK/G/Ihjx2YeKbQpPxdCvQ3goc=;
        b=sLmAhgSq8+tmx1YQpg1/kDqhxgDhe7LYJ5vwrhaHbpUh/gz8sv1SLkhTEjdAXHFVFB
         UQR1opr8RZU2s+0Y5kSw/46DKRgSOce9m8CiNjJ/8V3x3p6V8f2Oe52TrNnq1HJglzJg
         hpMjuJxh9mN8RWvVRlXaF+k9/4OTcR2X4MzH13l2YaU1cdcWiDq2WbYLvzOzXCUUf/Bc
         fPdqTmO5I3pUVPExTExJPvUQhagOsdxpSmT6ikRozNDAdp44bA4W9NxHUjkB1dL2pUgG
         CLl4Dv/4cR55R7xtaGEo08rF+CKZeucoYJ/sNRhJom8PcdJXqQ9l1apyy6wMf3lfo/xD
         HBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJWpnQebQDBxIqjpa9Sq5UAEuL2+Q7IR9h3NSF/cqnemNjWP83wVevoL/k3Epq1nDhDFTVDUF/q+5enLuFJesy1wYptXNt3YC/soh3BsVaqIQNfRh3tqvDnMQjhzCp96uEUn+tVsYoO7A3
X-Gm-Message-State: AOJu0YwuE498lpuRLpfnZV3S6V1H5gDxnGAbQ6X3ipYstQAIwNQyJaAq
	9lwkcZKKKlFSclnFN0Lhk+6SgybjQwJGALh2LaAfdGLeDz557mAO
X-Google-Smtp-Source: AGHT+IGV+g8i4PY5Pwnyy1nv/gWQ2jZdzaluRE2j3ANO2KGktSNJ/KF430xe3csJjHxeCxRbDXGA6g==
X-Received: by 2002:a05:6a21:1506:b0:1a7:7ac1:a3ba with SMTP id nq6-20020a056a21150600b001a77ac1a3bamr4661407pzb.53.1712648614823;
        Tue, 09 Apr 2024 00:43:34 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001e40898e9acsm4248237plg.276.2024.04.09.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:43:34 -0700 (PDT)
From: Guanbing Huang <albanhuang0@gmail.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v6 0/3] serial: 8250_pnp: Support configurable reg shift property
Date: Tue,  9 Apr 2024 15:43:20 +0800
Message-Id: <cover.1712646750.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

To address the issue of configuring the reg-shift property, the 
__uart_read_properties() universal interface is called to implement it.
Adaptation of PNP devices is done in the __uart_read_properties() function.

Guanbing Huang (3):
  PNP: Add dev_is_pnp() macro
  serial: port: Add support of PNP IRQ to __uart_read_properties()
  serial: 8250_pnp: Support configurable reg shift property

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 drivers/tty/serial/serial_port.c   |  7 +++++-
 include/linux/pnp.h                |  2 ++
 3 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.17.1


