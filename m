Return-Path: <linux-kernel+bounces-83077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD7868E20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000D4B221E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739D1386D9;
	Tue, 27 Feb 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hubC6OF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76BDDB8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031246; cv=none; b=jsXgN+u0Rd08o+kTqoDtRcoCyr7bofUExehGL4/McZKhR4gajNn/39AntYtA6/4Z6uiUsq2rq/7ajDvrWB3oTuq/S5d+AHT+emytzb9ewWlmpAHpnpXuXVJTZ5NcFjdfiJr49vHS7Af90VkZhGOJeZL2P3nXBeDfZq2hGENzPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031246; c=relaxed/simple;
	bh=FHx8m3iCIIe60r0s7LZnmfg704GTpAI9tBZ7zlx8XyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADAoG6qXnmUipYs5equxWEFvbQxWqEGlf2+TgQZ7sB29qrnIDhPOSJEX4QZjLcCImxozVq/SKCCVEXHOCCVkR+IVWcWd2mdMWPcIyGpnOMf3sT91XPz1WGXAqD0Q6YnXuUCAAgRjBDSDXRu+x9M7ZuZXENC+QBY8MSwyIGF4wAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hubC6OF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B54CC43399;
	Tue, 27 Feb 2024 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031246;
	bh=FHx8m3iCIIe60r0s7LZnmfg704GTpAI9tBZ7zlx8XyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hubC6OF+v4BxhZ2FATDwjOcceReNpbSGVQyUYvCOckZK9hGcYZZ63+wCuSo1XrFQU
	 EkMbjlFctlmAwiAH6257k02OYtxvPmYgAmpfl35YSBccemS1Z+mAvahVHfjKU4+cLb
	 BzCaAOsTy72EF07XNYIlGcOVjQAhRO/FQyQaXfZbzRYZwZFZWorUTu9VGShWWic+g5
	 O09KKMTQPB4uL9PF6WvonVefc31J6kBV9jkmW90nSj5deah6Nnu2qaG6ZndemEEZtY
	 YtrNk+wYgpgOZ9oZ4zNFZ5cniMuPjqM45ahM+g381jw+LK9uTxzzG2VVvaZMZmKGPd
	 Y7BUxznQ7aXkQ==
From: Christian Brauner <brauner@kernel.org>
To: jlayton@kernel.org,
	jack@suse.cz,
	zhouchengming@bytedance.com,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] qnx6: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:49 +0100
Message-ID: <20240227-burgfrieden-allemal-bc8bc8301baa@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135104.830045-1-chengming.zhou@linux.dev>
References: <20240224135104.830045-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=brauner@kernel.org; h=from:subject:message-id; bh=FHx8m3iCIIe60r0s7LZnmfg704GTpAI9tBZ7zlx8XyM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S+uJSRl/lK5XE6pNOlO+wO2KTzaDT9u/a5v7du3u jbR9bJ8RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ26DD89/zfbf9Z9TjnJTkD QaW7f6ulmuU1Vu5cfXbn5wWm7cXvbzAyvAioe3SgsOwwb829RcffMZ/eK3Ym9aDfbNWEIJ6fqvZ LmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:51:04 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] qnx6: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/21c46129d279

