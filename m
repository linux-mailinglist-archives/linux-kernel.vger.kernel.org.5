Return-Path: <linux-kernel+bounces-83073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE7868E16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707171F22D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684621386D1;
	Tue, 27 Feb 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWlOzKjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E41386C4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031219; cv=none; b=FXQhyswsKNV9jX+oo7I81QGksnTtWqyvdXDgZqudMRueyAzowFCwRMSpW0pNukSy8BRSOpmjZrTLD3O0Z9UQKBYyePH4z9MOWW7SOL5RflFPAo2GbBFRkcvPY1m5uUvym+EC9lgwp0vDGPE7cjXfsO9+Jd+OjX+lYqg+VM3xX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031219; c=relaxed/simple;
	bh=9x1CMFFxyaT5o5BDqz2j0sB+l86gLsGs+SoShtZQ+MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pj/W49OyELhaZ5UttZGldom78itj1Afyi6sdDgx9kVMgkFlwmCZD24VRU1sjg+NwqxbHsHVdoTTqi/plfwxuhAJcVRrLudXlRWbjmZ2QXYann9QeSnztdxQ/8FhVxU8iMBIg19r9kim7wE/b1caba96kgf+j6CPb+DqF5pwdo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWlOzKjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F54C433C7;
	Tue, 27 Feb 2024 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031219;
	bh=9x1CMFFxyaT5o5BDqz2j0sB+l86gLsGs+SoShtZQ+MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWlOzKjv3htg7HuBln9XlIsZh5L4cGjjNuLVzP7c6qvxjNgp6CEyXOJYOlhis93RV
	 f7wZA8uFoaKWq0agkEpcDdbyzufYQTBDr0KV8FU0kLB9mUpkZ5FPWIFmpLJPpoM1kK
	 rFIdq/7Z+Dq/EMAVRcni6/s1tL+4V1uxA5NItEDlMLtZrzTl7CkWSRoOX8g+Br7fJF
	 t4ynNxSb74K/ytu4LG2oOfulzYKQhrUsN9lwEkBtR/5CRF5R9rNtSO4YFpPHjw/1sZ
	 XFYwKrOFbvpFRfN9gvLjt3xn8/Vq2AvVieMCqn9fcJXCOsj644gNoBNX9MR2P1HKyb
	 yylB6Q6fv+8TQ==
From: Christian Brauner <brauner@kernel.org>
To: shaggy@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	zhouchengming@bytedance.com,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	amir73il@gmail.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] jfs: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:45 +0100
Message-ID: <20240227-erlischt-filmpreis-b637a1cd3693@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224134925.829677-1-chengming.zhou@linux.dev>
References: <20240224134925.829677-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=brauner@kernel.org; h=from:subject:message-id; bh=9x1CMFFxyaT5o5BDqz2j0sB+l86gLsGs+SoShtZQ+MQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S/6MZ1daVZVTvke7SMzfxYVrxW59WSStFFH45+/V 6e+Kdjj1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR5nZGhuMzd72TX3nFOVr0 9mml22nf+VtSPdf6X7+3gKmnZqXUgQJGhp4atwcs9akVM/+GrVSu7fnX3Fx0ufdbi/5OOxvPOrf D/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:49:25 +0000, chengming.zhou@linux.dev wrote:
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> 

Updated commit message to point to slab removal.

---

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

[1/1] jfs: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/6259e5e07b76

