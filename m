Return-Path: <linux-kernel+bounces-50049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75F8473AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847C81F299AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216361474AC;
	Fri,  2 Feb 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYrXcY3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFA179A5;
	Fri,  2 Feb 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888977; cv=none; b=WTNjihGfnyOLdI9s7xsn9Ro5fjofIZnJm6kL2ORwaAWShnaNDOe7awGAJxBflZCwCG6l2OW1+gpx+SkgSpL1tWEKYjTpXRHIvjWfP+3eQ6ztSPXLAg2x3g8rID79rXqg3yjjbiXaoGbtsysYfHGNMXjmIcojzQX15Zrx59nouDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888977; c=relaxed/simple;
	bh=63G+CJKkgiFAMm5syYVO7r8aaYTakNEk7YekvfGgbM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRaWqPx3gmter/8SaBV/drtj9BXvpxLndwqYpO/z4ZEtwO01bPFebeKB44WD66oCYnbCeJtpkgyvMzg6e0dG4qxKnEIudH7NDfDHkbLJESGCkFTPYJcFkNyUHGk9mowC2nmL2tKTk4xV8b9fCGV1hRlzPhCrYhZBbVQHvWBaQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYrXcY3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E73C433F1;
	Fri,  2 Feb 2024 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706888976;
	bh=63G+CJKkgiFAMm5syYVO7r8aaYTakNEk7YekvfGgbM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYrXcY3WjLa1QnpPMwhItz7KWoiJj9u/hXec44z4BpyMoS3zvyAW3r9crnszwJuUL
	 zYbX2YSZIGj6/EYJIyMdB1IlxppD9Arb1oHgqZm/OEWGC7mJpPfA9rsoQ2jfslY0kF
	 G3RQ+e93r+DI/9Bm9nomdMAIX0Un2v2VVa19S3/j2k8NakG7PziWFgfL7juHxMwe7G
	 j9ONUyttVF85N+b7ejUgPqVr/sQ4TNpq1T9ycOhCsvPczQCSCH/AnceLMo2f73o10O
	 0mvk7gF81E8VvhC7PhHkHiy6wJ6aM2Up79goi47vxAj5C9Btnf4sobuufR//LfSJbS
	 y2kdcN+M8Mgug==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Date: Fri,  2 Feb 2024 16:49:04 +0100
Message-ID: <20240202-zentral-direkt-72e2f4d7ca36@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202131147.GA25988@redhat.com>
References: <20240202131147.GA25988@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=brauner@kernel.org; h=from:subject:message-id; bh=63G+CJKkgiFAMm5syYVO7r8aaYTakNEk7YekvfGgbM8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu5efoezOv9MTbt+Ip7NH5dozNJXHF4nLF7tbsF72/l 0zx6p7TUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHUu4wM3823aQeJl1YyuG5/ tIRNc763tAr39mWfWP1XfjyinHFGj+E3m26fmIvPvPPmilOLzjyR+Zn+iznNTFf85PdJX7M+vjX lBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 14:11:47 +0100, Oleg Nesterov wrote:
> 3/3 is the unrelated "while at it" change.
> 
> Oleg.
> 

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

[1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
      https://git.kernel.org/vfs/vfs/c/0ab0783b0160
[2/3] pidfd: kill the no longer needed do_notify_pidfd() in de_thread()
      https://git.kernel.org/vfs/vfs/c/afe79af3b522
[3/3] pid: kill the obsolete PIDTYPE_PID code in transfer_pid()
      https://git.kernel.org/vfs/vfs/c/082d11c164ae

