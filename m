Return-Path: <linux-kernel+bounces-58657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D398D84E995
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C893DB2E552
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9013C461;
	Thu,  8 Feb 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="d/wxYcqx"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01738FB0;
	Thu,  8 Feb 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423586; cv=none; b=JdDdVNW9OqdaCL+TB0hOCVIdc5bgoHQzIiau6BzHW2aJn2RouaoAeabhpkyNUQcQERBnjTgC1GPF0TIfrYIqEECjeX+K4HAJyAoFNrAR7qBEbr5J+vi6vI/C+jMmZFP1KQRKipnC1qGTrLpH7Y9DrpWgBnzyv8U8/xzgh6UTnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423586; c=relaxed/simple;
	bh=VPJkilQY0W3dQlN30OMPUbSBlEE8uurTighbY2OUl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EghCy4lLinfc0ucpYmBtRRo6CgdmC4ZWsdITTm3tvWwiSCTVytiRYHaIfX5D9Ze8FTsqq609UzOZwF9Re/5Hch/Sff7uWNZQdAjE0QQGcm63mGMx2CXdh6hy8/Fg6Y2YaQHt5cVwyIt0N+0MELwTLC5qd4PXv4Gh+PGlEwOmR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=d/wxYcqx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wu6GEbBipFa7DUcQHgPx5bUPL1eORflnOdQP6J6GMg4=; b=d/wxYcqxezRwk3oH0dGbh/hO2D
	rb8pj4e8ja3ALbkbJ0Bc3wgt2O935lC4S0FMlxGTALODWyTTxhOozi+GsKqhgLl+/FxEl7Rh9Ktym
	6CS0Yj7nqZQNdAL6VLSeQpM+gn7vNNT9PO4YoPmkHdDSNoSI7FmtK8VpU9XoRpz20B7b0eN486Gw5
	yZQms++TtzxFNlWJKJCKRZO9ALebp0bkFXWrrlbR1U2vfJQBos6DVioYHZ+vn14PE9Nd8SgkqieiS
	Gfzl66uKn78MwwzlgyLwdAauK9zW7pYd1vieqIe1JuwxhLohL9HS/P+5l3wVoNOrJYKwbrcEyg+nH
	zNcsVAhA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1rYArs-00EMbv-RP; Thu, 08 Feb 2024 20:19:33 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0FFEDBE2EE8; Thu,  8 Feb 2024 21:19:32 +0100 (CET)
Date: Thu, 8 Feb 2024 21:19:32 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Dhya <dhya@picorealm.net>, 1063422@bugs.debian.org,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: [regression 6.1.y] f2fs: invalid zstd compress level: 6
Message-ID: <ZcU3VCrt9VOpuFUq@eldamar.lan>
References: <170736382774.1975.1861975122613668970.reportbug@tsuga.picorealm.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170736382774.1975.1861975122613668970.reportbug@tsuga.picorealm.net>
X-Debian-User: carnil

Hi Jaegeuk Kim, Chao Yu,

In Debian the following regression was reported after a Dhya updated
to 6.1.76:

On Wed, Feb 07, 2024 at 10:43:47PM -0500, Dhya wrote:
> Package: src:linux
> Version: 6.1.76-1
> Severity: critical
> Justification: breaks the whole system
> 
> Dear Maintainer,
> 
> After upgrade to linux-image-6.1.0-18-amd64 6.1.76-1 F2FS filesystem
> fails to mount rw.  Message in the boot journal:
> 
>   kernel: F2FS-fs (nvme0n1p6): invalid zstd compress level: 6
> 
> There was recently an f2fs patch to the 6.1 kernel tree which might be
> related: https://www.spinics.net/lists/stable-commits/msg329957.html
> 
> Was able to recover the system by doing:
> 
> sudo mount -o remount,rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,compress_algorithm=lz4,compress_log_size=2,compress_mode=fs,atgc,discard_unit=block,memory=normal /dev/nvme0n1p6 /
> 
> under the running bad 6.1.0-18-amd64 kernel, then editing
> /etc/default/grub:
> 
>   GRUB_DEFAULT="Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux 6.1.0-17-amd64"
> 
> and running 'update-grub' and rebooting to boot the 6.1.0-17-amd64
> kernel.

The issue is easily reproducible by:

# dd if=/dev/zero of=test.img count=100 bs=1M
# mkfs.f2fs -f -O compression,extra_attr ./test.img
# mount -t f2fs -o compress_algorithm=zstd:6,compress_chksum,atgc,gc_merge,lazytime ./test.img /mnt

resulting in

[   60.789982] F2FS-fs (loop0): invalid zstd compress level: 6

A bugzilla report has been submitted in
https://bugzilla.kernel.org/show_bug.cgi?id=218471

#regzbot introduced: v6.1.69..v6.1.76
#regzbot link: https://bugs.debian.org/1063422
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218471

Regards,
Salvatore

