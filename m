Return-Path: <linux-kernel+bounces-31643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C08331CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFE284D51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B5392;
	Sat, 20 Jan 2024 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7IygPPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49E170;
	Sat, 20 Jan 2024 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710430; cv=none; b=toerZjokKS/mQS8VWLQ2HdnqhRs5lTmUyNO66AXmAU3twotege1sxRm2XxY6QG31j0lwuo2rdEW7Gl1S0FIdWvMBqmT+yho8t0U5rBlPXNK4WS4MnYO50hXJyNusCFQQ+qNj738xFQ7a0PNaLhDxX6nkSBTK409AMf2ieYkSWJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710430; c=relaxed/simple;
	bh=eFZZHeFIEdrm6Tlw6JWcfEH9KGbKVjVZcPqshvBe76A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h5x4j1zGjQGfx9YFoLK91+HlQUGReLgabtc4dRTWD7AWrenpb7Rp6Fi6YqQsrd+Ba096DJP5ebpIasrznXp3pVOylrp5ZK5wr7zkHgo4PDjCmQDxstZMBQDnLI7IZq66vKbDPP3ZbKPuF2z5lv/Hett/Gsx2OnWysQvNo9YQzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7IygPPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B87C433F1;
	Sat, 20 Jan 2024 00:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705710430;
	bh=eFZZHeFIEdrm6Tlw6JWcfEH9KGbKVjVZcPqshvBe76A=;
	h=Date:From:To:Cc:Subject:From;
	b=A7IygPPPKF9rB3KcOoqjjMPcFtnUCVKWyR3OIeXuw0hoxtIEudxuBzCPiV47lDLtF
	 T0GGYbP/a4F2kZErEhjfxAaSFISSAJnwPwZHe8xDaauNxCVoR37wyrWFSantkCT/Xq
	 VjWsVbMW5dwYPlYn8+PGfwUKF2hFH92++cKt5IUWsu1GT8lpZ36jCfaUiWkeyHFTTI
	 Y8atV2PF1RFXEbBMvuQMYDyiKcK6G6hrM0NHfD5UcNhYkVKCZKsGXumomPlSeGHJms
	 0pAQ0LhjnDywsfXFPAlzRiyetp+yRaliPL82Z9EkOJrAbUSI5HYQ2aqcvp5P51mLs0
	 XMpJ76Lueq2SA==
Date: Sat, 20 Jan 2024 01:27:05 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [GIT PULL] One fbdev regression fix for v6.8-rc1
Message-ID: <ZasTWVn1lzY6oVym@carbonx1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

there were various reports from people without any graphics
output on the screen and it turns out one commit triggers
the problem.
Please pull a single revert for now for -rc1 to fix this regression.
We will work out how to fix it correctly later.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 556e2d17cae620d549c5474b1ece053430cd50bc:

  Merge tag 'ceph-for-6.8-rc1' of https://github.com/ceph/ceph-client (2024-01-19 09:58:55 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.8-rc1-2

for you to fetch changes up to 2bebc3cd48701607e38e8258ab9692de9b1a718b:

  Revert "firmware/sysfb: Clear screen_info state after consuming it" (2024-01-19 22:22:26 +0100)

----------------------------------------------------------------
fbdev fix for 6.8-rc1:

- Revert "firmware/sysfb: Clear screen_info state after consuming it"

----------------------------------------------------------------
Helge Deller (1):
      Revert "firmware/sysfb: Clear screen_info state after consuming it"

 drivers/firmware/sysfb.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

