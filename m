Return-Path: <linux-kernel+bounces-121328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE488E612
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CEC1F30540
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACA153506;
	Wed, 27 Mar 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C69OYLw0"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BB12D774
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544184; cv=none; b=e3mdm30KTNZ8yWOQnSG7BPWahGiiWsdTXUXeIo/nAiPXMGDArATh+dZnbClvMj+A/TcraRiinmyt4iOlGDNl7h7AhuW4owT8c4I13EQY8TIYEtnWUsceEj84P+YHhHLDe1kYzsIicMV9Vvs8k/XFd3my47uOP0k6LfKXu9PuL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544184; c=relaxed/simple;
	bh=w8fAAjUbn+V2AC0IttZ8M+6kKib99nE0E7k8uWfW6f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGqnTDN3nZN3MWkLjs2LJ2TNS7cx3Xx0JT3yYeGKVeJqo6xlUpHDKLHbB93w6rfKhsOPmsZRm6RyjmDfU2NjJhSA82LgD0H/B5ezZ+M/caXJzZBH4BQEX1HPOcOhUBIBkZhEqVOJWxrOkva7hr0kXksKgsoh6Pu9G1oP5R7DRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=C69OYLw0; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c8ccffacbcso178895939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711544182; x=1712148982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDUDMYuwU2SUxAqC60S/6H5qJEoJ0FMo+cGtvAM2eZo=;
        b=C69OYLw0i3gMraRBWsUetmc26jqnS/DznsWavk0w53f6v38Rz+Fy3rf5K/VzyOaN4F
         6l+h8T9LVnHcam6zZqD1dmyE0yluO9qs6FC10eLIHFz8nZRn55WYvkdQKOP+W+paMxhd
         ykjbUY4QC96ivKvfP3FA+5fOYNLExspNOFrfiksbsZz39cvoOBwqsxnvl14//RuLwRqn
         VQpjm8SEClxkLJZ+eWYjIlttPrO0mFo55yBM/nWFCB5lxeYn/zPji/tw84NjZmw3CAEF
         XiXfLmnNxoqJ0bawg53OHgHZ47HG0d3N5juNi2plU68efh8h/ZbiqvlgZk8CME+qZ1vs
         P2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711544182; x=1712148982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDUDMYuwU2SUxAqC60S/6H5qJEoJ0FMo+cGtvAM2eZo=;
        b=uFs76m50bU4fD0AaBRuUhWDHW/Nfqb3xa1siSoDYfkAzgxNOxTV47nI7USXR6tKPGG
         3ahl2HOmlDsKyycMoUkRg94Bk3gqI2xsZUyuLFzmTgHDbtaHU/1hzxOATxQbo9caVMWF
         Or4yGkyIaJX5gjEd03cAryroGhkGRwC0KxihR9b5BZZ6aHh6I8Y2vrsCvkivN4JGTfXC
         9zTxquN3/T/Irsdq4t4BSGi78iHPHvctK/081CiPN8/Jw+M5l5ognUnVSjef6IiBYmhD
         Mx2gzNOHkvFzeK1AOMUXUUE8T7gvIeLavc0OTxoM9rnbJKUTOOQ0u7YJAtCUvfzoyyMy
         qWgQ==
X-Gm-Message-State: AOJu0YzJ0gxdcddoRde7D0KdPdoooO4IIPXR7hzOJds/v1fV36HAYgvP
	fAXK3JQRxafo0GCKRuh4E3pQmfzMBs7VYNirywVxdepnjSGJVCuHg+hLhjH1DgM=
X-Google-Smtp-Source: AGHT+IGpHwDVcEaSCyL0jaVUFQB7IqtIxhkm8li1Yxlb1nP0/kTO6T5MUCR28gpsX+7hskI59QpZbA==
X-Received: by 2002:a5d:8508:0:b0:7c8:dc57:4dd3 with SMTP id q8-20020a5d8508000000b007c8dc574dd3mr5226769ion.6.1711544181585;
        Wed, 27 Mar 2024 05:56:21 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c647000000b00479db9b38f6sm3249826jan.66.2024.03.27.05.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 05:56:21 -0700 (PDT)
Message-ID: <b929afe5-c148-499a-906d-fcf208b02fcc@sifive.com>
Date: Wed, 27 Mar 2024 07:56:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9-rc1 regression: irq: no irq domain found for
 interrupt-controller@c000000
To: Andreas Schwab <schwab@suse.de>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <mvmplvfg90v.fsf@suse.de>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <mvmplvfg90v.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andreas,

On 2024-03-27 7:21 AM, Andreas Schwab wrote:
> The SiFive ccache driver fails to look up its irqs:
> 
> [    0.762329] irq: no irq domain found for interrupt-controller@c000000 !
> [    0.769358] CCACHE: Could not request IRQ 0
> 
> This is fatal for the JH7100 based boards, since they depend on it for
> their DMA noncoherence.

I have posted a fix at
https://lore.kernel.org/linux-riscv/20240327054537.424980-1-samuel.holland@sifive.com/

Regards,
Samuel


