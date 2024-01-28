Return-Path: <linux-kernel+bounces-41553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD283F462
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F5B1F22D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95628F68;
	Sun, 28 Jan 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4CUHIZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CF79DD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424164; cv=none; b=ipA6YqcmvreOjfyTdRmdIeuTcUqFyuY18599zzLNLgZMEhx/jucA4SqwBYQwidERouuwwI4mOSJIh9+hQTOkZdeeVSbVFAFR8MPS21PKLqcQ30Imfv901lbZdR2RXDYkVKqXZXy1tYu9pxadk1hpGPkr1UBC6EnIuXci+/cZ9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424164; c=relaxed/simple;
	bh=xjirCRNXK/DYvRDptj3SiekbTqyL+FF6cdOHmoxLv0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MW/q6vDSot6+uxNAlNLU/JqXtKVF/hbkr2CAIv5bi3sw0XjVNAoxcumIIfex9wI9bUMmwK6uwoYyVYS5aF/OjJJ9SyraJRhv/hVfrCJLq7Fm0zp1eazEOH2u281NMKUSrsV4+d9ay/I1QUN2V4t7sPkwllpqOc7U2+BU9aCLIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4CUHIZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C12DC433F1;
	Sun, 28 Jan 2024 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706424163;
	bh=xjirCRNXK/DYvRDptj3SiekbTqyL+FF6cdOHmoxLv0Q=;
	h=Date:From:To:Cc:Subject:From;
	b=P4CUHIZ3G4QByLAch9O3JMJg8JjnXrKfHgBg85tdEK6FuKqf+PQSHLHJdw4pYKtdq
	 UEofo6xjFv/yIb8KVMidUPVTTwK5fmRdh9Jur33k7lVaoDw45L3LAFRPs+97MrR7ka
	 vOrU678ew7sr8fJF7B6DNBFDtR0GWhTkowuIQORFqmuR+1yMOWRbt0GOMgv20SLDOi
	 fwQr5j/6YMkU+zEkj+KZ7qnhBIcueAvRyDkyAPYWLahj4cAOvult1EfTVLQguGix6t
	 0J+ZKH8jabB/76GyuLkqYlx79Cl6mwZ2ScNS3p0QscbBILKgawRsgJkNywuuz099WP
	 6xMU8rHbFv8SQ==
Date: Sun, 28 Jan 2024 08:42:16 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapopoprt <rppt@kernel.org>, Yajun Deng <yajun.deng@linux.dev>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: fix crash when reserved memory is not added to
 memory
Message-ID: <ZbX3SHT2H_aqHnGW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-01-28

for you to fetch changes up to 6a9531c3a88096a26cf3ac582f7ec44f94a7dcb2:

  memblock: fix crash when reserved memory is not added to memory (2024-01-19 10:53:59 +0200)

----------------------------------------------------------------
memblock: fix crash when reserved memory is not added to memory

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, the initialization of
reserved pages may cause access of NODE_DATA() with invalid nid and crash.

Add a fall back to early_pfn_to_nid() in memmap_init_reserved_pages() to
ensure a valid node id is always passed to init_reserved_page().

----------------------------------------------------------------
Yajun Deng (1):
      memblock: fix crash when reserved memory is not added to memory

 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

