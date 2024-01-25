Return-Path: <linux-kernel+bounces-39324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0E483CEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EAB24E59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788D13A26E;
	Thu, 25 Jan 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MavYAVbu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E131CFA8;
	Thu, 25 Jan 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218676; cv=none; b=AhPX7+10P2zeUgJew6ezXlDOlMzUnur8v1EUdKeW+IdvVA3+kuLkVINJyb1C8s8/uJbH6265iJbZRwOrOFkpr7WBb5OCN7jHL5LH3yIEcvb+tM59cpRAg6cWp60Hnro8qgScrqDsJcDiDSyzoOL/MUfswo86nD5oeZlyuEv1yZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218676; c=relaxed/simple;
	bh=lC78wVyewjjmABhEvObMYBns92xqx2/zOC/X0yUN9bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzGcZGiSbu0M1k8DeVyAGxpPxp7IrE95eKwjMpaY05XWqi5coFOs1YO4KrkXRimmuR6TpGK7hf5p9JldRCwk0aA6LvNl7nocQUdc1zgcpeaF/nGoOdaozq20n0db2ZphnbxtXYVcO+9nnyzg9+hYISq3eNG43z+NR12vxOxywds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MavYAVbu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-beaub-VBQ1L. (unknown [4.155.48.114])
	by linux.microsoft.com (Postfix) with ESMTPSA id C006E20E56BC;
	Thu, 25 Jan 2024 13:37:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C006E20E56BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706218674;
	bh=PR/fPb1dGHHXeVY2KXfm5ZACStZEO2kXFWlKvNp4xyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MavYAVbuV4le5F5XpDrl/vF04jLi5F33JTclZmLQCQzVOu+O/5TZrHQ+yDFlYbbKs
	 hfdFMn+cBxW36fgyJ2NyffKsOzAShq+BFSwiWU1R28betONkOZHhQgkQk1uTd3nTG5
	 wyWIicfq9Fu85TbXY1CIiv/CiyqP4jouSOoECqoo=
Date: Thu, 25 Jan 2024 21:37:55 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 0/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240125213755.GA11499-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123220844.928-1-beaub@linux.microsoft.com>

It appears to put an outdated coversheet onto this series.

Below is the updated coversheet that reflects changes made:

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

Add a register_name (reg_name) to the user_event struct which allows for
split naming of events. We now have the name that was used to register
within user_events as well as the unique name for the tracepoint. Upon
registering events ensure matches based on first the reg_name, followed
by the fields and format of the event. This allows for multiple events
with the same registered name to have different formats. The underlying
tracepoint will have a unique name in the format of {reg_name}:[unique_id].

For example, if both "test u32 value" and "test u64 value" are used with
the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
tracepoints. The dynamic_events file would then show the following:
  u:test u64 count
  u:test u32 count

The actual tracepoint names look like this:
  test:[d5874fdac44]
  test:[d5914662cd4]

Both would be under the new user_events_multi system name to prevent the
older ABI from being used to squat on multi-formatted events and block
their use.

Deleting events via "!u:test u64 count" would only delete the first
tracepoint that matched that format. When the delete ABI is used all
events with the same name will be attempted to be deleted. If
per-version deletion is required, user programs should either not use
persistent events or delete them via dynamic_events.

Thanks,
-Beau

