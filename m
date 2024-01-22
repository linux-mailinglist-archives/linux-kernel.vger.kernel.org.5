Return-Path: <linux-kernel+bounces-33594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2007836BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A20A28140F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38035D8F3;
	Mon, 22 Jan 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIZioLnI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002174644F;
	Mon, 22 Jan 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937349; cv=none; b=TxQv8xFon26glvfnL2niHH1A31MtnelcxaQmMJt2JZ3d/RIzbHcRGE6Hy5IGSjEQmHqpqP2KqWWjF3LsZntrsuNMPPb7nqlzv/lYo7F2JOHYLrRBYoHoXw0/O67tM4z/C0nahV20JupEZFiAnL2Ckd9yZ18UgijaOk6uYRgfj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937349; c=relaxed/simple;
	bh=1k1aOxkjj4SQFLxC9IWD4IuMl5NQhpbLNoabYXHAOqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RXu2+4S5EI0L4qGls8lx93FAJqu3mTOjbtLInqMoXzpDJEmxQ0cLjiRixhGQVydf0KYftxt9qBnXhvzQQdt1+lkG5zALDG1LtNob0PxWS6JZL2WExmsOTCZDTVHnzzlZvnFokYPwQ3zo1eP1bguTTWLocvGE3DGLGoIlSkGZl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIZioLnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05754C433C7;
	Mon, 22 Jan 2024 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937348;
	bh=1k1aOxkjj4SQFLxC9IWD4IuMl5NQhpbLNoabYXHAOqc=;
	h=Date:From:To:Cc:Subject:From;
	b=aIZioLnIt7idds+mjKCSbxY7Wm4kLfL11yF7BVk4yKHZJgygo+yaqgi+LV8kqS/Uc
	 CNIqnQgLYMgVl7E1Y7hVa0aTJXdzNu/M+gVS54NkPLoozqIF5k7XGdVLSQQYzSXt6l
	 rjukQa6Yyl4mcInTY+/Vm2boW6/RpuTY/DEDZ9mT9iPeOWaGjyMEEvvrZwTICUdSxu
	 EGq51ETxQNGTZ05AvoohMoKy44+z3/Ez18SFDgX5PI/NHeDmZbaV34RBwJxMs32oqh
	 xp5m4nz834+gigoDaN7cbtXvfFb1XcerxU4Xftya2av95OBjdws+QEInvCGe2hnuGm
	 bh1ut3QHX6slQ==
Date: Mon, 22 Jan 2024 09:29:05 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] Enable -Wstringop-overflow globally
Message-ID: <Za6JwRpknVIlfhPF@work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wstringop-overflow-for-6.8-rc2

for you to fetch changes up to a5e0ace04fbf56c1794b1a2fa7a93672753b3fc7:

  init: Kconfig: Disable -Wstringop-overflow for GCC-11 (2024-01-21 17:45:31 -0600)

----------------------------------------------------------------
Enable -Wstringop-overflow globally

Hi Linus,

Please, pull the following patches that enable -Wstringop-overflow,
globally. These patches have been baking in linux-next for a whole
development cycle.

I waited for the release of -rc1 to run a final build-test on top of
it before sending this pull request. Fortunatelly, after building
358 kernels overnight (basically all supported archs with a wide
variety of configs), no more warnings have surfaced! :)

Thus, we are in a good position to enable this compiler option for
all versions of GCC that support it, with the exception of GCC-11,
which appears to have some issues with this option[1].

[1] https://lore.kernel.org/lkml/b3c99290-40bc-426f-b3d2-1aa903f95c4e@embeddedor.com/

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      Makefile: Enable -Wstringop-overflow globally
      init: Kconfig: Disable -Wstringop-overflow for GCC-11

 Makefile                   |  4 ++++
 init/Kconfig               | 12 ++++++++++++
 scripts/Makefile.extrawarn |  2 --
 3 files changed, 16 insertions(+), 2 deletions(-)

