Return-Path: <linux-kernel+bounces-78312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A58611B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1ECB26E94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560977CF1D;
	Fri, 23 Feb 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QvIIF0yO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BB14A97;
	Fri, 23 Feb 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692027; cv=none; b=aud+Pbf1jQbuQLy3KWtLN16YEeuetRAjBfHj7W6v5XFBHagGvVr6NVSIPuRWUolQA8Ovwg9Oc3GHE92UwHoKIXw7biDZ2XB5VDtnfl1b+JnTcOdTA5MYKyRN8HYus+QQ/dwC2JIPqmhVNMREqK0ErJD+qNbnheFK37+vwl94emo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692027; c=relaxed/simple;
	bh=KKUuXezB/G+ILZzSTILOSQmE/Cbf7JN8aDFNpOwtadw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRVYvob2/RbvZC6FCA/Rz+msTIozkETsF7BV42bWR+lCsHPOoWbt5W9Ci6sHfJzuum6txTCIlrAj3974ycECmIhCFVs1a3gWCEl1J7D11ZI+QCbaSk7ZQ2t90NMQcVDEdXI/34/xptTxmkC+hvpHtkjNtam6cDegPwRFgz7lSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QvIIF0yO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E2CC433F1;
	Fri, 23 Feb 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708692027;
	bh=KKUuXezB/G+ILZzSTILOSQmE/Cbf7JN8aDFNpOwtadw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvIIF0yOS7qDRmS7ZybUiXbnP9VzNjS1e91aZB3N2uZWsjsjRbCdh2Y7NDOrHKYFW
	 qcP5UhSjxl3dhU+t3gqpqvDZ46bm8R644L3c7pAdxOz5BxYkh9WspEjqJVyii5ZDKU
	 jNX4Sdk2YEsjvRBTfxkT6SaZVfVcZZB3s/pevq9E=
Date: Fri, 23 Feb 2024 13:40:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <quic_selvaras@quicinc.com>
Cc: brauner@kernel.org, axboe@kernel.dk, jack@suse.cz, jlayton@kernel.org,
	keescook@chromium.org, peter@korsgaard.com, hayama@lineo.co.jp,
	dmantipov@yandex.ru, quic_linyyuan@quicinc.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: gadget: f_fs: Fix NULL pointer dereference in
 ffs_epfile_async_io_complete()
Message-ID: <2024022350-rescuer-stretch-71e8@gregkh>
References: <20240223054809.2379-1-quic_selvaras@quicinc.com>
 <2024022302-routine-schematic-b4fd@gregkh>
 <d2f40e2d-cbbd-41f9-9aa6-41d0f251ffda@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2f40e2d-cbbd-41f9-9aa6-41d0f251ffda@quicinc.com>

On Fri, Feb 23, 2024 at 05:05:59PM +0530, Selvarasu Ganesan wrote:
> 
> On 2/23/2024 11:28 AM, Greg KH wrote:
> > On Thu, Feb 22, 2024 at 09:48:09PM -0800, Selvarasu Ganesan wrote:
> > > In scenarios of continuous and parallel usage of multiple FFS interfaces
> > > and concurrent adb operations (e.g., adb root, adb reboot), there's a
> > > chance that ffs_epfile_async_io_complete() might be processed after
> > > ffs_epfile_release(). This could lead to a NULL pointer dereference of
> > > ffs when accessing the ffs pointer in ffs_epfile_async_io_complete(), as
> > > ffs is freed as part of ffs_epfile_release(). This epfile release is
> > > part of file operation and is triggered when user space daemons restart
> > > themselves or a reboot is initiated.
> > > 
> > > Fix this issue by adding a NULL pointer check for ffs in
> > > ffs_epfile_async_io_complete().
> > > 
> > > [  9981.393115] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001e0
> > > [  9981.402854] Mem abort info:
> > > ...
> > > [  9981.532540] Hardware name: Qualcomm Technologies,
> > > [  9981.540579] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [  9981.548438] pc : ffs_epfile_async_io_complete+0x38/0x4c
> > > [  9981.554529] lr : usb_gadget_giveback_request+0x30/0xd0
> > > ...
> > > [  9981.645057] Call trace:
> > > [  9981.648282]  ffs_epfile_async_io_complete+0x38/0x4c
> > > [  9981.654004]  usb_gadget_giveback_request+0x30/0xd0
> > > [  9981.659637]  dwc3_gadget_endpoint_trbs_complete+0x1a8/0x48c
> > > [  9981.666074]  dwc3_process_event_entry+0x378/0x648
> > > [  9981.671622]  dwc3_process_event_buf+0x6c/0x288
> > > [  9981.676903]  dwc3_thread_interrupt+0x3c/0x68
> > > [  9981.682003]  irq_thread_fn+0x2c/0x8c
> > > [  9981.686388]  irq_thread+0x198/0x2ac
> > > [  9981.690685]  kthread+0x154/0x218
> > > [  9981.694717]  ret_from_fork+0x10/0x20
> > > 
> > > Signed-off-by: Selvarasu Ganesan <quic_selvaras@quicinc.com>
> > 
> > What commit id does this fix?  Should it go to stable kernels?
> 
> Fixes: 2e4c7553cd6f9 ("usb: gadget: f_fs: add aio support"). Yes it's
> required to propagate to stable kernel as well.

Great, when you resend the next version, please include both proper
tags.

> > > ---
> > >   drivers/usb/gadget/function/f_fs.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > > index be3851cffb73..d8c8e88628f9 100644
> > > --- a/drivers/usb/gadget/function/f_fs.c
> > > +++ b/drivers/usb/gadget/function/f_fs.c
> > > @@ -849,7 +849,9 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
> > >   	usb_ep_free_request(_ep, req);
> > >   	INIT_WORK(&io_data->work, ffs_user_copy_worker);
> > > -	queue_work(ffs->io_completion_wq, &io_data->work);
> > > +
> > > +	if (ffs && ffs->io_completion_wq)
> > > +		queue_work(ffs->io_completion_wq, &io_data->work);
> > 
> > What happens if ffs->io_compleation_wq goes away right after you test
> > it but before you call queue_work()?
> > 
> > Where is the locking here to prevent that?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thank you for your feedback. I understand your concern about the
> potential race condition with ffs->io_completion_wq. I’m considering
> introducing a lock to protect this section of the code, but I wanted to
> get your opinion on this.
> In the f_fs.c driver, there are pre-existing locks. Would it be suitable to
> utilize these locks, or do you suggest the creation of a new lock
> specifically for ffs->io_completion_wq? We anticipate a performance impact
> if we use the existing lock, as it might be held by different
> threads. What are your thoughts on this?"

Test it out yourself and see what works best!

thanks,

greg k-h

