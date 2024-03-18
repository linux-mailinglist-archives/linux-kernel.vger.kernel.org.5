Return-Path: <linux-kernel+bounces-106467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3655E87EF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FF91C222C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1E55781;
	Mon, 18 Mar 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXDphS0g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1055E67;
	Mon, 18 Mar 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783363; cv=none; b=iZN5sKyCKADnjzfjhJLMXrnxN4wfFqgfDPeBh7w4pES9Qb3B9oRAnWkL9UpD/f7gvww+kL05xkXpjcr3d5aJJzVRxhmAk/7iWx080+W9idsGLDZ8dhpE2H+7wtiQBJcy/2ncgOjrmjoW40t8ISNisyGYWQksCeujk1VNt5XEUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783363; c=relaxed/simple;
	bh=5lepVMjaegCUK0SIqSPdsEcjoX5wIILym+A9zxP7jxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cr9Nt3xcC/1nq5vi21XzUZBjMu1EnfFVxzbkn4zZ4nmLdseL2nJmWhBN6pWrIycYNX2f6i0O4M5KcsVcZ0dbUMfJaVbOOjPGnfgxtD2pniuhEcn+f5XZKX4+moXa6Xrwj2JkB7gz6Rrogwd+iISEo58pIOAOLhJGJL5iWQg7e+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXDphS0g; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710783361; x=1742319361;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5lepVMjaegCUK0SIqSPdsEcjoX5wIILym+A9zxP7jxc=;
  b=QXDphS0gn8kZy2b0NNK6mEpVPlXAAOx44iOU73Q1fMtVXX6euU3FFpN0
   LRPtS9NUIlYtyzo/uFHiMMWVagUdBLjANRolZ05xgALaDM6tp8phMwkyQ
   XPIgLOAsaFjE00btbzbicwuxWzZQG20+4GabZuZJc6tRW90++T5bxfo9h
   75tdjvFYP027zR1383tOXiKNHoLadLjz1HkWDXLFUz9WR2NsJDRrye8E0
   S1FgxkJPT2KRXZpChkImqTpSjJyYJaqpyYnXwtQtH6m4Jfd8s396V85qP
   jRWDwpsmUAW23HfJC+Q4jmQBv9JDBpDQTp8uClyUdzuliGmb9TyS+b3iN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="28092429"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="28092429"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="18016376"
Received: from ahmedess-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.133])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:35:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Subject: Re: stable docs.kernel.org links?
In-Reply-To: <20240318170309.GA1187959@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240318170309.GA1187959@bhelgaas>
Date: Mon, 18 Mar 2024 19:35:55 +0200
Message-ID: <87zfuvo32c.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 18 Mar 2024, Bjorn Helgaas <helgaas@kernel.org> wrote:
> When providing a URL to a bit of code, it's nice if the URL remains
> useful indefinitely, e.g., this should work "forever" because it
> includes a git tag:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?id=v6.8#n1300
>
> Is there a similar "id=" mechanism for https://docs.kernel.org?  I
> could use https://docs.kernel.org/core-api/genalloc.html, but the link
> may become stale as docs get reorganized.
>
> I could link to the .rst file directly with the git tag, e.g.,
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/genalloc.rst?id=v6.8
>
> but of course that's not as nicely formatted.

This works, but I don't know if there are any guarantees that it keeps
working:

https://www.kernel.org/doc/html/v6.8/core-api/genalloc.html

Cc: Konstantin


BR,
Jani.


-- 
Jani Nikula, Intel

