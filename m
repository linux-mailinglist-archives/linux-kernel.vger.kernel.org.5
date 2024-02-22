Return-Path: <linux-kernel+bounces-75710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D485EDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D9EB22401
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C9A95E;
	Thu, 22 Feb 2024 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MIsneGrY"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18574749C;
	Thu, 22 Feb 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561094; cv=none; b=oG9QE7r3xvCLGnjIi2kk8kQhIFiCjOccwDSSHaj5hRvwEcNXeLilhKv/jhilkdqrfq2LtW4cs2vLx7D93mWrHUeQuJd7Uz1GoNUKQjOAG0QXIPQrWgIlZAAGT+NLK01xRcvJjthvtCNS4czY0AyKawqFy3MPhDRbrcE/J7l/SFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561094; c=relaxed/simple;
	bh=HOC8fAp7uoZPx2wsPqzZgkjKamQtnMHmTT6efKj+cIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNywNP5EvoVtlWkqdOJPZJHp8Y1CJztgJ4MUwO5+G6IopY3bgC2rgexbt2XWJQaI/Hka4EIb+Mt3SvOuu9ml5SZ/fL+ZgnrCkjYZo0a4sFklhfIx75lM8oq++8y3DuJG5TQYBMcQKSkLmu+9TGNzyY+IqnBrpTUAZcrYlARQ43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MIsneGrY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.121])
	by linux.microsoft.com (Postfix) with ESMTPSA id 92F362083ED8;
	Wed, 21 Feb 2024 16:18:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92F362083ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708561092;
	bh=leI7pBm4iv+OeYaf/mJ+4WxQz3RxcWm8jW8X2o4m6pI=;
	h=From:To:Cc:Subject:Date:From;
	b=MIsneGrYOMi1dtwhI6w+PAWJhofXi54dfiDvrTKr7tu5DCr6Hvsbp9bdOLlZuia45
	 IJ2JVPXMJ8KUsQB9MOWuY2BQ/kGClkJA2Ud9E1eiJsEtEiomvZ0zW1uHVAxTATu628
	 zGHtkDmJZmJ15nlssODFmOnCwSGQsoSE8PLLgX9s=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v4 0/4] tracing/user_events: Introduce multi-format events
Date: Thu, 22 Feb 2024 00:18:03 +0000
Message-Id: <20240222001807.1463-1-beaub@linux.microsoft.com>
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
several different formats of the event. When this flag is used, create
the underlying tracepoint backing the user_event with a unique name
per-version of the format. It's important that existing ABI users do
not get this logic automatically, even if one of the multi format
events matches the format. This ensures existing programs that create
events and assume the tracepoint name will match exactly continue to
work as expected. Add logic to only check multi-format events with
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

Changes in v4:
  Use kstrdup() in user_event_group_system_multi_name() vs kmalloc() and
  snprintf().
  
  Use kasprintf() in user_event_set_tp_name() vs kzalloc() and snprintf().

  Grammar fixes in change logs.

Changes in v3:
  Use hash_for_each_possible_safe() in destroy_user_event() to prevent
  use after free (caught by kernel test robot <oliver.sang@intel.com>).

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
 kernel/trace/trace_events_user.c              | 209 +++++++++++++-----
 .../testing/selftests/user_events/abi_test.c  | 134 +++++++++++
 4 files changed, 314 insertions(+), 62 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.34.1


