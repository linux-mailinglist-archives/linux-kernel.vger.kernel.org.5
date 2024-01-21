Return-Path: <linux-kernel+bounces-32142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4B0835722
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90DF1C20B54
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4C381CE;
	Sun, 21 Jan 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HrRdW3N2"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4B27441
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705858643; cv=none; b=GasbYl/8ZpEqAA1WT0NOaAGQDErZYsizY7QxliCDTCgXM+GBLy62XLfKT/jGPuxsVUeJMZXJp4slvE1ZlrAN1IsjKptwCxnrkSc1I21Hc5etE8t1/GSj/g2Cu5f+AtuN8i+e5F8XM38Bev4WDvnFF26eriN4K9qZz+fIjUTbopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705858643; c=relaxed/simple;
	bh=JPM9TnkWt8kGJWfSrJL+0v1d7QDwm7HJm+cbOf/RlIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoS/xTPPUHpIclcBTUsJaxTJBBls02j4i6cJNAtWSSTPxzboj3becvPcmV1wkFnmCxYLm9okfsl6Un0z3EJlRRmZN8SyLIb1gh5bxLc6CY/+bmwZ67Lvjjm49aI9buV7xXlzdCynKiZSdiXAH6lc3QbkM+ctmgt5H8cqa0KTND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HrRdW3N2; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Jan 2024 12:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705858638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WKtD/jbDjNkLZF9EblEjk8T8MZDbfyWkkGAZ5M55w=;
	b=HrRdW3N2UQCvIkhj7ZC4z4UMFNCXIM9z2n3XAmgKEDQHBP6vaDlnOFz5Np3bZmr0LGJqAZ
	AtEU92cSPBVM/Xwo6GeIru5HRGQayQ/9lNg57lqZbhmCk2ASOQ2GWnZxLQyMsmf2TrOgxD
	hSs0A57nIMBMmbrZushLAvjjBatncSg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, bfoster@redhat.com, jserv@ccns.ncku.edu.tw, 
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 2/5] bcachefs: Introduce parent function for
 sort_cmp_size()
Message-ID: <65vkoqenjy52rinrxduonprebumy7beh5fpd5i6ukgg6nr5buv@zybxigfqsj4q>
References: <20240121153649.2733274-1-visitorckw@gmail.com>
 <20240121153649.2733274-3-visitorckw@gmail.com>
 <vrzgjxym2gnawuds54s4lr4zqbldm6sxp5yksrz5467hcrzjtp@lphbsqbidqdm>
 <Za1O2JDOnTRL0QvL@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za1O2JDOnTRL0QvL@visitorckw-System-Product-Name>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 22, 2024 at 01:05:28AM +0800, Kuan-Wei Chiu wrote:
> On Sun, Jan 21, 2024 at 11:17:30AM -0500, Kent Overstreet wrote:
> > On Sun, Jan 21, 2024 at 11:36:46PM +0800, Kuan-Wei Chiu wrote:
> > > When dealing with array indices, the parent's index can be obtained
> > > using the formula (i - 1) / 2. However, when working with byte offsets,
> > > this approach is not straightforward. To address this, we have
> > > introduced a branch-free parent function that does not require any
> > > division operations to calculate the parent's byte offset.
> > 
> > This is a good commit message - but it would be even better if it was a
> > function comment on parent()
> >
> Sure, however, it seems that sort_cmp_size() can be directly replaced
> with the sort function from include/linux. Once we decide on the
> cleanup tasks, if we still choose to retain this patch, I will make the
> adjustments.

nice catch - looks like sort_r() is the more recent addition, so that's
how that happened.

