Return-Path: <linux-kernel+bounces-66042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA38555C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D461F224C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4258A2511E;
	Wed, 14 Feb 2024 22:31:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2558171A8;
	Wed, 14 Feb 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949908; cv=none; b=F5So2DWzYvcXQzjzWoOB2LRy0aKaVT4sE5hqHjeTuVn0DlrKRCP2vdahcdWX7mSFcOPzEb3zW0NRj06h46HyQM+Os+l7bPk+nXm5qBvLx6ahkcefQvoDfYhGbpC8fdpNyXlz+BWRMpIG3PmoQBKQyYrh2wrmHa5vENzfXfliCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949908; c=relaxed/simple;
	bh=Ak+FVjuVLM8KJPcbSalK+zj2toFz7ly4sGyhwK/MKhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KA3YQyloOXbHN90P8VekesXU4E9vgWE86gM3Bv6X7UAC2qkDI5HUtF9TUjsCfBjWmbcJBVfgYiwu3JbyewcvmmoE9wWbTe3fgXo/W0B1wsX7tTHhawIHgTk1Yw4BCR9rl1Vg2gK5Hh3U99MTozjZA2WSmHIEEQM/JvFbJt5woe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6745C433F1;
	Wed, 14 Feb 2024 22:31:46 +0000 (UTC)
Date: Wed, 14 Feb 2024 17:33:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Smita
 Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <20240214173318.2be1f3c9@gandalf.local.home>
In-Reply-To: <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
	<20240214121153.00005c97@huawei.com>
	<20240214102310.7ba53f3a@gandalf.local.home>
	<20240214181200.0000500b@Huawei.com>
	<65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 14:19:19 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > > assume this will be resolved as well?    
> > > 
> > > That pretty much sums up what I was about to say ;-)
> > > 
> > > tp_printk is more of a hack and not to be used sparingly. With the right
> > > trace events it can hang the machine.
> > > 
> > > So, you can use your internal patch locally, but I would recommend waiting
> > > for the new printk changes to land.  
> 
> Steven, Do you think that will land in 6.9?
> 
> > >
> > > I'm really hoping that will be soon!
> > > 

I may be like Jon Corbet predicting RT will land in mainline if I do.

-- Steve

