Return-Path: <linux-kernel+bounces-19931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC28276F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16641F239AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE7454F8E;
	Mon,  8 Jan 2024 18:00:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627054673;
	Mon,  8 Jan 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T81xt48glz6K9Vd;
	Tue,  9 Jan 2024 01:58:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D0275140CB9;
	Tue,  9 Jan 2024 02:00:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 18:00:43 +0000
Date: Mon, 8 Jan 2024 18:00:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
Message-ID: <20240108180042.00005443@Huawei.com>
In-Reply-To: <659c1d888a5fc_8737f29495@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
	<20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
	<ZYHWZjsnQwcBEDpd@debian>
	<658346b553a01_34d57294d4@iweiny-mobl.notmuch>
	<20240108150318.00006eba@Huawei.com>
	<659c1d888a5fc_8737f29495@iweiny-mobl.notmuch>
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

On Mon, 8 Jan 2024 08:06:32 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 20 Dec 2023 11:55:33 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > fan wrote:  
> > > > On Wed, Nov 29, 2023 at 05:33:03PM -0800, Ira Weiny wrote:    
> > > > > The callback for building CDAT tables may return negative error codes.
> > > > > This was previously unhandled and will result in potentially huge
> > > > > allocations later on in ct3_build_cdat()
> > > > > 
> > > > > Detect the negative error code and defer cdat building.
> > > > > 
> > > > > Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> > > > > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > > ---
> > > > >  hw/cxl/cxl-cdat.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> > > > > index 639a2db3e17b..24829cf2428d 100644
> > > > > --- a/hw/cxl/cxl-cdat.c
> > > > > +++ b/hw/cxl/cxl-cdat.c
> > > > > @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
> > > > >      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
> > > > >                                                   cdat->private);
> > > > >  
> > > > > -    if (!cdat->built_buf_len) {
> > > > > +    if (cdat->built_buf_len <= 0) {
> > > > >          /* Build later as not all data available yet */
> > > > >          cdat->to_update = true;
> > > > >          return;
> > > > >     
> > > > 
> > > > The fix looks good to me. Just curious how to really build cdat table
> > > > again when an error occurs, for example, the memory allocation fails.    
> > > 
> > > I did not go that far as I am unsure as well.  
> > Memory allocations in qemu don't fail (well if they do it crashes)
> > Side effect of using glib which makes for simpler cases.
> > https://docs.gtk.org/glib/func.malloc.html
> > 
> > There shouldn't even be any checks :(  I'll fix that up at somepoint
> > across all the CXL emulation.  Sometimes reviewers noticed and
> > we dropped it at earlier stages, but clearly didn't catch them all.
> > 
> > Which come to think of it is why this error condition is in practice
> > not actually buggy as the code won't ever manage to return -ENOMEM and
> > I don't think there are other error codes.  
> 
> Ah.  Ok but in that case I would say that build_cdat_table() should never
> return < 0 to be clear at this level what can happen.
> 
> Would you like a patch for that?  (/me assumes you dropped this patch)

Probably needs to first rip out all the -ENOMEM returns that got into
the CXL code in general, then tidy up the return type to be unsigned.

If you want to do that it would be welcome!

Jonathan


> 
> Ira
> 


