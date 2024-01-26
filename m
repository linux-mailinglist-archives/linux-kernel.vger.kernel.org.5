Return-Path: <linux-kernel+bounces-40295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F983DDE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC95288F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901B1D526;
	Fri, 26 Jan 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="qoFZrRTC"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C31D6BC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283863; cv=none; b=Q6n9cFqIDCXC49AvKHU1Bt1Vv4dBijDB9WJM0gWbf2jN9Tk9BnuSHB3xZB7461MGEK4EV0mNSS5yYyE/VwreFil4u85mU7G+IuZtuK07iLSLkUeEl9s0EZ8dBkNcx9TgJev4W7jK5l4keurQ5CADNR1/B54UPD5rU2ABKTXoEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283863; c=relaxed/simple;
	bh=l07HvO3amMtEmyMPjcFyRThB9vZ3wFKF/bKvtHDrDH8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SByBiH+W6DxKfmZFKHHs8KmUpxPSMBt8m9xIBV0RHFXvjrOAPQwqc1CjBoiYFInr2XUXHbx2uiYtjaHcpYjAxwdzhULZVTeI/m5FQ02hUW+OBpzChH+qpAgibBR/q9yQggY6nxeGtlOpjw2ByZ7K3SwpsCV+OdQyj2inXbEVnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=qoFZrRTC; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C43678284EE9;
	Fri, 26 Jan 2024 09:44:20 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id k9IkBqD-HrQT; Fri, 26 Jan 2024 09:44:19 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 58D828285921;
	Fri, 26 Jan 2024 09:44:19 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 58D828285921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1706283859; bh=A2Nou6hSh2z9fSIkgB+Hp5LVSycUeH7IrVZnyfUu7hM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=qoFZrRTCXmgB8munzRTnR1SiG6kuJniE6ZARMZ6blfeqnOv0EQ7dpz4eKWbL+8bSk
	 zZmoO4RTfvpUyatnpH3DBBWTkQ8BB5mIbn1cdBSImEcrhAN2Ohy4dWdZ2OZdGjvZmb
	 fZs3pB5cB0LkHY3oT1b05wlUUvcNFe+a3KFoAsP4=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TYfbt6uPPsbz; Fri, 26 Jan 2024 09:44:19 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 218C78284EE9;
	Fri, 26 Jan 2024 09:44:19 -0600 (CST)
Date: Fri, 26 Jan 2024 09:44:18 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	iommu <iommu@lists.linux.dev>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	aneesh kumar <aneesh.kumar@kernel.org>, 
	naveen n rao <naveen.n.rao@linux.ibm.com>, jroedel <jroedel@suse.de>, 
	aik <aik@amd.com>, bgray <bgray@linux.ibm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	gbatra <gbatra@linux.vnet.ibm.com>, vaibhav <vaibhav@linux.ibm.com>
Message-ID: <1005430514.10127305.1706283858858.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com> <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com> <20240125155017.GW50608@ziepe.ca> <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com> <20240126151701.GZ50608@ziepe.ca> <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com> <20240126153806.GA50608@ziepe.ca> <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC112 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc: iommu: Bring back table group release_ownership() call
Thread-Index: LjsszU7HTiVuL5lSzea+joNjeMRWP9lK7PgD



----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> To: "Jason Gunthorpe" <jgg@ziepe.ca>
> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "iommu"
> <iommu@lists.linux.dev>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
> "Michael Ellerman" <mpe@ellerman.id.au>, "npiggin" <npiggin@gmail.com>, "christophe leroy"
> <christophe.leroy@csgroup.eu>, "aneesh kumar" <aneesh.kumar@kernel.org>, "naveen n rao" <naveen.n.rao@linux.ibm.com>,
> "jroedel" <jroedel@suse.de>, "aik" <aik@amd.com>, "bgray" <bgray@linux.ibm.com>, "Greg Kroah-Hartman"
> <gregkh@linuxfoundation.org>, "gbatra" <gbatra@linux.vnet.ibm.com>, "vaibhav" <vaibhav@linux.ibm.com>
> Sent: Friday, January 26, 2024 9:39:56 AM
> Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group release_ownership() call

> ----- Original Message -----
>> From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "iommu" <iommu@lists.linux.dev>,
>> "linuxppc-dev"
>> <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
>> "Michael Ellerman"
>> <mpe@ellerman.id.au>, "npiggin" <npiggin@gmail.com>, "christophe leroy"
>> <christophe.leroy@csgroup.eu>, "aneesh kumar"
>> <aneesh.kumar@kernel.org>, "naveen n rao" <naveen.n.rao@linux.ibm.com>,
>> "jroedel" <jroedel@suse.de>, "aik"
>> <aik@amd.com>, "bgray" <bgray@linux.ibm.com>, "Greg Kroah-Hartman"
>> <gregkh@linuxfoundation.org>, "gbatra"
>> <gbatra@linux.vnet.ibm.com>, "vaibhav" <vaibhav@linux.ibm.com>
>> Sent: Friday, January 26, 2024 9:38:06 AM
>> Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
>> release_ownership() call
> 
>> On Fri, Jan 26, 2024 at 09:29:55AM -0600, Timothy Pearson wrote:
>>> > On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
>>> >> > Also, is there any chance someone can work on actually fixing this to
>>> >> > be a proper iommu driver? I think that will become important for power
>>> >> > to use the common dma_iommu code in the next year...
>>> >> We are looking into it.
>>> > 
>>> > Okay, let me know, I can possibly help make parts of this happen
>>> > 
>>> > power is the last still-current architecture to be outside the modern
>>> > IOMMU and DMA API design and I'm going to start proposing things that
>>> > will not be efficient on power because of this.
>>> 
>>> I can get development resources on this fairly rapidly, including
>>> testing.  We should figure out the best way forward and how to deal
>>> with the VFIO side of things, even if that's a rewrite at the end of
>>> the day the machine-specific codebase isn't *that* large for our two
>>> target flavors (64-bit PowerNV and 64-bit pSeries).
>> 
>> I have a feeling the way forward is to just start a power driver under
>> drivers/iommu/ and use kconfig to make the user exclusively select
>> either the legacy arch or the modern iommu.
>> 
>> Get that working to a level where dma_iommu is happy.
>> 
>> Get iommufd support in the new driver good enough to run your
>> application.
>> 
>> Just forget about the weird KVM and SPAPR stuff, leave it under the
>> kconfig of the old code and nobody will run it. Almost nobody already
>> runs it, apparently.
> 
> We actually use QEMU/KVM/VFIO extensively at Raptor, so need the support and
> need it to be performant...

Never mind, I can't read this morning. :)  You did say iommufd support, which gives the VFIO passthrough functionality.  I think this is a reasonable approach, and will discuss further internally this afternoon.

