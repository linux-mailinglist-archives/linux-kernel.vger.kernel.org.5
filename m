Return-Path: <linux-kernel+bounces-31257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CC832B47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6051F25125
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DC5380F;
	Fri, 19 Jan 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOlo9EXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41A4C62C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674091; cv=none; b=Ooax5nyTf4B4183qFXaDt2pG+bEawtNvfF3FiWgjN8M1NDyNWxISndnLJ4pMdj448QDDhReonET02Eo0DDDVMxDtX6/LTRkHfFeH1vQwgs3eSju+49v0a5XCUgYdm8TvV+R66zH0h6uWZ0t62JB4qYd0TGCITGF8MU/PCgu41VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674091; c=relaxed/simple;
	bh=ivyOXrVn1/AH/urr/k0fNYqHzRAlDgm38pd1Jt907s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk8edXpfFpvPbp1q/Wo5iYYazqD9LVIbBqboVKjhb/43VGx/kB9JV41GqbT9J9EyPV0EAwnk3CkMNGgKhwGynHdrmKVWB0RJkP3ma4/1C9s1cVreSX0eCWzBFaYgmMAle/Fi1IZevWRC6BNbfXVhrkatz3g7jr3OU/BKfcgtr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOlo9EXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72EAC433C7;
	Fri, 19 Jan 2024 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705674090;
	bh=ivyOXrVn1/AH/urr/k0fNYqHzRAlDgm38pd1Jt907s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOlo9EXAl4z95TQcwVbBgfeUDq1IgtJnHU4g+n1dh8wj7bdarQrm+auQG8xKOvBya
	 njtH+FcHB+erD+/zm0Koy4XUEf7SMhcjyAjGdVrD9B6rl5xuYCoH6BU276xxsHS6R2
	 mGV/WB0y4h2SlGFqT1rt4G6a6GLfP/abv0m8h9tl6HQe/b+iaBdi32HfUcy0MWJSS6
	 Mnc3iDKOIe1tyzzphXa9qE2Kx7XBz+EX6geW1dGA8VamINwwhXX845mGBVCFahTDpz
	 6HQLvQK05z5HJ1p2QbUL9FRMGRefPO8n/AuFM8RTjJyDMTv7aubCmPSuM0/cJ5o0uS
	 Atq5m2dbtiLBQ==
From: Christian Brauner <brauner@kernel.org>
To: Fullway Wang <fullwaywang@outlook.com>
Cc: Christian Brauner <brauner@kernel.org>,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com,
	jannh@google.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] fs: romfs: Fix potential uninitialized memory leak
Date: Fri, 19 Jan 2024 15:21:04 +0100
Message-ID: <20240119-heilkraft-umgefahren-8f84c6395f6b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <PH7PR20MB5925B0893BC44476B0D2E993BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
References:  <PH7PR20MB5925B0893BC44476B0D2E993BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=brauner@kernel.org; h=from:subject:message-id; bh=ivyOXrVn1/AH/urr/k0fNYqHzRAlDgm38pd1Jt907s8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSuao3Z2/zzq3S59gODtVlHz3t8f3AzKEr7+tMd+cb7i jIeslz37ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIXgUjw1XFuxq9bXp33kzn trN4FKm0anbtkj3xlT85re/uO6H9Ipbhf1KrfVRg/DLOZIGtj5MLn75leZG/u28zY90L5tjHW3x 1OAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 15:14:12 +0800, Fullway Wang wrote:
> romfs_dev_read() fetches a caller-supplied number of bytes from the
> backing device in an all-or-nothing manner.
> 
> Commit bcf85fc fixed CVE-2020-29371, which exposed the bug when
> the requested length crossed the filesystem size limit, the number
> of bytes to requested was truncated. However, in romfs_readdir()
> in super.c, the requested number is firstly truncated with
> romfs_dev_strnlen() then passed to romfs_dev_read(), leaving
> the bug exploitable still.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: romfs: Fix potential uninitialized memory leak
      https://git.kernel.org/vfs/vfs/c/530041d36e37

