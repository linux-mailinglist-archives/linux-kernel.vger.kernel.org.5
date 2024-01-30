Return-Path: <linux-kernel+bounces-43718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE4841858
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975571C22C72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3FE374E6;
	Tue, 30 Jan 2024 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATsRK54z"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9236139;
	Tue, 30 Jan 2024 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578284; cv=none; b=Wju+NxR9kHYqhxHswXyB2cPpA+eoLS3BgBul/+Dwr2bvbbDRaoBz/ao1qYbG12tjS5kON/jjBhVFKp8e+chv59a+i+Uz53rRCHe2JrlgH+frKX4xTNHP2IbrMbs3TkV7iIxfhL1DvtWkFDySzc4uuWENSszxbrd/qr9BJVe/VoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578284; c=relaxed/simple;
	bh=pdiLzVVJ6IINEY+dX9MjF6XRC5ht/E67cJ1XtKl6k/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SBsLNsLhkrMSZ5FBirV2E8GG9fNsXhcMiZkafhAG1P+cXGFYyHhMTkAiLtUxXkZ8lIE9syeFvnUJPfoZremJaIQRgcnQ8UQTNmjsiXf+udfA4YyKXpRvgGLr3txtfyJWnQ9HVRlQZ2ZJT5UegWmaK5mujKZK8pSKNNYxl7uN1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATsRK54z; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706578282; x=1738114282;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pdiLzVVJ6IINEY+dX9MjF6XRC5ht/E67cJ1XtKl6k/k=;
  b=ATsRK54z78W/xVVkXARI+f6mmXmLAB4INi5rioaPWILICsKsZG1/mWyM
   AC7SezX7p4GhlOzRNlweoROtAMr4rdk/T3oOVBXnm2apU4qhxk9UVb6GI
   mKhQtQsldoGS3y2BuUKyPDZfklyeZZ4aFlcG7bTqAsqivWPeeUTtZO90W
   RY8B70TIWPXyc9rK5I/T3IntsPh2iTcsFm+Eb6UJZJwqSwrr/cHHlb67O
   rsIXSTj3kAq/xXjYp/QwgyPFSi6vGW83B5VgmeiJSeTsTmOZicTVNkcOD
   qe4Cj6LM+pfC+5d7JfMmM8FmnGB3K2zdKuyOpONNsmJNlMtyrHtmliJFc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="402767516"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="402767516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 17:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="788015350"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="788015350"
Received: from sriramja-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.16.208])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 17:31:12 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sunil Kovvuri
 Goutham <sgoutham@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, Hariprasad Kelam
 <hkelam@marvell.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
In-Reply-To: <BY3PR18MB4707BB7ADFB58EC7032FBAF7A07E2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
 <87h6j154yx.fsf@intel.com>
 <BY3PR18MB4707BB7ADFB58EC7032FBAF7A07E2@BY3PR18MB4707.namprd18.prod.outlook.com>
Date: Mon, 29 Jan 2024 17:31:12 -0800
Message-ID: <87jznrr4in.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sai Krishna Gajula <saikrishnag@marvell.com> writes:

>> -----Original Message-----
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Sent: Friday, January 26, 2024 5:41 AM
>> To: Sai Krishna Gajula <saikrishnag@marvell.com>;
>> richardcochran@gmail.com; davem@davemloft.net; kuba@kernel.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
>> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
>> <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Hariprasad
>> Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>
>> Cc: Sai Krishna Gajula <saikrishnag@marvell.com>; Naveen Mamindlapalli
>> <naveenm@marvell.com>
>> Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for
>> Octeon PTM clock.
>> 
>> Sai Krishna <saikrishnag@marvell.com> writes:
>> 
>> > The PCIe PTM(Precision time measurement) protocol provides precise
>> > coordination of events across multiple components like PCIe host
>> > clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
>> > support for ptp clock based PTM clock. We can use this PTP device to
>> > sync the PTM time with CLOCK_REALTIME or other PTP PHC devices using
>> > phc2sys.
>> >
>> > Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
>> > Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
>> > Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>> > ---
>> 
>> I can see that the same device id (PCI_DEVID_OCTEONTX2_PTP) is used by a
>> ethernet driver.
>> 
>> That brings me a question: why expose a different PTP chardev? In other
>> words, why can't you just implement .getcrosststamp() for that ethernet
>> device?
>
> This driver runs on endpoint device and not on the host.
> getcrosststamp() needs ART time, frequency details in case of x86 host
> system. Our use case is to sync the host's PTP/PTM time to the
> endpoint device via PTM interface.

Ah! I see. This is for "the other side", cool :-)


Cheers,
-- 
Vinicius

