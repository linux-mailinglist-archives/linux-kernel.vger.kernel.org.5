Return-Path: <linux-kernel+bounces-83074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA4868E18
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287AB1C23888
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635113956A;
	Tue, 27 Feb 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUKDolkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2631386DD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031226; cv=none; b=SfdOQRKUXLnAdoPZyfLIVvJGiu1FMoytXOvnFM6CHFGq/HvEUIpP2EEpAn8zMa5YoKBzX13aaHSDNH+j3AfTGFq7s2WIRadIwl3oCMxIpeSi8VOniJIupIhpaHKom4In2C0iZMIYqUBON/okqaE6ClRBYKlknKt3+9sD1UcAC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031226; c=relaxed/simple;
	bh=tdwzpfcE9pm1aLDdYcAJxvS9HDtO9+l5eCGDiQCmZqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICmKbALwT90pZCAzkITTfIWDq0pnFNFT30MQEsm7+RSQM2Bjj+IaOK7+aRRWadI3+NS3+llItRKFhhzdmGHhc1Yh+BzFtxr1z2R7wMqtJOVXc+FPRp4vUK+t2q7TixoUfElHD6Gb2CUz5vlWdBhsoMaCqms5eVGh3ZctssWo57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUKDolkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46862C43390;
	Tue, 27 Feb 2024 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031226;
	bh=tdwzpfcE9pm1aLDdYcAJxvS9HDtO9+l5eCGDiQCmZqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUKDolkjn+GrxN91w5nH6NtVMlccBHfVbWiXyOc5miRcAT7nRQkQAFLxHgBsKZMKy
	 1h5JBfW5B6xYsKdV+Yie9qzwKZshS5LBkiTP1gId90jm32ljycK6zhvX7+BW2r9Lnf
	 iScmSSJSiv5lSfTaTTPB3RJxKWnNKxpSd9rtgkW+SKQFEf6MXdCz5YVFoxuStt65wz
	 MTQssOHvf9Wv7aS5kobbCxlbcT8f7IFIlLcLM4AovZ8UnJfZUpR7aTc1SmjiCHpnB3
	 YwhLDtb6rsxPQmyBnf8u/QBao4V/SXNKg0hCw0XdPSVNx+edzfkUvaXQTb1uuic3Bc
	 6wl1uRXZfnlFg==
From: Christian Brauner <brauner@kernel.org>
To: jlayton@kernel.org,
	jack@suse.cz,
	zhouchengming@bytedance.com,
	akpm@linux-foundation.org,
	willy@infradead.org,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] minix: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:46 +0100
Message-ID: <20240227-liege-gasheizung-15d8684aae8e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224134935.829715-1-chengming.zhou@linux.dev>
References: <20240224134935.829715-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=brauner@kernel.org; h=from:subject:message-id; bh=tdwzpfcE9pm1aLDdYcAJxvS9HDtO9+l5eCGDiQCmZqk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S925/wcz65t3IHfNjXeO1P1e9L5Jwuy/8o+CpjZl 9HsvlLMtKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBxsZGeal5N86ckzG+Zb8 uhm72zSnR99cdC52kXOFV+eUNd6zrlxh+CvVXVxxQvhfkIXspP9cq1tC7/rmPfJWvPw2USpX6N7 6CDYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:49:35 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] minix: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/84a9fad0729b

