Return-Path: <linux-kernel+bounces-38888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127EA83C7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B229616D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014BD1292F3;
	Thu, 25 Jan 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6auVbhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB66E2B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199872; cv=none; b=Xp+SQbQmIQ6TEEQv+6pI0J39ldy6dS1dSaSo7V7xOTNmmdxodCingxj/8pL2+8brc/G7KGWdc4PakgC63ud9dTOQaAx3hy39yVV2oGwXQkMt13Z0D6H7SPrapxuYCjSkJ4zpElD2/GdI+ch3OOu4bi82rhOx6pn+HAwZ9CPo1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199872; c=relaxed/simple;
	bh=4JtuZ4c5afftcmm7Cjz7TNoieO1jwYMjkzuMSShCYTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYoJioSnXfm2WVRdnGvlvbHxben+G/tzhvLDWNnEZql62gyDwxKAx84YukmSAtUOpgLtdKi09bbYBU7f35Suz71D9CHFLohWfpk/N5Fy2+ItJk7Z2+KssvQGdrr0eP/tzNPE8RBh5eODWfWwS+AT/UsYkj09aPHSsz/3977Ra/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6auVbhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C53C433F1;
	Thu, 25 Jan 2024 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706199871;
	bh=4JtuZ4c5afftcmm7Cjz7TNoieO1jwYMjkzuMSShCYTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6auVbhM9axSRqWcd4zS2A0L4BPGVyybQRBYCpyKp7g7+eQ4JVIfHqC+cC1kHoeda
	 kHJrfZF596xNfZx59L62YS/XYN0HV7aFpGL/xcDbf1G5VPF43II8aNBlUrGxQHTW9c
	 juSlYSkG20Cn1ZNfTKfPajJPeu8GLAlqHxqrOQXgpDlYZZUalJ8RMRRGeHg0dQES/u
	 u+IImCcU+Iw9szQ8B5j4qEtuX2HLrYKXQ3H1nnekdIRX9fhPt4mvfhjfjVCiCqZa3+
	 rIiKLsh8j8RWgRGAhoe6BnmLwWnBfTqrGzKpp8V0BJgeiM4EBY7J4QHLZaMIGXUm27
	 VAWig1+32cnfw==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Keith Busch <kbusch@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iov_iter: streamline iovec/bvec alignment iteration
Date: Thu, 25 Jan 2024 17:24:10 +0100
Message-ID: <20240125-deponie-chirurgisch-58609146686b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <544b31f7-6d4b-42f5-a544-1420501f081f@kernel.dk>
References: <544b31f7-6d4b-42f5-a544-1420501f081f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=brauner@kernel.org; h=from:subject:message-id; bh=4JtuZ4c5afftcmm7Cjz7TNoieO1jwYMjkzuMSShCYTY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRu6jZ1aTGRuGPqUr3wjlHpktmTTtadmnRfVtdUxvKe3 Zry/Rt+d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkTxrDf8/rGmtLXAMkOcqF +RJ3hb6rObpty35XvR/va+/PuV0Uws/wVyyaszMtaZbfFq5wiRz1r5Jf3fSb//llf56WOk9mxpJ WBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 15:24:46 -0700, Jens Axboe wrote:
> Rewrite the alignment checking iterators for iovec and bvec to be easier
> to read, and also significantly more compact in terms of generated code.
> This saves 270 bytes of text on x86-64 for me (with clang-18) and 224
> bytes on arm64 (with gcc-13).
> 
> In profiles, also saves a bit of time as well for the same workload:
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

[1/1] iov_iter: streamline iovec/bvec alignment iteration
      https://git.kernel.org/vfs/vfs/c/89d0b83ecf39

