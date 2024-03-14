Return-Path: <linux-kernel+bounces-102764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D587B6FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1641F22060
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C1101E6;
	Thu, 14 Mar 2024 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PgY3jklQ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F674FC09
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388578; cv=none; b=b3bLLRdIALDen5F0hhq/Xy7KnuWN6SsiT365lAy+PKSCOfGALZOS0X/7qSy99JWfnfrGKWVu4RR6l0UgMTHCDyqEvf6RZeWkT/vD4bGj5ME9jHhGtOAV9ZTzhJ94q2mOuekiHHHD2Ou86cZlv4cYBPZJ31l/qJoq1b7erzvSwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388578; c=relaxed/simple;
	bh=r/5rWAmOr8FV7J5CKIRM8SeNlP5YUbxQya4+bn61kU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mxzu6l6ptm8D5sMtGESyXj/4PggxFGb5r2H3F46f9trTxoYLfFeewFWoqS1nQaLZ77Ze9DM7FNwzCKTyZMLlSwhfuw2bU7A0gL360D6WIR7avTpCKb/Nin/GZ09/8Sct9usCMUsw541JCsWmyShELlOkP375SjTM2f7Hj8fvmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PgY3jklQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42E3u9Q6003626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710388571; bh=FnIYpBEse3cooawfHwVYLh1+SD1W84F0FexfGAX3+mA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PgY3jklQvgaGSV0dtBkXCpWa4IWBsSiOXbCbI7e5jq0xzTbLx3cBcvN/otD0PwTli
	 W3xWiDa6G7JPTalrakPW7e05FaB5gvy1UxPA295gOIS5lhh6ruUK8GoITi7endbgZu
	 4am5TxlWE4u5hHZIriFQYUz1MjkQH9+0nS+14kMTfh1NAFj2GOvO+hxNJvVhXyNGMR
	 tdCDIt4cQZqp9FoJwHTKDiRaHKl67fr2xVPqdbmQNEr6vP+oOazJ5Fq72n71cI8gbW
	 Lg8o147n1kAS3ZuYpCIBjd2clfoOBJGbONEfpHDHKleYCOkX46XkHPM3Pppls8jVV0
	 ob2+iNRFHNoSw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 428AC15C0225; Wed, 13 Mar 2024 23:56:09 -0400 (EDT)
Date: Wed, 13 Mar 2024 23:56:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for v6.9
Message-ID: <20240314035609.GA856050@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.9-rc1

for you to fetch changes up to 0ecae5410ab526225293d2591ca4632b22c2fd8c:

  ext4: initialize sbi->s_freeclusters_counter and sbi->s_dirtyclusters_counter before use in kunit test (2024-03-07 13:32:54 -0500)

----------------------------------------------------------------
Ext4 bug fixes and cleanups for 6.9-rc1, plus some additional kunit
tests.

----------------------------------------------------------------
Arnd Bergmann (1):
      ext4: kunit: use dynamic inode allocation

Baokun Li (1):
      ext4: correct best extent lstart adjustment logic

Cheng Nie (1):
      ext4: fix the comment of ext4_map_blocks()/ext4_ext_map_blocks()

Chengming Zhou (1):
      ext4: remove SLAB_MEM_SPREAD flag usage

Jan Kara (4):
      ext4: fold quota accounting into ext4_xattr_inode_lookup_create()
      ext4: drop duplicate ea_inode handling in ext4_xattr_block_set()
      ext4: don't report EOPNOTSUPP errors from discard
      ext4: verify s_clusters_per_group even without bigalloc

Kemeng Shi (8):
      ext4: Add unit test for test_free_blocks_simple
      ext4: Add unit test of ext4_mb_generate_buddy
      ext4: Add unit test for mb_mark_used
      ext4: Add unit test for mb_free_blocks
      ext4: Add unit test for ext4_mb_mark_diskspace_used
      ext4: alloc test super block from sget
      ext4: hold group lock in ext4 kunit test
      ext4: initialize sbi->s_freeclusters_counter and sbi->s_dirtyclusters_counter before use in kunit test

Maximilian Heyne (1):
      ext4: fix corruption during on-line resize

Srivathsa Dara (1):
      ext4: enable meta_bg only when new desc blocks are needed

Wenchao Hao (1):
      ext4: remove unused parameter biop in ext4_issue_discard()

Ye Bin (1):
      ext4: forbid commit inconsistent quota data when errors=remount-ro

Zhang Yi (1):
      ext4: add a hint for block bitmap corrupt state in mb_groups

yangerkun (2):
      ext4: remove unused buddy_loaded in ext4_mb_seq_groups_show
      ext4: improve error msg for ext4_mb_seq_groups_show

 fs/ext4/extents.c      |   6 +-
 fs/ext4/inode.c        |  10 +-
 fs/ext4/mballoc-test.c | 601 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.c      |  62 +++---
 fs/ext4/resize.c       |   5 +-
 fs/ext4/super.c        |  45 +++--
 fs/ext4/xattr.c        |  61 +++---
 7 files changed, 680 insertions(+), 110 deletions(-)

