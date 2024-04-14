Return-Path: <linux-kernel+bounces-144228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637A38A4362
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD741C20752
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8251350DB;
	Sun, 14 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUQlcjqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80540134432
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=WSqrgE3vTPfM+GYdAruf5OMx/hgjkmpART31TE2bNONXBiBph4L7vHrg7Du9JIWxMj0Zu/OYr5/o4JK3AH1e5hmLDlyN/D0/any7VXck1ksRIci9LzfLPrhYyCDFyZpCMeGU7p5SwrtFSLgx2ebcTH2OAgThBv8O5MBr9xnJI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=7UlnJ16rSnRhcFmtv0mafzMbnH+iolNByYGo2vrHRXw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FUpTkY3xtnuTbwi48fGd7A34kjnsjnNbUnQX7o2xmoXla2C6+jttP6CxzA19JmIEeQPF59jvwVOrhXFhvD3E7VOAE8OuxxKb6xg1WBjNqcZ9pZWqENNzpHQzBLXVbnDXGDh82fZGR8m76DqzQQaWTyI3i9nwXnpXKIx8kH4umYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUQlcjqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3398BC32783;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=7UlnJ16rSnRhcFmtv0mafzMbnH+iolNByYGo2vrHRXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jUQlcjqdenEzfnEvH4B4O//d4jBvlWHG8nRNQe8B9QzGJ3YU4L0qCecmHQDXWfT7A
	 0YI9zvKDjUMsZ7duJ3NsVyp1fJYJlOjdjrFeDmoYpW4PoctA3lovvRbhXtfT/XAdoJ
	 67KZ8xxzK4QTY7iwmILezNMuIkgsmq1iFqu8q+KNF3mPpXje+g/RDUjcUXgpFeoFo7
	 flWFxPuWdfMH2ZNZEom6DfYLBwYhxP9B2WlUuiepxwVxWDlPmEiqnepgH1wQbCRmRn
	 TFu5Fe+2737oc/Pl6yA0koqkPfYqmDOZ+KuZO7t/3vbkbsBZGdxn8kmXO7JO/TpB8e
	 Z2keFJ4jw5rcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 134D5DF7858;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to wait on page writeback in
 __clone_blkaddrs()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876507.3156.2662208686749241669.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240326112845.1576111-1-chao@kernel.org>
In-Reply-To: <20240326112845.1576111-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 26 Mar 2024 19:28:45 +0800 you wrote:
> In below race condition, dst page may become writeback status
> in __clone_blkaddrs(), it needs to wait writeback before update,
> fix it.
> 
> Thread A				GC Thread
> - f2fs_move_file_range
>   - filemap_write_and_wait_range(dst)
> 					- gc_data_segment
> 					 - f2fs_down_write(dst)
> 					 - move_data_page
> 					  - set_page_writeback(dst_page)
> 					  - f2fs_submit_page_write
> 					 - f2fs_up_write(dst)
>   - f2fs_down_write(dst)
>   - __exchange_data_block
>    - __clone_blkaddrs
>     - f2fs_get_new_data_page
>     - memcpy_page
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to wait on page writeback in __clone_blkaddrs()
    https://git.kernel.org/jaegeuk/f2fs/c/d3876e34e7e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



