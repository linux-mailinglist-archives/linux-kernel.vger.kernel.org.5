Return-Path: <linux-kernel+bounces-120148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4188D2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799A430746D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAC01772F;
	Tue, 26 Mar 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDkhEcxf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E303FD4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497349; cv=none; b=KmkRF2ikDxo9Vd0NECZieTceoRPFLlc0cWKfnRiVxncT7AZ0+r3aEZ1T1NSIXpzaDeHN6kRt0hUESJadEo7+oL45osd/tvatrmJ0vLyZRyh6aZRxRrO/hFos0pX0VWrIbhus1FlAk1wywWvMb5w6YBdqDeACu9JwNayrG8dUHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497349; c=relaxed/simple;
	bh=CGBZO6sWtWt1UsxFRGNjlem6tqqGRAu237yPiACZoHw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CONNSGKB7wBLthB/peqaUZZSLbnFi5FrqvkMjt2qfegtPw31Tw2v7I+psi37Wp3ZuzeVNN3OUxb6gG7szUJHIA2NjYdTz+SrrK89pe1k65oVQs4j/Mth6jbxp4O0c/Dq2e/Xt6Zwt+NSCi2n2wTGZUNBF38L90ffsKTTc9Tb/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDkhEcxf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711497347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGsDJu8XpAr6x1oX6/jFrO71+5iqc/pjZkV4HoqWC1Q=;
	b=dDkhEcxf6Z7U74Aql5aFTq8X71V3ow+KzyKBNYNUERi0dld8GofKA5szMqX/AlwXNsNnmr
	qkwZrSXFooaQoxt1+uGjohVtaHGhWchm3vrfMhz3nUk0CnyhuYGy5zAMJtQuQimwT4CNf8
	bMKDsuXgVX8rQlj4qhE2VGyF1zNS4vY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-16we0NusMEWwjw_q96pEFg-1; Tue, 26 Mar 2024 19:55:45 -0400
X-MC-Unique: 16we0NusMEWwjw_q96pEFg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so4190950a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711497345; x=1712102145;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGsDJu8XpAr6x1oX6/jFrO71+5iqc/pjZkV4HoqWC1Q=;
        b=sxXZ09iYiH7n3g5AgIcr9C9fswsaMWHY02aRpiaQadEWN3mEiItaIb7v7FkIJ68SW4
         jwp9vWDSqkjCdLJlKaDKbvFlCk4MqWTZUpyb8VrcDYS1eArcXdp2EwFOaefCLZSQxV8/
         owveLvB+zkfqrWGWFjYrxQCdEibr6yVNBU2HzxbOJisJeM4Im6aHmJBji8y0sWKLFBvw
         7H+iA1Jh+gzbSfah5UfiyShDbIk7U+bLvIjvo38F2xUYoq+7zoD/lqiYqRcD8Bv+Zw5C
         jbsx7Y1M+GH7glP+jCHK3ua1kTW0lBW58FDfkrQKeNMJy/0RpPa4IeqcIFT/O4koitfQ
         UC3g==
X-Gm-Message-State: AOJu0YwSDbcc7kXno5h+kcb61xrD5eVQm1VREF+YlkO+cryyJOluXd1l
	6D01/xMOXD54zxf7ySq29BLZ4IEegMknIBwz2JaCgUQXt35xR9X4b3Igzemi/CBk5hUGlDNc/jK
	rS+skT4fx2/VxSDzOgg2+dc2gKTpqFJCwz/RcSkSdkME+dxxDu4w0p21wL/wQfA==
X-Received: by 2002:a17:902:e546:b0:1e0:2377:b23c with SMTP id n6-20020a170902e54600b001e02377b23cmr11306266plf.51.1711497344852;
        Tue, 26 Mar 2024 16:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0PwA7G3bbW59cTMwsRfBzB0MvWtcaXY+g1f6iUtKsH2Z84f05R+a0cugj0CKI9MKqWCmnSA==
X-Received: by 2002:a17:902:e546:b0:1e0:2377:b23c with SMTP id n6-20020a170902e54600b001e02377b23cmr11306241plf.51.1711497344429;
        Tue, 26 Mar 2024 16:55:44 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a170902761800b001e1153c3047sm48387pll.106.2024.03.26.16.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 16:55:43 -0700 (PDT)
Message-ID: <46c6a9aa-821c-4013-afe7-61ec05fc9dd4@redhat.com>
Date: Wed, 27 Mar 2024 09:55:37 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] vhost: Fix stale available ring entries
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com,
 keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com,
 Will Deacon <will@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 09:38, Gavin Shan wrote:
> The issue was reported by Yihuang Yu on NVidia's grace-hopper (ARM64)
> platform. The wrong head (available ring entry) is seen by the guest
> when running 'netperf' on the guest and running 'netserver' on another
> NVidia's grace-grace machine.
> 
>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>    -accel kvm -machine virt,gic-version=host -cpu host          \
>    -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>    -m 4096M,slots=16,maxmem=64G                                 \
>    -object memory-backend-ram,id=mem0,size=4096M                \
>     :                                                           \
>    -netdev tap,id=tap0,vhost=true                               \
>    -device virtio-net-pci,bus=pcie.8,netdev=tap0,mac=52:54:00:f1:26:b0
>     :
>    guest# ifconfig eth0 | grep 'inet addr'
>    inet addr:10.26.1.220
>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>    virtio_net virtio0: output.0:id 100 is not a head!
> 
> There is missed smp_rmb() in vhost_vq_avail_empty() and vhost_enable_notify().
> Without smp_rmb(), vq->avail_idx is increased but the available ring
> entries aren't arriving to vhost side yet. So a stale available ring
> entry can be fetched in vhost_get_vq_desc().
> 
> Fix it by adding smp_rmb() in those two functions. Note that I need
> two patches so that they can be easily picked up by the stable kernel.
> With the changes, I'm unable to hit the issue again.
> 
> Gavin Shan (2):
>    vhost: Add smp_rmb() in vhost_vq_avail_empty()
>    vhost: Add smp_rmb() in vhost_enable_notify()
> 
>   drivers/vhost/vhost.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 

Sorry, I was supposed to copy Will. Amending for it.

Thanks,
Gavin


