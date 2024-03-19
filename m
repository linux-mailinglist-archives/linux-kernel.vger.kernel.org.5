Return-Path: <linux-kernel+bounces-107060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585187F714
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B610B1F22892
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8147F69;
	Tue, 19 Mar 2024 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPiC8Qbe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58C446C8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828288; cv=none; b=VsCUVvVYLbQ2JRof1nSmjhRK5ki0MdVsdjpuD5oBKS0QFQnFaTmjXprROzgxK7gD9/JuSHMtd0WO8DfDlX57P7REr4vdB5/xqYAWxIYQR/8naUtsrQfCLIY0eL0+G+pvqgwSpqz0fDCbqhj9C99ViJsQEK3dXNJs7f48udSLrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828288; c=relaxed/simple;
	bh=tQvXsniKwtZ0PeKE/Wxl4zOW+IREK9GLuyMiAOZl5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX5QGLWzyJAaImfba8trU4fePSJF5k2nTbBGbxjgEcpzzXp6WW/pvx18ngbqB14x1eJwjPXXv9xMec8W2tHikOdMoeehLITqJWC/JpacLS7lLgd7W/CNhusLF1n0G9JTGm9LNscaQUvihi0eiPekaZB3Yr2S4+sgqLiaFWIM+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPiC8Qbe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710828286; x=1742364286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQvXsniKwtZ0PeKE/Wxl4zOW+IREK9GLuyMiAOZl5I0=;
  b=PPiC8QbeRLem/gvXxDKecbnouD+G0iSn3srlik3FU0N1pOmpn2xwgA2E
   +AzzjmUA53bjRJQB2+qKs9bFaDXOH2QJ50wNIZGpDu0w2uCLCerkSpD7g
   ikbSpPaiZivufrSh8eT5QmQ6vAgqnlVOX4/DR8QCmmUSWWPEUEXAw8fdr
   FxHQS8ys+24J0FwgrYweBqnnacatfga428RxhLJO1sBtSRnSaAhDY0WNB
   s2r2jadSMBXcpxXNkldjNpz5RgU2EpQYbVq5rOb5NdiJLg/40/pktYrME
   4woOm8777QZCd0ZsiZkNk9Pbe67EQ4GXF64AiJyP9BLY6i5BOIJpkj/xD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9478287"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="9478287"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18280558"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.26.116])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:04:36 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 0/3] Trivial code cleanup patches
Date: Tue, 19 Mar 2024 07:04:34 +0100
Message-ID: <6485785.DvuYhMxLoT@fdefranc-mobl3>
Organization: intel
In-Reply-To: <cover.1710703217.git.ayushtiw0110@gmail.com>
References: <cover.1710703217.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 18 March 2024 20:54:09 CET Ayush Tiwari wrote:
> Address different kinds of checkpatch complains for the rtl8712 module
> to ensure adherence to coding style guidelines.
> 
> Changes in v2: Checked any possible reuse of backup_PMKID_list
> manually and rebuilt, rebooted the kernel and loaded the driver
> with modprobe.

You have not made any changes to any of the three patches in this series. 
No changes in commit messages and no changes in code. Am I missing 
something?

So why did you submit a v2 of this series?

Fabio
 
> Ayush Tiwari (3):
>   staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
>   staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
>   staging: rtl8712: rename backupTKIPCountermeasure to
>     backup_TKIP_countermeasure
> 
>  drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)





