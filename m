Return-Path: <linux-kernel+bounces-148399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1F8A81F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD27B1F24428
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385913C918;
	Wed, 17 Apr 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spD+u/L1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863B13C675
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352974; cv=none; b=TZFqBKWkCJdp1Nri6/ljpGLU/ssf5RZrX0A4Hf/KDXdTHdT21w1Tm36hXQQlcmohWjWBGaVehl7L89ohfza+YIjZnmeICfoUH4TuJi/yWNdjEbMe53475umh1hLynev8Ik23BLuiy1yftp48BXi2XY1WIqrMKi8KocTFAYyoxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352974; c=relaxed/simple;
	bh=b9eQVO5DEetlNMd2dejQjvjZNeo8+gjXxwiMgoytLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeD04ujEP2xG+kcTylsp0ZwSDhVEnOhMe/21aLveH0POTgWpFRGtIhW6D5ok23tcftql02nPwxVzK2COAKLYU3MsxXArcOfE6p6DfnxVRcsw7EogH7DbPcdX8fT6jpqnQC0e12RHpBpAR3/MnqioSPZCz//S+vvaDg98Y1LtJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spD+u/L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A379C072AA;
	Wed, 17 Apr 2024 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713352974;
	bh=b9eQVO5DEetlNMd2dejQjvjZNeo8+gjXxwiMgoytLg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spD+u/L16KVIRaZE4iypYl0pLJKCD7wfCKq26ynKvEfNV5LzwHJR66H0g9Uzf3tBC
	 O3ZEiRTqDndUbewaJpbGy19M7NlkdBW9HyK4lhyZzWqAurdBquw10uwq2nrGY5SUtD
	 hcE8u7rbtxrYk8b76UgxeeDOBgWWG7LPv+6yQNuxgngnvyMS/x2xJ2T+5k25f73cdG
	 2lWlUYJ2CzsIy9bLWMPHG9ZxYcONUnMTtEBpTFqnoXIHx2GuMi5BqdzQy6jTk6F8h2
	 RQB3De8nCGQw4VBFFF2zGbZSyUO0PGmjPpVgru3qglgKYQcaK1yzTHA5c1PZobpXgC
	 jl+32K0O7dpiQ==
From: Christian Brauner <brauner@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Ilya Denisyev <dev@elkcl.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Fabian Frederick <fabf@skynet.be>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	KaiGai Kohei <kaigai@ak.jp.nec.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] jffs2: prevent xattr node from overflowing the eraseblock
Date: Wed, 17 Apr 2024 13:22:04 +0200
Message-ID: <20240417-kapern-angegangen-0ac84cd51096@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412155357.237803-1-dev@elkcl.ru>
References: <20240412155357.237803-1-dev@elkcl.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=brauner@kernel.org; h=from:subject:message-id; bh=b9eQVO5DEetlNMd2dejQjvjZNeo8+gjXxwiMgoytLg4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTJb/i5zlVaat5v/hnsXRWbOKbddb9YdNj8zpvUXWefm ARtallj1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARoxWMDOf7km0/eViH7L64 bco3V/3PO3tWv2H64FbiPmOLuaGYoTUjw7+PE6pbPjZ0/jyn8vkkm+muDDbj6UH/ZdjrloUEOen vYQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 18:53:54 +0300, Ilya Denisyev wrote:
> Add a check to make sure that the requested xattr node size is no larger
> than the eraseblock minus the cleanmarker.
> 
> Unlike the usual inode nodes, the xattr nodes aren't split into parts
> and spread across multiple eraseblocks, which means that a xattr node
> must not occupy more than one eraseblock. If the requested xattr value is
> too large, the xattr node can spill onto the next eraseblock, overwriting
> the nodes and causing errors such as:
> 
> [...]

I have to say that the rick-roll of your domain doesn't inspire a lot of
confidence though...

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

[1/1] jffs2: prevent xattr node from overflowing the eraseblock
      https://git.kernel.org/vfs/vfs/c/c6854e5a267c

