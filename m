Return-Path: <linux-kernel+bounces-36114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B5839BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF211C23558
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00334F21E;
	Tue, 23 Jan 2024 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IfVx9G7I"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E224E1D0;
	Tue, 23 Jan 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047734; cv=none; b=Fi1ZAWRPB+zmv2AtTMfiSHnEBYlHmC1dtVNxwDPy+d+C+RLMqSBXr5KsmyzO0Ze4EWjThTSJpKW4YnQoVeoWlSixab2mJ5HnTZRL3xWB6NX8arhe2z1eRPdefLhCHT4tE7x6VNAM5fHvUlxW5bLJE2bquaVNkAE4KC06mnVtvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047734; c=relaxed/simple;
	bh=ymZLlbzgF+6RAj1E0FlGUaNHOf2JMEO6loXEClZrnFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADqLoa9/cLf7Zctl3eJyynjRhBK4M/rqMtj4foXaRJSYrduF93E/Qb3sz1ZdZlTuLS90mc6dS76XRl5cWPaQ8VsLmfvucPSp+HEUFbtK/tT7FsIalyQcpN8rFOrGmI+9/beUuIcw460k388aSL+/mWRT9dKctLjPqjekHOcc+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IfVx9G7I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id 544DA20E34C8;
	Tue, 23 Jan 2024 14:08:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 544DA20E34C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706047732;
	bh=bEfWYDXjszLhtUJ60Cu9ub34bsEWpGoaORHmdozbgOI=;
	h=From:To:Cc:Subject:Date:From;
	b=IfVx9G7IqRu1Ivn1sFKQ7IXPcAWmEaSDo9LJhk7h52yHcPUp8CAOFdqeZWZ95aMWR
	 TQ0fNWrjOozMia11x9lOyVLhTh8di4/nyU/5UPbV2JcVxdhRAa+mxsMKGllu5L85oU
	 iCQQnPV76Ai+av9aEoNQRNW4bS7gG5VLobnKg9i4=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH 0/4] tracing/user_events: Introduce multi-format events
Date: Tue, 23 Jan 2024 22:08:40 +0000
Message-Id: <20240123220844.928-1-beaub@linux.microsoft.com>
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

Add a register_name (reg_name) to the user_event struct which allows for
split naming of events. We now have the name that was used to register
within user_events as well as the unique name for the tracepoint. Upon
registering events ensure matches based on first the reg_name, followed
by the fields and format of the event. This allows for multiple events
with the same registered name to have different formats. The underlying
tracepoint will have a unique name in the format of {reg_name}:[unique_id].
The unique_id is the time, in nanoseconds, of the event creation converted
to hex. Since this is done under the register mutex, it is extremely
unlikely for these IDs to ever match. It's also very unlikely a malicious
program could consistently guess what the name would be and attempt to
squat on it via the single format ABI.

For example, if both "test u32 value" and "test u64 value" are used with
the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
tracepoints. The dynamic_events file would then show the following:
  u:test u64 count
  u:test u32 count

The actual tracepoint names look like this:
  test:[d5874fdac44]
  test:[d5914662cd4]

Deleting events via "!u:test u64 count" would only delete the first
tracepoint that matched that format. When the delete ABI is used all
events with the same name will be attempted to be deleted. If
per-version deletion is required, user programs should either not use
persistent events or delete them via dynamic_events.

Beau Belgrave (4):
  tracing/user_events: Prepare find/delete for same name events
  tracing/user_events: Introduce multi-format events
  selftests/user_events: Test multi-format events
  tracing/user_events: Document multi-format flag

 Documentation/trace/user_events.rst           |  23 +-
 include/uapi/linux/user_events.h              |   6 +-
 kernel/trace/trace_events_user.c              | 224 +++++++++++++-----
 .../testing/selftests/user_events/abi_test.c  | 134 +++++++++++
 4 files changed, 325 insertions(+), 62 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.34.1


