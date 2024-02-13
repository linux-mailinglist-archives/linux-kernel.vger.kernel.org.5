Return-Path: <linux-kernel+bounces-64031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D9853923
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EFF1C20DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE15FF0A;
	Tue, 13 Feb 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+3ho/U8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF8604DA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846908; cv=none; b=EfiTLmISEV4fFmH4Vo7oJrEXA514cjRdk9bD0FUf8qpSJHWLSjK5W2MgzDU2ql/7jGfAXqRXFhZ0GK7DOUOwz48PropV5jpH+2RJVV/3a8/YJCaE0niAA4KC7fsHPcjg8ZdE9Zr61BIHmNDLMDDKLmopSG9ogAYaadLWfonywro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846908; c=relaxed/simple;
	bh=ocordXpQ+neK+gE/WaXmtwCB5cdrpeIWkHnMVkONmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEtKTP4eZ2Z6YHVM/edj75tFLy3/pC/QfDj3q5YcZi+lMI2K8TNh00BeojaXulh3b1UYYOtPfNumBOZeeEUqyprKP+LMJW1GZKpogImKuTh6xoY7TEiZU/JadYk4O/Iv63xtoDQ5paj/e/ykR1WMtrsMweHJq9zeGIZNIY2LFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+3ho/U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579FCC433C7;
	Tue, 13 Feb 2024 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846908;
	bh=ocordXpQ+neK+gE/WaXmtwCB5cdrpeIWkHnMVkONmTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1+3ho/U88ddGrv/M9DgvKayan0ZbC/xyDbmydRt222ukvnsPSrRLzZJ73FjA56jSk
	 qsaPM15y1s60QHLp1bX57g6++iJY+wEipKdXr+4wQSQUEvaI8l/sknoTh2j7f/cqL8
	 2UDs4AiLgP8aHxav2YUYROeKj7usfpOzSTkwXV4E=
Date: Tue, 13 Feb 2024 18:30:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"dennis@kernel.org" <dennis@kernel.org>,
	"tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>,
	"david@redhat.com" <david@redhat.com>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"pcc@google.com" <pcc@google.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"gshan@redhat.com" <gshan@redhat.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	Andrew Wheeler <awheeler@motorola.com>
Subject: Re: [External] Re: [PATCH] arm64: allow post-init vmalloc PXNTable
Message-ID: <2024021321-scooter-citrus-233c@gregkh>
References: <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
 <2024021300-gently-ether-3978@gregkh>
 <SEZPR03MB6786975721BC2C6393731C59B44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR03MB6786975721BC2C6393731C59B44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>

On Tue, Feb 13, 2024 at 05:16:04PM +0000, Maxwell Bland wrote:
> > This shouldn't be in the changelog, it needs to go below the --- line.
> 
> Oh! Thanks!!!
> 
> > Also, your patch is corrupted and can not be applied :(
> 
> Shoot! Apologies, I just noticed the hard-wrap at 80. I am talking to Moto's IT right now, I will resend patch once I can fix the mail server config.

tabs were also eaten :(

