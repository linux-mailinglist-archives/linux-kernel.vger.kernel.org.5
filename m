Return-Path: <linux-kernel+bounces-58273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164C84E3D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F454289E79
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937BD7B3C5;
	Thu,  8 Feb 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLOeOW2L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CB7AE69
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405491; cv=none; b=E1p3ex0RflouBo5+HtJgJF2gh/Hvy0mhGhauOFcIh196rb9cnw9ce2CezWqxeWihUVJtqpBeZLbr+gJuhAce4T7LyeSbV6P8xc/2csYeiW4KK4iqAJ/JviqGRAcGjpNw4sLG3T/MKWPzHxH87N2TkY2HNUGwZTRnaIjE8sRuMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405491; c=relaxed/simple;
	bh=S4OjuDatb/mla7k+TvA9eg80gNVRZwgPQ7rsBU3DwVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4IpA1rWU7QfAPnWZrJlLDeV//YbZmgVEQ1HgQkZJ1oBlhLvdGjyTf2tfglOrPXGQIBkB/643ksmZ0OhzdhtfJcHhAt4bYSKstnEMkDHwAeTPPJVhymK3l6MiolQczzBv1XxhTmrzZmw29yQ79qel4Jb9zSWNfecjQTAWA93ETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLOeOW2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707405488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4OjuDatb/mla7k+TvA9eg80gNVRZwgPQ7rsBU3DwVE=;
	b=iLOeOW2L3aS2fi7fxMZnWWPdk40sCEma1WVW791i7QNvm9xKxAWLMWl1dJQ8NkAg4rvmgM
	MkIdKNPCXFtKx2koZzyMDmkyP3kUIvaAy/zmghR0JZ9TLXXlfA4zE6Ne/9y2iTzN21jNdK
	z5iaBdA2yCFfvqtbsUZeq7UKHuzFyls=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-jwiCEznvNWmheLVIDKLRxA-1; Thu, 08 Feb 2024 10:18:06 -0500
X-MC-Unique: jwiCEznvNWmheLVIDKLRxA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78315f41c6cso222017385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707405486; x=1708010286;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4OjuDatb/mla7k+TvA9eg80gNVRZwgPQ7rsBU3DwVE=;
        b=hwVk3L5GpqIXQWSvwCO9Sv/Kch7jlw0ZgFWxeX0DfRCOBxrY67Fs/B521YhJf0O7lz
         JqTgqfiLOd56vyzg6U3Z4D04Sl7ZQ5buXm0SQplIWhIUhHsVUI7xCAwnfe0XIMK4ia9j
         KYxTOB5VwXup1iRHvl5NDYwBkreSXpLJATL2OtyXGPpsNvNA8p7mZjyBYAft1plu5okw
         pHReGqXPIuVUv8YsEK2nCB+VgD06nyJMYdSaPZXF+vD/RCETu5EJop2s4UYKXAhL93PE
         b+8PaiixXEEleJfJn03q4VqY1rvrnfycV5p+MJXy5QMdyi630zPk5N48NxxC+HfRucsK
         iV5w==
X-Gm-Message-State: AOJu0YzeWAVylQn52/33Bag/8zWeNdQdSQjTLTNf7glVMJg8PxR48RkK
	qFL1fkPBqTAHPxGVeKkaY2ipdpn/hc47tYSfk8HmQGN5Dz/C/6X+NjwaREUFdZ7ur8wcTfWpXy9
	FnQn45JONYlLmK6Nc5jkycgqTP9IyyuA3bbiwfZV68KJuMMejlJTEcE9AXhecjQ==
X-Received: by 2002:a05:620a:223:b0:785:445f:41e9 with SMTP id u3-20020a05620a022300b00785445f41e9mr9589224qkm.14.1707405486469;
        Thu, 08 Feb 2024 07:18:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKFL280+b7zJfP6GaaQfcspFhTEDByKhYcPjAnLxbtiL/TL1f0Lt8a8T532YJivC2bp49uNw==
X-Received: by 2002:a05:620a:223:b0:785:445f:41e9 with SMTP id u3-20020a05620a022300b00785445f41e9mr9589191qkm.14.1707405486065;
        Thu, 08 Feb 2024 07:18:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2A989kUioOTdlaleHBBbdw7VE2xoQHW44/91/jRZgpKOD74Doez9AzQGOMC8USDhUcT33mSb0KEAFuWM++bd+oQlgdQJRzsVhTmcn+Rp1aoKSk4xFZSd8maN67poAtqORDCvUJQ9GrR2w+joAKv5aC0GGD02ckaw0VP2XLp5S4Gb/10O+n3npj08DhGDlHo1GUlxi9D1FdvrkUcKS6abjVC/85G7KYxTFGR8s5HzGKGPf1aLgHX50pNIj84XzJ5iizsqC3GuZD68yB2vbJ4/UTwMc4ocGOaADRyPkYc0BOHKquzkpQKUf8lrt9ua6jrjFEd7cwZoYPEDolqUCEXNfqSGxRS7ZcVjmynNFu7qtBsk7QOCZPOt+s64O6wYrJl82MsQ40ZJomZImls4AJX+PleabWCMIXZngDo7d8CzO
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id g15-20020a05620a13cf00b00785a9820313sm71654qkl.84.2024.02.08.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:18:05 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, linux-kernel@vger.kernel.org,
 ricardo.neri-calderon@linux.intel.com, yangyicong@hisilicon.com
Cc: Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v4 1/4] sched/topology: Remove duplicate descriptions
 from TOPOLOGY_SD_FLAGS
In-Reply-To: <20240207034704.935774-1-alexs@kernel.org>
References: <20240207034704.935774-1-alexs@kernel.org>
Date: Thu, 08 Feb 2024 16:18:01 +0100
Message-ID: <xhsmhy1bvf0ie.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/02/24 11:47, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> These flags are already documented in include/linux/sched/sd_flags.h.
> Also add missing SD_CLUSTER and keep the comment on SD_ASYM_PACKING
> as it is a special case.
>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


