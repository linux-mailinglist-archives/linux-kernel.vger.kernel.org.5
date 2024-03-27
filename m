Return-Path: <linux-kernel+bounces-120779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F05788DCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E88B2481B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF312D1FE;
	Wed, 27 Mar 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+YyVcRT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4112CDBD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540631; cv=none; b=arjiTV3LSoXiiZfkkRfTJ+zXR/d/6QvNCmEoGrxHC9cTCAqPvpTkZz/bzi21grU1IgEVCWgNcWTSBNQnMSqIHCJQkJsE185SVrqL2rgSrnBB04PsOKWmIG5ml2MRJ0HmbyT9MQqBKKXLiGPJzqYsnAN05llRad+IDZSilcBqyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540631; c=relaxed/simple;
	bh=/bVCLHeYkfY4wX+w0FmLv677D8eoPiD32q9LLkx2i8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcfvkX+dt23wDFrasax2hsWDV7RjlyViLj+SoJqNR7PQ66X0RV40uHGkSkONpt4igL3d1pQTEf9y5FfN5b/KFcWrSb4gcplLpXiBo82OHXkpgdxn47+Phxm58qTQsAYxxBhSoNSYibes2HG6ZCkL93JTf+uvT6Z6gDWwmGpq+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+YyVcRT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711540628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWri6+tiRPxiqqVnG5Me+/c+BeHQBoEHnxaqpBOMAaM=;
	b=g+YyVcRTrBoF0zkelwnE7/u9v7MojwI3QlIjTjtkGu4t5eiIzFXDlzhKAU0LTYqejx01F/
	cJ8ZFMCGkAG2fRG1fnHgvFa2yivwibA4P7C7iIyBV+xfY3yUxM5u24zvrzIINkJiW9FOrq
	Y0aMOoYX2lgSVBuSEUcBrSu9kWvj/Kg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-1dlbOp5hMkWLvJ5w71UaLw-1; Wed, 27 Mar 2024 07:57:06 -0400
X-MC-Unique: 1dlbOp5hMkWLvJ5w71UaLw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41407fd718dso36069975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540625; x=1712145425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWri6+tiRPxiqqVnG5Me+/c+BeHQBoEHnxaqpBOMAaM=;
        b=lbJD4Pj7MdYMNEG2rl8QqyICYRJ+WXUFz0XvuPT5n1pjab3CrCfPEGWxJUrZ2tBPfh
         OHoQarJSL6tJQn4oeIpfKXh3OmbtzU703vVYvy0prx+2DQrw0wnKFJpXhgAQB3IOLtTi
         nVEDXJ2hdSjuByEOO7caba3HHR2Nl811U2uecexgQlWToEneDRfUv4re+ECbTREnYbIK
         UoqwI5GA88TLsihynxhCEHdbYpXRoeK8arfmatZOtvkIfRATBKaxrzUx+5yLF2Lfgsxj
         uqHI5soaIZpKG4z7s8Cjw8glfolygm4un0phNL1cJx16+MIMwQwkh7oRpolZGRh/1P+0
         CDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmn6IeANC8PIjl8ktcrSYINBxsryvJRkLPRfqlRV+5Y/wnjPBMBWuR8r+2EMn5xpCYuklkCa0GmzXPOhbTihTRXoccnQUAuknSZg1j
X-Gm-Message-State: AOJu0Yyr0FAbU1C8PgoBlTvtpg7fVCT/X1XjiD0JSP/UtA0o1wXaAHOZ
	KOB3VXGhJRKk8t9ygA12AkJ3BeR/4jaM/a+r5/L2Gm2N7FrqbJj5tiABkfEcc/K7mq3m1tOpPqH
	Q6xEVuoeQMfY1Ycxq7EZ23gWDxXo+/YGMbHiicRIZ4jxpRoxc4i8FPRCT7wUd/g==
X-Received: by 2002:a05:600c:3b9e:b0:413:133c:b9c8 with SMTP id n30-20020a05600c3b9e00b00413133cb9c8mr886067wms.33.1711540625447;
        Wed, 27 Mar 2024 04:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjtWZgoLECCahLjXIvmW31Yh+6KWzfZk85gRGbWkJ9cBwuztQZcyvva3YOYYkjVtDSlBU+UA==
X-Received: by 2002:a05:600c:3b9e:b0:413:133c:b9c8 with SMTP id n30-20020a05600c3b9e00b00413133cb9c8mr886041wms.33.1711540624781;
        Wed, 27 Mar 2024 04:57:04 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm1934113wmo.21.2024.03.27.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:57:04 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:56:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: Keir Fraser <keirf@google.com>, gshan@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240327075049-mutt-send-email-mst@kernel.org>
References: <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org>
 <ZgKXr8IQ51xBECuP@google.com>
 <20240326114313.GA9482@willie-the-truck>
 <20240326154628.GA9613@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326154628.GA9613@willie-the-truck>

On Tue, Mar 26, 2024 at 03:46:29PM +0000, Will Deacon wrote:
> On Tue, Mar 26, 2024 at 11:43:13AM +0000, Will Deacon wrote:
> > On Tue, Mar 26, 2024 at 09:38:55AM +0000, Keir Fraser wrote:
> > > On Tue, Mar 26, 2024 at 03:49:02AM -0400, Michael S. Tsirkin wrote:
> > > > > Secondly, the debugging code is enhanced so that the available head for
> > > > > (last_avail_idx - 1) is read for twice and recorded. It means the available
> > > > > head for one specific available index is read for twice. I do see the
> > > > > available heads are different from the consecutive reads. More details
> > > > > are shared as below.
> > > > > 
> > > > > From the guest side
> > > > > ===================
> > > > > 
> > > > > virtio_net virtio0: output.0:id 86 is not a head!
> > > > > head to be released: 047 062 112
> > > > > 
> > > > > avail_idx:
> > > > > 000  49665
> > > > > 001  49666  <--
> > > > >  :
> > > > > 015  49664
> > > > 
> > > > what are these #s 49665 and so on?
> > > > and how large is the ring?
> > > > I am guessing 49664 is the index ring size is 16 and
> > > > 49664 % 16 == 0
> > > 
> > > More than that, 49664 % 256 == 0
> > > 
> > > So again there seems to be an error in the vicinity of roll-over of
> > > the idx low byte, as I observed in the earlier log. Surely this is
> > > more than coincidence?
> > 
> > Yeah, I'd still really like to see the disassembly for both sides of the
> > protocol here. Gavin, is that something you're able to provide? Worst
> > case, the host and guest vmlinux objects would be a starting point.
> > 
> > Personally, I'd be fairly surprised if this was a hardware issue.
> 
> Ok, long shot after eyeballing the vhost code, but does the diff below
> help at all? It looks like vhost_vq_avail_empty() can advance the value
> saved in 'vq->avail_idx' but without the read barrier, possibly confusing
> vhost_get_vq_desc() in polling mode.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..87bff710331a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2801,6 +2801,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                 return false;
>         vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
> +       smp_rmb();
>         return vq->avail_idx == vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);

Oh wow you are right.

We have:

        if (vq->avail_idx == vq->last_avail_idx) {
                if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
                        vq_err(vq, "Failed to access avail idx at %p\n",
                                &vq->avail->idx);
                        return -EFAULT;
                }
                vq->avail_idx = vhost16_to_cpu(vq, avail_idx);

                if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
                        vq_err(vq, "Guest moved used index from %u to %u",
                                last_avail_idx, vq->avail_idx);
                        return -EFAULT;
                }

                /* If there's nothing new since last we looked, return
                 * invalid.
                 */
                if (vq->avail_idx == last_avail_idx)
                        return vq->num;

                /* Only get avail ring entries after they have been
                 * exposed by guest.
                 */
                smp_rmb();
        }


and so the rmb only happens if avail_idx is not advanced.

Actually there is a bunch of code duplication where we assign to
avail_idx, too.

Will thanks a lot for looking into this! I kept looking into
the virtio side for some reason, the fact that it did not
trigger with qemu should have been a big hint!


-- 
MST


