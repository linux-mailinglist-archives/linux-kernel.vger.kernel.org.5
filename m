Return-Path: <linux-kernel+bounces-149107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE88A8BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6BC288D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80023758;
	Wed, 17 Apr 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ry4nIhtM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708B1E895
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381283; cv=none; b=dm0LoICKytNk592B1bjVt62+Oauo5tOhczkcPwzg4ic7E+BnJP8ESrcTVvzywjgpCGz0B1xafF7YVIajEYALMJ71rpFnx00YZSGHf87yJHLE/MBNgXSbdHqGFErn8EiDXU6tEz9IXRZ8SnZnJSGfBWLPeyCWaXNYc7i1vk7NQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381283; c=relaxed/simple;
	bh=j3qtkOvIu5NbbjZy+XtkB7ACU21ZGmO9yIcEK3aYMtA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U3BLFQJG6GIsXYW7D9W3KH5mfOX2BLdPoixyIQgl+NRgIBvHzwjiBgGXbkW7VaVpOSOvpFfpACsc5OPamFOwlywTV2EtP0F1/r6ojLefIB9laX1wepu/WdUGCbFKEBm+aOKeJeEi/6ZTLJ37BWqTWZpwZr9eXYLp1UC1+BVYv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ry4nIhtM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a482a2360aso1006936a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713381282; x=1713986082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wzyp/UH0jiy8sQKjCgNes1kTmHnUc2aQBFCGoELS9Y=;
        b=ry4nIhtMRSXi4o2wlTC7wqDebiNx6tsGS6nBBEGXp/g6FMW7vdBrWHXKuuZX6UPTha
         eSXMaC1sHJ2u4BTuh3uHOzqXfZPjzzKa0zbwXap2/vbhtz08LhPIzCsQPrUawKYR3GRn
         K5lfU7x5SMD5itmpwec3VqYSsnBLbUSozMOGwYFjgKRKMwsGGBxajE3JYrbI+SNdihOx
         fj93kDh0tCV8G/WfW7EDjpP1YlCzdbrpOVZPa+Benm9m2ePhPPWygPW5wOwemf8L1SYz
         DU+Uv5Q2J6U8tzP/25Wg27b2Rw7ZslTvcV94nDyTWgIGBOlgwIJOhP55Xsr2oRWNBQ6Q
         v7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381282; x=1713986082;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Wzyp/UH0jiy8sQKjCgNes1kTmHnUc2aQBFCGoELS9Y=;
        b=kBgB3wB5SCu0YWH4TGl4mLAafkKy1ZH+xOPmE9h2buYX+AR96/VfBsVFzoG/7pPyqL
         7fbW0MuXwcR2LmfcAoKsS6rO8Xc4kf6AnfleHllu7wGWrRmvRiuE++W2D/VduItkbfrQ
         7JRY0PSIPEXibHICKgCXFLktx89Robc1xgDgFJoHSNX5xtVrD/c3zoFY4lB3UBEM9Zj9
         uYcvaB2rpjt8qrMQh36O0WfM2VfHnAijzU77VWZxgN7yD/L6Jdsj/pB9mU68bjeXfRlj
         xqAfqIHpeH+7Q3vtF2cu1ZT4vGCjLxPZF5TjclyfxVOZIqqov18Ft7Rnjx+xyrlkr5Hj
         WtCg==
X-Gm-Message-State: AOJu0YzBw/isYVz2gPYpav3pEncqaRHIquDxXEjAtUBxIzAFo7VLhanj
	PdWCCQY0NG+H+TMajbOm7Omlvr/qB/pLBNaQ0HccetNAwFcsYzbZjBq8zD9VXO5rYkz91ByCNvo
	6ZWvEnTo1+w==
X-Google-Smtp-Source: AGHT+IH7/Aa367SHEy+NegojZYO1oPMAye7GaDYMPJA1YNPkWO1SC9j+QPzjmAPsbgELwb1zZNKMGLO6XEgIjQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:398e:b0:2aa:ab39:fcb6 with SMTP
 id z14-20020a17090a398e00b002aaab39fcb6mr669pjb.1.1713381280812; Wed, 17 Apr
 2024 12:14:40 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:13:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417191418.1341988-1-cmllamas@google.com>
Subject: [PATCH 0/4] binder: optimize handle generation logic
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Tim Murray <timmurray@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Martijn Coenen <maco@android.com>, Todd Kjos <tkjos@android.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patchset adds the ability for userspace to select a faster handle
generation logic. This is implemented through a new ioctl that enables
certain functionality on a "per-proc" basis, this is required in order
to maintain backwards compatibility.

Cc: Tim Murray <timmurray@google.com>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Alice Ryhl <aliceryhl@google.com> =20
Cc: Martijn Coenen <maco@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: John Stultz <jstultz@google.com>

Carlos Llamas (4):
  binder: introduce BINDER_SET_PROC_FLAGS ioctl
  binder: migrate ioctl to new PF_SPAM_DETECTION
  binder: add support for PF_LARGE_HANDLES
  binder: fix max_thread type inconsistency

 drivers/android/binder.c            | 78 +++++++++++++++++++++++------
 drivers/android/binder_internal.h   | 10 ++--
 include/uapi/linux/android/binder.h | 13 ++++-
 3 files changed, 83 insertions(+), 18 deletions(-)

--=20
2.44.0.683.g7961c838ac-goog


