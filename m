Return-Path: <linux-kernel+bounces-47789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B88452EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE41C264DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0415A4B2;
	Thu,  1 Feb 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoXGG9HG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1217554
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776832; cv=none; b=RFNWc+cRuJd0ryPhLtZT+Wl+a67YMvhrurZmgtDN7bQJTsptXZrWkrkKGGFO4JA3Xm/kOZ4r5C+97xasNUu1vmDJ6yO1rsAWHMO09yrxApDeWARYvGVCKxN8p2SFiPFDE/IHNcmqWv86rrYUnRN+1AEfyAyEyFmREhJvCpJ+8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776832; c=relaxed/simple;
	bh=g/4tx/iCm+9BQCzD37jmIjXm4y79gZgnlOQOTDWikuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvfvt9svucVkUUHeUSyNsBJWXn5GSQokBU9XeIPOSjVenlOt1XCXczEbYGX7ydrGSD0PxxM0qudA2PGb9qF9yuQeCmR8CIAvmle2ZayGmPybG4/WgZIG6mGXwrbP7cV+CwZqZfaJ8Dg9t+kAkTu0mBNdSBmAiA3jmGIzp1w/9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoXGG9HG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706776830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkCWV8fSLAWGNlqsa3ptZDoOlPO4LQfFc4U980Ufp9o=;
	b=YoXGG9HGtJTBwxw3XtAdYlY99/DlkxLQGuRDb40os0PPKHql6v7HWpoCPmeIdVeoynG6pA
	5NPjB40lggpz8C9JsfCpTOs7TWAtp3CJ/TrkNp89xi/19IsOoQMaKMAAu8iQzY0syOHJot
	dUyZ03j4aiRLWpk4abJpdvGEbywmJkQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-iEXS7HLINh2j8KDo98uw_w-1; Thu, 01 Feb 2024 03:40:28 -0500
X-MC-Unique: iEXS7HLINh2j8KDo98uw_w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55f922036dbso309630a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776827; x=1707381627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkCWV8fSLAWGNlqsa3ptZDoOlPO4LQfFc4U980Ufp9o=;
        b=VDwjL8B5AYQ+xZfATuNgdv8NhXGT9gmmNK1RQykl+TVj+YoXqM/kw4SP5N9NoL8YiT
         lUp2tbB8uWFLe70lErKNnWy1NP2QM7xawvkXEkJw/MUgNNS5G8e6KnnW53OzrlCx/LUh
         GyUUE/NW7JnNwvfsDt8ki4uk/ssfffg8yaTAMalNuTQeuh6LyZCmb9wIQ7dpCS8Ly9fz
         SVfxAOsPUsbLUv4zwQomdFb+TuvFumiljFkl6cdr+RksaDPN4+Are+o6a7fiFxsljbft
         bTIyzNYoscdW/D2Ac2vbT3MoA3byCxGKUCY6dpXxMwSNibAFHpH0Vqt4Ni+Mz6GIWThY
         ud0Q==
X-Gm-Message-State: AOJu0Yxkc92j3Q7VCD0M3EWzNcUQNus2X+acnFKjlMsglw4CCSodVYJu
	utUZAODjKpNX7l2W4vdznEzvRuAUGmntyauVeqxkiw5vIAMGvCuiZbM8kq4sLOqteyQDzjW1MXh
	ChiyIwOFvD8HFnZA+KxTzJZZkQ2SdpMIABCsyUxH9lkzJ7MnaYvy9DSpWBah9Yg==
X-Received: by 2002:a05:6402:78e:b0:55f:b005:57a1 with SMTP id d14-20020a056402078e00b0055fb00557a1mr921727edy.14.1706776827119;
        Thu, 01 Feb 2024 00:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3laig23HZp6DIctLuen5OfD+zRgqhxYlNkBm+KfjgIZsHa9+TW/k+knOlKqs1FFbXTidJIA==
X-Received: by 2002:a05:6402:78e:b0:55f:b005:57a1 with SMTP id d14-20020a056402078e00b0055fb00557a1mr921717edy.14.1706776826783;
        Thu, 01 Feb 2024 00:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcztGWraZMER6rtyXPMrjri/yLOA+nNhAIaQjhxNq4V3DQmtGwQmKvy1Sq3yLWUb9+E452thkCmnJRv7HMyoG7qK0LxCNyEMrfcY7YsTIEey+dTpyzoFAA49rZRad6CxrZY05vhNnUtEueihXszQlw0doocp65I1Wwo14ze40hEbZN3BDYyJAEzOAuFL5n3k5gdfAmJmqx93mHB/d8a1+pTKa4nuHRXiy2aeereNLhCbE+ofeh9BmiWXyFZX4gtWoVsjw3w45sJjn1+4FODuNLa6C/bkN+GFs=
Received: from redhat.com ([2a02:14f:179:3a6d:f252:c632:3893:a2ef])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c791000000b0055f283314e1sm2998692eds.43.2024.02.01.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:40:26 -0800 (PST)
Date: Thu, 1 Feb 2024 03:40:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, david.marchand@redhat.com,
	lulu@redhat.com
Subject: Re: [PATCH v7 0/3] vduse: add support for networking devices
Message-ID: <20240201033944-mutt-send-email-mst@kernel.org>
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
 <f25f3c31-c793-4743-a587-0e2063dc2d65@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25f3c31-c793-4743-a587-0e2063dc2d65@redhat.com>

On Thu, Feb 01, 2024 at 09:34:11AM +0100, Maxime Coquelin wrote:
> Hi Jason,
> 
> It looks like all patches got acked by you.
> Any blocker to queue the series for next release?
> 
> Thanks,
> Maxime

I think it's good enough at this point. Will put it in
linux-next shortly.


