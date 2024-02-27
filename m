Return-Path: <linux-kernel+bounces-82999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6875868CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415F7283EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658356458;
	Tue, 27 Feb 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDJnUn2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86622137C2A;
	Tue, 27 Feb 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028086; cv=none; b=ALj70woPEIXD1A3rL9HzBMlkB5opz1Vca38aesx7b6Q/VtXduK9I0ukQjqmSPKcbmYtHX2GSnu4Czdx505W9ADE7+vpLVHDUrVBa18q+xitX6+P8SMfFKYBNI0g9pOGJrqy+hEs4kIi5Uagb4ecZNgyW+oWdFuSKJgBVrwpnYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028086; c=relaxed/simple;
	bh=t+Z8nkmnyZJiKo/g3DXuSPfon4RTeiLy3dhfd9t83Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffvx6UwV88RdA2QdnwQ6KuV2P0FXBVxBse2hn7b5rh7fOC2diLHMtAT/LePr3Z7dThTx+r1XtpaHxb0WWLlZhpoVGfxpWwZvDZMckHZJFDfShSvsylMeH0Mn5rR6LQ8ueoMwMgGZyEsBVEGM1CuhAOGIwCmYUKCLXeuysIhZ7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDJnUn2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3533C433C7;
	Tue, 27 Feb 2024 10:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709028086;
	bh=t+Z8nkmnyZJiKo/g3DXuSPfon4RTeiLy3dhfd9t83Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDJnUn2pu3CFVygPe9YqcwwYE9Py4DJP18zijdBQwwowz2wBPtV7l4/m8HPkkUr2M
	 TV0wCGjoK4B3p8E5PPXHCv93VORXwFrr2kEFM+yqIbmnRV5vumY6UrbLDRN2s3DzRw
	 zJhsr/cOi3QcjZUSyrrES1oNF43vlrjgvDR9AeHGGJHv72tzTVuilOwlVhYlrscNOs
	 2DKBvdgqe0AQL8nrcuj7t1ZKOv/scxtYuDI8pvWgWRLY/VefMYOJuCvT606rb8UWV8
	 0TZuyDKzNTIZfB7wRYe5chFSVdIlFNOIMfJrocvHSKWiqhhGCduH6vKtQbeh5hySx1
	 bGYEF+WXNnTkg==
Date: Tue, 27 Feb 2024 12:00:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>, karahmed@amazon.de,
	qperret@google.com, robh@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, frowand.list@gmail.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <Zd2yyOuZNAUZgdac@kernel.org>
References: <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
 <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
 <Yu1t8TpXT1f372v/@kernel.org>
 <76cb3b37-5887-404f-95b7-10a22a7ba65b@quicinc.com>
 <ZcxvKvSfJv6L2O9e@kernel.org>
 <CAA8EJpqpGN6yzd5pUs06aax=L5wDwPK6aM6R2X784y7ot+P-aQ@mail.gmail.com>
 <ZcyEzHva7pq-3Zav@kernel.org>
 <a44a435c-e52d-4ee5-b05e-9f43a071c479@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44a435c-e52d-4ee5-b05e-9f43a071c479@quicinc.com>

On Tue, Feb 20, 2024 at 02:28:32PM +0800, Aiqun Yu (Maria) wrote:
> > > > > Hi Mike,
> > > > > 
> > > > > We've put effort on bootloader side to implement the similar suggestion of
> > > > > os bootloader to convey the reserved memory by omit the hole from
> > > > > /memory@0{reg=[]} directly.
> > > > > While there is a concern from device tree spec perspective, link [1]: "A
> > > > > memory device node is required for all devicetrees and describes the
> > > > > physical memory layout for the system. "
> > > > > Do you have any idea on this pls?
> > > > 
> > > > I'm not sure I understand your concern. Isn't there a /memory node that
> > > > describes the memory available to Linux in your devicetree?
> > > 
> > > That was the question. It looks like your opinion on /memory was that
> > > it describes "memory available to Linux", while device tree spec
> > > defines it as "physical memory layout".
> > >
> > I suggested a workaround that will allow to save memory map for the
> > carveout.
> > The memory map is a run time description of the physical memory layout and
> > core mm relies on availability of struct page for every physical frame.
> > Having only partial memory map will lead to subtle bugs and crashes, so
> > it's not an option.
>
> Any idea of a formal solution for this case?
> It is a real use case for the commercial device. Memory saving is always a
> good topic for commercial devices. So for a total 128MB memory, ~60MB for
> kernel total available memory, and ~1M free memory saving is important from
> OEM point of view.
> 
> There are 3 types of memory:
> 1. used by firmware and not available to kernel at any time.
> Either struct page can be avoided by kernel. Or bootloader not pass this
> part of physical memory was discussed here.
> Any good ideas?

As I said, struct page must exist for all physical memory known to kernel.
If hiding the memory that is not available to kernel does not work for you
I don't have other ideas.

> 2. shared by firmware/subsystem, and can be read/write access by kernel.
> Just as it is now. Struct page can be allocated inside kernel and also
> reserved memory for this.
> 3. freely used by kernel.
> Just as it is now.



-- 
Sincerely yours,
Mike.

