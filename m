Return-Path: <linux-kernel+bounces-99668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA770878B98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2921C2116F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAA58AD7;
	Mon, 11 Mar 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4dWM25w"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8D58ABF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200487; cv=none; b=Iy93AL8sOgFcdeL8AKi3uKVqtgvuUCYNEPZG+3bwY4bgzPbEoqZYiSfPNOLK8XYNdz2gYKpP9z+JBMxKQ5T/8wGnc03W/FOSVL8PTlPy8YX5E47RqiWuCUVjbW0knIw9aevn3xxqCuClbGTaiICvSDDNHJkgvMASEPQaLScEcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200487; c=relaxed/simple;
	bh=oMBEUrIufNiH5v4Ezh8LCLg7QmBGNpZT2yXP31KEKm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AWcocMspLhU3v1ARSodTGe+v4aWsRKlWbyya46As9Ykka3ZkE4cUF651qRk2rnoyv6MfxO5QRbtzZHlInF5lK3d5gYDkgx72S/yoZWuTgI2kQu/jF0JVjMv6rfS089u6G1UHF6kxNqtofjnPu7rWzpW9XJYLaB+YRda19Hzol6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S4dWM25w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dcad814986so37896305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710200485; x=1710805285; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sijOqUV0v9b+uu6ucC7y1n+V6LIAN15M66Y7AMirCnM=;
        b=S4dWM25wdVnn/V4sveILyhwzGtZNqtJxvlNY2pH/fLfVdM44X9gVdzlPRWzRZCrgsp
         HNp2tgQEhCGYjmYThXRREjH/gJ7T9Vl7F2K7yh4lqjrFNmqvMBHODixe7pdYwwKxvU00
         LwbKsV3/1fKpKQ965sMHotjxAkBBz9tUP9Y98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710200485; x=1710805285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sijOqUV0v9b+uu6ucC7y1n+V6LIAN15M66Y7AMirCnM=;
        b=iS9VnL6Eau5vIeo+m0Yqo34RMjC0mtTlu0kmqzTRdj9juAHHmfiQw3JRdmjTmPbYj0
         eziUZYYYJQZuNATTQ77qrH/o+rfLnh09sSPmg+h/IagcJuQ6UaURL4AbZHxDEZDEZbp5
         mnk9ZCqgXXZ1XvbVHghGEDW48D4zoboTuEEtidSLnO6FiMBdCk4H9RrGeqElgS3R+teg
         aUel+qpKhhRB7PUcqwOGuAAcMNlV28cNsXpiaZSNHoWwJiyicUZAmSv8/+bUfYXulwqt
         KAqZMznoSmVP+ycj9c0i0gtdJT+4k5HnG7ZE8V0mkFhRrDotAeENBAJKvDK7Y4oYdnrQ
         M/mA==
X-Gm-Message-State: AOJu0YzPJiJR1en9Hf/bzCqyaKvKN6tf1UrL4lmk0V4/BPa1mKmjTJ0T
	smzaxIIKUA8PBd+URLdvIItOW8Egq35K/m1HwqWigDTQnikyk9H5PnltThnsDw==
X-Google-Smtp-Source: AGHT+IE4FPC62JWv24Re4HnAvjBsvlPzELc8KjZdIGfSWVJernlkYiRfS4rgmxzDYiTK0R3q5UfsbA==
X-Received: by 2002:a17:902:edd0:b0:1dc:a8aa:3c86 with SMTP id q16-20020a170902edd000b001dca8aa3c86mr7725774plk.5.1710200485198;
        Mon, 11 Mar 2024 16:41:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d949393c50sm5283343plf.187.2024.03.11.16.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:41:24 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:41:24 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Terry Tritton <terry.tritton@linaro.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp updates for v6.9-rc1
Message-ID: <202403111640.68D9B74844@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these several seccomp updates for v6.9-rc1. There are no core
kernel changes here; it's entirely selftests and samples. Details below.

Thanks!

-Kees

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.9-rc1

for you to fetch changes up to 56af94aace8a0489fb1a32fd6f1cf0c548fe3911:

  samples: user-trap: fix strict-aliasing warning (2024-02-12 10:42:02 -0800)

----------------------------------------------------------------
seccomp updates for v6.9-rc1

- Improve reliability of selftests (Terry Tritton, Kees Cook)

- Fix strict-aliasing warning in samples (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (1):
      samples: user-trap: fix strict-aliasing warning

Kees Cook (1):
      selftests/seccomp: Pin benchmark to single CPU

Terry Tritton (3):
      selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)
      selftests/seccomp: Change the syscall used in KILL_THREAD test
      selftests/seccomp: user_notification_addfd check nextfd is available

 samples/seccomp/user-trap.c                        |  8 +++--
 .../testing/selftests/seccomp/seccomp_benchmark.c  | 38 ++++++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c      | 41 ++++++++++++++++------
 3 files changed, 73 insertions(+), 14 deletions(-)

-- 
Kees Cook

