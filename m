Return-Path: <linux-kernel+bounces-54986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022584B5E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245EF28ACD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C812DDBF;
	Tue,  6 Feb 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPWjXmO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430C12F39D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224621; cv=none; b=EFBcSyrShnFHkVwtDxAFyM0sE0oASMefoRL5A07Y9NJsecL1A+x2KnMCeBcbfTCG7ryX51VocL3Wt8Te0x4DnkGpGBnP31QvRHuT9dUK2qfKRZkLFLtO2Xk1aTHI92weIJ8dFKHkUp4sFM/mubAaTkZx58YQZuRLfmt0t1K4/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224621; c=relaxed/simple;
	bh=f2NJsL1AHrcmsfIRBquTgcgsHnokU+e8ioELra+4c4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mH61ZmIBI5STCZ5MpcIYFpWcmvS+vKdcd1lBa3dasekSoEuEhbXCrJvIiWlmytWjS5n/yL0eY3M2abYLiELLR99+uijfEJ0GZRZwtbQqpfz46qWDUx3uoEdhHkv2olZRi1jNtZBU+dkGNDUFXF94pBzO/9Mzaz8rLNBf4sN7vs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPWjXmO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9761AC433C7;
	Tue,  6 Feb 2024 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707224620;
	bh=f2NJsL1AHrcmsfIRBquTgcgsHnokU+e8ioELra+4c4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPWjXmO0fzr+PklyEVnkXIOdhFVtB+OEmXNHz7IcALhJJKfTQxhI6f2jjVLjh7Rfj
	 T172epi16buPnIrOTfTAYWlj6n4CEpCw6D9PhQvjPQysP98C1bdI1XmKVrh9LEpH8p
	 oyk7p/VZIf/t99xjOapXNsISczSyPKCnMWoSCLGZTlcWXKYPh0hxj759QpgZQUd63a
	 wZ68MZ24ZS1VPQpcrX7GMMXyUM3XRsxUDqJzHS67M7fgGiHQhyftkYrk/HhkgmOVNb
	 Ka49vjOqZMtUJb44RIRLc5Y4OOPXBFK3y0AiXKVR6PBTTt2DjsUCWcpLbIfvgFjQ3S
	 Wn+kvIyXXYV4g==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: exit: kill the no longer used thread_group_exited()
Date: Tue,  6 Feb 2024 14:03:28 +0100
Message-ID: <20240206-erdloch-textzeilen-09e0019041a4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205174347.GA31461@redhat.com>
References: <20240205174347.GA31461@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=brauner@kernel.org; h=from:subject:message-id; bh=f2NJsL1AHrcmsfIRBquTgcgsHnokU+e8ioELra+4c4g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQe0lNxeqoTM/W73aMPzVdX17FXVe/4eFy9Uq2z5fmBj t59C+dadZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkxJbhv+OiwklreTJios6J Z82bJH11+pU5KX7Os77/2n3xBvvk6GhGhn8Fjwvm/DGqXF22KTnQ89i1R7c6j8TVZlos9o581h/ 0gBUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Feb 2024 18:43:47 +0100, Oleg Nesterov wrote:
> It was used by pidfd_poll() but now it has no callers.
> 
> If it finally finds a modular user we can revert this change, but note
> that the comment above this helper and the changelog in 38fd525a4c61
> ("exit: Factor thread_group_exited out of pidfd_poll") are not accurate,
> thread_group_exited() won't return true if all other threads have passed
> exit_notify() and are zombies, it returns true only when all other threads
> are completely gone. Not to mention that it can only work if the task
> identified by @pid is a thread-group leader.
> 
> [...]

Applied to the vfs.pidfd branch of the vfs/vfs.git tree.
Patches in the vfs.pidfd branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.pidfd

[1/1] pidfd: exit: kill the no longer used thread_group_exited()
      https://git.kernel.org/vfs/vfs/c/3cad8297df1b

