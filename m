Return-Path: <linux-kernel+bounces-154023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B558AD638
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F8B22900
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B31C6A0;
	Mon, 22 Apr 2024 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N849DPe4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B311BF24
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819485; cv=none; b=pX110hA4IpCbmsdK0rJydkT2WbcpgBzlzOyQaLci8FhUUUz/QbSpLbPRGTKHOObH/kT895XOvQ2dDsH10QcB26Uyq55p4w1PMWdOjc3YfPx24mMg9xZL/dp8+sSK5xI9f6lxq6JuaZu/jAMRSIzkwZWPAl0DnoD9FpOyv8rTrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819485; c=relaxed/simple;
	bh=X/XSvnsrPoXupaSH/bXPRLAjaVq3ammbbc8eQs4MfSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAGYk5iaorGKcGx0Yzq1NUCHg3uah9sYxE5GdxmgMQYJZ9jfEjV+pItnwqWA9SmeISEZ8xJwXBMevIg3R78O4ykbcoQj8I4be6cMB9dOqfEqHzGkHjM2/i87LXfKl30YVbtFb0+w7YF5yPe9TOisDbFyBcl/gqx6Oxj4U5DaOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N849DPe4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713819482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvn7f/v2fMtGre/U+zH+5pEbKnBwIFIuOe2b+sOiT/k=;
	b=N849DPe48ljMbftp/ylxhLC+l41LDXByYdS8WZ+phRUxiscZxKXZZDi8y27vsRs9kUfrK0
	Z1oZSasgy4PsliCMxC1aPIkjJStpk5h60/VNxry5jX/11zf1fZ4Ea0rMrXPweNRXtu0sGQ
	DbY2lZJtIi6V+xRArcEMwU4ucpIPPYw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-WBUI60zUPd6xn9UTMAIwfQ-1; Mon, 22 Apr 2024 16:58:01 -0400
X-MC-Unique: WBUI60zUPd6xn9UTMAIwfQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343ee356227so3203156f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819480; x=1714424280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvn7f/v2fMtGre/U+zH+5pEbKnBwIFIuOe2b+sOiT/k=;
        b=NCHvMhXaHF0LN+iWFjILQD1sXhoOjqEZKNS3fXWGZ4JftpkrWPCVJIVf1GTbtC3fjB
         bw1WGeQ0JNb+JF6xlkQe4te38EEE7UOsugj9FYLyclIFFnmlSfDyXnlO5o6G/8a6nq2I
         hxIqUVOIH1Yg192KeoZnjw9tVW9vApgfb3UR4YYUAShG4QpKPK0NqLM99AjXLOEFlkOC
         /U9xX7PlZnzYJvrC5q6HrNu7kTGSzXmKy6o8WDinUk8yZo5FouSNZ7QLjUFRITE4MHP+
         V087G6mEJgLytQc4GH1xmtNl12mTyEmvc9c8MzOA4iByMsIhyouTVUzUoDeWw4WuMwLy
         wXag==
X-Gm-Message-State: AOJu0YygBAjIVQZKSr6r+II+ojuUVYURvHI3Mj8XgKZwM4ObyYKhUSix
	BR38mwvxFuRKFm2SBo57Jl3lxMwEwdZYMnVp1+yMCiCJ9Xj195rd67QsnVOAmjbQ5XaPm2bmzoU
	XV8HTg+sKhJlN/rmvYQs3g2jeatkoW7A63W/PUJkQZnKo/rEFIbhIaOVoks4yOA==
X-Received: by 2002:adf:cb83:0:b0:343:75eb:bb79 with SMTP id q3-20020adfcb83000000b0034375ebbb79mr9063488wrh.49.1713819479983;
        Mon, 22 Apr 2024 13:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaK9k8slPED7kfQkV9Sd6NAWhb6FMzKP31WDFt1alwrqQlr5TJJICpDtQqR4i0OM22+/Wo8w==
X-Received: by 2002:adf:cb83:0:b0:343:75eb:bb79 with SMTP id q3-20020adfcb83000000b0034375ebbb79mr9063472wrh.49.1713819479441;
        Mon, 22 Apr 2024 13:57:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id h15-20020a056000000f00b003434c764f01sm12887597wrx.107.2024.04.22.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:57:58 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:57:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, david@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 0/3] Improve memory statistics for virtio balloon
Message-ID: <20240422165725-mutt-send-email-mst@kernel.org>
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418062602.1291391-1-pizhenwei@bytedance.com>

On Thu, Apr 18, 2024 at 02:25:59PM +0800, zhenwei pi wrote:
> RFC -> v1:
> - several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
> - move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'
> 
> RFC version:
> Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84


Make sure this builds without introducing new warnings please. 

> zhenwei pi (3):
>   virtio_balloon: introduce oom-kill invocations
>   virtio_balloon: introduce memory allocation stall counter
>   virtio_balloon: introduce memory scan/reclaim info
> 
>  drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_balloon.h | 16 +++++++++++++--
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1


