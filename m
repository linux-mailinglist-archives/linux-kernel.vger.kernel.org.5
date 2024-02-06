Return-Path: <linux-kernel+bounces-54967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042484B599
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838811C23C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03231DA3F;
	Tue,  6 Feb 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWR4QWFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7F12F396
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224045; cv=none; b=EAqgIOmQZYnRCbA2Sh8QxidSHBonzyX6n7IfTmdYZPdq2qmM9PdsPP1AqbVjpKxYACX3Ip3zKV9W4qugANsiPM5rv9Ks68LhDJClMm2bqgD26Q125TwZi4VWCG1szUxzQHb0W2CRDLYwsuHRUUsllclOZ+x2x8fw2R7pmPnUgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224045; c=relaxed/simple;
	bh=cdzUH6nl3R9j/UmKXAGaCg7Yh03Jd0qTIFg89qeQ4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLInFifkv4kTeqKkz0dB4iuHxE6F8ZJ8jzYBPcF9fX+d8ePmA3JLdCjo+LCdwADUMZrXYhe0d0CBvFwmfNUBHXB6qu5cJgZE1Elq3dpwu3YZpr5tBz4mWR+sMqo7EUGzYpVVgdutACFLO5x3Qzm7za5ghXMI89sxZRELOeVpClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWR4QWFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D02FC433F1;
	Tue,  6 Feb 2024 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707224044;
	bh=cdzUH6nl3R9j/UmKXAGaCg7Yh03Jd0qTIFg89qeQ4RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWR4QWFOXlnNAtvLaAfytF3QLK7zZDjrW62fVezaT3vV0vHRKQjg7T4nw7WueHe3h
	 Y3OOV5EEB7GW6xWsyXyJQam4k4gor3Bh9LaYp0pfLHu0j2S+FoGhWDxWnNJNgrr49U
	 3EAQBNcKdiSP/tbpkVy2Yb95U1r0X3dUlXdFWiIhIWJNDu6s3TPX+pNZAQt+A7erQ9
	 VcNEyUtEnMVyFcMc8w0MS58ALO+E5/39f+ZOFDyF+vd9s5ulQ4is4kd1tQ/NqpZHj/
	 fd5DDPELMxMNbmrV5a01aB7Z5Sdz9xIuISKw9z7YAl/ZMYXzd22+SrlBOv1pF77pr5
	 lPfFPNI2feUaw==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change do_notify_pidfd() to use __wake_up(poll_to_key(EPOLLIN))
Date: Tue,  6 Feb 2024 13:53:55 +0100
Message-ID: <20240206-erbsen-nahverkehr-b7bc2be9fce7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205141348.GA16539@redhat.com>
References: <20240205141348.GA16539@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=brauner@kernel.org; h=from:subject:message-id; bh=cdzUH6nl3R9j/UmKXAGaCg7Yh03Jd0qTIFg89qeQ4RY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQe0n5y3mmxga8Za2TWTtc8z0Wvzl+ty/M9fEl8/peEx 3b5RhvkO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyaivD/+BD4m9uPqryXfQw N7lL4fzyF3a92be/TPRxue5y+cua6DKGv0LiAY/7Qk5q77y5YcUax+8rn//MMTE/atb5eMb0o3N vZDACAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Feb 2024 15:13:48 +0100, Oleg Nesterov wrote:
> rather than wake_up_all(). This way do_notify_pidfd() won't wakeup the
> POLLHUP-only waiters which wait for pid_task() == NULL.
> 
> TODO:
>     - as Christian pointed out, this asks for the new wake_up_all_poll()
>       helper, it can already have other users.
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

[1/1] pidfd: change do_notify_pidfd() to use __wake_up(poll_to_key(EPOLLIN))
      https://git.kernel.org/vfs/vfs/c/e1358f104c9e

