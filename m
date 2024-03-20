Return-Path: <linux-kernel+bounces-109369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A2881826
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6391F216C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4585644;
	Wed, 20 Mar 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8Qi/WVv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FF85645
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964272; cv=none; b=jSZSbFDYx7La1nhywCzrMx0nFSK6Mnzmnr4wgeCkXcObFkDOnaogbwUXraf+LZmNor/YQSYkzUjunCdu++fTqmNkRrRBVHjglEwrTaXyAodzv6WcwdXo+SJENxKUCKrYZ4k7gL7Y9SaBTcl6xG7Pzkop6pilsM5nrYaVZ5N1pmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964272; c=relaxed/simple;
	bh=EpwmDWMEvj+bTYnIg0y28dqQH8LEVqmqsBX939rabos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHYRoBr386FsVZ+VqTlOc+xZk+/9OHzcECOT+81PCmiAoTFeXrRQQP3/MUF7bzvZjcim45R0MzJcFT49RGo8Wzz9fV/Cb3aoyNShOwMbeuIVpQyS58/q7qTFyroKLUq2FA4VcqLwBMBbOcJvpoIRJAE4f7lhOJhzn9D9ynXoEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8Qi/WVv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710964271; x=1742500271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EpwmDWMEvj+bTYnIg0y28dqQH8LEVqmqsBX939rabos=;
  b=R8Qi/WVv0w+1YwWlw8fRTLySPAi3rWY3VjlhSo/ONAZwsKYzlnhIf7ar
   IbDXSqDD3jbdnAKQ/XlujCH9SA/DNRXi4AiZJtlfKzEkbWVINQm3c/7W9
   128eJjYEX22g3EFkgR4Ji8Iu3VSdfip+VsvWm+T3xwgMQ099kar+NxRe3
   lnyVjliPrNYRhx/9J0ns5BdramrTdq0mBtU+1RT/8FA2J2zPWwFQoUzKq
   Q5riVRV23IrX8fLqdXbNaZwmhQd+wNSmXuGpVz2ZpSJggeXHS6RX0qlZ1
   az+0VBtM1qD++ZeF6G/UTO9VV1cxb0ByO1vODwC0ZtPt68LExAVVIXksa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16652618"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="16652618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14655562"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:50:44 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 0/3] Trivial code cleanup patches
Date: Wed, 20 Mar 2024 20:50:40 +0100
Message-ID: <4105521.oiGErgHkdL@fdefranc-mobl3>
Organization: intel
In-Reply-To: <6485785.DvuYhMxLoT@fdefranc-mobl3>
References:
 <cover.1710703217.git.ayushtiw0110@gmail.com>
 <6485785.DvuYhMxLoT@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 19 March 2024 07:04:34 CET Fabio M. De Francesco wrote:
> On Monday, 18 March 2024 20:54:09 CET Ayush Tiwari wrote:
> > Address different kinds of checkpatch complains for the rtl8712 module
> > to ensure adherence to coding style guidelines.
> > 
> > Changes in v2: Checked any possible reuse of backup_PMKID_list
> > manually and rebuilt, 

No you didn't do what you are saying.

> rebooted the kernel and loaded the driver
> > with modprobe.
> 
> You have not made any changes to any of the three patches in this series.
> No changes in commit messages and no changes in code. Am I missing
> something?
> 
> So why did you submit a v2 of this series?
> 
> Fabio

Julia commented on patch 1/3. You should either reply that everything is 
correct (if it is) or fix your patch. Please don't send new versions that 
don't change anything and don't ignore comments (mine included).

> > Ayush Tiwari (3):
> >   staging: rtl8712: rename backupPMKIDList to backup_PMKID_list

This patch introduces errors. You haven't compiled this module, otherwise 
you would have noticed that. Always compile your changes (preferably with 
CONFIG_WERROR set). 

Please read the output of git-grep:

[fabio@linux]$ git grep backupPMKIDList drivers/staging/rtl8712
drivers/staging/rtl8712/mlme_linux.c:  static struct RT_PMKID_LIST 
backupPMKIDList[NUM_PMKID_CACHE];
drivers/staging/rtl8712/mlme_linux.c:           memcpy(&backupPMKIDList[0],
drivers/staging/rtl8712/mlme_linux.c:                  &backupPMKIDList[0],

Can you see how patch 1/3 introduces errors?

Fabio

> >   staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
> >   staging: rtl8712: rename backupTKIPCountermeasure to
> >   
> >     backup_TKIP_countermeasure
> >  
> >  drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)





