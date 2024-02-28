Return-Path: <linux-kernel+bounces-85253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420D86B2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457B71C24E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937C15B98E;
	Wed, 28 Feb 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5v6i5df"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61715B987
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133633; cv=none; b=Xmno0G7qHc99Z92PPpWXTf5CoZg7a2G4Cn1RBoUSpvqWSKCbzkrK5H3TVo9+/zNyUx3YwpWIaB7QoXnnaWujNVY4ktRKSken/pZyYmqW5NgqTxCP69Y2cFsHXB8kXdrhwMUcbAZcuxs/sqIZDB3EOsvPo+NtPlkovgJyOnALdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133633; c=relaxed/simple;
	bh=3O2nE44cniQ2tQX5w1nDZxqhC3jC/S/fvEVLOK16/To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPQMC6QS1T+6gNBw2W43xV0YhYEBDSCEX7g6IR9+foT5/WfDOE6/qIlW6RNL/uHUh32IWcuGBWKJllEcr2P+KMtMgCEehykjFWbsfBqM6ZLUvWfIl4fT5fYJ9qYZ84+rcQLwabdCHFv0i0Jp9Vg1EsAaVMsUz+tcNtZSzm7Z3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5v6i5df; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709133633; x=1740669633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3O2nE44cniQ2tQX5w1nDZxqhC3jC/S/fvEVLOK16/To=;
  b=L5v6i5dfvha+11eXyppYyKoFFm6imDqJGLh8kFDemG770V1RFwrKMgIq
   3GTfScV/BRMSM3doThnWYxErPpkmp96ofDvrGL3rXdgoQ8yZBW40BtEP7
   +lxbY6m+FpTZQ2R5aWbW3gPYpgzX2bGmG47KOK4zqpgwBGe1i5f9ymLir
   DAjfNUIQQKMwLbk0TUSxiqbthxQHpfdYJd+iErxEpYpYeUAb7Crf3Izul
   YKWsP7q2VvkgHy3gvnYJrM7S6lvLRPsqmwNmdA6/8aYgYvLe77jKPxYn+
   OhgzGBuQ/qKvRo68lXh3fUTfisLs3BbJQRt3ro89DatGJwfQTiX/PdzwF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14087723"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14087723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 07:20:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034392"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="937034392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 07:20:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2EE9A28A; Wed, 28 Feb 2024 17:20:28 +0200 (EET)
Date: Wed, 28 Feb 2024 17:20:28 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, x86@kernel.org, bp@alien8.de
Subject: Re: [RFC][PATCH 11/34] x86/cpu/intel: Prepare MKTME for "address
 configuration" infrastructure
Message-ID: <fagzl3kohuuka5zndogf4tzsfjvikvg5okoqr7a3godvt2vfmb@zuk2ayl6sfqy>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183941.7CB634A5@davehans-spike.ostc.intel.com>
 <z52bbgqxtr7wpa3yqqgbwurb6vx6i7gpddae2rrbxkjasuhnuk@7zsudlb4tw6s>
 <b01f92b3-65ea-474b-8dc9-f2e1ca6ae0af@intel.com>
 <wtdmrkjfvlf4b5mkpqw537u6xuxkdajix2knbo5ivanjzzpvvg@qqlw7gaetujj>
 <b32cdda4-5cca-4608-b403-30ab6ce668de@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32cdda4-5cca-4608-b403-30ab6ce668de@intel.com>

On Wed, Feb 28, 2024 at 10:48:19AM +1300, Huang, Kai wrote:
> >   	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
> >   		pr_info_once("x86/tme: not enabled by BIOS\n");
> 
> Since now detect_tme() is only called on BSP, seems we can change to
> pr_info(), which is used ...

Right.

Dave, do you want a new version? Or can you fix it up on apply?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

