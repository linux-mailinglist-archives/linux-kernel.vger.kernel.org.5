Return-Path: <linux-kernel+bounces-48019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8D845651
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE52284F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7815D5AC;
	Thu,  1 Feb 2024 11:36:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA915B964;
	Thu,  1 Feb 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787379; cv=none; b=a4cNCdwq6m2/IRN7X0nCuY2pNAsdTfVTa1CmJLrK2XbNIZuxo6O6EtVwgTPaYXJ+juuyPxk+Otn5LGR2Oq035W/DyXS+svBi70TLwjYdpKEU7amkV0nY4ZNXBmIt0bbR9KZBT3Ka7IrI6F9uBP+QHU3CdOmE5yR5c9RobWP+Tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787379; c=relaxed/simple;
	bh=jGa42X+BFB0gekur+doHwNmJpCnbHR5W4fMjgpjmq+0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHBcW74SdqqR4u21vaHCHolgfoLGxVOsx/o1sjlZ6eRPsRIWVooOFnHQUijVSUmrUoh2uxf3DYEuYWmMSatC0G4V1hnJpPiro32kfGSzI12lMY02VhtzlwsmQtPGEf7Qghe32iRmyHqWDLTVvuc/M3QPpd5VasN9wejCKA0uxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQcGD01SGz6JBVN;
	Thu,  1 Feb 2024 19:32:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BD2C1400D1;
	Thu,  1 Feb 2024 19:36:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 11:36:13 +0000
Date: Thu, 1 Feb 2024 11:36:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Message-ID: <20240201113612.00001d90@Huawei.com>
In-Reply-To: <1785013.VLH7GnMWUR@fdefranc-mobl3>
References: <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
	<6168759.DvuYhMxLoT@fdefranc-mobl3>
	<65baefec49c1a_4e7f52946b@dwillia2-xfh.jf.intel.com.notmuch>
	<1785013.VLH7GnMWUR@fdefranc-mobl3>
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

On Thu, 01 Feb 2024 09:16:59 +0100
"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:

> On Thursday, 1 February 2024 02:12:12 CET Dan Williams wrote:
> > Fabio M. De Francesco wrote:  
> > > I just noticed that this is not the final version. It misses a semicolon.
> > > Please discard this v3. I'm sending v4.  
> > 
> > Ok, but do please copy the aspect of scoped_conf_guard() to take a
> > "_fail" statement argument. Passing a return code collector variable by
> > reference just feels a bit too magical. I like the explicitness of
> > passing the statement directly.  
> 
> I had introduced a bug in my tests that made me see failures when there were 
> not. Now I fixed it and tests don't fail.
> 
> I'm sending a new version that passes the return variable directly, not as a 
> reference, similar but not equal to:
> 
> 	cond_guard(..., rc, -EINTR, ...);
> 
> Actually, I'm doing this:
> 
> 	cond_guard(..., rc, 0, -EINTR, ...);

Can we not works some magic to do.
	cond_guard(..., return -EINTR, ...)

and not have an rc at all if we don't want to.

Something like

#define cond_guard(_name, _fail, args...) \
	CLASS(_name, scope)(args); \
	if (!__guard_ptr(_name)(&scope)) _fail

Completely untested so I'm probably missing some subtleties.

Jonathan


> 
> I'm not passing 'rc = -EINTR' because I want to take into account the 
> possibility that rc contains values different than 0 from previous assignments. 
> I'm passing rc, so that the macro can assign either a success code or a 
> failure error to this variable. Any value from previous assignments must be 
> always overwritten: 
> 
> 	#define cond_guard(_name, _ret, _scs, _err, args...) \
>         	CLASS(_name, scope)(args); \
>         	if (!__guard_ptr(_name)(&scope)) _ret = _err; \
>         	else _ret = _scs;
> 
> I should have seen long ago that my tests were failing because of a missing 
> 'else' when passing a statement in 'cond_guard(..., rc = -EINTR, ...);'. It 
> had nothing to do with how to pass 'rc'. Sorry for that confusion.
> 
> Fabio
> 
> Fabio 
> 
> 
> 


