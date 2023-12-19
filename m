Return-Path: <linux-kernel+bounces-5615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A0818D21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988DBB22F38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E8208DB;
	Tue, 19 Dec 2023 16:59:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A347B2;
	Tue, 19 Dec 2023 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvjZF2xphz6JBGx;
	Wed, 20 Dec 2023 00:58:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 63597140F83;
	Wed, 20 Dec 2023 00:59:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 16:58:47 +0000
Date: Tue, 19 Dec 2023 16:58:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Fan Ni <nifan.cxl@gmail.com>, "Dave
 Jiang" <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <20231219165845.0000100e@Huawei.com>
In-Reply-To: <6580d606467d1_715492946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
	<20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
	<20231218123339.000024fc@Huawei.com>
	<6580d26a74294_1bbb129489@iweiny-mobl.notmuch>
	<6580d606467d1_715492946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Dec 2023 15:30:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Ira Weiny wrote:
> > Jonathan Cameron wrote:  
> > > On Wed, 29 Nov 2023 17:33:04 -0800
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > 
> > [snip]
> >   
> > > > [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> > > > 
> > > > Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> > > > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > > 
> > > This only becomes a problem with the addition of DCDs so I'm not going to rush it in.  
> > 
> > That makes sense.
> >   
> > > Btw cc qemu-devel on qemu patches!
> > >   
> > 
> > Ah...  yea my bad.  
> 
> Might I also ask for a more prominent way to quickly identify kernel vs
> qemu patches, like a "[QEMU PATCH]" prefix? I tend to look for "hw/" in
> the diff path names, but the kernel vs qemu question is ambiguous when
> looking at the linux-cxl Patchwork queue.
I'm not sure if the QEMU maintainers would be that keen on a tag there.
Maybe just stick qemu/cxl: in the cover letter naming as a prefix?
[PATCH 0/4] qemu/cxl: Whatever the change is

> 
> @Jonathan, what do you think of having the kernel patchwork-bot watch
> your tree for updating patch state (if it is not happening already).
My QEMU tree is a bit intermittent and frequently rebased as I'm juggling
too many patches. Not sure we'd get a good match.  Mind you I've
never tried the bot so not even sure how to configure it.

Jonathan




