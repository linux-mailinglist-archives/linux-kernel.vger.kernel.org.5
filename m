Return-Path: <linux-kernel+bounces-99625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C2878AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E441F214A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A15820D;
	Mon, 11 Mar 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQbd+xEN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECA5810E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197200; cv=none; b=ca0Y27K3mBT8IzUdeqYFO8XsIc8j9ZIyV2ntDScNTpcbrtZl+qOhNIqIIoVqOe5p/IVWSdB8h2AQIg8ac80RaWtph7nZNHRqIkRAHkRj7iOo+QnQdw5+KJe8t5T2qMALubp0/q1MYznBH93yHyyZDnyp9mf1tTCtR5woZA8Lo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197200; c=relaxed/simple;
	bh=ZJAAeL3fVss9iGjRrFB3dUfBTrjy5/IGazLgsApqp4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgQ3JTZdryU9wSg2hlPmMDxH8Yce9Mx5HjyD28sF4rzip1wFPN0RYhIkH7d4bzOKkaKidvHHNq9DpgLCqLLFt6VBxhbrep0EwqiG2t0Yt/aR5Ko6uoBlrhQSydVwiT3nC+Fvpha2giCuSylSC7b9zhhgx08yTMkHWAjUdvDrwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQbd+xEN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710197199; x=1741733199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZJAAeL3fVss9iGjRrFB3dUfBTrjy5/IGazLgsApqp4Q=;
  b=FQbd+xENy+oxZbeIYdwrnN/sUNl+x577ZUtEZnv+Ln5Xd1yHsIPdtKVx
   woOe+J4ZiomnEiyEIC8Z+rwEVq4/MMxtTdZqaMnvUJyAxobjXSlv/FVwx
   5xibQEZKywY2hP0u29YfVO05LpmgBwcDSCW/msTgNHxEt0MzUoELaaLHv
   ngXJxdu9esdJcCniR8ubM8Q+18VyDBa1vXOAqeqsRgg6hVwCCSNH4OxlH
   +Mj1CEa7QDBdCVRCeqiOHLguyJsxqKk+wMdHHg7OEqx/6uEdAOa5fK/Fz
   JB5apdjfRcSEgRtoBWH9qf4cO09ZPbtfLt/RZcMYqtvfa76biLxaNrqq9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5069989"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="5069989"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 15:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15811648"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.137.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 15:46:31 -0700
Date: Mon, 11 Mar 2024 15:46:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: p80211conv: Rename local foo to decrypt_check
Message-ID: <Ze+JxSpqc/eHfCKn@aschofie-mobl2>
References: <Ze9Ie67PCSvBU+og@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze9Ie67PCSvBU+og@MOLeToid>

On Mon, Mar 11, 2024 at 07:07:55PM +0100, Felix N. Kimbu wrote:
> This change renames the local variable foo to decrypt_check in functions
> skb_ether_to_p80211(...) and skb_p80211_to_ether(...), giving intuitive
> meaning to the identifier.

'rc' is typically used for cases like this. If the name of the function
being called is reasonably intuitive, then 'rc' suffices for the return
value.

> 
> It also indents the parameters to match the the opening parentheses.

'Also' signals that this patch is trying to do more than one thing.
One type of 'thing' per patch please.

The commit message prefixes are off. Please see First Patch Tutorial
Section: "Following the Driver commit style"

Patch fails checkpatch. Please see First Patch Tutorial Sections:
"Git post-commit hooks" and "Understand patch best practices"



--snip

