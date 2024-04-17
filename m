Return-Path: <linux-kernel+bounces-148838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D358A87F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD1D1F272A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49551482F2;
	Wed, 17 Apr 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjkdaT3Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFA143877
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368479; cv=none; b=jb9J4CSs0VXpWIXYemq6RJuNAMVc/tu6HpioXcOpMPudC3iBOQ0dkesMFgj4JvVk0JX+SaaRzk0maYRcOYV8RuYbevBQtoLfPvt38N6NEkkfDDB1/6+2TL0WJtDLcV79UAQC5kte1YEb310bnK8eZn+bqUqercwubf3eQhZMS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368479; c=relaxed/simple;
	bh=ym8DvO8SRJOit/KXUFs6lvUuqHeyZurGWk3S7tYMlMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzcsG0bBo4ORImleXZoZcX4Yya6vM8yY5UxZuZtiROPZyNXSMVB67sz2LQJD7Ua3nyMGYiqhPAE19Prb7ojaS5U2PNmrLukwlIc/3Vz403FsMoRml2pAEpOeZFsh3YS2vVwoLnunfleT0K0CTmm65WSnyNpLPFyv37RC9EUc/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjkdaT3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713368476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQav6+KhkNcvzSqK0RSgvcrQ/+D1t9LYeHG/i6wdsbo=;
	b=HjkdaT3YeFe3jQxxZ4T9oLxb1mZia/QqBEnUirxMwh51B/96jiCGiri8++wqRceSK6GCm2
	8JCffgK72OA4AH9rXhstiNg9XExXcLUiZosJ28uJSiHTQ3Sw3uJMFl1o1Dvisa77U5Yai9
	qABRyvnSMU2m2+XINc0GR+ihOBUJNhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-EW278JR2NCiqTaIiMEgiHw-1; Wed, 17 Apr 2024 11:41:12 -0400
X-MC-Unique: EW278JR2NCiqTaIiMEgiHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4C2210A2B48;
	Wed, 17 Apr 2024 15:41:11 +0000 (UTC)
Received: from fedora (unknown [10.22.9.10])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8755B3543A;
	Wed, 17 Apr 2024 15:41:08 +0000 (UTC)
Date: Wed, 17 Apr 2024 12:41:07 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 1/3] serial: core: Store fifo timeout again
Message-ID: <2ofvmwtigayox5ilt62lececgol3jqqfisfhiz3bewugf4wime@fbz45h7ovyoa>
References: <20240416182741.22514-1-mcpratt@pm.me>
 <20240416182741.22514-2-mcpratt@pm.me>
 <Zh7KV0FuM2B56J7w@smile.fi.intel.com>
 <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Apr 16, 2024 at 07:20:18PM +0000, Michael Pratt wrote:
> Hi Andy,
> 
> On Tuesday, April 16th, 2024 at 14:58, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > ...
> > 
> > > + if (port->fifosize > 1)
> > > + port->timeout = uart_fifo_timeout(port);
> > 
> > 
> > else
> > port->timeout = port->frame_time;
> > 
> 
> 
> Consistent with what I said in the other reply, the only reason that
> I have an if statement here, is to avoid doing extra math for devices
> without a fifo, as a specifically calculated timeout value would be useless
> in those cases.
> 

As we are talking about a device with a scale of KB/s, I am attempted to
suggest to call uart_fifo_timeout() unconditionally.

> However, if you don't like the 10 ms default timeout, perhaps port->frame_time
> could actually be a more reasonable default value? That is, provided that we have a process
> for calculating the proper value already in place...
> 
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko
> 
> 
> 
> Thanks for taking a look :D
> 
> --
> MCP
> 


