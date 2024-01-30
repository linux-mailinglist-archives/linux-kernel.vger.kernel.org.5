Return-Path: <linux-kernel+bounces-45403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98569842FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BC628485D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130147866A;
	Tue, 30 Jan 2024 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdCDW7bo"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72778661
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654064; cv=none; b=FPIyy8pySWDI1VKxH7ZpoIQ6JII0NBBlJDQnGsQGNcGxh9W8NosEWjKN+9atRlTvnlBnWQIEDbzuFNRf/NXrR4sOcXQFkvt0bOc3Ip7lLV3fOfW/UfucR0PxrXnyxZD3U33q0mh8YLIaCj0VeSwoWuwSTE63fFKiTshUtD7z+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654064; c=relaxed/simple;
	bh=YJMQN1wSu3kzU1AM+Nw8MKpj81qbFQg+xPDsjKDzeTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DGVdEcZGGUuzn1ucUopqfnw45AKMgcYNps8BpPgHSN2+itNXYZHtODVuuynAofb4C8gJqaFd6sqP2bbn+sV6mf+pY7cGqPzXfHIagJNAUusplj/y1aqESCEpS8xkOtPa0Wpx50KmNxT6F+ke7d5J4y91bFDLM+BF6uYeO58TTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdCDW7bo; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706654062; x=1738190062;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YJMQN1wSu3kzU1AM+Nw8MKpj81qbFQg+xPDsjKDzeTc=;
  b=AdCDW7bonNwD9+53HIUrZ5b1XupIwPTW0qIiRm+Z3di4f1nHfmDW5B43
   0PNItsLqu+Q07zUPuXFwNOlQTyOcZZegkNPAW+nmPDcnFKK3Nkp6St09w
   mOD1LcVrHT0LcZB+PSFIiA71qfq5QmaSjgnj8rQt7lLLNn/jpIGkCyNp5
   /khYQXyVx29G4j1IuQMpeqbwIceAJGgeBsBL3zuM/a6UiUxngbwdFnV/Y
   vCHpikFGbWm5pkA+Ysg8EK11wP7kuZ7Chh+hhkleGqPXlhwbeW53Aip1j
   TZIZq1CxYh0UACEICzsVoxmVcImzzES5cmBy/aA1aIlv5Y/gIeSlSirS5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407136144"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="407136144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3900840"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:34:08 -0800
Date: Tue, 30 Jan 2024 14:34:06 -0800
From: Tony Luck <tony.luck@intel.com>
To: x86@kernel.org
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Subject: commit tag order vs. "b4 am"
Message-ID: <Zbl5XvzpqND9exmW@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reinette noticed that v14 of my resctrl/SNC patch series[1] did not adhere
to the tag order proscribed in Documentation/process/maintainer-tip.rst
Specifically my "Signed-off-by:" was now the last tag, instead of
appearing before the "Reviewed-by:" and "Tested-by" tags as it had in
v13.

A little digging showed that my tag had been moved to the end by "b4 am"
when I used it to pick up some additonal tags.

An e-mail discussion with Konstantin ensued to determine if this was
a bug. Konstantin said:

   This is the intended behaviour, because b4 follows the chain-of-custody
   procedure. If we encounter a Signed-off-by trailer matching the identity of
   the user preparing the series, we move it to the bottom to indicate that the
   chain-of-custody boundary has moved to include the code review trailers
   received after the initial submission.

   https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/

   Basically, the "Signed-off-by" trailer is special because it indicates that
   everything above it is the responsibility of the person doing the sign-off. If
   we kept your Signed-off-by in the original spot, then it wouldn't be clear who
   collected and applied the trailers.

Question: Do the TIP maintainers agree with Konstantin's opinion that
the Signed-off-by: includes all the tags applied prior? If so, this
should be called out in Documentation/process/maintainer-tip.rst


[1] https://lore.kernel.org/all/20240126223837.21835-1-tony.luck@intel.com/

