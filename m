Return-Path: <linux-kernel+bounces-134805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D189B731
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A871A1C20E40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF979C0;
	Mon,  8 Apr 2024 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI2rCJ8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16E320D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554616; cv=none; b=hhn12QlEQU5fYg/bvtod6mhAoNEggyj6aUyVmhbg6/oNBp4ME0oQv7KRIXpWQojIqTtxWCVDwhWV/g8H++h9PFv3ELXIDKB+Kd4CosHg5Bt7WOkLS8Rlt2l5ryONKKPhRiXDc7KnFFw0tmGUsQVAZvLgU5W86A4jaHpIb7e99WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554616; c=relaxed/simple;
	bh=iU5vDNIx6zIx9DyNg2I5X/8PgAN7nC0Dy8WySJQ9hso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iRFHL5UrtBzkDKD69aLfNgEpgjc7y/EsR4lHtE2njj4kb5xAh1LKEV0dVh58LGA1EI+Zzklvq5XkRUD8G399Pm0KHlrcCP+mXUzdofWtX7qZI9T3GAE70GU7alUjBkD0uJhGiY9+4L2RH/v/kaatxnovvEQ0JuknJYUCIIjHEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI2rCJ8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACCCC433F1;
	Mon,  8 Apr 2024 05:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712554615;
	bh=iU5vDNIx6zIx9DyNg2I5X/8PgAN7nC0Dy8WySJQ9hso=;
	h=Date:From:To:Cc:Subject:From;
	b=NI2rCJ8+P5HEhnNhBD5MD8aPdH0ZvM+rIrt4QuyfQ5dcRVU31qDe6joDgIzTMtfiE
	 +uYxkHyEMl3sNfd4uleOO0PloutnovgYEuudoMedFLtlXjr+vWEXR6t37oUPAtyIyZ
	 33B3fx6AZe3CuV3q58U73xs0vDjzTmHcpQ2MYbvYSFUgW2Vo3/cQh+oEKIWOmSHDjr
	 DeHXE6bjgz+fY0eoGKit3eEui4YNni3EvtUSt4w7BNWvRc+EzaYqr+C8xwl2pbWCIp
	 Gu4wA9MDBmkV3bZX2dSh0nomcbkmkeEy3xZK+CMHixTjqJGsrzuhkumZiJdTFw2aMI
	 nw+M40WfzrLVw==
Date: Mon, 8 Apr 2024 08:35:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL]: memblock tests: fix build errors
Message-ID: <ZhOCPl22BRClRPO3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-04-08

for you to fetch changes up to 592447f6cb3c20d606d6c5d8e6af68e99707b786:

  memblock tests: fix undefined reference to `BIT' (2024-04-04 11:08:33 +0300)

----------------------------------------------------------------
memblock tests: fix build errors

* add stubs to functions that calls to them were recently added to memblock
but they were missing in tests
* update gfp_types.h to include bits.h so that BIT() definitions won't
depend on other includes

----------------------------------------------------------------
Wei Yang (3):
      memblock tests: fix undefined reference to `early_pfn_to_nid'
      memblock tests: fix undefined reference to `panic'
      memblock tests: fix undefined reference to `BIT'

 include/linux/gfp_types.h    |  2 ++
 tools/include/linux/kernel.h |  1 +
 tools/include/linux/mm.h     |  5 +++++
 tools/include/linux/panic.h  | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)
 create mode 100644 tools/include/linux/panic.h

-- 
Sincerely yours,
Mike.

