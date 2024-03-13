Return-Path: <linux-kernel+bounces-101187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5E87A3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85A7283048
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E589E17588;
	Wed, 13 Mar 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER3EPbND"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82162168CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316753; cv=none; b=u/hdweTwfMUt5zaOB++vF9EfJQ+LRkfY/zygtyoPE59DRF25VYC91hk/XUhKjGEj3UhKND8rd6wam3ktHhNxZchjZo18MA8twCZqwF+0SjgJb6KeOvIn91wJTIGimtPM3zflfOQ67v9g1g7cTXVwwwio6O4twH2MrX54RC4Jow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316753; c=relaxed/simple;
	bh=q+qcFCVN+8qOeJnlbBAPgfVssdFLR1xbMoqBCTMrCXQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NSmwmrP8Os3z1Yg/KkL1tIPQzrHxc/x7XiUeu07PTM3vWLkZsdcl/EsYfCKlA0EpvcFUqjtToVJw3UnrXk08NeTh3pCuUNhr6ylIY+2OjQ067L/lJqzhLEGrkRmNQEKjJgQ4cWiY2ZLQec+msZtyEOx8geYrUfWcQ0peKnl6ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER3EPbND; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so872179a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710316749; x=1710921549; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2LV9+nYbBq5j2mh5nDsTue/YcwXza1QFubwAYcXUGo=;
        b=ER3EPbNDlkaZMg3bAq4PZg83zS1puMYovfTMygdcOQhJqFhJJvfXTqn29j0PAceR0P
         Ug9IDvi6YEF2x/uDm2CFYNJ4/GY88sA05538qamRYZsaro00yQyuyR7H0Cw70iqKtLxX
         I12jyDeQNBMUQL/UtZcIrucz6XSFyb6AqXzauAgCPze2Q7E1iLLqz7Dcvi85UpLXcRBL
         cDvgteGonOl8wj5o/UFpQB7Q1VNxdYaUD6VQGT9Pm/tXf5LcSBJy/NzQRLA6sjWuayqs
         ItVs9Y8QoFU87c7/WZGLMc0A2RY8zZH8x50HYxP5FhcJNm2hAUedBiMYCAsQy2v+Odo1
         sHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316749; x=1710921549;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2LV9+nYbBq5j2mh5nDsTue/YcwXza1QFubwAYcXUGo=;
        b=P2ejeadtymwVRmqp3AoOJUeI0qZPAtYC6e4r/BsiHN4b40UQ1bofCJciFB5bWpdna6
         m1pq7deuzLfQ8ittUnRXstON2QS6Fj3l0XfZkWN9Qc6Ef4MT6qAXkqnSBhga1IlVqzUD
         w79muxabahmjAqiW9+SyBg+K/X8W0KvqEdlQLvsOOB4Rr6KYhlNsbmqxCdwHbNfN6xtx
         yJnCsAqjxgY2nOCARKLbIx6L4doOSrXz5fHVYOVkJarlpSDYL1vzfVlPcpTwBFl7/7P5
         98fD0mXwnd0/YcSp1aUv+5+6pYdcHra3M4d+4biWMP+ggjhFtPQg6AdLGM2sWWIFUydL
         8uSA==
X-Forwarded-Encrypted: i=1; AJvYcCUkDi9kSJwhf+3oEzYkX1PATwnv1BDxJ73HFECiAAn3TAePS+RkKp4SP42PxqvZtDLst6r/ynGjPOPUUWUo7+8w2c4Cb6DgvIbeIxeQ
X-Gm-Message-State: AOJu0YxNv3HGEw/vhWuMX/jjWsk6wwY5Yic+JwuRcBurTpK/l/ItTgNT
	titBBiBXrI/mEd5LaJgT/LGRFF2wS1KWIS2nogwl8O0P2pzrC7rT
X-Google-Smtp-Source: AGHT+IEXhCmnlpKmoL1ss/cBt/Ilp5OY7Ni3lJIvuIoTQ+/kRFIOZVfJbwlCyzhp692SSVMCr9ltiw==
X-Received: by 2002:a17:906:2e86:b0:a45:4416:1fbd with SMTP id o6-20020a1709062e8600b00a4544161fbdmr3368291eji.39.1710316749087;
        Wed, 13 Mar 2024 00:59:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id qx26-20020a170906fcda00b00a45a687b52asm4594185ejb.213.2024.03.13.00.59.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 00:59:08 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 0/4] Cleanup vmlinux.lds.S
Date: Wed, 13 Mar 2024 07:58:35 +0000
Message-Id: <20240313075839.8321-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To support 32/64 bits system, we have some definition conditionally. while
some definition is duplicated:

* __PHYSICAL_START has the same definition as LOAD_PHYSICAL_ADDR
* LOAD_OFFSET could be defined directly to __START_KERNEL_map 

After these cleanup, we could reduce some complexity of vmlinux.lds.S.

Wei Yang (4):
  vmlinux.lds.h: fix a typo in comment
  x86/boot: replace __PHYSICAL_START with LOAD_PHYSICAL_ADDR
  x86/vmlinux.lds.S: remove conditional definition of LOAD_OFFSET
  x86/vmlinux.lds.S: take __START_KERNEL out conditional definition

 arch/x86/include/asm/boot.h       | 5 -----
 arch/x86/include/asm/page_types.h | 8 +++++---
 arch/x86/kernel/vmlinux.lds.S     | 7 +------
 include/asm-generic/vmlinux.lds.h | 2 +-
 4 files changed, 7 insertions(+), 15 deletions(-)

-- 
2.34.1


