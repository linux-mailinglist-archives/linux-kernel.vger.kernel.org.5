Return-Path: <linux-kernel+bounces-165926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00598B9386
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C60E283AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CCF1BF50;
	Thu,  2 May 2024 03:00:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C518AF4;
	Thu,  2 May 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618808; cv=none; b=S9hz6aApfJq7rNXA6XWeBauOog2HdsFr/RX71cc2CgJz8SbGx5y2FCNx1PiGvIRbB5F5H/CouW7VlTslXqW9JgMytqaefq7Mtge4W/dVynSQ5Ci6fBqXouGyfeXtc5Z+5Y7H0BoRntZn4uTpz/cE5QVzlrqkILBRVJe7xNKJoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618808; c=relaxed/simple;
	bh=kRgeUqjKugUT6fl36wPCVjN7Bje/oAvReSD4mld4cic=;
	h=Message-ID:Date:From:To:Cc:Subject; b=SJliBGIu/HXZS7XQMss0L+GqqRxy3nb2W4HAhq6LH3k+gawArUVdAPV7xzLjmLAyhyV/7TJaPnkN66v8n+K7IHIfFoQW20T1ml2WmVjdmLsOdV167slE0dtlDQp5crBSe0XRKxzFAZvxnNrd09ghKHxbKuwhpce2qMASDcQAuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC3AC4AF18;
	Thu,  2 May 2024 03:00:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2Mgn-000000039gD-0Y8g;
	Wed, 01 May 2024 23:00:53 -0400
Message-ID: <20240502030024.062275408@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 01 May 2024 23:00:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] tracefs/eventfs: Fix inconsistent permissions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


The tracefs and eventfs permissions are created dynamically based
on what the mount point inode has or the instances directory inode has.
But the way it worked had some inconsistencies that could lead to
security issues as the file system is not behaving like admins would
expect.

The files and directories could ignore the remount option that changes
the gid or uid ownerships, leaving files susceptable to access that
is not expected. This happens if a file had its value changed previously
and then a remount changed all the files permissions. The one that
was changed previously would not be affected.

This change set resolves these inconsistencies.

This also fixes the test_ownership.tc test as it would pass on the
first time it is run, but fail on the second time, because of the
inconsistant state of the permissions. Now you can run that test
multiple times and it will always pass.

Steven Rostedt (Google) (5):
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Do not treat events directory different than other directories
      eventfs: Have "events" directory get permissions from its parent

----
 fs/tracefs/event_inode.c | 102 ++++++++++++++++++++++++++++-------------------
 fs/tracefs/inode.c       |  67 +++++++++++++++++++++++++++++--
 fs/tracefs/internal.h    |   9 +++--
 3 files changed, 130 insertions(+), 48 deletions(-)

