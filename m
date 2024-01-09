Return-Path: <linux-kernel+bounces-21053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24EA828915
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E22BB2409C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF39FE8;
	Tue,  9 Jan 2024 15:35:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26539FDD;
	Tue,  9 Jan 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8ZgZ12z0z67frD;
	Tue,  9 Jan 2024 23:32:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 610A4140A08;
	Tue,  9 Jan 2024 23:34:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 15:34:58 +0000
Date: Tue, 9 Jan 2024 15:34:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
Message-ID: <20240109153458.000007e3@Huawei.com>
In-Reply-To: <659cb410470dc_8dbbe29426@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
	<20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
	<ZYHWZjsnQwcBEDpd@debian>
	<658346b553a01_34d57294d4@iweiny-mobl.notmuch>
	<20240108150318.00006eba@Huawei.com>
	<659c1d888a5fc_8737f29495@iweiny-mobl.notmuch>
	<20240108180042.00005443@Huawei.com>
	<20240108180553.00001577@Huawei.com>
	<659cb410470dc_8dbbe29426@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jan 2024 18:48:48 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> 
> [snip]
> 
> > > > > > 
> > > > > > I did not go that far as I am unsure as well.      
> > > > > Memory allocations in qemu don't fail (well if they do it crashes)
> > > > > Side effect of using glib which makes for simpler cases.
> > > > > https://docs.gtk.org/glib/func.malloc.html
> > > > > 
> > > > > There shouldn't even be any checks :(  I'll fix that up at somepoint
> > > > > across all the CXL emulation.  Sometimes reviewers noticed and
> > > > > we dropped it at earlier stages, but clearly didn't catch them all.
> > > > > 
> > > > > Which come to think of it is why this error condition is in practice
> > > > > not actually buggy as the code won't ever manage to return -ENOMEM and
> > > > > I don't think there are other error codes.      
> > > > 
> > > > Ah.  Ok but in that case I would say that build_cdat_table() should never
> > > > return < 0 to be clear at this level what can happen.
> > > > 
> > > > Would you like a patch for that?  (/me assumes you dropped this patch)    
> > > 
> > > Probably needs to first rip out all the -ENOMEM returns that got into
> > > the CXL code in general, then tidy up the return type to be unsigned.
> > > 
> > > If you want to do that it would be welcome!  
> > Actually.  Build_cdat_table() can return errors just not for this reason.
> > 
> > host_memory_backend_get_memory() can fail for example.  
> 
> I must be on a different version because I don't see that.
> 
> >
> > So original patch is good
> > as is, just that the discussion of memory allocation failure threw me
> > off and should be cleaned up separately.
> >   
> 
> I did this testing on Fan's DCD version...  :-/  ... probably very out of
> date.

https://elixir.bootlin.com/qemu/latest/source/hw/mem/cxl_type3.c#L183
https://elixir.bootlin.com/qemu/v8.1.0/source/hw/mem/cxl_type3.c#L171
been there a while, but meh, too many branches floating around :)

> 
> Fan do you have a newer version than your 2023-11-16 branch?
> 


> Ira
> 


