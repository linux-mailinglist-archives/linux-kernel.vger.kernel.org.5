Return-Path: <linux-kernel+bounces-117383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B088AABA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E62A7C16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C05E099;
	Mon, 25 Mar 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JV5VH4m5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DD1C692
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381003; cv=none; b=DLyRAve9mUBg+K9sC6EiFBevWYwZ05FpJG5bDOIH6+w/eDnnqVIInqWpBgBYhQlhzWJdmTqCzz9LQ+exZTFh1S7IptgA2o/YzuwgmDuSuB4+Vgkjmlwr+gc3Aavak+9r4sdYyJFjQ6y0qY77f7sNXEuz5YTeYcGHbWgzI8kJB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381003; c=relaxed/simple;
	bh=6HPLPy2o0ghlEcknT+LnEDdwtnLPNgzIIhw3MI9IaSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AcSqxJhYQzuFfUQul48wgVkR/s5NGGeBN1VjDeTrf2ODc9p6hU2AILqFMTUfroTBvObXgeLGW0HljVsEVwEQIyFvhrj7LvHNK4WMNoAP9R9vXaE0Dn5x05Xqz+xcPG4yW8Dv94KkEZGu+rAG715L2cMVnM0NG8LZKOYapa20fZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JV5VH4m5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381001; x=1742917001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6HPLPy2o0ghlEcknT+LnEDdwtnLPNgzIIhw3MI9IaSI=;
  b=JV5VH4m5H878T+VXMKLNjoWNorbrab9FYbCnNShJz6oqa0A1KPGZp9o2
   CbJVtw28B2OK0ThSYXYtROqNGAixKXm6ZUNSgTA9stvnO+IjsJ6Kydmrp
   F+1FaHhCi1Lr3nvH/ZdCHe01UeAu9tkyDe7zTBej1xJFLCuIaCOKEWJpz
   ZV4EYEm0450Sh3ynRKaD6ZNDYjySdF0rM0GTczmK2kMGUihxjlTU2kCNv
   F/GwaKXjKO2o44xExz7Fp68YobiBWOds92mv2Uqa6OEzVmHXrqNcN87VM
   Q+vnMU9uHEuuisI76yPEjbwIv3XhFUcoZew+ZBwmxIb4qbmdh+0gQ6H0t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23842492"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23842492"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20337575"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:36:39 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [RFC 0/4] kernel/panic: add more descriptive logging of kernel taints
Date: Mon, 25 Mar 2024 17:36:31 +0200
Message-Id: <cover.1711380724.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

A few years back there was a discussion about it being difficult to
remember all the taint flags [1].

Time flies. I stumbled on my old branch, brushed it up, and here it is.

I'm not entirely happy with the static buf (which was there to begin
with) or how to decide on its size. Thoughts?

BR,
Jani.

[1] https://lore.kernel.org/r/YmvU+/RUhOcL+B1p@kroah.com


Jani Nikula (4):
  kernel/panic: return early from print_tainted() when not tainted
  kernel/panic: convert print_tainted() to use struct seq_buf internally
  kernel/panic: initialize taint_flags[] using a macro
  kernel/panic: add verbose logging of kernel taints in backtraces

 include/linux/panic.h |   8 +--
 kernel/panic.c        | 116 ++++++++++++++++++++++++++++--------------
 lib/dump_stack.c      |   3 ++
 3 files changed, 87 insertions(+), 40 deletions(-)

--
2.39.2

