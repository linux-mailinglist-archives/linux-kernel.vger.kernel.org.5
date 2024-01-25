Return-Path: <linux-kernel+bounces-38901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8E83C81B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A71B1C222AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA012FF93;
	Thu, 25 Jan 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrkWGPUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32674E0B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200500; cv=none; b=qr5loHIIZSsT3F5BLBH2SDDTzjDMsPJMiskMijuvDn+njk/ZWg43igIjFu5feY7wOTUC8O5QhLimy/LkOqyK74CKGFc4QpVMbtg+etNE6Dwyo1PhsJDm7m84k/auGX96HQxG57uBPxhJX7ZD+7U8sz+E6tSUVHRbtJb3mr3hl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200500; c=relaxed/simple;
	bh=I5g+OWHe+JscFTYS3ir1nAN/wknuJjp12CvgVKZkQ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pb+yqUmoZeAdlrZlXBhUNeRG7sR5LBUmdZ0+tfbX+aBLkOCEZAbTX3XX2RfsdoaVNdYbnsSQcDDdF+gDzT7FCbsla2PrYVkMiJBhS2c24/ajJ/SliT5id4ZMVD33OQjnOURJ2CmhrZvchWqp90XeymnJHIpPF8YkVVs6MVJBr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrkWGPUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42EDC433F1;
	Thu, 25 Jan 2024 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200500;
	bh=I5g+OWHe+JscFTYS3ir1nAN/wknuJjp12CvgVKZkQ5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrkWGPUHFP/sFrTzY+Oea8nNRIydMjRl2z5nR6aHqno5b/vY5aJKULwxWU7sFoPKg
	 dVrATypCWUtLwLel2IWj0atRAGUqV1eZ9Ji5Qwqt9vOIkqkbt7eLOxoK+S9s2MMk97
	 9OPGZS0/ZVwZMSYg1BXW8JJ/pxel3Tnt2MFj+/r3iKj3agFankiTWlbUOtp/lFug15
	 lK8CQi/ai7+wYkSZSh0bK2KVstuBnx7dY3PP33PUopqFIJJBsDcS0JsMx3mvZiViYT
	 aKro9Naj3ep66TgLVznpCcnxcsiVl9CMZOBpgjY3L1/eW8nC/YJKSk54q/ssOuqi//
	 xtMnf41wjBpnQ==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pidfd: cleanup the usage of __pidfd_prepare's flags
Date: Thu, 25 Jan 2024 17:34:50 +0100
Message-ID: <20240125-kilometer-erwischen-9077030e4326@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125161734.GA778@redhat.com>
References: <20240125161734.GA778@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=brauner@kernel.org; h=from:subject:message-id; bh=I5g+OWHe+JscFTYS3ir1nAN/wknuJjp12CvgVKZkQ5g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRu6l3tuPPRvz2tVXf6XHZbf9zwbOn8u/WXv7MvY+oRY Hp8WCjzaEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEYnQYGU5e113clv/8/YYL X7dXR1zxfiLEq6Fq3esTYvK+PFZq2glGho0/uBdYnLPeVuvneiP+u2dKS65o0RkX0cxG1sXGYqy SDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 25 Jan 2024 17:17:34 +0100, Oleg Nesterov wrote:
> - make pidfd_create() static.
> 
> - Don't pass O_RDWR | O_CLOEXEC to __pidfd_prepare() in copy_process(),
>   __pidfd_prepare() adds these flags unconditionally.
> 
> - Kill the flags check in __pidfd_prepare(). sys_pidfd_open() checks the
>   flags itself, all other users of pidfd_prepare() pass flags = 0.
> 
> [...]

Thanks!

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

[1/1] pidfd: cleanup the usage of __pidfd_prepare's flags
      https://git.kernel.org/vfs/vfs/c/2502da713861

