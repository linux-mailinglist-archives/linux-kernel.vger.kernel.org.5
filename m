Return-Path: <linux-kernel+bounces-42863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810208407EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2313CB23440
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721365BB7;
	Mon, 29 Jan 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOZyJZwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F47657C3;
	Mon, 29 Jan 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537463; cv=none; b=tqRv1Wz9/Kca8QWULIEjbH9M4PiweZCdhWN8rfkvMo6wj+rOdvvfhDlrQhBxt9qQ62Oca2WwZ0xDqvytkePUfYodddIzg3VXv2s88dNFcDiriRbAjvACOSq6Suewo9v00kk15Im8uwG+Hnf5WJuvrO4CjZf4/mhtY04FRzfTboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537463; c=relaxed/simple;
	bh=ywbv2ll5lbmpewZNor0xC+FWUmdfnz6nqlZMyPLpEi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5eOeQomP8rCIfGlhPQiyz+IpsIEMcGdMQBGtwtzUop6QuTZO9XqZZP0Y2SiXCH+Kd6TSPm3LSUCtVWzKiYQy5Fp//qmX+SXyBW21mkExp609fer1qmOCH12dAlBVE9mRIHPOGfexlNRq1tijbTtD2f76g38FJRGKDoR4VyCMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOZyJZwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C915C433F1;
	Mon, 29 Jan 2024 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706537462;
	bh=ywbv2ll5lbmpewZNor0xC+FWUmdfnz6nqlZMyPLpEi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOZyJZwyETsCXRERgUAzxOxCMZzg7shEIa8i9nMLIewP2DBTgviS7PCBxGukvIfcA
	 +J8wImpHSsODsPP7mENaQwNLPCB35eJ+qF67nkJB05GBOLTDP5Lp6uAI62TIRbRl1X
	 yzUnRgQlTrM/O8nUoyaqa+WRmvfJXOHAx9DLPPWMh2Ah8bMwUdN+LsHQmnXY4TelMx
	 MoRzI40C9olzbVHtkGgWrvzTw2D0dvKqfARLf2CwLt9yb3+wHjwZoyt/eWGL8U2cxZ
	 hwNyXKvB67hpfeT3TjQggcBkfxlbPVoM0a5M8YWJPnEP05tywBrnrUlnkL+hmnDApH
	 jUh/Tr9AU2Ikg==
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vgerkernel.org
Subject: Re: (subset) [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
Date: Mon, 29 Jan 2024 15:09:10 +0100
Message-ID: <20240129-paletten-wohnviertel-9d6c3b85f80e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127020111.487218-2-kent.overstreet@linux.dev>
References: <20240127020111.487218-1-kent.overstreet@linux.dev> <20240127020111.487218-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=brauner@kernel.org; h=from:subject:message-id; bh=ywbv2ll5lbmpewZNor0xC+FWUmdfnz6nqlZMyPLpEi0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRu3/iWxeDztORr37g01MLX9fmpfbSWuxx8PdTJ46iv5 uXDzv1mHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM54cTI8Pg0T7nNkVTm707t 7IXTw6abyb1pu2dW1jD/lpFb0oZP0xgZbs6aoa1fepXxxUL5RXXru4NlZ/xjerYqyHRJ6V2bfYZ P+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 26 Jan 2024 21:01:05 -0500, Kent Overstreet wrote:
> *_lock_nested() is fundamentally broken; lockdep needs to check lock
> ordering, but we cannot device a total ordering on an unbounded number
> of elements with only a few subclasses.
> 
> the replacement is to define lock ordering with a proper comparison
> function.
> 
> [...]

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

[1/4] fs/pipe: Convert to lockdep_cmp_fn
      https://git.kernel.org/vfs/vfs/c/38b25beb3b67

