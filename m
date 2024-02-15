Return-Path: <linux-kernel+bounces-66526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016E3855DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88F71F211BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDF1759E;
	Thu, 15 Feb 2024 09:25:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155114013;
	Thu, 15 Feb 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989134; cv=none; b=KpKYZaBxqmjOju2sRZYyl8dWcjQ5cb8VO39Nc65rz7/65QPs20/NOHiO53lfQfKemtUyxtZo5ILyANZ/W+EDjQPBRNRsJawgqHijDlNV2Uq7mHzQOq3mPTj3M3DjLd7RvZldv7/sjZ8dIPwTBqwaUyInn1ALUw40rpmBbPob+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989134; c=relaxed/simple;
	bh=YQURBqxlBmlrENS0OZmqjmiVnc+NlYI/vm/ZgXwKVRk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ng4o5dUrIUYz2g7CnorV3B+AOu3MU6p2UWRnubBRvYCYBVBzr8dlqwgiDt140oPK4fBMknIBGkFlYrSpRPcGN4U8nIkxD54iI2qyX8R+99tqojTsS2rpUE5kz4ZIhz82jV9JOkQ5d2TtYmpoKuwrvdtrlkW+grndJvSLIhZAvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tb8hn4wRHz6839B;
	Thu, 15 Feb 2024 17:22:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 25CE91400CD;
	Thu, 15 Feb 2024 17:25:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 09:25:28 +0000
Date: Thu, 15 Feb 2024 09:25:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, "Smita Koralahalli"
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <20240215092527.000055b9@Huawei.com>
In-Reply-To: <20240214173318.2be1f3c9@gandalf.local.home>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
	<20240214121153.00005c97@huawei.com>
	<20240214102310.7ba53f3a@gandalf.local.home>
	<20240214181200.0000500b@Huawei.com>
	<65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
	<20240214173318.2be1f3c9@gandalf.local.home>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 17:33:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Feb 2024 14:19:19 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >     
> > > > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > > > assume this will be resolved as well?      
> > > > 
> > > > That pretty much sums up what I was about to say ;-)
> > > > 
> > > > tp_printk is more of a hack and not to be used sparingly. With the right
> > > > trace events it can hang the machine.
> > > > 
> > > > So, you can use your internal patch locally, but I would recommend waiting
> > > > for the new printk changes to land.    
> > 
> > Steven, Do you think that will land in 6.9?
> >   
> > > >
> > > > I'm really hoping that will be soon!
> > > >   
> 
> I may be like Jon Corbet predicting RT will land in mainline if I do.
> 
> -- Steve
> 


Agreed. Don't wait on printk fixes landing. (Well unless you are sure
it's the year of the Linux desktop.) Reverting is fine for 6.8
if you and Dan feel it's unwise to take this forwards (all the distros
will backport it anyway and 6.8 isn't an LTS so no great rush)
so fine to just queue it up again for 6.9 with this fix.

As Steve said, tp_printk is a hack (a very useful one) and
hopefully no one runs it in production.

Jonathan

