Return-Path: <linux-kernel+bounces-133350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821789A2B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1301F24DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AD17164F;
	Fri,  5 Apr 2024 16:41:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88616F858;
	Fri,  5 Apr 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335263; cv=none; b=dRJggNSgXps2f98o/PpCfzv8wvMDSGy4vNiQ/7VVxsQ6CPzwcmiNBpIW/Fim88EkpRVqeNNcc+bIf7pOHXJ0OZSpBNP+ZugaXmSXFpDG0pv8fhu0K76l58C1AbMNm/1LmSW1LUOgL43uBjwLZHH6VqZ4W8oP2qR9bgU0/c3TfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335263; c=relaxed/simple;
	bh=3Atpy12ZUgPWTseaHFws+5AQqqQErgzz9HigTS5MKvA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGkLRVJJaho9uGhXBu+k1GvzoYShzVwNzjVApyGAKVMO6JVJjcL0gJgAR+XhP8B+h2jLPpiWXc6mjdpbzyeXnsZUsM8Sxb+b13KUouv/Z49/KIakjNK8hTHlgse652FK6KcVehSwGSAz3//mzH+LIXNe0p/irZ5XfrQpZzSrYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB42X2RK7z6J9Zb;
	Sat,  6 Apr 2024 00:39:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C8200140C98;
	Sat,  6 Apr 2024 00:40:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 17:40:57 +0100
Date: Fri, 5 Apr 2024 17:40:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of
 mbox_cmd.size_out in get event
Message-ID: <20240405174056.00005422@Huawei.com>
In-Reply-To: <ZhAhAL/GOaWFrauw@aschofie-mobl2>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
	<20240402081404.1106-2-kwangjin.ko@sk.com>
	<ZhAhAL/GOaWFrauw@aschofie-mobl2>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 09:04:16 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Tue, Apr 02, 2024 at 05:14:03PM +0900, Kwangjin Ko wrote:
> > Since mbox_cmd.size_out is overwritten with the actual output size in
> > the function below, it needs to be initialized every time.
> > 
> > cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> > 
> > Problem scenario:
> > 
> > 1) The size_out variable is initially set to the size of the mailbox.
> > 2) Read an event.
> >    - size_out is set to 160 bytes(header 32B + one event 128B).
> >    - Two event are created while reading.
> > 3) Read the new *two* events.
> >    - size_out is still set to 160 bytes.
> >    - Although the value of out_len is 288 bytes, only 160 bytes are
> >      copied from the mailbox register to the local variable.
> >    - record_count is set to 2.
> >    - Accessing records[1] will result in reading incorrect data.  
> 
> Agree with the other comments on need to set .out_size when doing
> cxl_internal_send_cmd() in a loop. Poison list retrieval can hit
> this case if the MORE flag is set and a follow on read of the list
> delivers more records than the previous read. ie. device gives one
> record, sets the _MORE flag, then gives 5.
> 
> 2 other things appeared to me while looking at this:
> 
> First, it seems that there is another cleanup wrt accessing records
> with invalid data.  Still focusing on get_events and get_poison
> since those loop through output data based on a device supplied
> record count. The min_out check means the driver at least gets a
> count of records to expect. That's good. The problem occurs::
> 
> if (mbox.size_out != struct_size(payload, records, 'record_count'))
> 
> The driver will log garbage trace events, and that could lead to
> bad actions based on bad data. (like a needless scan of device based
> on a false overflow flag). So, checking that size.out is the proper
> multiple of record_count protects driver from bad device behavior.
> 
> I think that can be combined w the patch Dan is suggesting to
> reset mbox.size_out on each loop.
Hi Alison,

I'd split it.  Dan's one is a bug fix, this is hardening against
a device bug. Good to have but not really backport material unless
we think there are devices like this out there.

> 
> Second thing is the pci-driver quiet handling of PAYLOAD LENGTH
> values reported by the device. It seems like at a minimum the
> pci-driver could emit an info or debug message when the device
> is reporting payload lengths that exceed what the driver can
> copy in.

When does this happen?
1. New fields on end of a fixed length message.
   Correct to silently eat it as the spec is buggy if we don't
    have backwards compatibility.
    I don't think the spec has had that particular type of bug yet,
    but maybe I'm forgetting one.
2. Device bug.  Can't tell that is different from 1.

So maybe dev_dbg(). I'm not sure why the cxl-driver would ever want to
know.

> I'm referring to the mbox.size_out adjustment in
> __cxl_pci_mbox_send_cmd(). Or, if it's not the pci-drivers job
> to judge, pass that actual payload length value back in the
> mbox structure (new field) so that the cxl-driver can use it.
> The pci driver would still do it's "#8 Sanitize the copy" work,
> but it would allow the cxl-driver to clearly see why it got the
> .size_out it got, and squawk about it if needed.
> 
> --Alison
> 
> > 
> > Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> > ---
> >  drivers/cxl/core/mbox.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 9adda4795eb7..a38531a055c8 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  		.payload_in = &log_type,
> >  		.size_in = sizeof(log_type),
> >  		.payload_out = payload,
> > -		.size_out = mds->payload_size,
> >  		.min_out = struct_size(payload, records, 0),
> >  	};
> >  
> >  	do {
> >  		int rc, i;
> >  
> > +		mbox_cmd.size_out = mds->payload_size;
> > +
> >  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> >  		if (rc) {
> >  			dev_err_ratelimited(dev,
> > -- 
> > 2.34.1
> >   


