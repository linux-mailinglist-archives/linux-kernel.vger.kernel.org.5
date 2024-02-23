Return-Path: <linux-kernel+bounces-78581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CD861553
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33A8B235B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BFB81ADF;
	Fri, 23 Feb 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCs39cQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00755224D8;
	Fri, 23 Feb 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701326; cv=none; b=GnLI3dD1sQ90WeDIBxmPfUU1HFQE9Xw2edI/THemTOJHd8ZwlGByDWd2eEMmYymb+0f5ZpgOqCAC3sps+eA29/pisadIktgPZbtRPzACS5C9cHyC+hleO3kUWMvxOeaRpNr9D/GCE1lQwEvAKnrTCKLTPzkoyg9jXVSp2tRaKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701326; c=relaxed/simple;
	bh=t1YhDY3Mj7VccEYqf444G1Mvboy/rT14dxLeiWliCn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGIcsbZONSqqTDAiikVXJCt8aPGHuJAe8qF8h3PBa498Tyf0kryi7piU24Tl39Xdtm+mWfBfAelt6GEYi+aeKzs/rJ2Dw9+uwT+XA0GAKBm3NYeIbu6VembA1YZP4eQGnwz9PXDPoIRI3n260okA9Q+mw3kQa0FrHV3umN6Wod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCs39cQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8D9C433C7;
	Fri, 23 Feb 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701325;
	bh=t1YhDY3Mj7VccEYqf444G1Mvboy/rT14dxLeiWliCn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCs39cQTEzsL+AmycumMAHIkPAHRUZY9TUmShOUgoMECQTlU+buHcZcgx5tslSjet
	 eEkOfil4TipMFWLquROqgpAoQvXEj278HzK4+aI93LcjHmThDj8HkYLpZ2ESHfUX2a
	 IVVjk70OBI90HUHHJyOU8Kmv+RHUzU9FpAw8MuRdG9+4P7Uz4xTBTf5bR44AhFXxnx
	 jZqmQzx+fMaPZdTgBEgrB935Uh+lETnnmFUxmY/xIpuP+g/HZxjb15j8pb0aYgWlad
	 BTkwwyVVUliMXBHOy/gEv4D5N5DqqdAygqPFkAKIMuiiCxyiM5z8tgOjaKoYfjfBhy
	 Br4TyPht0JRog==
From: Christian Brauner <brauner@kernel.org>
To: Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix endless loop in directory parsing
Date: Fri, 23 Feb 2024 16:15:15 +0100
Message-ID: <20240223-flurschaden-atemschutz-2f63ca39e81f@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <786185.1708694102@warthog.procyon.org.uk>
References: <786185.1708694102@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=brauner@kernel.org; h=from:subject:message-id; bh=t1YhDY3Mj7VccEYqf444G1Mvboy/rT14dxLeiWliCn8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe2Nbexnu8uEzR7WWMg2HI/Evv7Cb32P2P26GRrn/fa /79+H65jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkU+DD8Fdm1K29mwpx/r00e uHuk7dv7rXy1pd/ar216DZXBm59HFzMyfL7gxz1590O56Te9hRwuhDle22FQ+/z6BemYBcyML66 3cQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 13:15:02 +0000, David Howells wrote:
> 
> If a directory has a block with only ".__afsXXXX" files in it (from
> uncompleted silly-rename), these .__afsXXXX files are skipped but without
> advancing the file position in the dir_context.  This leads to
> afs_dir_iterate() repeating the block again and again.
> 
> Fix this by making the code that skips the .__afsXXXX file also manually
> advance the file position.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] afs: Fix endless loop in directory parsing
      https://git.kernel.org/vfs/vfs/c/c7742709248d

