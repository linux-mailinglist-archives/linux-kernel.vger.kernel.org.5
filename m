Return-Path: <linux-kernel+bounces-91124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B28709D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B80B24F61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9DA78B44;
	Mon,  4 Mar 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NOA8+81x"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1B62147;
	Mon,  4 Mar 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578060; cv=none; b=qVfl0x57FDbA4Cq43F7TEbtuhTy0Ol/nEr9Mmvu3KDJVNeMoyrtrS4kGl9ngmN00fjqSMKGmiWyZc2droHcuXnDlmIHEVtmt0QAO6JJ9YelUrc0YtJ9QY4xDAkc58shLQzW7oO9UxJqcS7YJ+IeQqCRYTf+TMHR6iXBPd2UrIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578060; c=relaxed/simple;
	bh=kbd0JOxZAv7pXQq1VfK/EidocvkZPARJYB9xxm+7BAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgRQfwCYh8FVJJKwiDu/DGagzS9saaMBJhRZR5IAxowJlMCa66/5P03mBoqJR5Hkl9zq3ZhtNxcA2NR95X+jiyFWTIkxVKa5UTGcjkY8apBAwyfTV3k29PRwrABKTRgsbeyHtmkq0At5ihyzrmyHuz2LgfFZqG0yTQ3HRfANM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NOA8+81x; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709578058; x=1741114058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9wd9WUH4whGwXp0eHXVUdDwqcrqNWWjri6sAP3vphCI=;
  b=NOA8+81x7UlfsFakR5IQbhS9SIv1BV3DF9n9KdxaBU5FAJbEDtY1IDX6
   raXjT/iehSw87DSk4ijD0o1xPqxd86k0XEhuRUWQQEAs2hlg9NXfyApE7
   v4n1u4q6M3M8QYTqFaLUS2K2M3lPDYlXyTT94QdamYf1ia6gZy2DoFtbO
   g=;
X-IronPort-AV: E=Sophos;i="6.06,204,1705363200"; 
   d="scan'208";a="385374124"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 18:47:35 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:47643]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.5:2525] with esmtp (Farcaster)
 id abeaadb9-70cd-4744-b817-67fa8b437c78; Mon, 4 Mar 2024 18:47:33 +0000 (UTC)
X-Farcaster-Flow-ID: abeaadb9-70cd-4744-b817-67fa8b437c78
Received: from EX19D026EUB004.ant.amazon.com (10.252.61.64) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 18:47:33 +0000
Received: from uc3ecf78c6baf56.ant.amazon.com (10.187.170.53) by
 EX19D026EUB004.ant.amazon.com (10.252.61.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 18:47:30 +0000
Date: Mon, 4 Mar 2024 10:47:26 -0800
From: Andrew Panyakin <apanyaki@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <apanyaki@amazon.com>, <benh@amazon.com>, <boris.ostrovsky@oracle.com>,
	<jeremy.fitzhardinge@citrix.com>, <jgrall@amazon.com>, <jgross@suse.com>,
	<konrad.wilk@oracle.com>, <linux-kernel@vger.kernel.org>, <mheyne@amazon.de>,
	<oleksandr_tyshchenko@epam.com>, <sashal@kernel.org>,
	<sstabellini@kernel.org>, <stable@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 5.10] xen/events: close evtchn after mapping cleanup
Message-ID: <20240304184726.GA3441283@uc3ecf78c6baf56.ant.amazon.com>
References: <20240302160357.GA2232656@uc3ecf78c6baf56.ant.amazon.com>
 <2024030433-legacy-unrivaled-f5fc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024030433-legacy-unrivaled-f5fc@gregkh>
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D026EUB004.ant.amazon.com (10.252.61.64)

On 04/03/2024, Greg KH wrote:
> On Sat, Mar 02, 2024 at 08:03:57AM -0800, Andrew Panyakin wrote:
> > From: Maximilian Heyne <mheyne@amazon.de>
> >
> > Commit fa765c4b4aed2d64266b694520ecb025c862c5a9 upstream
[...] 
> Where is the 5.15.y version of this commit?  We have to have that before
> we can take a 5.10.y version, right?

Remaining patches for 5.15 and 6.1 ready, will send once analyze test
results.

