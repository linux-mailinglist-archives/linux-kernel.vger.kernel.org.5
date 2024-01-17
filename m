Return-Path: <linux-kernel+bounces-29084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0370830834
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB50CB23481
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E100208D7;
	Wed, 17 Jan 2024 14:36:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C613FFF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502213; cv=none; b=Lsv4f2pof0iz3u9C0gmc7iKdJCLdNvTXl9a0y3JXbzzG2C+wLSP1gap03ZI8hyYUFRgZxeELyFfrKJu9X6drX0CJe2g2I3eY6ADHKt1LlsFD5UTluBJDdN3D9gqNzM8zyofEAfgTNsLuavnRk1vBmVsYUpi3Ek+0VNgANwbAdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502213; c=relaxed/simple;
	bh=VP+ewG4i1VGYMK580EkwFjLKkD/0UMqSk2Ya5N5+Uj0=;
	h=Received:Received:Message-ID:User-Agent:Date:From:To:Cc:Subject;
	b=FKDmY4xFJQqrIitCJiWPNpBqiUchtEI1CfWXKhm+YiZvncUfREekC6olxcbQdZrvDSO20ls4KJeX1s0ypAKoZPXRlm/IP0EIiwF9gQlP7qfOlwefkB9Zup5St3K+IqHgewR1afm3IdMYOsoUoC/1YDVUsmuOEw8w30ESC4VsosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F78C433F1;
	Wed, 17 Jan 2024 14:36:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rQ73S-00000001XXY-271S;
	Wed, 17 Jan 2024 09:38:10 -0500
Message-ID: <20240117143548.595884070@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 17 Jan 2024 09:35:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] eventfs: A few more fixes for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

More eventfs fixes for 6.8:

- Hard-code the inodes for eventfs to the same number for files, and
  the same number for directories.

- Have getdent() not create dentries/inodes in iterate_shared() as now
  it has hard-coded inode numbers

- Use kcalloc() instead of kzalloc() on a list of elements

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 1057066009c4325bb1d8430c9274894d0860e7c3


Erick Archer (1):
      eventfs: Use kcalloc() instead of kzalloc()

Steven Rostedt (Google) (2):
      eventfs: Have the inodes all for files and directories all be the same
      eventfs: Do not create dentries nor inodes in iterate_shared

----
 fs/tracefs/event_inode.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

