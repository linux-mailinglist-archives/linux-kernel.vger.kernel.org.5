Return-Path: <linux-kernel+bounces-59592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E784F96E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373971C20D26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC37AE78;
	Fri,  9 Feb 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGpEGKIk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD874E17;
	Fri,  9 Feb 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495364; cv=none; b=h2+MQYXhEEdtETDnoJIOaoxl+zuFuYj4q0Wydwjon+IZB3QJxGO3qLNm03WyplaAC2SS9Z5zrH+8QTzJWU7La9f49hbclYvtJaNUn/EFYWTS4sP0l6J6bm8R5UgmnQCcqSbclAhIKvzb/NjYr5zoZrqH5awgvLA03H9JXZEET4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495364; c=relaxed/simple;
	bh=HY7CClStAsX0getnIKIa/TlFZVB5sdICRUbb66V5RLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmQ9VIJd5L1RBE6lO7lcXFzx5zfB9Nd2qgF9zXtQGJR4KpWqN3nACFlA0H8dMBsuTrfSjeEr0XYYYCtITNw4wO++o7YDp229cNUd8epJn0Iroeyth9ETljBpBKJsBrX16ig66yVGXRpct3EA9opaWcZbg1dJP+YNyb/qxU66S/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGpEGKIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCAEC433F1;
	Fri,  9 Feb 2024 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707495364;
	bh=HY7CClStAsX0getnIKIa/TlFZVB5sdICRUbb66V5RLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGpEGKIkAC1JmD6lOOdiTmkTBbEMn8scsRqXfcET7WrGRUILvmTXO+CmK3xGd905k
	 OfxleyPCJRb8vSLbzQmaonFWBEZmeZ9Iv25B3ybhLGC3CWgE1aYjbORwUWyhia+sDH
	 NVT0bZ+l06F1hXddSuG8haJsVFrYtkvi8LmDzTuQuMJ1WoeyKKSCh98+saRiVVJeSN
	 OeaMWK4518E5Hofd3dkzgrlXa+mFq6o/kPNDD20JZLQK3I2f08I//06dWoRNMpCEyc
	 9AAlKCEUn+/NN7954XrCU3xb7uzlWisxiB5urO1YiUAdWBSv7h3hXgy4hnnrdL/0Nz
	 ULe6XoK/MNvVg==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to prepare_kill_siginfo()
Date: Fri,  9 Feb 2024 17:13:23 +0100
Message-ID: <20240209-zeitraffer-antiseptisch-56312df26b2c@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209130620.GA8039@redhat.com>
References: <20240209130620.GA8039@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=brauner@kernel.org; h=from:subject:message-id; bh=HY7CClStAsX0getnIKIa/TlFZVB5sdICRUbb66V5RLY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQe8zeMf8Hbf+7kBe3YCcbhjdZXGTyZVrxPV1i7WM5x+ f2pzbY3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbybj7DX1GmsOaDNXZRE8Wt dda1nZy47N/9cJ55V55pL0pLOLr52SNGhiUlsiobontzi1g1Ev4sifisv+5p5dw6luKFIjx/Pv8 R4QYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Feb 2024 14:06:20 +0100, Oleg Nesterov wrote:
> So that do_tkill() can use this helper too. This also simplifies
> the next patch.
> 
> TODO: perhaps we can kill prepare_kill_siginfo() and change the
> callers to use SEND_SIG_NOINFO,  but this needs some changes in
> __send_signal_locked() and TP_STORE_SIGINFO().
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

[1/2] signal: add the "int si_code" arg to prepare_kill_siginfo()
      https://git.kernel.org/vfs/vfs/c/3a363602809c
[2/2] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
      https://git.kernel.org/vfs/vfs/c/2885a4b3358d

