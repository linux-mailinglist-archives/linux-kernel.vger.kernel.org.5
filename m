Return-Path: <linux-kernel+bounces-37324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F883AE55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DB5B27C87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156F7CF2B;
	Wed, 24 Jan 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h3xy9l+w"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501837A70E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113340; cv=none; b=Ft7rIvVrxsH7SXXHwKu1HDjo/EEky1MzFsjtB5R8nhZ2RQaZqGYzA67I2OTxGw5P/UyO7w9AJd/qKKdhVQ3lk3u53IjLFpe+IiOOoYuFXbqrgTAPixhnfNBmz1s4V+NsFh63DMcANzCkE41GEAgId9NBw9MVwDeprap2LhQoWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113340; c=relaxed/simple;
	bh=2qjGnuDh6ifwIgUcyBjFu+JwoBrM1hrX5M+nsUoGfzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KA5jwPGACU2e/hryB1smpGlErIxZg04tyl9CrDUPi/IeZ+PJjFIFiwQoEiI5M9L2/zsMWt/gLQBUx5l/OvtQJgGr/bohPQ5f0alin0j/L4zjLMC7L0xFqXLDeFzZvckT4wzw/Eiey0H2ie7/0P7ZDnN4EPY4Tj5EceIFkMr3yJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h3xy9l+w; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71e24845aso33732085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706113338; x=1706718138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1/+Q4HNXD3rHWRCH2nnbFJqBHbEhLGtYiYO5EM+jKk=;
        b=h3xy9l+wxTrDWTI+WoLBGYgYEPVMRrs4jT2paulnrjT6JpBj5vS5dt928ZehDRac1M
         FkJAV0B3giY1+ZvehgJ/4HnH9kAK4tSp4WXl4gVjk9dhyUg3vpxpyLI2Yuebj9ibs1Kx
         mnXJSdCQvWNr2WiZXyGxMbDV7TEgJ/tkC/z7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113338; x=1706718138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1/+Q4HNXD3rHWRCH2nnbFJqBHbEhLGtYiYO5EM+jKk=;
        b=LI04KDbSgYGdpvlr9DbJHuhFR6VQ/nRq41h23hnG5pB3kpWM096+NAnZ0ws3hQ14U5
         9KETnhENaBIRD8VFh5ljFfLhXKvAFWqiELfkxKrApjz0hUUdcjsije3dRMMO+3TZhNyb
         Akg+Pq1jMuDEG8AUFJHOTWzxv8V9DTdvoEZNPG3PaR3zI3vNigSSPizo81hHVxD+KxYO
         1RSBB7OJG1HKLJQ9bQTtqUMTVmBsqiwBTqnKUyERFgAdJL1vuxASk8U8fwMfyq2enyoO
         6RnGhaTKGgrhPQalDC+ZNnZ75aaZrgbNVQGIz7GeKqInzqtdVmOLlPwriPQoGEQTP0Q3
         ve4A==
X-Gm-Message-State: AOJu0YzQ8mE3p3yCLtJcMfy18olw/1VJ82mnECS8Wx1G/tgvET9aw1J2
	97EhlPYm7ghN7QywQKUiJx4BfSKJ4SGjUuD8wTx+yJWHp8BlpPunfEGqcyl+CA==
X-Google-Smtp-Source: AGHT+IEMyrGoauSfrCz6I+smyfnlOJDl3pWToiG5+wb77vGP3m7KnGTGC9r0R90tWXQ+wmVP6ORsrw==
X-Received: by 2002:a17:90a:f98d:b0:290:121a:c382 with SMTP id cq13-20020a17090af98d00b00290121ac382mr3920287pjb.24.1706113338662;
        Wed, 24 Jan 2024 08:22:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090ab89000b00290701c8623sm9072570pjr.28.2024.01.24.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:22:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org,
	Terry Tritton <terry.tritton@linaro.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com
Subject: Re: [PATCH 0/3] selftests/seccomp seccomp_bpf test fixes
Date: Wed, 24 Jan 2024 08:21:47 -0800
Message-Id: <170611330425.2663547.18299563068150086794.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124141357.1243457-1-terry.tritton@linaro.org>
References: <20240124141357.1243457-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 14:13:54 +0000, Terry Tritton wrote:
> Here are a few fixes for seccomp_bpf tests found when testing on
> Android:
> 
> user_notification_sibling_pid_ns:
>   unshare(CLONE_NEWPID) can return EINVAL so have added a check for this.
> 
> KILL_THREAD:
>   This one is a bit more Android specific.
>   In Bionic pthread_create is calling prctl, this is causing the test to
>   fail as prctl is in the filter for this test and is killed when it is
>   called. I've just changed prctl to getpid in this case.
> 
> [...]

Thanks for tracking all of these down. These look good to me.

Applied to for-next/seccomp, thanks!

[1/3] selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)
      https://git.kernel.org/kees/c/18975ce05799
[2/3] selftests/seccomp: Change the syscall used in KILL_THREAD test
      https://git.kernel.org/kees/c/fbcdf41167fe
[3/3] selftests/seccomp: user_notification_addfd check nextfd is available
      https://git.kernel.org/kees/c/0c6f28a84431

Take care,

-- 
Kees Cook


