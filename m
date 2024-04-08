Return-Path: <linux-kernel+bounces-134885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBC489B837
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9041C21AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB22375F;
	Mon,  8 Apr 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYnuNscK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70965567F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560793; cv=none; b=Q770nRvUNqQ6Nrmncc2iNevcqXKdcHj39OGdln4b7/bbr4wegfnnQ6aZ9sBSU7VMczsFcYW9Y0AOylxGoxAu3D59t8eauZX4GCZ5uTFo3SkLfTVUkBQLEJMdHi1bhY0GsXnVOf3fh5OUt//Hu+0KE2eibzb8h0MgxlDg4KPOFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560793; c=relaxed/simple;
	bh=eUKziqBBzbrhqWBZ/O72l+OQvAqgubuL+SFhJPQecLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5sml25LBAcy6HoC0Lmv38YmSvEk0sxE5SRBFL1oH2oxR9xX0DNCsKTioN1WEPsb3fSxL9hlQQH+YJoZd3bEueAgzLGvAqN04JbFyftuIIeI8gzpCBpgF3sWStAM5/GXjdNMsFwjTQfampfbJOcqKep6cGxfWLx+0H6A2ChnIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYnuNscK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712560790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YA3MygwowqMrDITGbbXDUxPQpip1dfebFGErHe4OpA=;
	b=QYnuNscK4/euOZ17kvzrJnkkx5r5gmM5RuqF3nbG0uWadWNWEDCl9Xj1mxXaYVWmrHxydD
	d5/HrO1y63IiqtrJc/2BW+5GED6ke6eES/B5ISeG7KV6R7mczNq1UmPd43sPCPb7791hDp
	Bv+HfGPU6KGT7EOFGsSQ9pMrdV2OeFM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-voBoR_JoOXGS7u9jyteQ5g-1; Mon, 08 Apr 2024 03:19:49 -0400
X-MC-Unique: voBoR_JoOXGS7u9jyteQ5g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-516d2c322d5so2812083e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712560787; x=1713165587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YA3MygwowqMrDITGbbXDUxPQpip1dfebFGErHe4OpA=;
        b=kRJE/evpd9z0T/sd4Qr2QFwDVvq+wdY9p8p4cHdEWVGVvM2M7lm369s1PNss3Z2U7d
         ZDW/rZ80v/C8S7AY0z57RNxWFLLX5J1tLKl5lNRjSZVrmvDoScbzZLKOndgn903RYEHm
         vr8xgYEKr0BH//+noH2EsDWS2bIn6SFOI8BQKvlNnSQfj8x8cc9ZLoTwSwaKp6KHC7vc
         wt+h0X6kkkH7iecI453b7Bq/ZCorS8NYk+tPqVjCQ5W9JqATYd6j9dTa+mMuRUYqsbS2
         Vtnny/xG1BYPoCGBAIGCYlEqv2148JCtbmLaOvjpRDQywfFrX7ar1MOuolRvz0/F3D7y
         pKtA==
X-Forwarded-Encrypted: i=1; AJvYcCUFgl0DaP1t43NQGtP6aQSdc4MuD8kDvoY6XR3kFJBp7eXTFLXQBXx9vdaBkwOryt0FpNapeBKR1GP+ZAZnrKN044FiG7oJfFGFOoY+
X-Gm-Message-State: AOJu0YzJf5GUJuaFVPeFGJQu7XwRYeXPwd5BKqP0XCfi2owu+v8O1/lt
	Ujr+GlrI3xe+SSah+2jBn/etreaZ/BZ9CvHhU5/tWGgQdz3SyKCa06WZ0eZl7kkRKCtyMGZAUy/
	p6U+E0F/LWUFbKiJXDdzsr+aBGT45sfYDnDIVI6PfD5UjtfQHv6ys65gZz8V3Og==
X-Received: by 2002:a05:6512:3193:b0:513:5971:10c9 with SMTP id i19-20020a056512319300b00513597110c9mr6919923lfe.56.1712560787490;
        Mon, 08 Apr 2024 00:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbR0BCsbYb3Uabba61Ahp4qeIPNoBlWIrkVtqaThQquJhajN6V7N8ZV16ym9XreFqJ/6ATOA==
X-Received: by 2002:a05:6512:3193:b0:513:5971:10c9 with SMTP id i19-20020a056512319300b00513597110c9mr6919899lfe.56.1712560786914;
        Mon, 08 Apr 2024 00:19:46 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c45ce00b004162ef30447sm11622842wmo.18.2024.04.08.00.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:19:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:19:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240408031900-mutt-send-email-mst@kernel.org>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
 <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>

On Mon, Apr 08, 2024 at 02:15:24PM +1000, Gavin Shan wrote:
> Hi Michael,
> 
> On 3/30/24 19:02, Gavin Shan wrote:
> > On 3/28/24 19:31, Michael S. Tsirkin wrote:
> > > On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
> > > > All the callers of vhost_get_avail_idx() are concerned to the memory
> > > > barrier, imposed by smp_rmb() to ensure the order of the available
> > > > ring entry read and avail_idx read.
> > > > 
> > > > Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> > > > the avail_idx is advanced. With it, the callers needn't to worry
> > > > about the memory barrier.
> > > > 
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > 
> > > Previous patches are ok. This one I feel needs more work -
> > > first more code such as sanity checking should go into
> > > this function, second there's actually a difference
> > > between comparing to last_avail_idx and just comparing
> > > to the previous value of avail_idx.
> > > I will pick patches 1-2 and post a cleanup on top so you can
> > > take a look, ok?
> > > 
> > 
> > Thanks, Michael. It's fine to me.
> > 
> 
> A kindly ping.
> 
> If it's ok to you, could you please merge PATCH[1-2]? Our downstream
> 9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
> platforms.

Yes - in the next rc hopefully.

> For PATCH[3], I also can help with the improvement if you don't have time
> for it. Please let me know.
> 
> Thanks,
> Gavin


That would be great.

-- 
MST


