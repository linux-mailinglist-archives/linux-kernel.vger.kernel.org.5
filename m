Return-Path: <linux-kernel+bounces-62454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA248520FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B3A1F2299F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853334D5A1;
	Mon, 12 Feb 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCVy1d+q"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB84CE0F;
	Mon, 12 Feb 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775712; cv=none; b=FW1j8MU9dmp3hQqo1gqMXhkOG0EOzsmTysBpX5mzZEFins87aHTRoMD+3f1AYgmTTagt69PQZG+HZ8FVSynl++uahgJDmH9T8S89ZrogoICRoTyh2ZTF1YwJ4gYLoH1wp2yn0CFJ8/ObqwiGAwrEhmzy1Lu4L037HqAM5UM9TcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775712; c=relaxed/simple;
	bh=y2m2uO1no1fiw88GoXKkQD+X/l3kVWbx0bdXFCnja60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=forLWlbQeY2p4Yquc32MdkcTD7BOrsfIK1YHQT2NI5xSk+OHCb1hXm/tvHztDJlcFuOVdiV3B4hF93UetLpvEslleNsUw5GdbK1Kjf0rMGfX6onQ5bVUZ2VUvGfZs4RbShhspWjiifkn3CRnd/TjUuIN7T+/dfqbc9k2bEE0/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCVy1d+q; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707775711; x=1739311711;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y2m2uO1no1fiw88GoXKkQD+X/l3kVWbx0bdXFCnja60=;
  b=TCVy1d+q0K++dIObUC2agJNdkLt5u6Rf31kXJlmnKKJ+6VUe2qSySy4f
   3Vx+SbJ6J2O2UKfORMaR6wQdX4w9GZp5LRrWlV3SpG6x0jgvrrMzkIl1v
   LbiEfk85Swzfzs8/r4toDBL8B4mi4v2Pbgs7oXcdboPa1wDeSun1xor7m
   FYgwm4nk3NeIrfz4LGHleUsSCHS2++uNdGA8EMwucQ2MljrNJjyYxg7aX
   cxyXUOp1TcoK2pZTfiF7aGTQisCh3/9YxX+EHamrEDP3WNNAuy1MloYU4
   wyG3uzd46XxVSjkcwC/BxTZcndjsc56JZ0ZEyhMxVzUeX4pvmdgCnp3In
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396205074"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="396205074"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 14:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7337485"
Received: from sparrish-mobl1.amr.corp.intel.com (HELO [10.209.29.247]) ([10.209.29.247])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 14:08:30 -0800
Message-ID: <dfa253e01ba9164abdd47da489c2a3da5da5cc93.camel@linux.intel.com>
Subject: Re: [PATCH] tracing: Fix wasted memory in saved_cmdlines logic
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort
 <vdonnefort@google.com>,  Sven Schnelle <svens@linux.ibm.com>, Mete Durlu
 <meted@linux.ibm.com>, stable <stable@vger.kernel.org>
Date: Mon, 12 Feb 2024 14:08:29 -0800
In-Reply-To: <20240208105328.7e73f71d@rorschach.local.home>
References: <20240208105328.7e73f71d@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 10:53 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> While looking at improving the saved_cmdlines cache I found a huge amount
> of wasted memory that should be used for the cmdlines.
>=20
> The tracing data saves pids during the trace. At sched switch, if a trace
> occurred, it will save the comm of the task that did the trace. This is
> saved in a "cache" that maps pids to comms and exposed to user space via
> the /sys/kernel/tracing/saved_cmdlines file. Currently it only caches by
> default 128 comms.
>=20
> The structure that uses this creates an array to store the pids using
> PID_MAX_DEFAULT (which is usually set to 32768). This causes the structur=
e
> to be of the size of 131104 bytes on 64 bit machines.
>=20
> In hex: 131104 =3D 0x20020, and since the kernel allocates generic memory=
 in
> powers of two, the kernel would allocate 0x40000 or 262144 bytes to store
> this structure. That leaves 131040 bytes of wasted space.
>=20
> Worse, the structure points to an allocated array to store the comm names=
,
> which is 16 bytes times the amount of names to save (currently 128), whic=
h
> is 2048 bytes. Instead of allocating a separate array, make the structure
> end with a variable length string and use the extra space for that.
>=20
> This is similar to a recommendation that Linus had made about eventfs_ino=
de names:
>=20
>   https://lore.kernel.org/all/20240130190355.11486-5-torvalds@linux-found=
ation.org/
>=20
> Instead of allocating a separate string array to hold the saved comms,
> have the structure end with: char saved_cmdlines[]; and round up to the
> next power of two over sizeof(struct saved_cmdline_buffers) + num_cmdline=
s * TASK_COMM_LEN
> It will use this extra space for the saved_cmdline portion.
>=20
> Now, instead of saving only 128 comms by default, by using this wasted
> space at the end of the structure it can save over 8000 comms and even
> saves space by removing the need for allocating the other array.

The change looks good to me code wise.  But it seems like we are still
overallocating as we can now accommodate 8000 comms when 128
was asked for.

Wonder if we can reduce the default ask to 127 comm so we don't have to
go to the next page order?

Tim


