Return-Path: <linux-kernel+bounces-8318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB281B591
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0D71C235F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5B6E2D0;
	Thu, 21 Dec 2023 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps3lmauA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE3697A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20F9C433C7;
	Thu, 21 Dec 2023 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703160825;
	bh=86v74TtrMiZEnufMUJK1zu8sA3eKYSUPgub/Djn1w+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ps3lmauAmds/OdMAnnVDrdODnINF9zYuOQk79dUBnqzpi/UURiKhfSe52R+7p3J4x
	 +4gi/FSvrADNWSLhzMu7my9iNM+f/b2wURA0nZxQyIYTon5/8SAOFTVxi2/Sm3SZsT
	 acBRzAaTFvkDoOcGrKgJHSCGfHm6hrIUH/LAVaW16QZFJuBvssZKrPrcwwJFo1R31+
	 N8kP9aXV40EorllOT5s5Lwfyb7hEOJOCxwh2QXz+EURUHaz+UCdDhot43+udt1PNuO
	 /CrxHpT09fz1atIppJ4BhymmpO9mM81vm31kzksX//wBHraid7yZTmQe3+oZs/VsTs
	 pS0myTYM5EKmQ==
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] watch_queue: fix kcalloc() arguments order
Date: Thu, 21 Dec 2023 13:13:30 +0100
Message-ID: <20231221-tragweite-leerlauf-9e4516a9c158@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221090139.12579-1-dmantipov@yandex.ru>
References: <20231221090139.12579-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=brauner@kernel.org; h=from:subject:message-id; bh=86v74TtrMiZEnufMUJK1zu8sA3eKYSUPgub/Djn1w+Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS2aL88ebmtQ+T36Wghdv5fprWpFeofnPdLK8xYvm7Cj n4ewexvHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5L8nIMOWz5c3MkBrLl2zC bOtWmbQ93TZ3x+1TX9QX8U1rMNeRec7wVy6ggv1HmXHJHzYG439RHxS/qh11fn9Lp92c68KqDqU IRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 21 Dec 2023 12:01:21 +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231220 (experimental)
> and W=1, I've noticed the following warning:
> 
> kernel/watch_queue.c: In function 'watch_queue_set_size':
> kernel/watch_queue.c:273:32: warning: 'kcalloc' sizes specified with 'sizeof'
> in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>   273 |         pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
>       |                                ^~~~~~
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

[1/1] watch_queue: fix kcalloc() arguments order
      https://git.kernel.org/vfs/vfs/c/770bedae3662

