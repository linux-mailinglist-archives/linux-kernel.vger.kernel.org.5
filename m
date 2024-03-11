Return-Path: <linux-kernel+bounces-98796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA4877F90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F11C21D94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FF3CF7E;
	Mon, 11 Mar 2024 12:04:32 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0337169;
	Mon, 11 Mar 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158672; cv=none; b=g1S1m9BI3KADqMjnDzdl9dIuFHRvxtxI/tJAWcpL2tXa/jXPE8osoxvpGoFVUOjiqXX2Iy5pd1qwotlRJzUHRq/Y1wDYqiUZlAs7xu+p/HVXCz/2E/Ulo+JQw7cgcmIq4UKL5zpowiNvtA97fZPD8CDX0s6HMEMo9C2KDllM7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158672; c=relaxed/simple;
	bh=nkJgEXT1Ucxn9qpvwgcSnGtM5AohvS1u5Nys0R2lLFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJi337aqaeihfOnKpT0shFCGlmkBJOkJcJpEePD/MCRM31ZzWFtlQk5tUx9f/WFeWncJjiZC2QGIE2udPtOq7v+PwQOmwt5/g2S6CRJ0anUKz8bc3NE2IFKIW4aEAeX8UQhmkYA3UyzAeMpMUES+3XClJle2abE5eikWV6zlugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id BEBFD52014F;
	Mon, 11 Mar 2024 13:04:18 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Mar
 2024 13:04:18 +0100
Date: Mon, 11 Mar 2024 13:04:18 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	<gregkh@linuxfoundation.org>
CC: Hardik Gajjar <hgajjar@de.adit-jv.com>, <maze@google.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<guofeng.li@gm.com>, <hardik.gajjar@bosch.com>, <eugeniu.rosca@bosch.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of
 invalid gadget ptr
Message-ID: <20240311120418.GB5631@vmlxhi-118.adit-jv.com>
References: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
 <8d116b78-9227-4e48-8d37-3a0cb0465dfd@quicinc.com>
 <20240308115506.GA5631@vmlxhi-118.adit-jv.com>
 <4816d981-3955-495c-8fc6-3b9b15ba1689@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4816d981-3955-495c-8fc6-3b9b15ba1689@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Fri, Mar 08, 2024 at 05:47:37PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 3/8/2024 5:25 PM, Hardik Gajjar wrote:
> > On Thu, Mar 07, 2024 at 11:12:07PM +0530, Krishna Kurapati PSSNV wrote:
> > > 
> 
> [...]
> 
> > 
> > I believe using gether_cleanup altogether may not be an optimal solution.
> > The creation and deletion of network interfaces should align with the behavior of each specific network driver.
> > 
> > For instance, in the case of NCM, the usb0 interface is created upon the creation of a directory
> > in config/usb_gadget/gX/functions/ncm.usb0, and it is removed when the corresponding directory
> > is deleted. This follows a standard flow observed in many network drivers, where interfaces are
> > created during driver loading/probing and deleted during removal.
> > 
> 
> Hi Hardik,
> 
>  Yeah. I observed this behavior.
> 
> > Typically, deleting the gadget on every disconnection is not considered a good practice, as it can
> > negatively impact the user experience when accessing the gadget.
> > 
> 
> Got it. I was suspecting issues might come up during fast Plug-In/ Plug-Out
> cases as setting and cleanup of network interface might take some time.
> 
> > In our specific scenario, retaining the usb0 network interface has proven to enhance performance
> > and stabilize connections. Previous attempts to remove it resulted in an observed increase in time of 300ms,
> > particularly at the start of Apple CarPlay sessions.
> > 
> 
> Thanks for this info. Makes sense to keep it in free_inst only. But my
> initial doubt only stemmed from the fact that actions taken during bind must
> be reversed during unbind.
> 
> > Furthermore, it's important to highlight that in Qualcomm products and msm kernels, the inclusion of gether_cleanup
> > in the unbind process was eventually reverted. While the specific reason for reverting the patch is unknown,
> > it suggests that the addition may not have yielded the intended or required results
> > 
> > Following is the revert patch details in msm-5.4 kernel, if you want check it.
> > 
> > Revert "usb: gadget: f_ncm: allocate/free net device upon driver bind/unbind"
> > 
> > This reverts commit 006d8adf555a8c6d34113f564ade312d68abd3b3.
> > 
> > Move back the allocation of netdevice to alloc_inst(), one-time
> > registration to bind(), deregistration and free to rm_inst(). The
> > UI update issue will be taken up with proper stakeholders.
> > 
> > Change-Id: I56448b08f6796a43ec5b0dfe0dd2d42cdc0eec14
> > 
> 
> Agree. This was merged first in 4.19 downstream (most probably for car play
> use case only) and then reverted in 5.4. But present 4.19 code in QC still
> keeps it in unbind path. The only reason I suspect it was reverted was to
> get back on to same page with upstream driver (atleast starting from 5.10,
> this was the reasoning to remove gether_cleanup in unbind path and put it
> back in free_inst).
> 
> Thanks,
> Krishna,

Thanks Krinshna for your comment
Come to the first comment from Greg. 

> What commit id does this fix?
> 
> thanks,
> 
> greg k-h

>Hi Greg,

>The network device parent is not being properly cleaned up during unbind since the \
>initial commit of the driver. In that case, should I mention the First commit ID of \
>the driver as broken commit or would you advice to say, For example "Clean up netdev \
>parent in unbind".

>Thanks,
>Hardik

@Greg, 

Can you please provide guidance on how to proceed? Should I update the commit message to exclude the term 'Fix' in the title?

Thanks,
Hardik

