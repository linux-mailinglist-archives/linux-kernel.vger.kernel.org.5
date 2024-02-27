Return-Path: <linux-kernel+bounces-83080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEAB868E24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A95282BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6E813A267;
	Tue, 27 Feb 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0CBQQCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3213A258
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031259; cv=none; b=jOxhMtiqhk9qKOYQhKh0mztFTtnRNsTzaQ3tjz8cAc/xtwnxnDXteEIErdFrFtP7iLv/fiJ34bwcMnAhqtTGXmH7546KWSEanMOdiuHlsntc6Tm8Udqnsn7P0XfEFB/piKOBeQY/XKyOIG4p3lI3ok0vmWEwOp5Idl7ZxMnM318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031259; c=relaxed/simple;
	bh=nNPGrMaO/QAJqhitd9EqSL5P1ipJthKxOphbNUF4fdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E75n7W3vVHrZB37tUR4ZP5tZg1YaNRdL8JhK2k9wl2VlfXE9fTjbkoJUbMyjAMSfpqmd6od0q4xwcLuSUx18l0zAQFtCL18w2qIBtyzSPPkAj0eoqJPEfxupGkUCOt1zA4i9tRgIGKZGg9YD0b3z/4OkAI2BcujUaFWB5MoQ+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0CBQQCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5A4C433C7;
	Tue, 27 Feb 2024 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031259;
	bh=nNPGrMaO/QAJqhitd9EqSL5P1ipJthKxOphbNUF4fdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0CBQQCsfb1EWsPwO/lMFK/t4b0NyYf374vUtG6iksya+RKbUc9UulDoKiXhQhSK/
	 fqS6EYd7wLM4nbvzpfu63AaDtVbjVAqRRR9AmImO/iSAWogHLNZZdHR8MpKvSDJqK+
	 8RG+Fwpx/Ni1U/63SQ8ENFbJnN8RiZnJhxyo5qcQ2VxVRnOWYTHLoaO7jORY2tmn31
	 hR0qjh44dyhr/qGItBJlgIocy0A+rETAuS6ZcVw63NhI7I/AuGaP3JnFF8+DTDM4ec
	 4DrsAu68+xgZfxun6JBWD53PVb8N/4Vj6uj22OcKOd1jpfIY/qQfTdITLci3jTEerD
	 YhNV43VaQDUFA==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	jlayton@kernel.org,
	zhouchengming@bytedance.com,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] romfs: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:51 +0100
Message-ID: <20240227-daher-kursprogramm-cae4adeda552@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135143.830142-1-chengming.zhou@linux.dev>
References: <20240224135143.830142-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=brauner@kernel.org; h=from:subject:message-id; bh=nNPGrMaO/QAJqhitd9EqSL5P1ipJthKxOphbNUF4fdU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S+huaC2yInHfXq+XfunvtrTX5NCg1h6TrFf7Onav FvjQO/7jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInI3mNkeBHz9uabyp6JC0Lu bzPZZDnLearDCssaTuXV6s/UVolENDH8ZhH5NmnDtEXMBWIr7njnXErMyV3zce5p1TuFFtcWmP5 fxQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:51:43 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] romfs: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/64497346f982

