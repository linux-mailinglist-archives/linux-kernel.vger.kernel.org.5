Return-Path: <linux-kernel+bounces-83072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885C868E15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CACA286F43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58452139579;
	Tue, 27 Feb 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqsbI0k1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582ADDB8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031211; cv=none; b=kPFhrro27qspx8tq+Wh0RqeNbt+cibfj8G4OxN/rWy++5YQQ5TOxMSJrUSUM9phVSKJtYCWCyUmZGMNPPJqUR1it4081+Jrnc904zAPHzCjswLrX+QQdbHNDW1dNRx3g4kbsKXki49tgf7AQE67Kgs/J5dvrmxHQstsbiV5ULcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031211; c=relaxed/simple;
	bh=56CXj8xivmlxmcNAnKkWLXRWWmoojp0H+4ZYHPVHGvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ82He+X7uLGhi+4gAiDfJctDDFmZ3wST4HmaFPSoe1mKcj637XHKZCXQ7HI6SURrDutq1JMKEyAlqxXfCguKdAFhrvg8FrUMdIfc0ZGW4qfRuzs17PmCvn8NR3hcuhBesUqlt4odqee+/S8tLKoFJK3ldmrs2A+PjJl0sjLIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqsbI0k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFBDC433A6;
	Tue, 27 Feb 2024 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031210;
	bh=56CXj8xivmlxmcNAnKkWLXRWWmoojp0H+4ZYHPVHGvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqsbI0k1VPUNstbLVw/XTzEJMVR6UBOjl/kB26ObtvbVz7YZ/HLmmK85u7DwxANWT
	 RFA37hbXqE9eOvJ3sHLbpJY7AXpPOzqwyAOQOUwWbSa0v3uGGh9wpSgmtKQimmqtRI
	 PYHyZXG3LHz0mZMuhm3GvRQeJlMLNG2WzELyaPzHhzCCBWzm9binzBu6gIpyEsRhV1
	 lgf/VPBMrhQg4CK5kQzKQtXN/bOD8qcSzTKCemYw1PjmpYz3Y2lV87gZ3oRdYAo+mE
	 NYPhkt//pyhdquzMOdqIuQtnSmaLOQHywq9TynwJ6xG62vEGKLLiWWEntmCw5gX9vo
	 fybXxLnhWuDKw==
From: Christian Brauner <brauner@kernel.org>
To: bodonnel@redhat.com,
	jack@suse.cz,
	zhouchengming@bytedance.com,
	chuck.lever@oracle.com,
	amir73il@gmail.com,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] efs: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:44 +0100
Message-ID: <20240227-dachorganisation-ziegen-9eda09e33322@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224134742.829325-1-chengming.zhou@linux.dev>
References: <20240224134742.829325-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=brauner@kernel.org; h=from:subject:message-id; bh=56CXj8xivmlxmcNAnKkWLXRWWmoojp0H+4ZYHPVHGvQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S9qVH/96GLGvdfe3V7z9O5kVgtVVXu7rG+6XCveS k+LE60T7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIqiWMDL1pTFcuvF6a/SDo /ekq05lZVp6L2yfxc1xJXvDf/5if9g1GhjX1urEV83X/XaqbvfiLeLPg5KulgcYrz2+ZLNz3+oh zMDMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:47:42 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] efs: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/00214815bfc7

