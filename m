Return-Path: <linux-kernel+bounces-101326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA387A58F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB2CB2177D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321138DE6;
	Wed, 13 Mar 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRyLy1Fl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789BD383B9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324533; cv=none; b=NT7iaGONSTGCCGsIpc9CJXCjiSc0T9Y9B5o14UvMJzS+gVv5fSOcE3Ul1itHG/DfngGizfdaj+qDAJvfIPHZqX4tG9N/aoanT4uDJAGkG2Q6D2Fc1vN7joA2nK7D66wJBFXhk6NySQxztPIUYuXV8PjFK0/+sYyL9JRZpNSJpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324533; c=relaxed/simple;
	bh=aSw6o7ezc8c9/Vjkfi+RE9UYn23okpahByuvCrBXroI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akUI2Y6MDq+CBM80eSd9KONi7iyV/J8OBQJ1YO3KeivCKoFmD+Pp8T6LVuArSeJR92qEByK7nyG1VESSK3swJF7RoWldPQM8NDOWfxHuxPMGQqYVd59TyrAKeDGSQmRuwKVk+xJ1ftLsykKJuVHOlApaVsyXkJih8mKx0BqDMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRyLy1Fl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710324532; x=1741860532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aSw6o7ezc8c9/Vjkfi+RE9UYn23okpahByuvCrBXroI=;
  b=VRyLy1FlcOaOB+M4wVCpEZa+/wgIxT6sFsRB3lfPDYkXJzm0dZiLxcMq
   0x6KsvuvMI6pjb3ddMwBzWfbtIHnFDsxn/S3yILBScKPlQ4K6b3158fuD
   VUry7gJm9sDYbJBgbpvHxBW31HMT2T0dDNfXv6AjXY7HP0N33qIXdvZCo
   cT4oCPgFFL1qZfL7uUQMUlYrwIkIG6ZZrG+x6RUSWDkJNy/haI9lSLiEO
   rVkxdUIqIr3k0W+7WduhcgQixNa1gbhxNbR4HeUIFHaFHizoA7JpSvaXV
   y/DLmW3QqurS2pHiJCHAiWr+Ig4UTIU9drHwCahVd06oGBrad25xwOcnd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8848410"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8848410"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16442321"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.6.143])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:08:48 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: outreachy@lists.linux.dev
Subject: Re: [PATCH v5] staging: rtl8712: rename tmpVal to avg_val
Date: Wed, 13 Mar 2024 11:08:45 +0100
Message-ID: <2263049.iZASKD2KPV@fdefranc-mobl3>
Organization: intel
In-Reply-To: <ZfFpW9XvHhUkcspq@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZfFpW9XvHhUkcspq@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 13 March 2024 09:52:43 CET Ayush Tiwari wrote:
> Rename local variable tmpVal back to avg_val in function process_link_qual

You are making a new patch versions (v5) against your previous one. This is 
not how the development process works...

Make v6 against a clean staging tree, and change your commit message 
accordingly:

Rename tmpVal to avg_val in process_link_qual() to reflect the intended use of 
the variable and conform to the kernel coding style. 

Not directly related but, there is no need to say that process_link_qual() is 
a function (parentheses already say that). Furthermore, by renaming you make 
it clear what is the intended use of symbols, you don't "give meaning" to them 
(they already have meaning by the mere fact that they serve their intended 
purpose - https://ludwig.guru/s/to+give+meaning+to+something).

Remember that only the final versions of patches, the accepted version, will be 
applied against the kernel. Therefore, if this version was good, it couldn't 
be applied because in process_link_qual() there is no variable called pct_val.

git-am on your patch gives expected errors:

Applying: staging: rtl8712: rename tmpVal to avg_val
error: patch failed: drivers/staging/rtl8712/rtl8712_recv.c:861
error: drivers/staging/rtl8712/rtl8712_recv.c: patch does not apply

> to give intuitive meaning to variable and match the common kernel
> coding style.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
> 
> [skip]
>
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter
> *padapter, static void process_link_qual(struct _adapter *padapter,
>  			      union recv_frame *prframe)
>  {
> -	u32	last_evm = 0, pct_val;

As said, a clean process_link_qual() has no pct_val variable.

Fabio

> +	u32	last_evm = 0, avg_val;
>  	struct rx_pkt_attrib *pattrib;
>  	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
> 
> @@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
> sqd->index = 0;
> 
>  		/* <1> Showed on UI for user, in percentage. */
> -		pct_val = sqd->total_val / sqd->total_num;
> -		padapter->recvpriv.signal = (u8)pct_val;
> +		avg_val = sqd->total_val / sqd->total_num;
> +		padapter->recvpriv.signal = (u8)avg_val;
>  	}
>  }





