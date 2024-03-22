Return-Path: <linux-kernel+bounces-112118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE07A8875E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E65F1C2248B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E282C7D;
	Fri, 22 Mar 2024 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlPjukNo"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1428174C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711151838; cv=none; b=T/fqu0pbwcb74wCpimJIZ7Ef7Y7mO4RFxui5JOSfz4fnh+B4T6Jb/QnEdKKylD0/Noh2Zp6iZUNjOUkml8J6i4AEnZ4oFGDyiQeSGwd5HVU8tzculydp5QqofvmhBp4bWGy462y6XMHLv93roPOzVug7tGXG0hgTGmrXDcwKh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711151838; c=relaxed/simple;
	bh=uU8lVmAuNAcGsbGMACEh+b0UM7t1xrJOGABQ/Hqy2M4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ss9rbB2xp1ewWPailapcwSphuaxbyihHzOmxWGgi3aOqsONBrLddkiCq9hoUiaRD2Nh+33tiHQEdFU0wCS01YblEP0kA4unQKNH0l1uLchFexXtLseteTZsfhi0gKRmG+mFRhsqgscj5rapVtoQmBp9Ah2V3ymu4IErtawCYeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PlPjukNo; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2226572ccf8so1602237fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711151835; x=1711756635; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BvBQsbrJmViGYUyffjiNgWneo+LjEJnsprmW9VkcYk=;
        b=PlPjukNogDOFK9/38KmhzIs1sOzqU0c001HlzoWjV/7edSHzgdPzbBCNaaRuBkzZX6
         s8aJw+rjzRmU4CW68Ek3dJhIGv1L1bK9rE8RXXEhduZnWxiuCoNUT26IOmPOLM49x+id
         oz85IVLU6YPoljy7u/Te3LtnULFUlW4VyJz4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711151835; x=1711756635;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BvBQsbrJmViGYUyffjiNgWneo+LjEJnsprmW9VkcYk=;
        b=cdPW2cSaTA3uUX4Ew49OSVtYaHRxCbPd0pcV700Uz+sZ7zTDEi9vgnGTbSS+QRGkZQ
         SYvITPQ/qXuoKzrJ2jlVa+9pZQTxWeM0ihRq0Jb6uOXIWiClgzSDD+m0NntfLtmCD/1A
         3G9stUZnURX/symOFB5XzenQ9Ah/Rjtxp32VLZYT12ttDXou7o67wQTsv0AEMeNqLUF4
         YVLrOifiqlFYaa1dUjbKLY21j99Yy00e4tzi5JX2qr4eRpUWALRbCFeNd2+psofSweZg
         BTe3m2kwLQXggtbI8ntOF6d/kSY/YrNf4v1nTcoCfdZoDhyr+HyYOCZkDcYwl/3nO+Og
         dj6w==
X-Gm-Message-State: AOJu0YwnE9g5xMh8xMUnSHDVx0iZmGUKDGqLewvD8x3E5k9MVtOlZwTk
	DLmVD7f87Y6e80mq+dzLCnZPr90Nb70rCHC/OdgqiDDhCloqtEcW1wLgzRy/iw==
X-Google-Smtp-Source: AGHT+IHlbAjHmpZv2PECXkEbnRQviLX31SB8/37bTCsmgbwmooqqvNTjkYmIA8pNh23KM4MQK/BJeg==
X-Received: by 2002:a05:6870:1641:b0:221:3c64:fbb with SMTP id c1-20020a056870164100b002213c640fbbmr1353951oae.30.1711151835770;
        Fri, 22 Mar 2024 16:57:15 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p6-20020aa78606000000b006e73508485bsm322293pfn.100.2024.03.22.16.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:57:15 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:57:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	David Gow <davidgow@google.com>, Guenter Roeck <linux@roeck-us.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Liu Song <liusong@linux.alibaba.com>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] hardening fixes for v6.9-rc1
Message-ID: <202403221655.A2BCB96145@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these handful of hardening fixes for v6.9-rc1. One of the two
"end of -rc1 API refactors" I mentioned in the first PR is included here,
for DEFINE_FLEX(), now that netdev has landed.

Thanks!

-Kees

The following changes since commit 0a7b0acecea273c8816f4f5b0e189989470404cf:

  Merge tag 'vfs-6.9-rc1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2024-03-18 09:15:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc1-fixes

for you to fetch changes up to 231dc3f0c936db142ef3fa922f1ab751dd532d70:

  lkdtm/bugs: Improve warning message for compilers without counted_by support (2024-03-22 16:25:31 -0700)

----------------------------------------------------------------
hardening fixes for v6.9-rc1

- CONFIG_MEMCPY_SLOW_KUNIT_TEST is no longer needed (Guenter Roeck)

- Fix needless UTF-8 character in arch/Kconfig (Liu Song)

- Improve __counted_by warning message in LKDTM (Nathan Chancellor)

- Refactor DEFINE_FLEX() for default use of __counted_by

- Disable signed integer overflow sanitizer on GCC < 8

----------------------------------------------------------------
Guenter Roeck (1):
      Revert "kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST"

Kees Cook (2):
      ubsan: Disable signed integer overflow sanitizer on GCC < 8
      overflow: Change DEFINE_FLEX to take __counted_by member

Liu Song (1):
      arch/Kconfig: eliminate needless UTF-8 character in Kconfig help

Nathan Chancellor (1):
      lkdtm/bugs: Improve warning message for compilers without counted_by support

 arch/Kconfig                                |  2 +-
 drivers/misc/lkdtm/bugs.c                   |  2 +-
 drivers/net/ethernet/intel/ice/ice_base.c   |  4 ++--
 drivers/net/ethernet/intel/ice/ice_common.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ddp.c    |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_lag.c    |  6 +++---
 drivers/net/ethernet/intel/ice/ice_sched.c  |  4 ++--
 drivers/net/ethernet/intel/ice/ice_switch.c | 10 +++++-----
 include/linux/overflow.h                    | 25 +++++++++++++++++++++----
 lib/Kconfig.debug                           | 12 ------------
 lib/Kconfig.ubsan                           |  2 ++
 lib/memcpy_kunit.c                          |  3 ---
 lib/overflow_kunit.c                        | 19 +++++++++++++++++++
 13 files changed, 62 insertions(+), 39 deletions(-)

-- 
Kees Cook

