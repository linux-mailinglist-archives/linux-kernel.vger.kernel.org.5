Return-Path: <linux-kernel+bounces-50440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F628478FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691471C27B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D418173D;
	Fri,  2 Feb 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H9919c1k"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D58063E;
	Fri,  2 Feb 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899501; cv=none; b=iOAMKoQhpeO06nKCRlK+xwQDf+YG+VZCTCdlOQD8r8O08w0N0e0Cur+Dv6GaCHk5N1IfkT82iNDvRlu1NlieS8EHLAJtQOGsS8460DFjsXDbAWca2UzF81y94UkLY2hYfk6igG5RrazExw+2ra/SJviq9f4m99Gbv1FgaMamP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899501; c=relaxed/simple;
	bh=pmKB4eIe2cyRrYdX+1cbU2atDrbrBb75iAXm274H9B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usFI74cqxavUTeqaD8WPt//DqrjvGDSZjN3TrzXdg7DLLzO8GYllNRtrplGi00REA14OY0igI6rTYmK5efomuyS8tV56mKg0NzNfbSnqGLy/Zjj7nbPKj3wjWjvyq06XpvIF4sMtOf/WEXIngWdib/uhH4I7Y/anvHj5I2qlpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H9919c1k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.115])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8987120B2000;
	Fri,  2 Feb 2024 10:44:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8987120B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706899498;
	bh=48MWZE2UYPXR09piVcxgKgUazOGoiw/j3+WKWE+SLDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=H9919c1krN3yFShbS3oFr6BFpRZlbQyUd2KqJF+tbrZoC0BtIKW8SwOz4hFRpgVO6
	 PMT3L4m4+de2NPtV4lWI+UzZ2RtxHHlwC7PxEPSpIwgqa1yEqIGbkFA6nriZJ1mh5I
	 cwm2qAzNJy0pPHJD8qs3HusCmYwywXN/fo0k/2bE=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v2 0/4] tracing/user_events: Introduce multi-format events
Date: Fri,  2 Feb 2024 18:44:45 +0000
Message-Id: <20240202184449.1674-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently user_events supports 1 event with the same name and must have
the exact same format when referenced by multiple programs. This opens
an opportunity for malicous or poorly thought through programs to
create events that others use with different formats. Another scenario
is user programs wishing to use the same event name but add more fields
later when the software updates. Various versions of a program may be
running side-by-side, which is prevented by the current single format
requirement.

Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
the user program wishes to use the same user_event name, but may have
several different formats of the event in the future. When this flag is
used, create the underlying tracepoint backing the user_event with a
unique name per-version of the format. It's important that existing ABI
users do not get this logic automatically, even if one of the multi
format events matches the format. This ensures existing programs that
create events and assume the tracepoint name will match exactly continue
to work as expected. Add logic to only check multi-format events with
other multi-format events and single-format events to only check
single-format events during find.

Change system name of the multi-format event tracepoint to ensure that
multi-format events are isolated completely from single-format events.
This prevents single-format names from conflicting with multi-format
events if they end with the same suffix as the multi-format events.

Add a register_name (reg_name) to the user_event struct which allows for
split naming of events. We now have the name that was used to register
within user_events as well as the unique name for the tracepoint. Upon
registering events ensure matches based on first the reg_name, followed
by the fields and format of the event. This allows for multiple events
with the same registered name to have different formats. The underlying
tracepoint will have a unique name in the format of {reg_name}.{unique_id}.

For example, if both "test u32 value" and "test u64 value" are used with
the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
tracepoints. The dynamic_events file would then show the following:
  u:test u64 count
  u:test u32 count

The actual tracepoint names look like this:
  test.0
  test.1

Both would be under the new user_events_multi system name to prevent the
older ABI from being used to squat on multi-formatted events and block
their use.

Deleting events via "!u:test u64 count" would only delete the first
tracepoint that matched that format. When the delete ABI is used all
events with the same name will be attempted to be deleted. If
per-version deletion is required, user programs should either not use
persistent events or delete them via dynamic_events.

Changes in v2:
  Tracepoint names changed from "name:[id]" to "name.id". Feedback
  was the : could conflict with system name formats. []'s are also
  special characters for bash.

  Updated self-test and docs to reflect the new suffix format.

  Updated docs to include a regex example to help guide recording
  programs find the correct event in ambiguous cases.

Beau Belgrave (4):
  tracing/user_events: Prepare find/delete for same name events
  tracing/user_events: Introduce multi-format events
  selftests/user_events: Test multi-format events
  tracing/user_events: Document multi-format flag

 Documentation/trace/user_events.rst           |  27 ++-
 include/uapi/linux/user_events.h              |   6 +-
 kernel/trace/trace_events_user.c              | 224 +++++++++++++-----
 .../testing/selftests/user_events/abi_test.c  | 134 +++++++++++
 4 files changed, 329 insertions(+), 62 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.34.1


