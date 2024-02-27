Return-Path: <linux-kernel+bounces-83075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22691868E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6410B211B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E08139568;
	Tue, 27 Feb 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU47WGlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F11386B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031234; cv=none; b=Y5l0kxI3mcJUyHawyM9LazKrVrTT6ssL7meuQ3BFFYTBH15Mtta1tkLpkKwO2ZEwhMgjYS9JD9jEqb+PHStaoZCafKxMM8oL/bba6QNSDjrnNulVTdP7xcSTIEHFdMePFj69VBhMtC3jV6Kr4Ym5z3JpJXDzT83K54Kdrc7JWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031234; c=relaxed/simple;
	bh=/mxC6qC32J0iPOhJxkeY8EHyScbniafSLgOMJKtR0XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXXlvl5dI6+pNH3sfLF5xNJGWhOyqb2qbMINfXv+Xiy4Q/8JwYJ/sfHGmqQVAj/Es1haseFvx/yMdRvHbFJns2Y1rIv+HTeotcCEF8QLgHgXGZ8btD77FFfZAy2SWhvvwa4jPNBL8qgc83tufpkvDMlJFxkfwOeCiCGB/GuM6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU47WGlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E29FC433C7;
	Tue, 27 Feb 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031234;
	bh=/mxC6qC32J0iPOhJxkeY8EHyScbniafSLgOMJKtR0XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU47WGlZ+TuhhypVCoKQHQkbia16CtsyLv+/cKXOjzgUB02ev17wE03ZY2TqD02iN
	 qoAXZdLZxhCkj5tMbVGA9eEEHTyUw95rRumdsV07gdmHeO04HfjRqGo+bnz7rDiV4n
	 QaTr6Ux+9Lx3sMfoxTBLvQhLbCEJsv0HliDnDwENl8QRyTdv+1rZ2XU9UuF34/6yDu
	 f1jctyVmKk2IVMssx/VaYApt0jYyaWoTjWkARZgXAsQ3dRt9kll+m7L8a2IZnmAZQN
	 BtsUauO5Vtc3iDODgAAwgMnUo68PSDUJt2n25be4LKTN/SnZIzxcfJCcm30ygp3skT
	 Nwt6bY3QhPepA==
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
Subject: Re: [PATCH] openpromfs: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:47 +0100
Message-ID: <20240227-geehrt-kurven-2306958e4d1c@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135028.829910-1-chengming.zhou@linux.dev>
References: <20240224135028.829910-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=brauner@kernel.org; h=from:subject:message-id; bh=/mxC6qC32J0iPOhJxkeY8EHyScbniafSLgOMJKtR0XY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S/2KM03t31XgVF4UvacFL6SCqHLFvvWfP/5YI2h0 bOlC4PDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyN5Dhf8w61X9+R6qDn119 ZenDcb1C/tbqPcKHMpmO79ht8U4lPJmR4ebBuW5s0doGiyIkzOVUBay5bn7aF+24o0eJtebIllu qjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:50:28 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] openpromfs: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/6a940f2fa299

