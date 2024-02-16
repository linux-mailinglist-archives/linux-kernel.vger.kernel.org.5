Return-Path: <linux-kernel+bounces-68237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17A8577AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA811C209FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2C19BCA;
	Fri, 16 Feb 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcXRItxH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DB1A587;
	Fri, 16 Feb 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072129; cv=none; b=n9WBMvpu0k4YG+TMPBFRv3+3g8AP/dCe50T7uykcN60CyqJ1bLPCrapatPKMkd2h/J4FtNsZqxUfNV7HZCYamBFcmgSgWFpcDUlu/U9qtbVuSKNSf+ddAX1GMPIW1edRf5Vx4m2asboyDEFnfkWYEV97dIFvOnDGflVDBVdL6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072129; c=relaxed/simple;
	bh=Nc4byJdJJWJ4cNNExDneUkbDXxOHN/J7AM2XX7SxI70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0nmY13a4jBDCC8fwVgzKCU+qOB1Yi0wI1rEqbKCmEKNLLTwOMyyr4Kct4bmiws58AX6bZxWEWOKjHPQwlpaG/gpoFblAwV8c90O7NuQ8QSf00t4KPJC2Jym4fORtWLVVuLTK2/z8w8lNi4xwZQsAYPTmHmU9tgpUCg1st9GzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcXRItxH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072127; x=1739608127;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Nc4byJdJJWJ4cNNExDneUkbDXxOHN/J7AM2XX7SxI70=;
  b=GcXRItxHPIpAxAA44S324CjU8WZxiqE4BBaUahpz7r8nPj5a5W9/mSvK
   KsnyQbN8AnDjnkJ0M9Edl4zyA7Wdiise/vkiB32J01bTMVArnn1UPvQXD
   f1VMIjRpFDGuoC4tC74+WCo1MeogXmRPFRbBFISvz3ltRK1nYPCkbiXXV
   jsmoNTGMoL9yiYsFvecYkmlpasiannbDfrfEfqBsxX7OmZ51ASkWS+lDg
   3e8PRgzlGp2tb2Nst3n3q1dDAgJu0p4TMDChpHbYEqrNL01NEtXCmqPFk
   bLQ34fX12VUcWvgMoAn+/eSKuq9m+cqOTTZ2LPSbAPGrmryoABzGLnkNW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="24658539"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="24658539"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912324995"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912324995"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.79])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:28:41 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Vegard Nossum <vegard.nossum@oracle.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, Kees Cook
 <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, Lee Jones
 <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
In-Reply-To: <26b25204-9829-44a8-9836-1ce1c8725586@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
 <2024021530-plank-cornmeal-90eb@gregkh>
 <26b25204-9829-44a8-9836-1ce1c8725586@oracle.com>
Date: Fri, 16 Feb 2024 10:28:39 +0200
Message-ID: <87v86o4xu0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 15 Feb 2024, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> On 15/02/2024 12:50, Greg Kroah-Hartman wrote:
>> On Wed, Feb 14, 2024 at 09:37:31AM +0100, Vegard Nossum wrote:
>>> Document titles should have ==== above them as well, and then you would
>>> need to shift all the other headings in this document (i.e. all the ---
>>> should become ===).
>>>
>>> Info here: https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation
>> 
>> Really?  I copied this directly from
>> Documentation/process/security-bugs.rst which is in the format that I
>> used here.  Which one is incorrect, I'm confused.
>
> Documentation/ currently has a mix of both formats and they both work,
> but the guidelines linked above is the gold standard and what we should
> aim for in new documents.
>
> The "correct" format would thus be:
>
> ====
> CVEs
> ====
>
> ...
>
> Process
> =======
>
> ...
>
> At least this is my understanding; I'm happy to be corrected (and in
> this case, we should also update the documentation).

rst basically allows any order of the heading underlines, and their
relative hierarchy is determined by how they show up in each document,
it's not specified by rst. However, it would be much easier for everyone
if all the kernel documents followed the same style.

BR,
Jani.


-- 
Jani Nikula, Intel

