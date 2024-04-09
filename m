Return-Path: <linux-kernel+bounces-137657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8B589E531
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D41F22AD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADC158D67;
	Tue,  9 Apr 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="foHbs2y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBF12BE9C;
	Tue,  9 Apr 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699425; cv=none; b=FtV8NfNpqiw4SRpdeyI87shU45eMrXibCmK5XAc3d4AOyBNl0sbWGG/FM1BizPiGkNFD5a8VsUhvjPtBpozJ7qbgVBdIjZCX9bHdmaBwjnbaMxX72435ZM1CocYJP7OGK0t5fu0l5YAdVeIckPnsy0xiGKLkuAD0Kc7qtbK4xfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699425; c=relaxed/simple;
	bh=OdGUosTzjanbGQAzwiEZydBArCk/VVr1V8XWzZH9fJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I2tWX9M5wGP0Jhx9PDy1ZxiUfRmH1K2HIIOlpFJ9OD/5wx5J6/YKaZBno5EctFGkkrOpcxlLrXOIAzkBkCz2pGDh/ERYVCxMj6QmIOjBc0bh1B2ZAcYGV5eWVAmSjQUJhGt3kGIMKT6yop8MWr4RUrEJluwsAma76DlbkXDoiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=foHbs2y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEBCC433C7;
	Tue,  9 Apr 2024 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712699424;
	bh=OdGUosTzjanbGQAzwiEZydBArCk/VVr1V8XWzZH9fJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=foHbs2y4veHCZfs0/a/bJgqhpH1/Q4SmRz5GRT6k1OqlMTTh9R9uAGwzpqnzyMq40
	 dWeDHzl6heeYaGWfAM9PxBs+DeYmyMwFKSAZGJtv0vyf9t6UMcAMP5JEZJ+mPiUP2j
	 SeFl8DMHv4cS2TSoqhH11UKLSYubelRlhmuua22o=
Date: Tue, 9 Apr 2024 14:50:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang, Ying"
 <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, Vinicius
 Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc
 <Ravis.OpenSrc@micron.com>, Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae Park
 <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
Message-Id: <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
In-Reply-To: <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
	<20240405000707.2670063-2-horenchuang@bytedance.com>
	<20240405145624.00000b31@Huawei.com>
	<CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 9 Apr 2024 12:00:06 -0700 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Hi Jonathan,
> 
> On Fri, Apr 5, 2024 at 6:56 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri,  5 Apr 2024 00:07:05 +0000
> > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> >
> > > Since different memory devices require finding, allocating, and putting
> > > memory types, these common steps are abstracted in this patch,
> > > enhancing the scalability and conciseness of the code.
> > >
> > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
> >
> Thank you for reviewing and for adding your "Reviewed-by"!
> I was wondering if I need to send a v12 and manually add
> this to the commit description, or if this is sufficient.

I had added Jonathan's r-b to the mm.git copy of this patch.

