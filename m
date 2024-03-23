Return-Path: <linux-kernel+bounces-112203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4428876E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6751F2331F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1E33DD;
	Sat, 23 Mar 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7dsq+GN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6C372
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164686; cv=none; b=NutjnPwIRoRRGLDtialS37eV9hxppaoHPUM93bolJd8eETzVf9UnCH5uibbsk4JPy0+Rqr3crI56CcYQxCC+8wuJaCOa7WyXpI8I0tAQVAh+V79T1r22QxGf0IrHrAdX4W/Gyfr+Qq1UpU8Y5yA5XZNjczEbOLZ86Wn5hJ2okSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164686; c=relaxed/simple;
	bh=jMeXv8ZVDsi4WIx6QyXGDt0WkTDb5+Iv9t7Upa/07GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm2CXXRGETmqFWAkx+pq/+O6JDzljcdZ05Xnq7CLUyH7qopnXvKBckgLgChxYh0Xc5VQ/MkUur6xySJUUYjcSHJP7RWO8+vP3gFtUAecuErmBzSJy7Vb6aOkoUfXhye8fNGEXIRaCbpVX8fIbjq1JkK06ptHL/fPQUgkctM1BuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7dsq+GN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711164684; x=1742700684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jMeXv8ZVDsi4WIx6QyXGDt0WkTDb5+Iv9t7Upa/07GA=;
  b=j7dsq+GNoHYCDyOaNJMHp1w7RHd8fiBX/4QjJFfCwmUfxikrdMnwTo86
   cQATjM0AO9q6KES2Lq1BmRJodhVCRqgmpy1qrM8jdUdCusnKZ7O9wvWQz
   BwDW3YmDV54CbntiwDTy3X8cM73xm03DQIVy0sITTm0G2U3/pp/b2x6nz
   4vYsFkEgvvDu3BVbDd7EVPAiGGyjmsiRIjaV+6lno6mqxRrn2ikFy+gtL
   A9bCOD8OQIyNVw+GgzbE/0aZ3mRfoHjXVbv+dKaq4Y3O6WARNd+pD4iI0
   bTKYGTeQDnDxsNNM2c3WQkDG9Alop8WC5XY/h7Nxnhy4o7TluYyyogebc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="28706738"
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="28706738"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 20:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="19834963"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.88.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 20:31:24 -0700
Date: Fri, 22 Mar 2024 20:31:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Trivial code cleanup patches
Message-ID: <Zf5NCuZ/JNbcSpky@aschofie-mobl2>
References: <cover.1710965653.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710965653.git.ayushtiw0110@gmail.com>

On Thu, Mar 21, 2024 at 02:55:07AM +0530, Ayush Tiwari wrote:
> Address different kinds of checkpatch complains for the rtl8712 module
> to ensure adherence to coding style guidelines.

Thanks for sending v3 as a new email, rather than threaded with
prior revisions.

I think you repeat the changelog in the patches, but I'll go
ahead and comment right here. It applies in the patch too.

> 
> Changes in v3: Fixed issues about backupPMKIDList and verified with
> CONFIG_WERROR set and built the kernel.
> 
> Changes in v2: Checked any possible reuse of backup_PMKID_list
> manually and rebuilt, rebooted the kernel and loaded the driver
> with modprobe.

The change log is to inform reviewers of what actually changed
in the patch since previous version. So let's be specific
in these v2, v3, and next a v4 changelog. I think this is
right:

v4: Update the changelog to match revision history
v3: Update memcpy() param to match new name backup_PMKID_list
v2: No changes. Just a patch sending error.

There's a section in the first patch tutorial about replying to
patch feedback and you can read any of the lore lists to see
examples. Folks will expect you to reply to their feedback.
Even if it's just a simple "Thanks, got it!" Then, they will
look to see if their feedback affected the next revision.

--Alison

> 
> Ayush Tiwari (3):
>   staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
>   staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
>   staging: rtl8712: rename backupTKIPCountermeasure to
>     backup_TKIP_countermeasure
> 
>  drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

