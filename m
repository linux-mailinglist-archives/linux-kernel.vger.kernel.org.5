Return-Path: <linux-kernel+bounces-55029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC084B696
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28896283FD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA2131732;
	Tue,  6 Feb 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVPpRnZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E7130ADC;
	Tue,  6 Feb 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226812; cv=none; b=sSA66zoxzrAmbS/hXJt/ko7soBgQN5EGF5ZJQEdec1IDy5F38YxNT7HDKeugGr86pwsUTPgx28J/rBr8RLIayaQi8pkkYFCx8JRyiaI+j1dB+dcS+kd76vTzdtSrdmFUdUusj2TA9NGZV1IUQ6zG8OqsPzOFOJSvvn6Nh8NktCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226812; c=relaxed/simple;
	bh=YkVNUHuBGk93qbvqheqr1gUUEeEU4IZP6E7rtwwMssw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRpqmkPFJtPwnvgefH+f0q0eXe/XojhBUZeORUkRhLFwF+4Rn8h9qtefuDGZtYxwM/2w7yuVT/p+7M3Y/XWJsZ3tgHZhTu6l1pnnX2ub7t/btFiPpE9BTvci0YZxhsn8u5kt9oU+pzd5TGlwUpgNuWsngnXQ9TShZwvFnANuBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVPpRnZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC7CC433F1;
	Tue,  6 Feb 2024 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226812;
	bh=YkVNUHuBGk93qbvqheqr1gUUEeEU4IZP6E7rtwwMssw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVPpRnZnFtaMxwTo8tHP0GHU5KnSJoDoIVOn6UGPTSTCzxJguSke6MAk+bPKpO0YY
	 RrbJ3L00/ms7jmrUjIbBDBnY9H/vXRJoByaJa1c2eIPqWu+5Y240H46zeuEgAnIT80
	 O5CBY6HIa/H6KKDiK9+CiY2VY7KGfYnea07JBJlskSjPeGWhKOh7FoVLHQVRZ4QiG1
	 Ddni2WOGkHoWohaVyyzsVPImmtVWsMajireA9OBal8YCQmJSnX1fvyZHDas4JAQ+eU
	 MV+aDDK0rFK5Ca0RN7mU4XmYqNm5WjMCyehNhNdfz77GhF5CKBmXZOrBNDhyns9aTh
	 cCSRgyrDSoV5g==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: clone: allow CLONE_THREAD | CLONE_PIDFD together
Date: Tue,  6 Feb 2024 14:40:01 +0100
Message-ID: <20240206-gelandet-einrichten-6d3365011635@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205145532.GA28823@redhat.com>
References: <20240205145532.GA28823@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org; h=from:subject:message-id; bh=YkVNUHuBGk93qbvqheqr1gUUEeEU4IZP6E7rtwwMssw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeMts8Qc3IyzLieEj6g6O5HrKVNaUPJYIjHTZdV3Zpu +d5eWlwRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET45jEy/HezC+RY/Ga5KG+f f120Y379Frew8AQViRmHZwreKEz/yvA/s37GmiuCVheuMvnyxd1zP251Qv/Ow7wXT6cJzRSytS5 lBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Feb 2024 15:55:32 +0100, Oleg Nesterov wrote:
> copy_process() just needs to pass PIDFD_THREAD to __pidfd_prepare()
> if clone_flags & CLONE_THREAD.
> 
> We can also add another CLONE_ flag (or perhaps reuse CLONE_DETACHED)
> to enforce PIDFD_THREAD without CLONE_THREAD.
> 
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

[1/1] pidfd: clone: allow CLONE_THREAD | CLONE_PIDFD together
      https://git.kernel.org/vfs/vfs/c/572a94c5290e

