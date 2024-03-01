Return-Path: <linux-kernel+bounces-89052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B318386E9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FEB1F257E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E03BB25;
	Fri,  1 Mar 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alhEwi3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vp36FRU2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F703AC34
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323166; cv=none; b=oQXd3aLD0DcTu+yvN8pAtKcucoiMft7e9KcPLiBcuYWGq07+ZGYxv9OeTtEFtEW1MRDZvlHEm1aK5A+DvMUP3wVOmEk6fRT3qHktzv2Q0B65/UsB04rFb13ngWipN9H+baGBpGe6jb2p1HZcobtg2IduaE9ViuuKwxQCf9XvmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323166; c=relaxed/simple;
	bh=vEw8hKXCZ7Q5pqWVw83KkjUoR47z/R3Z0Zqq9PA2VM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSymK+SB/iZMlMUrppt+6UtS/zNwFmQcxwa59Tefyzj2r6yDVq2kpTeiNW4odpHGEBd2qkEnGqkHKZpGCcQAZNyk3q/QdQXQHTHe992Ecwl17RIwgUvPUwul8ptg8NIGi4vu9tGxpoIn3VdHREHs3FLWCP5KXTd81YEVC5hEfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alhEwi3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vp36FRU2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709323163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfFPGWCK+GSDiSmRj2uN72ko5lEX5jt2xXFl55bKfn4=;
	b=alhEwi3XGV0RCP4AGdMXeUdQqlR/iZDCbIaF93tSJe/gCqqH3SEY2MjHkTjX6Xj1upVyIi
	rkDbyCEoDDnIE/gt3xatWfGmA7E854npJzX9W5BOLihCK+GVGVQ/14g8Qok9X9xz2iGxmm
	eeSiLXYtg4Vwo3LZLp3QwoRCv/eVlsPpYYjue+Kj+U2cx52ZtYfCyIjeEOrgCiVBar3cOj
	4bR2/hDXYKZJx+RHOzzcgTyPsrqiIbV6nSNaLRCt7j6V/JsaeANqoWJow2o6pUGvaPx2yP
	pn3bSCAYLELeq0nnCde+BTnHjCKUk4SUMkg1zzH+fTipr3GfkEkb7k2Oe7OQ9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709323163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfFPGWCK+GSDiSmRj2uN72ko5lEX5jt2xXFl55bKfn4=;
	b=Vp36FRU2Xs3ultveYfGUTxgAlIEr9vbpLjThGBBl/hAXtk+WbJb7AoJfe9d1I/5Y13uzWf
	goXB4PKql1Ma2jDw==
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
In-Reply-To: <20240301115000.4ba2e411@jacob-builder>
References: <ZeDj/LK56borSxO4@hpe.com> <87plwe7w3m.ffs@tglx>
 <20240301115000.4ba2e411@jacob-builder>
Date: Fri, 01 Mar 2024 20:59:22 +0100
Message-ID: <87msrhwwo5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob!

On Fri, Mar 01 2024 at 11:50, Jacob Pan wrote:
> On Thu, 29 Feb 2024 23:18:37 +0100, Thomas Gleixner <tglx@linutronix.de>
> wrote:
>> On Thu, Feb 29 2024 at 14:07, Dimitri Sivanich wrote:
>> The real problems are:
>> 
>>  1) This approach only works when _ALL_ APs have been brought up during
>>     boot. With 'maxcpus=N' on the command line this will fail to enable
>>     fault handling when the APs which have not been brought up initially
>>     are onlined later on.
>> 
>>     This might be working in practice because intel_iommu_init() will
>>     enable the interrupts later on via init_dmars() unconditionally, but
>>     that's far from correct because IRQ_REMAP does not depend on
>>     INTEL_IOMMU.
> The dmar fault interrupt is VT-d's own interrupt, not subject to IRQ_REMAP.
> So this set up has nothing to do with IR, right?

Both interrupt remap and the IOMMU use DMAR and both set the DMAR's
fault interrupt up, whatever comes first. If IR is enabled then IR does
it, if not then the IOMMU init handles it.

But yes, the interrupt is part of DMAR.

> Maybe we should not call it irq_remap_work, call it dmar_fault_irq_work
> instead?

This work thing does not work at all as I explained in detail. No matter
how you name it. The only sane way to do that is with a hotplug state.

Thanks,

        tglx


