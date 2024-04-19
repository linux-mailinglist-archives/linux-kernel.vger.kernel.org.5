Return-Path: <linux-kernel+bounces-151932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A78AB5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571BD1F22685
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505113CAB5;
	Fri, 19 Apr 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBOc3h2i"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DA13C9D4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557779; cv=none; b=auNxsVeHzKwvqdaUR3wGCstJYCZpY06yfdsH61z3Wz1Rs2YiEYwzOnuCOsg3ymuY4+KYcMwuRVierSwlUKEylXhlbZ08oVmcZ8wOUXUNm1yEA1YCg7yVwcSJgJcsNG3HIh0cRwtexCZa90gucXUDPXoBNqZ+4HVVDGayEHeX3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557779; c=relaxed/simple;
	bh=d0q1IW1XEBU5UHI05e3nfjuTPDWFrdtEDKL189lSXdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ksw7SKv+e/jMOXGB/pIv8SB9OSoFP+Hid6Qopgx1e/ei+l434C8aN2cD2B6xlkeQrXA1UbW5VS/yOVzKSwLD+a2SD5O54rz+CTO+P/92tSA8Uuiut+rbc3W4xvfz83zQveu+vnFJA6/o5Q7Im3RUXFUIc6/j3tebsCU/iJrDQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FBOc3h2i; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1910280a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713557776; x=1714162576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+/599xU+nUmogYnOR3yI4+vYZ2pGK58sVKiIZs85hA=;
        b=FBOc3h2iejbz3sY55NoKzRCL35aUWGIj1eWjPvMg9pir6Lohyf0UfA3uXE4QGzi8s2
         u7DCOy4hZLSS4I+g3yljgiGG17ADi5N0aNQG2e4pas50H39OsIjHDjpcJgwRFnMbkgZx
         /Z7g83p+RQfSgUegIZIOArkYSeAkIwGVcLoD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713557776; x=1714162576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+/599xU+nUmogYnOR3yI4+vYZ2pGK58sVKiIZs85hA=;
        b=cFx1cKaM8tKhqLhIOcS+6YcUqE+2mKALjYeQFX5QctLqs+ZvULKAMunFtsvWTsz1/R
         G8Chv8loZKqUh9g+yvVNVRd/Xz7cuXo03XX4H+OerTQKYRcrZYBsrgLmLWstnpxqiQmB
         8wKDcMOsYJJUvuyluaoDQwreJM+denactZcfEWWxsvc1gT5n2hnjglknsLUpK/h14tJG
         cikqXulsmccmqk+1wW7MlSoDjkUhy54dQ+lLZZgMRo1XRy8OLcO/YrxfeCtjkBNwr8YN
         th3eyc/TKpkHWWk4u7redTY5y8ZJr8XjUpUeFwc33zlIRaY96C6MtMbMz6dyu9Mn5PqQ
         oaqg==
X-Gm-Message-State: AOJu0YyUFxShFZzqIuWB+6wKvkFBTJ2LU5jAFfavqmhXE3gIY41nFgJJ
	Nm0FA2uy6ae93JPVeGgNuRRgkFY7LzefLRnWtYslNKZ0PJeED2cz9EMYiWgFm7n5PLuiTlYFgN8
	=
X-Google-Smtp-Source: AGHT+IESIHnKRRrJZ4YRurOTzp1mRm+MQEnrwRis6Ui4Meat51c36bIKxDRi5CAyK1ll0Dy5V/mRjA==
X-Received: by 2002:a17:90a:688c:b0:2a2:e56a:ca8f with SMTP id a12-20020a17090a688c00b002a2e56aca8fmr3567335pjd.42.1713557776015;
        Fri, 19 Apr 2024 13:16:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sv14-20020a17090b538e00b002ab3bffb765sm3548735pjb.32.2024.04.19.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 13:16:15 -0700 (PDT)
Date: Fri, 19 Apr 2024 13:16:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] hardening fixes for v6.9-rc5
Message-ID: <202404191315.2714F7D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these handful of hardening fixes for v6.9-rc5.

Thanks!

-Kees

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc5

for you to fetch changes up to f4626c12e4b538f757a73d08f4d86d564175b4f7:

  ubsan: Add awareness of signed integer overflow traps (2024-04-15 17:42:43 -0700)

----------------------------------------------------------------
hardening fixes for v6.9-rc5

- Correctly disable UBSAN configs in configs/hardening (Nathan Chancellor)

- Add missing signed integer overflow trap types to arm64 handler

----------------------------------------------------------------
Kees Cook (1):
      ubsan: Add awareness of signed integer overflow traps

Nathan Chancellor (2):
      configs/hardening: Fix disabling UBSAN configurations
      configs/hardening: Disable CONFIG_UBSAN_SIGNED_WRAP

 kernel/configs/hardening.config | 11 ++++++-----
 lib/ubsan.c                     | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
Kees Cook

