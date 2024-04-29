Return-Path: <linux-kernel+bounces-161831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8278B51ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB91C20FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F412E7C;
	Mon, 29 Apr 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad6bEE++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28D6FCB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374149; cv=none; b=tBQTXSjAjsN3oXIS4fGLXoOaGROItP1FuRfuLajsoAPlahT8Vxnvv8e8v2kwA/Iu79EqaX347ROVOuMvjv6m9S/EVuciA+yo/8IkscW7PAjtVQYS27sLnoUo0kSyM8vI6VgWyEYazL9/Cb/23w/pf4ScH/2sCauDdiR/WuVW1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374149; c=relaxed/simple;
	bh=pogqEdNSBms+a1/+ebRncU/sioC2zzur3n3WfxW6guA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/3TtU4vdKweDmvciFP4qt0hSWH144QYadLsnXu5+oYXkqQX/OJmcmUZvA3jDgwel4YgjNUdeY73UrHAKQniE2QeSnh/Ok8nBtYky0sPA8+FA+EqZ/V7JHANq8bqW+IybFFGk0u5M+anp0OdKjHjxaa0wpCSqBHX4FwwdPOHQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ad6bEE++; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714374145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DoxRr+mz0BriEoydrVcRkNlqWUgXwM3/o76Mys3JDE=;
	b=Ad6bEE++aXycRelCfJai7aWJskFoNEwatDRj8ZQ20CAxt0EPRyWqZgiiZqDJTtUOpOxgiq
	fa+rca/oRr6bYtR++0bC9UhKSeGmWEbwyOXSpHLe7Aeh1lFhc/Y8Ce8z1oWifZvbw7x7eL
	3Aej0EY/9FMQ3cnw8zDWhlFRlgzhIGQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-oUCFJBp5NZaSt3JQK3-esQ-1; Mon, 29 Apr 2024 03:02:21 -0400
X-MC-Unique: oUCFJBp5NZaSt3JQK3-esQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2db869d3805so37403881fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 00:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714374140; x=1714978940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DoxRr+mz0BriEoydrVcRkNlqWUgXwM3/o76Mys3JDE=;
        b=WaiTvtAxXUjZ1WTOIP4jHTH5pJiNajOhdmN39bEqCcDltSzFDmJkFuHycpmyzZNSr+
         Jibe6j8VYSW//Pa2rUBZxaJOgQ/CrFZz+9LKwj8NLenTTqYpmZGEtmaixd8j0zDbHTwz
         pRGobmzGH4l0fQtX2uDyIXylrXj0TCQ3K3CWINJFsJjy6tPWe3juZ4uEN9BejTmrSeN0
         uQObxivSgibc8mjd9ALCvbL8pErJcRKgShbvIYTm9PSi22MT3kpVwiiqMH9qosmW5u/Y
         ZxqseewHzA67X61wGaaeUQisL8/PJFO1QCS8lsbujs2ITjzOJQ/OnPh/SFkZEvk+s0Nu
         RLfw==
X-Forwarded-Encrypted: i=1; AJvYcCUetNkLIGdGZR/H7DvHd+ODNkLOypNNTM7CAJRT50HK2g3xKm2PcJUGKAmieBfUMYyEOX7IPbssYK3jbKKR7U+oTJMX3c9eEKaYqsNx
X-Gm-Message-State: AOJu0YyXYCDMo25B5XmLSkJIned3Meh4R3LVb3IN6+QnSlo4W1hcQahw
	uhh3s3AYpj0LFgveMIo1vJaeiwGfrDmcaHBJQIHaeVB0LQR4yVlUdtmZ3T5omm6SHMR6uIIDjAX
	oOGs2N46qqw7ghIShJRoSP2tjqLC2Pb1L3E4BN6BR7H39ti/XYS9DwPsGyhxD1w==
X-Received: by 2002:a2e:9858:0:b0:2df:b0e3:b548 with SMTP id e24-20020a2e9858000000b002dfb0e3b548mr3826434ljj.42.1714374139991;
        Mon, 29 Apr 2024 00:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuHIAp2n2tfSQLWrLVwFMNH9X760go/jcvnYYzf5sELahjo+ORqasE4j3baWKWjef6Q8qWjQ==
X-Received: by 2002:a2e:9858:0:b0:2df:b0e3:b548 with SMTP id e24-20020a2e9858000000b002dfb0e3b548mr3826328ljj.42.1714374137176;
        Mon, 29 Apr 2024 00:02:17 -0700 (PDT)
Received: from redhat.com ([212.116.168.114])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b0041a49b10a13sm28190575wms.11.2024.04.29.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:02:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:02:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] vhost: Cleanup
Message-ID: <20240429025750-mutt-send-email-mst@kernel.org>
References: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423032407.262329-1-gshan@redhat.com>

On Tue, Apr 23, 2024 at 01:24:03PM +1000, Gavin Shan wrote:
> This is suggested by Michael S. Tsirkin according to [1] and the goal
> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
> the caller of the function needn't to worry about memory barriers. Since
> we're here, other cleanups are also applied.


Gavin I suggested another approach.
1. Start with the patch I sent (vhost: order avail ring reads after
   index updates) just do a diff against latest.
   simplify error handling a bit.
2. Do any other cleanups on top.

> [1] https://lore.kernel.org/virtualization/20240327075940-mutt-send-email-mst@kernel.org/
> 
> PATCH[1] drops the local variable @last_avail_idx since it's equivalent
>          to vq->last_avail_idx
> PATCH[2] improves vhost_get_avail_idx() so that smp_rmb() is applied if
>          needed. Besides, the sanity checks on the retrieved available
>          queue index are also squeezed to vhost_get_avail_idx()
> PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
>          for vhost_get_avail_idx(), so that the relevant sanity checks
>          on the head are squeezed to vhost_get_avail_head()
> PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
>          as the terminator for each line
> 
> Gavin Shan (4):
>   vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
>   vhost: Improve vhost_get_avail_idx() with smp_rmb()
>   vhost: Improve vhost_get_avail_head()
>   vhost: Reformat vhost_{get, put}_user()
> 
>  drivers/vhost/vhost.c | 199 +++++++++++++++++++-----------------------
>  1 file changed, 88 insertions(+), 111 deletions(-)
> 
> -- 
> 2.44.0


