Return-Path: <linux-kernel+bounces-19956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86021827757
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675C91C22951
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F454BCE;
	Mon,  8 Jan 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXU1KPLe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72C54BC2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ced19f15c3so1556280a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704738270; x=1705343070; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wntsga8MBQJaWaP7YapLiJi+lAgkD8shAgSVOuCyoMM=;
        b=OXU1KPLenpFSZ8qZbqRCvsmamYmbQ4IH/jh+hS+o+5MMc/81whiR6lZRDKny6ltTQs
         +CiM2JB9dJFYX+hdQv7rWY4d2+YolfmyjuuG6si6Vg/8i3Lvjy1XAKSgYc9+cwdCV0FD
         RtbgQ8n/xnbTfz4PdxKBHhC/3d4NmrN7o+G/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738270; x=1705343070;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wntsga8MBQJaWaP7YapLiJi+lAgkD8shAgSVOuCyoMM=;
        b=XRFVk3b1kmTtTQKovAVD6tj8NTQNx8eWsYtG7J0KIZk0r2x7e+/B9pUzh1bHkrnJbZ
         iX4OKQqaKE9TsU3bcnF1BAa6o9Tcp51RQy3VeKAUDvvcDnoGqR1CMUpMtO5+1bu4NAux
         60Lysqygtmbv9cFpxH1Rv++MiVomAHsCurV1u7XzTfB6UVhK7j4bihKAUPpShaesTRIo
         D3pfxk031U8DEsZcrGIuMzd1LYdkSpNwytsHVbmjCK1rHFCnB6wo8ne96L1I+upfhyFl
         hsLBlwtaZeVdBn+uqqVjJDVtGTv5yfR4kv5ad1mcvqAhdw8WnhmmTqxCVALo/0t5BGKZ
         ygAQ==
X-Gm-Message-State: AOJu0YzH1RUkrjzyENbzz1XuPg6ANr907AChyqrAgCjxBxKAXhR+ty5o
	DBA+ol8BsVeFe6UAm3FR2tgZTMoy5rSD
X-Google-Smtp-Source: AGHT+IH0a3ojzF5womZNmVLpf6U29HBSD1aeSujdsfiHNgTLeltOj+tIQc6pmhJ2ghoGWz8GO6zekQ==
X-Received: by 2002:a05:6a20:7494:b0:199:6bb9:df5d with SMTP id p20-20020a056a20749400b001996bb9df5dmr5451336pzd.24.1704738270492;
        Mon, 08 Jan 2024 10:24:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n3-20020a635c43000000b005cdc081bd2asm170992pgm.24.2024.01.08.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:24:30 -0800 (PST)
Date: Mon, 8 Jan 2024 10:24:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Tony Luck <tony.luck@intel.com>,
	Weichen Chen <weichen.chen@mediatek.com>
Subject: [GIT PULL] pstore updates for v6.8-rc1
Message-ID: <202401081022.31D251086@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these pstore updates for v6.8-rc1. These are a couple small
fixes, and a refactoring to use cleanup.h now that it has had time to
bake in a full release.

Thanks!

-Kees

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.8-rc1

for you to fetch changes up to 24a0b5e196cf70ccff97bc0add6fa7178ad50cc4:

  pstore: inode: Use cleanup.h for struct pstore_private (2023-12-08 14:15:44 -0800)

----------------------------------------------------------------
pstore updates for v6.8-rc1

- Do not allow misconfigured ECC sizes (Sergey Shtylyov)

- Allow for odd number of CPUs (Weichen Chen)

- Refactor error handling to use cleanup.h

----------------------------------------------------------------
Kees Cook (4):
      pstore: inode: Convert kfree() usage to __free(kfree)
      pstore: inode: Convert mutex usage to guard(mutex)
      pstore: inode: Use __free(pstore_iput) for inode allocations
      pstore: inode: Use cleanup.h for struct pstore_private

Sergey Shtylyov (1):
      pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()

Weichen Chen (1):
      pstore/ram: Fix crash when setting number of cpus to an odd number

 fs/pstore/inode.c    | 109 +++++++++++++++++++++------------------------------
 fs/pstore/ram.c      |   1 +
 fs/pstore/ram_core.c |   2 +-
 3 files changed, 46 insertions(+), 66 deletions(-)

-- 
Kees Cook

