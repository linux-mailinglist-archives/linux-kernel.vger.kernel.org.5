Return-Path: <linux-kernel+bounces-83078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2A868E21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6451F2321A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F513A24A;
	Tue, 27 Feb 2024 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDlxXaXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62C139567;
	Tue, 27 Feb 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031252; cv=none; b=vDagJ8ReNHTNoGZ+sp+nVccP51KuzgY2NHMi4s7aAsYOw8VO9wA7MG1fMHKGp19t9yBFUhM+7pFEyKW77MRacWqhueEIJl69AcY14Pvb65LTXXaG/GUjvZFyEvKBKBfWULfBJ3ni+96heChVm4rLwKXNvJwocYuOLOdqmtSlx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031252; c=relaxed/simple;
	bh=PwLisQd0EelziiSm3SmIZjWasG/wzOm57XHS0YJKHTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdU9PDNy48ZzaSLt+A7rJNT2E9kWfYPxfl5A4MpjANRy5fOZDWCSGtmYPGdDB4gTDAowUIu0qa8Eudas4TitT1sOn6jZBgSWyN6jmyVhaupjfe+xiAmk19ljIupLRBbFBrYN8uqjuG9dNGsXMT4zuMLG3WptQYXBoPYOhAmSaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDlxXaXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF8BC43390;
	Tue, 27 Feb 2024 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031252;
	bh=PwLisQd0EelziiSm3SmIZjWasG/wzOm57XHS0YJKHTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDlxXaXT+hEHByhmkXTKK9ngosXmGxEwZjh/bNcRmVh172231mNSYb6LcQ+XLHHTu
	 EGrFeyw9MRq5VOaARrxI/XmOVrIoKdGqKrjp6A4USV9Q8Ru652SsMxE5KCc2lyTc05
	 QvnE0XLDUQnvYraDbEHvUVKA3G8jmlLFOZ8FTqhfmTlnC9p6fOAgeNRGD1oTd7n0lA
	 pTnekJzufj1zt0vXcCVl+OVklwJnmHlA+q/kNf0o5LHkZOHWPeH/X2SPegSWkU+JZg
	 GmNZAm4mNWoa9R/vNBp8NffXj7ugj7vPpLp7X9R7uwHGb+xzrUCj40OyWmTfe4c6xl
	 2Q5JMCgUEttTQ==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	jlayton@kernel.org,
	zhouchengming@bytedance.com,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	reiserfs-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] reiserfs: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:50 +0100
Message-ID: <20240227-molch-kanzlei-19a6f2a8c45d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135126.830110-1-chengming.zhou@linux.dev>
References: <20240224135126.830110-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=brauner@kernel.org; h=from:subject:message-id; bh=PwLisQd0EelziiSm3SmIZjWasG/wzOm57XHS0YJKHTg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S/hnWcg7yG3bWvqqdxZvxnSPkgsYxBkCv6yhb1/+ cf8z9w2HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5ZMjIMF917ZeAjqxVZmGc akK39l1ZsHtCjFehUK6V88frK7TnpTEy3D/45bHkxCeW3JGL7i3OqFzxQ9vOefl1vypHEUFTz95 OTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:51:26 +0000, chengming.zhou@linux.dev wrote:
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

[1/1] reiserfs: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/e86aa34da713

