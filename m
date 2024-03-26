Return-Path: <linux-kernel+bounces-120092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6647A88D173
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B051C64F65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70B13DDA4;
	Tue, 26 Mar 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+Vmormj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF554BFF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493061; cv=none; b=ADBrVqVfDHkK+WXB5wvVnUnnotfYURfcmJqIFkUcSLYQ/iHGf54ICJXKuX4T0XeMW/V20oAldnRdUvH627u2M5PydnZGD6avBxS8Vud8hm0GQEOS4KYvqWoV0jwtLorzAaNFvXupXFA0O2s7Zqsf6cD/VgIEm2HRM9gFydA1EKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493061; c=relaxed/simple;
	bh=DmzPSzaPgO5ZdYrZP/V5WrYINYntX9rvKUOE24fNeNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F73ivZVwLwkatTvObdX53ltyHyKoLU1Y5W2s2gHDWiLv7uv6997Pp16EsDrZAmmvWQ7NiwwfTkJMJlsh2/f5mWQUCBgbt2ffqt3MKC/RHg6TX9F7l1zIaw7m8SU/KxLD0slKII4jRJnX9CCfnr7nRK5wPhAAB+lTGl80v58kQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+Vmormj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so4402136b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711493059; x=1712097859; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXI5ZdGfMORIPiIcqImDe2wXt3ueShbSXK4sRTx/QcM=;
        b=W+Vmormjn9EU5780R1Fax53N0KdU+9zbOYFEFW/CcBsS6FaDchRjAvZhUqjZea4RfO
         NrWHg3DqEkG8smFoAApc2NpVJicTfIzKJIhchEVtpCwm3PMg2aJUXqT3Jrh2hJIKA36D
         U0tbOjsTlWCHN/Yysfp5msqnVdWSewEVgZJMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493059; x=1712097859;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXI5ZdGfMORIPiIcqImDe2wXt3ueShbSXK4sRTx/QcM=;
        b=SaPEmGLPp3j07VAen1gUlUQT9cyaksRwc/6IXEjHuo5dTH9j++uaK2abYUcGtDDnQn
         RKN1bdvmVPBPzAeLUWNy5r10llsO/0NrT1//BP+VLm/Nqjd5+X/bkkgS0SWE0pvVMYo1
         aKYTR4LjdUQtEJzqPqX3NhFhXl8K3+U3bAnslbCAA2yLgRtLu4NX4+zh26zhY0X6WS5c
         Nr7YttWqB0UTDNbmstcgA9y2G9VAhkKwKr+uSGJMrbqRlW5NNK1urfKSRZ4Ck3snX9qe
         IYF/sNyavGbn98ccrbzW/r2subUL3Xnpvc8iJuzn5t3Pp2zg7cXQNzio27D6v58T3v7w
         4jfA==
X-Gm-Message-State: AOJu0YzvD7N6ou++q2LhLlT4xJfnCcSQnf2+PHPmQwWQGXmGX9DFv5h9
	jX0iMd4IO3C4nimVF+0kMajhf5cx4raLHKLzIVUHlOtfHC+JUCc81moQ2HNnwA==
X-Google-Smtp-Source: AGHT+IFYNEPpAhAP0GckgmftIJyxv28Z7U0cdsSZCG176h42q0yhHHC6B5JG435IRLzrseqndsRg+A==
X-Received: by 2002:a05:6a00:1896:b0:6e6:9f03:6a6d with SMTP id x22-20020a056a00189600b006e69f036a6dmr1317580pfh.3.1711493059527;
        Tue, 26 Mar 2024 15:44:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hy4-20020a056a006a0400b006e6a16acf85sm6550957pfb.87.2024.03.26.15.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:44:19 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:44:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [GIT PULL] execve fixes for v6.9-rc2
Message-ID: <202403261544.E7B2404@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve fixes for v6.9-rc2.

Thanks!

-Kees

The following changes since commit 725d50261285ccf02501f2a1a6d10b31ce014597:

  exec: Simplify remove_arg_zero() error path (2024-03-09 13:46:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc2

for you to fetch changes up to 5248f4097308c1cdcf163314a6ea3c8c88c98cd9:

  binfmt: replace deprecated strncpy (2024-03-21 20:20:52 -0700)

----------------------------------------------------------------
execve fixes for v6.9-rc2

- Fix selftests to conform to the TAP output format (Muhammad Usama Anjum)

- Fix NOMMU linux_binprm::exec pointer in auxv (Max Filippov)

- Replace deprecated strncpy usage (Justin Stitt)

- Replace another /bin/sh instance in selftests

----------------------------------------------------------------
Justin Stitt (1):
      binfmt: replace deprecated strncpy

Kees Cook (2):
      selftests/exec: execveat: Improve debug reporting
      selftests/exec: Convert remaining /bin/sh to /bin/bash

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Muhammad Usama Anjum (3):
      selftests/exec: binfmt_script: Add the overall result line according to TAP
      selftests/exec: load_address: conform test to TAP format output
      selftests/exec: recursion-depth: conform test to TAP format output

 fs/binfmt_elf_fdpic.c                          |  2 +-
 fs/exec.c                                      |  1 +
 tools/testing/selftests/exec/Makefile          |  4 +-
 tools/testing/selftests/exec/binfmt_script.py  | 10 ++++-
 tools/testing/selftests/exec/execveat.c        | 12 +++---
 tools/testing/selftests/exec/load_address.c    | 34 ++++++++---------
 tools/testing/selftests/exec/recursion-depth.c | 53 +++++++++++++-------------
 7 files changed, 61 insertions(+), 55 deletions(-)

-- 
Kees Cook

