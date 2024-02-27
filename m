Return-Path: <linux-kernel+bounces-83081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B4868E26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90709288D53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DEC139563;
	Tue, 27 Feb 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1fH9cOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D913AA4A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031267; cv=none; b=LkUPoQhXgY30bOCs/h9bBrKfAx7B9JisKZPaF63IrjymeMUIyXuZcdPcES0kQmVfFjLqec+FxvBpAnzw8Gz42i3Np8Aq7jrrZpTX/WwPBlAq+s5IGvk/ZjVyf1RmDz2FqrKcocMqoOomKCUlgHneaZl0yubxPQNnUrR3DeyjUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031267; c=relaxed/simple;
	bh=Ien1MAZxVCekAISXfiL/0KSTQDGPU/3AIJR+J8RGIQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upz1F6DgMVYplTMs6hx/r+gBp7njdUINSDng+OPVZiVQPcY2bGDrVdyKAkoNN0cdKZfKNP98ufMUBdD6PEr3/Uirzqr5fJgb9NkOegijxR3sDblKboMBwVTCGm9qkqFMvi+m1ue0pNaGTaEA594WWZzWqqL0ZwtqCAkfoy/6Tu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1fH9cOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDDAC433F1;
	Tue, 27 Feb 2024 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031266;
	bh=Ien1MAZxVCekAISXfiL/0KSTQDGPU/3AIJR+J8RGIQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1fH9cOHAEhe7lvjbLWTfOLNgfV6pS9O4SHZG1qXmCV5eje7iqBAaT9/Gf0BeE8ME
	 ABZO5fwUCWsK6bDOZ11oWgxFwmai0H01nvte6ixzmAR3vdEa0cp1KA/9AdQTbKmAfb
	 Gm/x1CX7M2crBI7T4+ZDiZ1yYxV6wieZ7tQnFIgyqSIKZRzi8RztLTN+g2ZxoLwSps
	 8Zf9owXsMHHltSIC5QUdUYZmF1zZjohugo3RokqeBwaxuuRpGuTn66wFAMsoklUtab
	 7EKZzKnX0Dv7eGe9w4f6g7r5Xx6oisCaUYuAE5E73fpRzC2MD8XFZaSyzqXbwOMlCk
	 RJol+uimoeiEA==
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
Subject: Re: [PATCH] sysv: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:52 +0100
Message-ID: <20240227-fungieren-groschen-60f2174931ab@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135158.830266-1-chengming.zhou@linux.dev>
References: <20240224135158.830266-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=brauner@kernel.org; h=from:subject:message-id; bh=Ien1MAZxVCekAISXfiL/0KSTQDGPU/3AIJR+J8RGIQQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S+pw3qE544Usw1X/sZAvntubhrybur5wdpVp5YUx 1973BzfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBFVB4Z/9mv9fUOtClY/cUw7 3i+2+Y68fs3sxrfuPU+Uvk+ZvHvSI4b/Doa3fauqnvc4mHr/N9x7490OgydHuEpVvpYs0vsjrM3 JDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:51:58 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] sysv: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/8d6e17b745c2

