Return-Path: <linux-kernel+bounces-109599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C6881B44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6BF282BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE95CB5;
	Thu, 21 Mar 2024 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWWr4v1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20E5660
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710988971; cv=none; b=rFfAOPAyIgL8jKiLSMFWUgBdD9jieVhZWaor3XgMUalk8vvcpydhHQv+hpRPeNiHlR+l0DAv5+v9VVit+dhoTXjp7WL6CDKfHWJkCEYqzMMjjC+x7k6gZ3fgs/bcguJ9g1HTcE+ppLwSonGGT2t5V7X9JLZKQ7jCWqxq6uPrj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710988971; c=relaxed/simple;
	bh=ND3Q6+ESxisTfW3w6/xHdoln2tpbUoz0Cd7/rISA0Nc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KedEgs6RivgqJIMU4lZQkFF7ANcLrc6EmOfBxfoII2XjKhx4JR+zQrXXBbjZYYanCcAxmZQjiODebaeSCQkJWZXQUJwz0UuFvz8xzW+D0hX+J0pIZH3koi5Sn6XKJzlWJ7KHf4/mP6TWZlON4Xt2DzQ7V9KzePqig34Z2/uyBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWWr4v1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7084CC43394
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710988970;
	bh=ND3Q6+ESxisTfW3w6/xHdoln2tpbUoz0Cd7/rISA0Nc=;
	h=From:Date:Subject:To:Cc:From;
	b=gWWr4v1A/RPLYgiXIjxYPJzCUCdU3xTCpoJ1PDS7ZCANgrIfOjVEPCV+r/suVB9Sp
	 YEyGwPlgH9WfXTqpbN7ZVZ6x17glYYQNiTGZ+kYWk6zZnaRKHJnJuE5xh1CdCkHnm1
	 9curc/2uqUqyajMYQ05O3QssDqMscodgKglYbcgXVFhQc/4VUQ/8Wq+9hTzcxb6sPI
	 Jam+MHyeAXl3Tj3YwL0Lq7sMpS2MHWyMXHB9yn4ei8Ha37j8FxDURll+tyfRCOHzx3
	 wd14QQGSdzWsVOB0CnEpEbADIp7bLxSb5gXR1xaiC0LR/rrQw/tkg0fg3Cb3L+3tMW
	 8/Lyo6M9ABpNg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a1fa3cf5eeso193706eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:42:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YwNB2rLaruD1uyyT6xxiWqh7+Ar632wFZQxXWoSiEAItg/hBZjU
	ymgZqh4+pYcP9x+cPOGVZK+KeO0YjIZ5RrRmKd4AN4Pcvpy/EDmxudeJIbMEsw6eQbgKu60NyPi
	Doa0qXdm4oiJzZbILxnA1UgrTFIk=
X-Google-Smtp-Source: AGHT+IE38QaBvjwFcJR+2ahM5aUtmP4iUkbHIUbV70NpnMljQ9Iib6wcwBZ3hrvQ0xE42tgLfQPZDtDJT/l0qX8tV+g=
X-Received: by 2002:a05:6870:ac28:b0:222:73c1:4a06 with SMTP id
 kw40-20020a056870ac2800b0022273c14a06mr20959642oab.1.1710988969781; Wed, 20
 Mar 2024 19:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 21 Mar 2024 11:42:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-iGLkXgDa8cj8Un7xz_8zW-AYncpyfy16-2y9KNLNJig@mail.gmail.com>
Message-ID: <CAKYAXd-iGLkXgDa8cj8Un7xz_8zW-AYncpyfy16-2y9KNLNJig@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.9-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 855684c7d938c2442f07eabc154e7532b4c1fbf9:

  Merge tag 'x86_tdx_for_6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-03-11
20:20:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.9-rc1

for you to fetch changes up to dc38fdc51ba650871f12e4032bfe170f5b0e8ed0:

  exfat: remove duplicate update parent dir (2024-03-19 20:56:10 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Improve dirsync performance by syncing on a dentry-set rather than
    on a per-directory entry

----------------------------------------------------------------
Yuezhang Mo (10):
      exfat: add __exfat_get_dentry_set() helper
      exfat: add exfat_get_empty_dentry_set() helper
      exfat: convert exfat_add_entry() to use dentry cache
      exfat: convert exfat_remove_entries() to use dentry cache
      exfat: move free cluster out of exfat_init_ext_entry()
      exfat: convert exfat_init_ext_entry() to use dentry cache
      exfat: convert exfat_find_empty_entry() to use dentry cache
      exfat: remove unused functions
      exfat: do not sync parent dir if just update timestamp
      exfat: remove duplicate update parent dir

 fs/exfat/dir.c      | 290 +++++++++++++++++++++----------------------
 fs/exfat/exfat_fs.h |  25 ++--
 fs/exfat/inode.c    |   2 +-
 fs/exfat/namei.c    | 352 ++++++++++++++++++++--------------------------------
 4 files changed, 293 insertions(+), 376 deletions(-)

