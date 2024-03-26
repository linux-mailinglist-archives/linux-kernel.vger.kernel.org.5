Return-Path: <linux-kernel+bounces-119684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45788CC02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4A41C65727
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B41126F1E;
	Tue, 26 Mar 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2KPHxJj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD42F4A;
	Tue, 26 Mar 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477832; cv=none; b=rqFWNTZowylvS1v2klprQILFfcrZCdJ24nCKx7PWe/BRErnCzmBxooFn+QZxba8V4edi3l03H7kcs9Ji5jI+ggr1odvIHSEwuWfE8fgR9afcowRSKjUnkzHNKguJUdYI1n+dAtXWxzEIOAD4IYPq0CeFWgUQ13Q+vlpxEkjLdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477832; c=relaxed/simple;
	bh=uBLkN0mAj3ZSbr4KU4lSaYj97mBcP/vKRcrn/2cfNJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USNTvjxKBKxP9SeWtAdajyWrZ5MXq6li/+J5PqTMMGy9H1QkPWtcbiyo8lyI7V1GGEUtZKs4uxq2iV1HYga+MQX7q5DhUFhA7sE2oNXz1o6lqJAhX5yMjrkSNbhAp8syrWN2gXMNO8Mv15dMTNi0ETtvvrmLxjZIKMY6K92d9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2KPHxJj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711477830; x=1743013830;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uBLkN0mAj3ZSbr4KU4lSaYj97mBcP/vKRcrn/2cfNJo=;
  b=Q2KPHxJjCPh5vMVXxfh8EjyQp+kGpXaVvfVknWsNnjvJZ9Bvn4SIFSh/
   1sCUli35r+rbKOBad2R8WLTxvcCoL0fOG6BO5dS1NOcq0XaOog0GKXlX0
   UOvrEAggoJzzD8eoBK17LHynOJwbBlTlEitGMwD9yfbJ7SpXqsweri6QQ
   RB9jpWunrL3uz1D1gmMMlJkfPVNZzQi3V0W1OBNazN0JwEU9mBHg5EJKH
   DDuzBltN9OLuyH7ACmyDWz5p5ZEH68SsH+ft6Wsxxqk325mwajOwf6IjS
   O4q2miMX80Zr9gRVKOpRPjkE24Dq6piwb5+7tgc68jjevQ7sbQcq4tW/W
   Q==;
X-CSE-ConnectionGUID: b7K5pEkuQ6e4WFK3MTl/3A==
X-CSE-MsgGUID: Bp8GSavDRgaNO+i+aQkiKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17692503"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17692503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20697374"
Received: from unknown (HELO vcostago-mobl3) ([10.124.221.236])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:30:29 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, "Brandeburg, Jesse"
 <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, "Bezdeka,
 Florian" <florian.bezdeka@siemens.com>, Kurt Kanzenbach
 <kurt@linutronix.de>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: RE: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
In-Reply-To: <PH0PR11MB58308AF32C9678FA550F38BCD8352@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240325020928.1987947-1-yoong.siang.song@intel.com>
 <87h6gtpvyn.fsf@intel.com>
 <PH0PR11MB58308AF32C9678FA550F38BCD8352@PH0PR11MB5830.namprd11.prod.outlook.com>
Date: Tue, 26 Mar 2024 11:30:27 -0700
Message-ID: <871q7wq20s.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Song, Yoong Siang" <yoong.siang.song@intel.com> writes:

>>
>>More a question: you are potentially triggering an interrupt from
>>igc_ptp_clear_tx_tstamp() (igc_xsk_wakeup()) which can be called from
>>igc_down(). So, how does it work when there's a pending timestamp and
>>you remove the igc module? (example of a situation that it might be
>>problematic).
>
> Hi Vinicius,
>
> Thanks for reviewing the patch.
>
> There is test_bit(__IGC_DOWN, &adapter->state) checking in
> igc_sxk_wakeup(). Since igc_down() will set __IGC_DOWN before
> call into igc_ptp_suspend(), so I believe the checking in igc_sxk_wakeup()
> should be enough to prevent the situation that you mentioned.
>

Oh, I missed that one, sorry. Then:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

