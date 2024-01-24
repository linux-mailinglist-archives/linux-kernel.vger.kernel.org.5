Return-Path: <linux-kernel+bounces-37631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977183B2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C402892DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE9134722;
	Wed, 24 Jan 2024 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eqNaNKTg"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE3133426
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126713; cv=none; b=aYOEJeMK1sp4vVh857dk6Dj8Ue0JWrUi6a2Eg9kAdAw7NjN6P0G/5pMQKZ5SXaEv+lCUaER/MDoMEqDcd7TuUQ0+Y4tsZlHVvGyKEPyfrwTcIu33N6j6Nsx6iZZEV6OswrNjYa32HFNfmcjk/25EY54KUkZbbVd7fu2+5+0CByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126713; c=relaxed/simple;
	bh=hE4dimkg1tvF1dEV9pXga/AdXg9+cmfNncPLB9cwyTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b9RVSCslZWKB26B3CoQ3aNtoXCp92paej2PIOxkW3ImBgB23QuaVf7b+YGLKtJvib63zk/GKHE38yU7g+gOoI2Q3NjYE/+uPFJO2+8JRItpqeMVo8UkHjns5EAeI4dHmu8rE+kjpHglQCh8+Q9lO8uVyWP+qkGA1R+lgWknJMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eqNaNKTg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfb81124ecso4304694a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706126711; x=1706731511; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Y7koMM394YcEzPAIuYhiOvpOOgnTMayLM5RiqJ5YNw=;
        b=eqNaNKTgXVtwSHCsvnh3+iLwk3OIAi3nqW7xtuT4anY0ElR37/O+oAWOOsdhfvL0q6
         QOp2pocVfis3MogCjc1R0OYDSRTwzkAiBQKtuuA37lnUcIvmv2C1cXTjhiNxMC4Acci7
         0z4Q4vRQSlcSv+DdXlNx6Ryti7rD+kf+ouqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126711; x=1706731511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y7koMM394YcEzPAIuYhiOvpOOgnTMayLM5RiqJ5YNw=;
        b=hicKSktC5TpehcS1nUpGIViSOxL0XqncPCWnX4BSplme+mlkBJ32ytxMXdjanVpgeE
         BwWB0f8F/DZidM5Um4wAhy4KwNveseEEeUVwXo44m2DDzthOBYypFskorLh8uTVVteiC
         yHGHt6mPXFGKhAXGbmf076/DPRo0Wqs/ZtHHHIMtoDAEEXdFVPLU47uMD182FHBeRpeM
         lSttm6OsH3jqgaWx7G1V1wwsOt2YJMFyEbDwzQA1T8UsSULsvw6aLjUyUSF57NT1c7D8
         8ZJ0F/1aCOg/J5ELnEYmQ1/lvsIVvEZLGy4qaMeT3FxLGQyGamyNXLHwwE+K8wjsHIky
         0JnQ==
X-Gm-Message-State: AOJu0YyYDEtO7vFTh3sHSdIO2ulmr4sLMJvHzyyWE92md1pVhh/U6olK
	xCVeHB81if4LXeDdYK5wqSCQe6aMYUGe1vCjw39v/fTBDZzmsyIb9DFPld+tgQ==
X-Google-Smtp-Source: AGHT+IHyOJEA1doA9PRcDsZemMCTGq4AfFgxZO9zVue12fkcWcsq7bdPSJK+1tDHuQmnMlfwSX/5jw==
X-Received: by 2002:a05:6a20:3b1c:b0:19c:32be:628 with SMTP id c28-20020a056a203b1c00b0019c32be0628mr1149240pzh.81.1706126711561;
        Wed, 24 Jan 2024 12:05:11 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f28-20020aa79d9c000000b006d9a13b491csm14013414pfq.212.2024.01.24.12.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:05:11 -0800 (PST)
Date: Wed, 24 Jan 2024 12:05:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Askar Safin <safinaskar@zohomail.com>,
	Bernd Edlinger <bernd.edlinger@hotmail.de>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] execve fixes for v6.8-rc2
Message-ID: <202401241201.A53405B0D1@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve fixes for v6.8-rc2. One change was sent as part
of the original -rc1 PR, one is a recent fix, and the rest are cleanups
related to moving the open() earlier. I was waiting for a couple -next
cycles since -rc1, and since we were already working on the in_execve fix,
I figured I should send this PR now too.

Thanks!

-Kees

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.8-rc2

for you to fetch changes up to 90383cc07895183c75a0db2460301c2ffd912359:

  exec: Distinguish in_execve from in_exec (2024-01-24 11:48:52 -0800)

----------------------------------------------------------------
execve fixes for v6.8-rc2

- Fix error handling in begin_new_exec() (Bernd Edlinger)

- MAINTAINERS: specifically mention ELF (Alexey Dobriyan)

- Various cleanups related to earlier open() (Askar Safin, Kees Cook)

----------------------------------------------------------------
Alexey Dobriyan (1):
      ELF, MAINTAINERS: specifically mention ELF

Askar Safin (1):
      exec: remove useless comment

Bernd Edlinger (1):
      exec: Fix error handling in begin_new_exec()

Kees Cook (2):
      exec: Add do_close_execat() helper
      exec: Distinguish in_execve from in_exec

 MAINTAINERS           |  3 ++-
 fs/exec.c             | 39 ++++++++++++++++++++++++++++++---------
 include/linux/sched.h |  2 +-
 kernel/fork.c         |  1 +
 4 files changed, 34 insertions(+), 11 deletions(-)

-- 
Kees Cook

