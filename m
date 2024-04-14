Return-Path: <linux-kernel+bounces-144239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE18A4377
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4496B21247
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728621369B4;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixgj0WG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE805134CEA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=m2wyYXLyhH8yxusH8+jebd6jkv8/T+IcS9chc3ZnJ6q9+d8ZJQ4zviX2YSzizYW2Rd65FBzQU+kC1q/yb4xCCLIhi3FbGeklOy6PvhJ5m3ulVCP7bpRmDKNsOhPNRzlDJ9SeVo12179OhREYIgDpHioW6wnEnb4IbfQU2epKpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=i/6QaGlaCv3KFEh/epsSeKYK/O3DnO3Wl/IJ5qbHsyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hMW5eFtx3+yU/KPuet4bI1cO5Doaj9uzrfq7oMxSmVTiVuZJ0AywgsG6eKaLWGqP0uYH7ecUGliKrPKy7a4O7qh0kHiygkGAX+eNMiTPVFvelz6cVXCLeB5R8c+iejsb6SDIer2Ri6RtWuE9al3qHSXbTus7irzOi1xikndo6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixgj0WG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB0DC4AF48;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=i/6QaGlaCv3KFEh/epsSeKYK/O3DnO3Wl/IJ5qbHsyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ixgj0WG45U1svFl8JkYJldy00Yr3jGm4ICxlZaHKYAPFAK8QdLG/Z9Ek/DDKeeyHx
	 8Q3cVy/GCpQ5Opzzm3chRA2dz+TeM3wurH6UCJ/+rTLh08ZKj5aFL4jZfp7ltUHqEo
	 WuUHRj/Oqo7kdIJfChoORNWova6fCGdxvrVQZSA7ZW2wWq8YDuM1GFFsVaDWtFQUmR
	 FyxkJM7aYPHc/QHNME84O0yY3fwR126GSHnv8VEe2n2p/JGmlXonPgcpZIwxi0pNt3
	 EeioKlYynraWGKtiofBTEtgfDgHZCffRl1OKiJC0FCcPQXiM4a9Dq8aSyLIhnJs/rj
	 TH6sYjCyeNi0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 731D3C54BD1;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: multidev: fix to recognize valid zero
 block address
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876546.3156.9489013504825208651.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240327074223.2216487-1-chao@kernel.org>
In-Reply-To: <20240327074223.2216487-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 27 Mar 2024 15:42:23 +0800 you wrote:
> As reported by Yi Zhang in mailing list [1], kernel warning was catched
> during zbd/010 test as below:
> 
> ./check zbd/010
> zbd/010 (test gap zone support with F2FS)                    [failed]
>     runtime    ...  3.752s
>     something found in dmesg:
>     [ 4378.146781] run blktests zbd/010 at 2024-02-18 11:31:13
>     [ 4378.192349] null_blk: module loaded
>     [ 4378.209860] null_blk: disk nullb0 created
>     [ 4378.413285] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> poll_queues to 0. poll_q/nr_hw = (0/1)
>     [ 4378.422334] scsi host15: scsi_debug: version 0191 [20210520]
>                      dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
>     [ 4378.434922] scsi 15:0:0:0: Direct-Access-ZBC Linux
> scsi_debug       0191 PQ: 0 ANSI: 7
>     [ 4378.443343] scsi 15:0:0:0: Power-on or device reset occurred
>     [ 4378.449371] sd 15:0:0:0: Attached scsi generic sg5 type 20
>     [ 4378.449418] sd 15:0:0:0: [sdf] Host-managed zoned block device
>     ...
>     (See '/mnt/tests/gitlab.com/api/v4/projects/19168116/repository/archive.zip/storage/blktests/blk/blktests/results/nodev/zbd/010.dmesg'
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: multidev: fix to recognize valid zero block address
    https://git.kernel.org/jaegeuk/f2fs/c/33e62cd7b4c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



