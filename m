Return-Path: <linux-kernel+bounces-73447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888785C2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8591F2378A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26777639;
	Tue, 20 Feb 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpceG3tt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853876C82;
	Tue, 20 Feb 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450240; cv=none; b=EpkaCGqHloLGBrVXs/Tnm0BMXaDQTx7BM55YspoDHqNPY/Kgh114Ik9CtYtWFP7Ja4osvOIlLSQDldWzio9zvVvHoDJr4Y0Z96TKERv8/NOhk5wBzhCTgrHGUOxJRfulhiFlR6UKKE9dsoenCKTwTj0U4anW3KIPzto0xRv5AXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450240; c=relaxed/simple;
	bh=ewruDfDUwyGuba3mq73luIf32qgjbcvGQHybwFYwAUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzXnITJ26B98wGfn48KMWdW03gVRCHcnu6tz22qa6VRf7HpOKvp88mr1Opij+d7kgB1l222trFAZVKkCo34SamMDW0H0lAJsNMf+AiFGADq3SWv2sWmwIgRl5BarUQ372ZXFT+RAuk3Im7nJe6IN2fGyyr8CZ5xMMCzXWQU42xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpceG3tt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708450236; x=1739986236;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ewruDfDUwyGuba3mq73luIf32qgjbcvGQHybwFYwAUo=;
  b=kpceG3ttuBC+9IT8J3Gs3fR+WlrNxlhe0AepzIXvFrTlWxogKUczHPTD
   ddtlivPb7VCAgXrQm8/3GEz7ZFIycP21HcflrGvktWofiS8xWa4U7Va/l
   ORb0g05imlnuHjM1HxaQA7JF5z7DOZGQeZTnkEz5a55qfOHQ4l+WXZJHW
   Kfq+K4iGoUrs8GA8w8nsppo3a2lJ2uwTXj4zlD5CpE27RHV7XHAVI354V
   iMgMR50HDCDLi3x+cp/5mHCuW5Lk0dDf3Nl+tMdSSgWw+I9YhguNjtLOo
   7fLZshtpuddKC7mZYKQnTfZmN2sr5ov1qGJxhlugX/IIsI8/cT2Mhr9yj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2440885"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2440885"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913113242"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913113242"
Received: from akogon-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.19.103])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:30:34 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
 kurt@linutronix.de, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [iwl-net v1 2/2] igb: Fix missing time sync events
In-Reply-To: <ZdDk9AHE8svlNbbl@hoboy.vegasvil.org>
References: <20240217010455.58258-1-vinicius.gomes@intel.com>
 <20240217010455.58258-3-vinicius.gomes@intel.com>
 <ZdDLI4o1Bll1xvH6@hoboy.vegasvil.org>
 <ZdDk9AHE8svlNbbl@hoboy.vegasvil.org>
Date: Tue, 20 Feb 2024 09:30:33 -0800
Message-ID: <877ciz59hi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Richard Cochran <richardcochran@gmail.com> writes:

> On Sat, Feb 17, 2024 at 07:05:07AM -0800, Richard Cochran wrote:
>
>> Does setting ICR.Time_Sync[TXTS] also clear ICR.Time_Sync[RXTS] ?
>> 
>> That is what you seem to be saying.
>
> Okay, so you really mean that if the _same_ bit becomes set between
> the read and the acknowledgment, then that event will be missed,
> right?
>

Yeah, I will reword the commit messages so it's clearer that it's the
same bit.

> In that case, thank you for fixing this more than nine year old bug!
>
> Acked-by: Richard Cochran <richardcochran@gmail.com>
>
>  

Thank you,
-- 
Vinicius

