Return-Path: <linux-kernel+bounces-20128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E10827A39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FE21F2379C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34A56450;
	Mon,  8 Jan 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCIZZa+P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E756443
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEB0C433F1;
	Mon,  8 Jan 2024 21:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704749617;
	bh=lmwJ4TYsfZDUfDxWWmBpM5usHBUnDUnWhMnytg9qbfw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=CCIZZa+PTCgih80p2a6lysWTn0GEWXIsYpz5GgrSUu+UWo80BFZTmNY7zOQoLb3++
	 /ZMY0aE76dEbmada0x3aRrNhEKb4BKAFGk13QTCMCJBR9m3+tspthOaH9wZSJMKCs2
	 LQpfUhOE2Un0F+kCr84TEBBLnU9v+K3n8UiQfom4SvXfoRFTjvovxr9vIvN1am/UzA
	 eg6vrIZPjcTGWeJpubTmfEnaFao5q1MwWYJdKt3QVKgDxbZoMOuOjw6Acl4n4XMBWW
	 m2g50UiCbiT3Sav6YrEFHoT6xnqRJ10FJa8jyJMxXL70S+f2kfAhPMh+ajuoCms543
	 i4tvKHSj43WPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 95715CE1FD6; Mon,  8 Jan 2024 13:33:36 -0800 (PST)
Date: Mon, 8 Jan 2024 13:33:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: lucas.dimarchi@intel.com, ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	intel-xe@lists.freedesktop.org
Subject: [BUG] allmodconfig build error in next-20240108
Message-ID: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello!

Recent -next trees get the following build error for allmodconfig builds:

------------------------------------------------------------------------

drivers/gpu/drm/xe/xe_gt_pagefault.c: In function ‘xe_guc_pagefault_handler’:
./include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of  size 0 [-Werror=stringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
  644 |         __underlying_##op(p, q, __fortify_size); \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s, \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of macro ‘memcpy’
  340 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
      |                 ^~~~~~
In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
                 from drivers/gpu/drm/xe/xe_vm_types.h:16,
                 from drivers/gpu/drm/xe/xe_bo.h:13,
                 from drivers/gpu/drm/xe/xe_gt_pagefault.c:16:
drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object ‘tile’ of size 8
  102 |         struct xe_tile *tile;
      |

------------------------------------------------------------------------

							Thanx, Paul

