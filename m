Return-Path: <linux-kernel+bounces-48371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE6845B14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B2F283D33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A862153;
	Thu,  1 Feb 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwXALT1w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787662151
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800581; cv=none; b=fDO393OwrrTqfi86DWWlJZ+CLa5tGlGwJ8Jt8fzS8jrd6mIWLFQASj/ADjhoKeURycfa4Z6GT/9nlIN7olI74IyjfPXVOAKTS8TwuwROnQxFE7+bKXCPWufqZdIxPfgh1DyE9r4upkfqcIprmsxkG4PgQU+4z+UBDZmvy0xiFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800581; c=relaxed/simple;
	bh=A316KNzrAV6T6rXy7TU0QVcJJI2i/GiKTSFrMmqOl2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPOLErNxL5AbPzLxuR2c7CQTL9yZIVfR/tbbyswBptWtmC50sZYiTYy0oEoMYdo2eWOD2skhGbJD4RvkB8FbCFBxCvthOZ2ve6xframW3RqwCQOGKDYB5lz8H7KkelD3LK4Obsap0SsexpVuAK+wZe1i1lcQXEA1Kb3l8gT4wyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwXALT1w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800580; x=1738336580;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=A316KNzrAV6T6rXy7TU0QVcJJI2i/GiKTSFrMmqOl2Y=;
  b=HwXALT1waBM+i9ik3jEz72mKbHYQU/LC/9xI6ZdAWNNYmRf4mXrKbCsO
   WUBGCrCYPbiczAycT06aYDHz5AJQaJCMZWzllcX2KbkpRgW8S/E9SQ6S8
   u9nNsE0LU5qhuWe9keGN4ftm2Yz7O47HSEmLYNmgmdihwEgYerTk4usSN
   rb8tS/S85hfR5uYuB7IxHKsS7jc3ugYSTPigOUjW4MuqVPii+QeCgM+2t
   cXD0FbK+6fwwvz0KkaTIgqW90GC3dwww6U7V5aHoX1nrFIzE/KcfJ8taJ
   xyBQVQpKUbPOK9ZJQhcPnWbViFt+T/AJaJ6sC+9FevZ6WP3Unr09P5yPD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17303331"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="17303331"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:16:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="37216882"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:16:13 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Paz Zcharya <pazz@chromium.org>
Cc: Jouni =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>, Luca Coelho
 <luciano.coelho@intel.com>, Subrata Banik <subratabanik@google.com>,
 Manasi Navare <navaremanasi@chromium.org>, Drew Davenport
 <ddavenport@chromium.org>, Sean Paul <seanpaul@chromium.org>, Marcin
 Wojtas <mwojtas@chromium.org>, khaled.almahallawy@intel.com,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/display: Include debugfs.h in
 intel_display_debugfs_params.c
In-Reply-To: <ZbuxsF7ubmL6lzdR@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240131204658.795278-1-pazz@chromium.org>
 <87o7d0h73r.fsf@intel.com> <ZbuxsF7ubmL6lzdR@google.com>
Date: Thu, 01 Feb 2024 17:16:10 +0200
Message-ID: <87v878fc5h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Feb 2024, Paz Zcharya <pazz@chromium.org> wrote:
> Thank you so much for the super prompt reply!

FYI, looks like we've got some hiccup in CI, will merge after we get
results.

BR,
Jani.


-- 
Jani Nikula, Intel

