Return-Path: <linux-kernel+bounces-47392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052FE844D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942EC1F249E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E903A8D5;
	Wed, 31 Jan 2024 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TJ/o3Tgv"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0523A8C6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744779; cv=none; b=XxJPnYj+INgg87CL+htAPSdgurNAZggv51ruJxswYizTWLqO3T7gF3g3i8KhtsOgHMStU+dN9tX+G/n1v/r40w4ffm5etHjGL/fnhKlxI77RR3H8SbGqUJQ1dbVI6oBiU7NFlWexQvJzI3XIViWqcLWjmTIAW/jD3GzotUlXYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744779; c=relaxed/simple;
	bh=hTDaYZJrU10SSTugPzsW6XZg1W6hwvEaLg7CFxa9ytM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Bc4SF0LiTniC3mvjo6pZOyNW/LYCMVlssX5yxH9mjUAEKMNGr9oDFb3TFJCpSKVq0pkcWAmyS3Vg2YZ4LogE04V6YkOlVFbStWI0VC4w8QFz5GdGBnU7WUdK4Q4srjHHlnaFftr06ImHjt28P8z1xLdxt2ZKMD1w3J/5TbJvSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TJ/o3Tgv; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d60ee03b54so146789241.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706744776; x=1707349576; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjS2NBBVk3rrsqe7JY+MoxAFjS7cR/H8vNXo8eECAdI=;
        b=TJ/o3TgvNLw+wSxoJlLQ9T9k7AZw+yKSgUI65EJpCrUgzM0wWYf5S+8mUdMoWpQ7FN
         YyO0TT/PtuXzbGxDSrOLdpFfcn/tmD3vfeMVFmMVfhht4Tq8DpgjH3XRftA+dJSC4okL
         6PLWwCwrX451RGedKziE3anPFAyoqEqV3msIOo/JpUiuM/bsyEXM0BbPM7vXFTRW7J48
         +BQhsB5qXCqWcO7pJv/+2f5c4yO+uoUpOdayO6qZ5YVviYL7ydcbapQ6VXOQeAoQDpJi
         IHJRAkyqjNF79KR7KP5inwl1TOO5VP3hWq7IMtEp1/z2MJtczx+0xNN0XnEzbz+U0T9F
         8CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744776; x=1707349576;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjS2NBBVk3rrsqe7JY+MoxAFjS7cR/H8vNXo8eECAdI=;
        b=rRi+w+NuY+coX0KgrpORKE2Gmvgg+B06q1YHyDTZs8O0yo7FsMVK/OTV0olqg6xWqf
         stF4IbfFmEic1IQL2iNhFvITlmDfaUUKh/ezULJJsF07vjGTFpq7W0uwvOL/gYQwxAbl
         T2EDM0jCckim55jiTgoRW+RA2Vn1c4bl6eubQjacAhafqgd5dhqd9FZlXJY9pkQz0ZRB
         4hIdXILveDOl3HlddnpTS2UBEaVVtMpIJIR5StJoON2s3nw6GlpcXgot7yVJwSKUkIS+
         epeHLwFAOJg8iaUoiiwwLFYBmA9mPW7DMwFFXJcx8+25AU4kzev885ObpTd/COhcca+t
         8ZaQ==
X-Gm-Message-State: AOJu0YyB1TbqkfkqTo/Pw22qN+KcYs/En5i3+PPDnX1jamHarHP6Lbo+
	/cDqzhD+jjH3oa0Qrc3Zfj08w70nDmPVQOYzFsFgU9n6DFMllu06nmrEC0v+cGcWl66UOVN8rRo
	=
X-Google-Smtp-Source: AGHT+IGL8wTif13k+ed9Fv3XbFrArv/wu1eXBE9mOS/Gx3ijLXNOBKQFQxPkb0FLFyDGzaheN//xDw==
X-Received: by 2002:a67:f316:0:b0:46c:a3fc:e899 with SMTP id p22-20020a67f316000000b0046ca3fce899mr2879922vsf.26.1706744776340;
        Wed, 31 Jan 2024 15:46:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhaFwtu9H5XhEll3EcwxPmJW2p+Yal/8RNJ863SUTIl1qflt+90wQRNbgKUrV4XGilm576/M2kWHyuHjfecd6xn2b7NKBVD5EAEbj0
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id na2-20020a0562142d4200b0068c717f758asm698418qvb.11.2024.01.31.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 15:46:15 -0800 (PST)
Date: Wed, 31 Jan 2024 18:46:15 -0500
Message-ID: <8b9583bc21af9323bf40a53b7f62c5c9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240131
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Linus,

Two small patches to fix some problems relating to LSM hook return values
and how the individual LSMs interact.  I expect you'll probably see
another pull request similar to this in the next week (two?), to address
some remaining issues, but these two patches were ready and I wanted to
get them into your tree sooner rather than later.  Please merge.

Thanks,
-Paul

--
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240131

for you to fetch changes up to 5a287d3d2b9de2b3e747132c615599907ba5c3c1:

  lsm: fix default return value of the socket_getpeersec_*() hooks
    (2024-01-30 17:01:54 -0500)

----------------------------------------------------------------
lsm/stable-6.8 PR 20240131

----------------------------------------------------------------
Ondrej Mosnacek (2):
      lsm: fix the logic in security_inode_getsecctx()
      lsm: fix default return value of the socket_getpeersec_*() hooks

 include/linux/lsm_hook_defs.h |  4 ++--
 security/security.c           | 45 +++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 7 deletions(-)

--
paul-moore.com

