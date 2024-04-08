Return-Path: <linux-kernel+bounces-135124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371CE89BB67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8FCB22749
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3648787;
	Mon,  8 Apr 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0yCv5LR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250B47F62
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567754; cv=none; b=orB5TWqNE6BKLIDmzTJcp2FaWqqTPhiatFucuhb35Qwe2wvYPPQr0zh6kiARuYb09/gQBoFPtHmdckR2LvOF1GE6vz2W79IAWdOnZZbPj/kq/kWmeyic0tOWlvEt81/4EnNjDiuVkqiXdt7YJZVh6eWgIoK86B8qvEZT1/ZAYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567754; c=relaxed/simple;
	bh=JEigFgZtlDcpBgMnwJRvjSwQEXnr/LWBGj9+c6wAxB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgyCpcSVTgsaUM+y0bbvEAxw7ePCUtKFViCajJ5wbhMJJbqWF8g6zw0hvyHfN2G5p3LIZkpvsDRQHjWflGwmGbewQZoTq6ktHREJIFWYJbwCUUbOA8ICBOrfpSDSUel7sX+q56LutKUx2LVqUw2vjWEUc17IIomy/jmHEan5HV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0yCv5LR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e2e09fc27so5340062a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712567751; x=1713172551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKQ4ssH0Vp8aO7T3dWiKeARcFGoFUU64A/KjThpMFOU=;
        b=X0yCv5LRGhSFOL5va9Ns7PWKTMor/xEkEmcCgxu0nnIz3d2ISKs6nsjl+DVb9ponse
         A3FadXiuTRxIsdEC5xf3JWOtTPslA2Xc0ipH8vh31WkojQCQC0oeJz+0lgdX91S0tbqu
         6rYK1f+y8IpCj6xuW3IAiL+b7POY1WyG2axKbgrHjU44EMyJFDbwp36FbBIzXimu/6tf
         Hb5D50Cu1spR+Z/VGynPDFe89E844whsdalw1wraHNlRmXHGpCZVZXhohb/2rfR2xoLb
         qy3NQKP33ay5mO30fTzEB0NGN2nW4leScOXnQl3t6r11YfR6OT/zUpeaPnd2zqHKGCyd
         rGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567751; x=1713172551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKQ4ssH0Vp8aO7T3dWiKeARcFGoFUU64A/KjThpMFOU=;
        b=UyaL0D4XViuKP0T0Zk3/df/Pki4HDN74kk2UQqppe5Wb3PA2U9TAecjabQa0wrrtGu
         ivEwx5qfdP4D/Ask84u+x8e6wc27T1YxeTtzFVrs967B3a/bBjR1+YUrhqtMw/EcmKpM
         pc1D4V7g/vP8pRmiIbUF0M0Akg/NmLc0mSzM3/It/zXec4iYMF4BtVu4+06Q1/H8gu0T
         uhRNq3zkZ9JHVGH2HAYwG+LKwvjcT6Gxq3UbNitG1ii4OM3A0uUjygSs7AwRKB2K/8wo
         9Mizs+93rbwq+gMoM9RdSixgxS6kOogQbiyDwghNSVGZtdV7jtWGfm6nGTOTJQiS/RJ7
         cYmA==
X-Forwarded-Encrypted: i=1; AJvYcCVTPVFBNqy3JOnT2CQP2jrpci64+Htb1V2zD3RzVKs6d45vJnk8AJVTPjMJmdje6oi2MwELMVv4khq1b7ev96Sy6h7BQG2V2TzgWqmy
X-Gm-Message-State: AOJu0YyCQEimQdMOJclo5H5OMKnOiSrEAYOAlUaIQDu6Xfj9ZF2eAZLY
	BqFIVRXxmNdZKz792eX2CwhNuADuv47QFVw7278RXjpW2z13Yzxc
X-Google-Smtp-Source: AGHT+IFKe5rDA9zFhVkP8K2kKoI+k6OLDvU3aBwxBekiRsRiZJ5fEVegJJgq/AR4ZBT4CeF9aBIz0w==
X-Received: by 2002:a05:6402:4027:b0:568:d6a2:716 with SMTP id d39-20020a056402402700b00568d6a20716mr8995305eda.7.1712567750642;
        Mon, 08 Apr 2024 02:15:50 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id n2-20020a056402434200b0056de7bee45bsm3854201edc.18.2024.04.08.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:15:50 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] locking/atomic/x86: Improve arch_cmpxchg64() and friends for x86_32
Date: Mon,  8 Apr 2024 11:13:55 +0200
Message-ID: <20240408091547.90111-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following patch series improves arch_cmpxchg64() family
of functions and rewrites arch_cmpxchg64() family in a
similar way as was recently done for arch_cmpxchg128() family.

The improvements builds on recent improvement of emulated
cmpxchg8b_emu() library function and introduce
arch_try_cmpxchg64() also for !CONFIG_X86_CMPXCHG64 targets.

While the patch series enables impressive assembly code
reductions for somehow obsolete !CONFIG_X86_CMPXCHG64 targets,
the true reason for the changes will be evident from the
follow-up patch series, where this series enables unification
of several atomic functions between x86_64 and x86_32 targets.

OTOH, by adopting the same approach and similar structure of
arch_cmpxchg64() macros to arch_cmpxchg128() macros, these
patches lower future maintenace burden and technical debt
of the source code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Uros Bizjak (3):
  locking/atomic/x86: Correct the definition of __arch_try_cmpxchg128()
  locking/atomic/x86: Modernize x86_32 arch_{,try_}_cmpxchg64{,_local}()
  locking/atomic/x86: Introduce arch_try_cmpxchg64() for
    !CONFIG_X86_CMPXCHG64

 arch/x86/include/asm/cmpxchg_32.h | 207 ++++++++++++++++++------------
 arch/x86/include/asm/cmpxchg_64.h |   2 +-
 2 files changed, 129 insertions(+), 80 deletions(-)

-- 
2.44.0


