Return-Path: <linux-kernel+bounces-46523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E88440E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD41F2A013
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E679762CD;
	Wed, 31 Jan 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1WwKLt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655E7F493
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708549; cv=none; b=JYaulIozQyppREDHbBkDkzz1/wZShTiz8bcBfEC/0HLvrW15JaUUCdsUQ8xm6yrAmaWc86JLEDAP+iTDbBuDlAjHFDIiOIts+B9dmiuKMdT7vD9Ick6hsQkP7WsLsSArHgpm0E8pZy9DVB3dSNPZhbKidSrv+rrH2e6LSoDSqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708549; c=relaxed/simple;
	bh=fd1t+MLIGSo6+wlh3RIVbOHWgyBs2x0wMqT9re9kEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5NA3iXKPNvXP4/2kqKpZUfXV9Bimlptl5k+ENZxALmk4d1hC75CKa15vzt/dDYAEaPVSISlQz4K9eiKU7xypxqPiadw1UccBc/rZ+CAJhGjQ9hvB0mauNfQ5av70eNFJFYH3ADdzE7Q4H9t8h9QzV1wmADbe7x89La0Dif9P1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1WwKLt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB81C433B1;
	Wed, 31 Jan 2024 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708549;
	bh=fd1t+MLIGSo6+wlh3RIVbOHWgyBs2x0wMqT9re9kEy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1WwKLt03TqdOnpUjf1cXTHb1alrPuAU0pt3A9l75Oy88IpWm+ZkD0BU+d+99LOui
	 broJoYdx5EgMwcfpDwbhe8sQ0ZG6t0HBgWeEalnseiKQWTM+9RjZmzXBbIkZMWe4Pv
	 dD0cD1CHmgdFf2bNq1nZy7L0JZu938BiYQVS9FaoU7HfxvdjTADeUhX+Tu2bLg4KvX
	 QdLsy7ebU0AgusZ26ywXmFiYGAdAKP3kLPgZU7j+TFf5akTwXVrYk4mrMc/A7uA7n9
	 BDC69K1BBDLb7l80rOGZRjWQFdC2CpvhyxrQxuA8T7IPA57OPtlpE8/XibTCQ0fqQ7
	 fDsPC+2vK6xrg==
From: Christian Brauner <brauner@kernel.org>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Christian Brauner <brauner@kernel.org>,
	stone.xulei@xfusion.com,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork: Using clone_flags for legacy clone check
Date: Wed, 31 Jan 2024 14:42:10 +0100
Message-ID: <20240131-skeptiker-bahnstation-a6bc73ed780e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202401311054+0800-wangjinchao@xfusion.com>
References: <202401311054+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=brauner@kernel.org; h=from:subject:message-id; bh=fd1t+MLIGSo6+wlh3RIVbOHWgyBs2x0wMqT9re9kEy4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8rO9vlqLM+zlXoGd29Wfrr714tmfC5LTd9gr3xU+8 uaWnBd7dkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEenYy/M+Zyqi23uioTYZd +4+VrBc1w/uiAtinNkg+tp/34EtfzUNGht9xMYfX+FVuXKDZE74w/vH3yMJlNT2vK0IDF6XvP/R 8NRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 10:54:41 +0800, Wang Jinchao wrote:
> In the current implementation of clone(), there is a line that
> initializes `u64 clone_flags = args->flags` at the top.
> This means that there is no longer a need to use args->flags
> for the legacy clone check.
> 
> 

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

[1/1] fork: Using clone_flags for legacy clone check
      https://git.kernel.org/vfs/vfs/c/b473491b6cf8

