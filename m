Return-Path: <linux-kernel+bounces-131506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F38988CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115E91F2B76F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F31127B4E;
	Thu,  4 Apr 2024 13:30:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E71272DF;
	Thu,  4 Apr 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237456; cv=none; b=HSenytMHTTcLdMISBfjqvD+6fFkQsbGIv03mP8C8pSR9kUTvYVCyAAbPCOBKUjA24c7JNLGHCIdYN+iiX2lPWwGj601GN8l3911yqfr25JhQGKEAHKrs6Vf2xET+flsoefvy1WBKjz1LfNP+cq++InQXHWfFE2YJQtdSdCohDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237456; c=relaxed/simple;
	bh=/4yYqOM9vkOMsFtlwSCM2wUTKRN+f5UX2VDXF/1zr8M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL8Mg7QGWjTAh0qRMW49U2CxV4FqMVB7G8maq/pvYPVYQgzoNdJ6x7AEzdyxCps95KOgN1iFr4AbMuacz6C9yb3/KoS3Mnluwq4H9owLjOnjurmNK9b3q5D66AXYS1ijzmMQ5kYQl0o6uyJ2zoY1AbDg4Iz1WSjkfHnesmcqSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Msk70F1z6G9PL;
	Thu,  4 Apr 2024 21:29:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 95FA4140CF4;
	Thu,  4 Apr 2024 21:30:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:30:50 +0100
Date: Thu, 4 Apr 2024 14:30:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of
 mbox_cmd.size_out in get event
Message-ID: <20240404143049.00005635@Huawei.com>
In-Reply-To: <660d6d64a50bd_7702a29466@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
	<20240402081404.1106-2-kwangjin.ko@sk.com>
	<660d6d64a50bd_7702a29466@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 07:53:24 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Kwangjin Ko wrote:
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
> 
> Fix looks correct, but I am concerned it is a band-aid for a more
> general problem. For example, if I am not mistaken, we have a similar
> bug in cxl_mem_get_poison().
> 
> So perhaps a convention to always define @mbox_cmd immediately before
> cxl_internal_send_cmd() like this:

Makes sense to me.  These aren't hot paths, so safe code is worth the
possible extra writes.

> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..5d44b5c095b7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -946,24 +946,22 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>         struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>         struct device *dev = mds->cxlds.dev;
>         struct cxl_get_event_payload *payload;
> -       struct cxl_mbox_cmd mbox_cmd;
>         u8 log_type = type;
>         u16 nr_rec;
>  
>         mutex_lock(&mds->event.log_lock);
>         payload = mds->event.buf;
>  
> -       mbox_cmd = (struct cxl_mbox_cmd) {
> -               .opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> -               .payload_in = &log_type,
> -               .size_in = sizeof(log_type),
> -               .payload_out = payload,
> -               .size_out = mds->payload_size,
> -               .min_out = struct_size(payload, records, 0),
> -       };
> -
>         do {
>                 int rc, i;
> +               struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd){
> +                       .opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> +                       .payload_in = &log_type,
> +                       .size_in = sizeof(log_type),
> +                       .payload_out = payload,
> +                       .size_out = mds->payload_size,
> +                       .min_out = struct_size(payload, records, 0),
> +               };
>  
>                 rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>                 if (rc) {
> @@ -1296,7 +1294,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>         struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>         struct cxl_mbox_poison_out *po;
>         struct cxl_mbox_poison_in pi;
> -       struct cxl_mbox_cmd mbox_cmd;
>         int nr_records = 0;
>         int rc;
>  
> @@ -1308,16 +1305,16 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>         pi.offset = cpu_to_le64(offset);
>         pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
>  
> -       mbox_cmd = (struct cxl_mbox_cmd) {
> -               .opcode = CXL_MBOX_OP_GET_POISON,
> -               .size_in = sizeof(pi),
> -               .payload_in = &pi,
> -               .size_out = mds->payload_size,
> -               .payload_out = po,
> -               .min_out = struct_size(po, record, 0),
> -       };
> -
>         do {
> +               struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd){
> +                       .opcode = CXL_MBOX_OP_GET_POISON,
> +                       .size_in = sizeof(pi),
> +                       .payload_in = &pi,
> +                       .size_out = mds->payload_size,
> +                       .payload_out = po,
> +                       .min_out = struct_size(po, record, 0),
> +               };
> +
>                 rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>                 if (rc)
>                         break;
> 


