Return-Path: <linux-kernel+bounces-75483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EB85E951
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9671C22594
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46586ADE;
	Wed, 21 Feb 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bbd9ALrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42613A1AF;
	Wed, 21 Feb 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549074; cv=none; b=nybWr0hiArKPTSQEgvxRv9Aq9En7hrW/2T+3kJ3ukReE26g8WFJfgcYZsCpcGRn77kxx5gSoZiHTGUIFplksjNBLFZLBQjvULoEeeS9mk7Nm1A2KXdar/2P8IRcrAChfb4fBvIs0UuEYuiedVKrbUyBX0uC4vvmIaBBMAefaFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549074; c=relaxed/simple;
	bh=cQNUlLy8aiGRIYPC4jZV2h79/t7uLaYDp/ZsuaE++9Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RD/0mynJsdJweaXVw9sZCxyvQ+bYrGzNlfX59Pro2+M7eFu2GpCOBAx8VjIHWeAQIPjmdWjWF/0EF2qacx4SET4Ya2z4k5TNhHcEPrljDt0FKd7AdcchbAOeqobVaDYVNLA8p2zg7ofVng0jNURX81YLOMktV8Lw0Wki6gbmHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bbd9ALrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CEFC433F1;
	Wed, 21 Feb 2024 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708549073;
	bh=cQNUlLy8aiGRIYPC4jZV2h79/t7uLaYDp/ZsuaE++9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bbd9ALrcftdB4hiAFAbv+r3I0ERbgznFbhuh6MxPmx8jG8xGLzeq23eo9RRwwfYK+
	 iZCi2iMyB0NelsBsnf7/OypvyrQWmMazP7HA7Jbw0rZNQMouPMIBGFEDM881CMWNgk
	 2e1ZuX9I7suwwEUiqPo2BxD0oszsroHPkKn6qHbQ=
Date: Wed, 21 Feb 2024 12:57:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-s390@vger.kernel.org,
 piliu@redhat.com, linux-sh@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, ebiederm@xmission.com,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up
 related config items
Message-Id: <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
In-Reply-To: <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
References: <20240119145241.769622-1-bhe@redhat.com>
	<9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
	<Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
	<559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:

> On 04/02/24 8:56 am, Baoquan He wrote:
> >>> Hope Hari and Pingfan can help have a look, see if
> >>> it's doable. Now, I make it either have both kexec and crash enabled, or
> >>> disable both of them altogether.
> >>
> >> Sure. I will take a closer look...
> > Thanks a lot. Please feel free to post patches to make that, or I can do
> > it with your support or suggestion.
> 
> Tested your changes and on top of these changes, came up with the below
> changes to get it working for powerpc:
> 
>  
> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/

So can we take it that you're OK with Baoquan's series as-is?

Baoquan, do you believe the patches in mm-unstable are ready for moving
into mm-stable in preparation for an upstream merge?




