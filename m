Return-Path: <linux-kernel+bounces-42840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A3840790
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B69A1F222D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13665BB2;
	Mon, 29 Jan 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc6JWBke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FC65BAC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536551; cv=none; b=pWEwH2IuPhRclgDUG89c7uGlrOHLz2/TwZFnLY/OalqgxpBfkL06ngxyVjRR8ePT8cXNdatuVnH5FKZ+s7dLpFgXugZop0cHJmgwoiuBQ8prdCLLfHrLNTktA/GSdH19OMVk34WgE7ZW0Q4qJf4rCjFdicjmHfjgtAB6KGBYPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536551; c=relaxed/simple;
	bh=fGTY8wk+7FZYdLAKuIsKJzTeIDJ4tR1MMhapoSmIbHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeIvSueQmAv4CZ8WYq8pqGY/YcAmCiP1I8yTtRUZFH/tu2g9uGC4s/5Dkxic2+6BlEfCWuplk7h7BBFMGtY/ZNtj9E/ggqJmYe95HB8lpK9DCY+Wo3b+R4YhggRGasbK5YxVbG2cNuNnvJrE9CB/hcgHvsl0f63n3iLPDVldPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc6JWBke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E5C433C7;
	Mon, 29 Jan 2024 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706536550;
	bh=fGTY8wk+7FZYdLAKuIsKJzTeIDJ4tR1MMhapoSmIbHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fc6JWBke9OIaN1uN3fC39GR3mX8zY7XQ8cgVPCJaxLyrByCiGTLoGPv8AjseUuM/E
	 8jWVmqTbiuTBxGqwoZeq0/u1qkE50MDTZY+WVSxUqnveTEtsJtWJzSkW9w/YoydW9+
	 uMQqc4q60jZ47zZnERsA+2oOhFfp4ZaGpAcVbBVHq3+6GZbiilPeZLSvBtPW0paEkS
	 874/z6GcVmRjflAuvQAzRenXBBGAvagWi/oNxnx3/tPcI6lXlRlC/9LpkPcodakWQD
	 2sf5YJL0bQ2cPacourBLTBXMciFlWQhbvQ6lI8+ZO25wr52+ZEANsDN31xjct0UObW
	 B738V8mK2WXKA==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] pidfd: don't do_notify_pidfd() if !thread_group_empty()
Date: Mon, 29 Jan 2024 14:55:41 +0100
Message-ID: <20240129-baldigen-geklont-185287b43190@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127132043.GA29080@redhat.com>
References: <20240127132043.GA29080@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org; h=from:subject:message-id; bh=fGTY8wk+7FZYdLAKuIsKJzTeIDJ4tR1MMhapoSmIbHw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRuXxf39dSVqStbr+QFTwtbyGtbaTalz1gq9dSdU/2zj nMbqbbVd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzknBDDX8GdQYn/OtlXmqmp 7WY4kndKWjl9euMzp0vbP+TcUvy/OInhn/EENcm9J60iX91cPOPkIYU7CRdirx3f8zlSK0fGadL 7dcwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 27 Jan 2024 14:20:43 +0100, Oleg Nesterov wrote:
> To me this patch makes sense regardless, but also this is another
> preparation for PIDFD_THREAD change we discuss.
> 
> Oleg.
> 

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

[1/1] pidfd: don't do_notify_pidfd() if !thread_group_empty()
      https://git.kernel.org/vfs/vfs/c/e191619dcdca

