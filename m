Return-Path: <linux-kernel+bounces-91328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C3870F06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CF71F21B45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E97B3FD;
	Mon,  4 Mar 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jGxCA8zZ"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9978B4C;
	Mon,  4 Mar 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589010; cv=none; b=g5cnOEMmJW6jKzjKDTuLTtiUkLliMZkKu4188ilDpG6LHMM5mNN02J74V7TF97DtdmKxvD6pHfmNirbaGHO+HGbfiI/mdvfb9LnjubAfn60uYZ58Sd/mWxTKD3hzx4KCsYAOtLyLAkM556KTteK6CBxw7aL/Tc5uOqGYiQdMK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589010; c=relaxed/simple;
	bh=RPwtqs/WLMpQhOOQffu+E9GNmObiNBz91RoPhZG7ldY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5/LWaetQn7y9tdtftJcntxTahPH+FJed7PYmvoQpVVByCLyDHY8yRNgIdZRzU5eOZteL0yQF2EQGt6+od2XKwgOmoh2uY1vqRzwi0sScwSKk72o/CuSxXyBVuZY7En9aZaGMAnV1uTsEtpKxbO3pUn4kCDsXON0pIXyCiksQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jGxCA8zZ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709589008; x=1741125008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IPLuyADOds20t9F10dBuRgOvEI8caqH4znwPq4fIKLQ=;
  b=jGxCA8zZb2p5NKtEpFvBsxuciRue0vYb+KYRlEdSTWWjWYgsNytQ0mop
   xrfpkfUhm/6aI3nPNfJtt/mFFBES7Raaks2rmTobMCDmCtZEi84Zas53q
   NsW88/f7Jmcb0r/YOC5OGAyoLJF5EhBLuTGAOPhbSKdnywFrilhfPY0Jw
   U=;
X-IronPort-AV: E=Sophos;i="6.06,204,1705363200"; 
   d="scan'208";a="278554992"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:50:01 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:26419]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.189:2525] with esmtp (Farcaster)
 id e2b6372a-4e89-463b-887c-9553dfcc05aa; Mon, 4 Mar 2024 21:49:59 +0000 (UTC)
X-Farcaster-Flow-ID: e2b6372a-4e89-463b-887c-9553dfcc05aa
Received: from EX19D026EUB004.ant.amazon.com (10.252.61.64) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 21:49:59 +0000
Received: from uc3ecf78c6baf56.ant.amazon.com (10.187.170.53) by
 EX19D026EUB004.ant.amazon.com (10.252.61.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 21:49:56 +0000
Date: Mon, 4 Mar 2024 13:49:51 -0800
From: Andrew Paniakin <apanyaki@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <apanyaki@amazon.com>, <benh@amazon.com>, <boris.ostrovsky@oracle.com>,
	<gregkh@linuxfoundation.org>, <jeremy.fitzhardinge@citrix.com>,
	<jgrall@amazon.com>, <jgross@suse.com>, <konrad.wilk@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mheyne@amazon.de>,
	<oleksandr_tyshchenko@epam.com>, <sashal@kernel.org>,
	<sstabellini@kernel.org>, <stable@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 5.10] xen/events: close evtchn after mapping cleanup
Message-ID: <20240304214951.GA3603725@uc3ecf78c6baf56.ant.amazon.com>
References: <20240302160357.GA2232656@uc3ecf78c6baf56.ant.amazon.com>
 <2024030433-legacy-unrivaled-f5fc@gregkh>
 <20240304184726.GA3441283@uc3ecf78c6baf56.ant.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240304184726.GA3441283@uc3ecf78c6baf56.ant.amazon.com>
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D026EUB004.ant.amazon.com (10.252.61.64)

On 04/03/2024, Andrew Panyakin wrote:
> On 04/03/2024, Greg KH wrote:
> > On Sat, Mar 02, 2024 at 08:03:57AM -0800, Andrew Panyakin wrote:
> > > From: Maximilian Heyne <mheyne@amazon.de>
> > >
> > > Commit fa765c4b4aed2d64266b694520ecb025c862c5a9 upstream
> [...] 
> > Where is the 5.15.y version of this commit?  We have to have that before
> > we can take a 5.10.y version, right?
> 
> Remaining patches for 5.15 and 6.1 ready, will send once analyze test
> results.

Remaining patches posted:
5.15: https://lore.kernel.org/all/20240304212139.GA3585816@uc3ecf78c6baf56.ant.amazon.com/
6.1: https://lore.kernel.org/all/20240304192006.GA3517973@uc3ecf78c6baf56.ant.amazon.com/

