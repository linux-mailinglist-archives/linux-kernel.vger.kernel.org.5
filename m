Return-Path: <linux-kernel+bounces-38824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142483C68C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E231F26998
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A976EB7B;
	Thu, 25 Jan 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoLPn3s4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021552208F;
	Thu, 25 Jan 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196449; cv=none; b=PX83zXZTyhoWOBD1A7T6hNoxGILMYWT+WD2kjfsWupRip4tG/3ZcMdPxUsz6P/fkbZ5IO6EdrFfOUQ5lljhBiipW8OP//BJLSXPYli0xDRq0jM8X8BKfxYc8VcxiX19K8+qIXupayPYyvV2vO0HeT5lgmE/7PILs223bq13xEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196449; c=relaxed/simple;
	bh=ECRXr7L0zeS+DXAfWpFRjW2zvhsH9/h3X0vo3nY9358=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHlsbBVKHo+RC00KZFBsQYCTR+3ILSjvdzOmJtOnIv7kKNtJtAD9ymJeN8jhvkVFdNWtgLH+fwIHhu9g0RUHL9LfGJLJ5k8YcWq6CkPMlwevl13HBzoYnUrlKgptjfAk78LIgq5Sfb8Tjq80kHNHDhccWYRreLB6Rhzulh2aPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoLPn3s4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706196448; x=1737732448;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ECRXr7L0zeS+DXAfWpFRjW2zvhsH9/h3X0vo3nY9358=;
  b=VoLPn3s41eKCfLapzIUqCI5d1Mzjyf/8E/pOtIcQ7/mdOuGKZxd4cNoX
   lGIoAVb2P9fBnLylaSW5je9ubNwXBS1wRZccJ9eMwb4s81i5YXpJ6mL+C
   ETsmeReDLLtAm/9mHPWqRNu9gGY1C6xCXwp28xHiiEg6EU2RY7q1pPIM3
   VgwLCACC9tlSZn7MnNI58ci76mRI+j1dtsRytqRjmIs7bnFYfqN4XNQci
   ZHV0esJ5w3P0ViTj7GU3mJfdCTLqtGQ/JYkTM+WiJflSrKp/+Ydec5+lv
   1bsIHxykBlpSEJKO/bxtsViOV+pVD+x2lEpIu0m1+bGO+UCy6jl3aP3L6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="8872325"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8872325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 07:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930038615"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930038615"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 07:27:11 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <87plxpbgpz.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
 <87o7d9d7dd.fsf@somnus> <87plxpbgpz.fsf@meer.lwn.net>
Date: Thu, 25 Jan 2024 17:27:07 +0200
Message-ID: <87y1cdjuwk.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 25 Jan 2024, Jonathan Corbet <corbet@lwn.net> wrote:
> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
>> 4. Add a warning banner at the existing documentation and prepare
>>    everything to get the timer documentation to the proper place and
>>    create a place for timer documentation below the current structure.
>>
>> The benefit of 4. for me is, that there is this warning banner at the
>> top. So this suggests the reader, that this has to be revisited before
>> relying on it for 100%. This banner might also remind the original
>> author/technically deep involved developer that this should be
>> updated.
>
> The best thing, of course, is to just fix all of the documentation and
> make it perfect now :)
>
> Failing that, the banners are fine IMO.  They mark possibly obsolete
> docs, warning readers, and also just might, in an optimal world, inspire
> somebody else to work to improve the situation.
>
> I've thought for a while that we should have a standard warning or two
> along these lines, like Wikipedia does, but of course haven't done
> anything about it.

One approach could be to use the todo extension [1], and use todo
directives instead of warnings. With todo_include_todos config set to
True, you get the banners in the code, but it's more of an invitation
for people to fix them. Maybe. :)

BR,
Jani.


[1] https://www.sphinx-doc.org/en/master/usage/extensions/todo.html

-- 
Jani Nikula, Intel

