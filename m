Return-Path: <linux-kernel+bounces-126536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98771893931
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C373F1C211BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC882DDD9;
	Mon,  1 Apr 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPBfuewt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150BE2F55;
	Mon,  1 Apr 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961634; cv=none; b=WEt9djM7hluvemzbDVUG9LVjK1aJUcTMpQ9wtlpZu6jh0WNOsHyNxfQuJo17d+layrIFa6W1qT8xau4OoBWRYz6/MmsWAG7VOL4YeAvr/xiVdRPFpF7Xt/E2OBLmMOEkqwsR70NnUiA63RIHqzuwPAYqByeow47l3/FDCOyjIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961634; c=relaxed/simple;
	bh=NX+uQ8uxVKNPnLm6VhOCJCE4GYlVkhpX+M9DMjah1Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVfn82GPb3jv5raoiAKOKr19TAiuudgMKyXCCa3pEqpNYH4LXmaaJR/188c3FuRsBWzMPLNSxRlaHdZRObhDplG49w8OU5I6YMptUoM2o9p807aP4eUS+mjhkfDHTErH/2r5hVDwepCCCkdeNsjyvGx4A+GOGFWd+Q9Em3PXihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPBfuewt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A30C433F1;
	Mon,  1 Apr 2024 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711961633;
	bh=NX+uQ8uxVKNPnLm6VhOCJCE4GYlVkhpX+M9DMjah1Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPBfuewtT3WxLpbXZPKdLBLXKpqvhSndMIYLWSQTYy/3BMH81KkonMs1eWViCi4c0
	 Ftnl36OrDwgiCxdNodl7IqvWNby8sIoNCAay3Xfq/scg3tvgBeLof7L7s5gxLyw1Ci
	 h7xFxVD6LWw04f0sElycSv/JZZWlHCs1Xjk0Kxq17LUyzZ4uvbfeYfzbowMjPntXWi
	 cxFR0946yVLLQgDj7L7Rn67KtDEzWOoXsP6/arWB37bCGDURxRx80zWtUGxfyD7BFE
	 d0USOvfGlTZPA4/bR5JObOb6sYm6+p+ZXH/P1MQ2LOQXOrL9o+LolUB4JoNQFTvVsC
	 nSg5pMX1PRVRw==
From: Christian Brauner <brauner@kernel.org>
To: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] orangefs: cleanup uses of strncpy
Date: Mon,  1 Apr 2024 10:52:57 +0200
Message-ID: <20240401-redewendung-retten-132ff0ea272d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>
References:  <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=brauner@kernel.org; h=from:subject:message-id; bh=NX+uQ8uxVKNPnLm6VhOCJCE4GYlVkhpX+M9DMjah1Fk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRxlUk5cUr8WO6+emV/YeOVbT0ZzWo6Pmd/LNEtU99X5 pWg+US/o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIBTQx/+Oaa5x25m57HtjXy zJu+udnhm7comgR4b+e54e43/8P0Fwz/7Pm+rX+6iGeZSfeUBY8y6/3MLP61PQtrYPnOdfHCTg4 jFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 21:41:18 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> There is some care taken to ensure these destination buffers are
> NUL-terminated by bounding the strncpy()'s by ORANGEFS_NAME_MAX - 1 or
> ORANGEFS_MAX_SERVER_ADDR_LEN - 1. Instead, we can use the new 2-argument
> version of strscpy() to guarantee NUL-termination on the destination
> buffers while simplifying the code.
> 
> [...]

If this needs to go separately from the vfs trees let me know.

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

[1/1] orangefs: cleanup uses of strncpy
      https://git.kernel.org/vfs/vfs/c/fc10fed37526

