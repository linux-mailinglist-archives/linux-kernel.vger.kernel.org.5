Return-Path: <linux-kernel+bounces-79379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2865F862165
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E731F24EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE34416;
	Sat, 24 Feb 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxINRkfq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6D15B7;
	Sat, 24 Feb 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736418; cv=none; b=WBJI+kkw31/5UeIvLEDyEKoTtVzu3h4YmPau3qTz/8VFvUAMPXEDYfIqj7zUeaiL82iBhRK93gGB/Qd0+YGipe6YdG7xY06J7a/bn7zjpHs4GL3n4H6k5GNCJSarLK3wHIp3gxYCZHurakIjXV0lTl0RRvxM7K/mG1T1yRZ1fVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736418; c=relaxed/simple;
	bh=47CiTeUQMoF+fNPDyBJ4FJQteyxz+4E8UMb9etYDCKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BYzmL5x6wEAYgsS89zWwLfFSXFLgtpO+bBrDNmEOGqoGuofULN/mA7uaJaz9+AGqBLLplHtVw8Cs9MFtYoQury13LN9gBlt3CyvSDSDCcpknZZCyR830gN3tklyTjGFQwjIlDHs5jdXiAZE59iLzKVXz2+csClfbDasc8Eq6Qf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxINRkfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8DCC433F1;
	Sat, 24 Feb 2024 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736417;
	bh=47CiTeUQMoF+fNPDyBJ4FJQteyxz+4E8UMb9etYDCKQ=;
	h=Date:From:To:Cc:Subject:From;
	b=DxINRkfq/CxUNstQrcWay8JINBj4+yv/TYi/INrwISSoMOANb1t0edg7DmSzqYjRB
	 IRTzj62+WwJzRI0/zQat3ortXs1SHnxMVZQT5vi2YuivYwt+MLP92+meDhdefLe9+W
	 CNXv3PcKsq2KT/zrim9Vpqr6PzVt4zRGfZB46iz5O4X0h7QvFpuMuTGmXc8kIqyMiX
	 1I/zelXIZapYZIq63GHuKfVbVdmYbHHhO8QVMzK59D+Y2e8GVvWeDWpbvPJ53Pq5t/
	 utOT43yicNC91cAHHrE0X8KYvppDyiB8cGYEOETJVpRlqzvlIGQ+UXUrglAZEbfMIl
	 Q/7GTVb7KMbmA==
Date: Fri, 23 Feb 2024 17:00:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>, daniel@gluo.nz,
	akpm@linux-foundation.org, keescook@chromium.org
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	xfs <linux-xfs@vger.kernel.org>
Subject: [PATCHBOMB] time_stats, thread_with_file: lifting generic code to lib
Message-ID: <20240224010017.GM6226@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Kent and I went on a little sprint of figuring out if there were any
pieces of bcachefs that we could steal for XFS.  It turns out that there
are -- the timestats code is useful for measuring delays due to lock
contention, and thread_with_file will be very helpful for exporting
filesystem metadata health events to userspace.

So here's a pile of patchsets lifting those pieces of bcachefs to lib
and fixing a bunch of bugs in them.  These patches have already been
soaking in Kent's testing tree (and -next) for a few days, but
apparently not all of them got emailed so here I am blasting out the
entire thing.

If you want to see what XFS does with this, have a look at [1] and [2].
For 6.9 it'd be helpful to get these modules lifted.

--Darrick

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring_2024-02-23
[2] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=contention-timestats_2024-02-23

