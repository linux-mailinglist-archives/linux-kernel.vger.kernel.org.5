Return-Path: <linux-kernel+bounces-66563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D1855E57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E32E280D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12551802A;
	Thu, 15 Feb 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OIVuXf7L"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258671754B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989841; cv=none; b=MjWGTxoAZ5go9qW8Jka/1Gqrr0sup/PaCjArJfhealpg55XJHxIsLnSa1PZoECcXjVovPzvnglF865U3j4NAA7VqddFGLZufGf6bcgE+MjvqQk6YXZBF/0fNu0hP4cGYRhfQfJBBsry+R091HkRjMQCfp+9pST2XWrs1aXdLmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989841; c=relaxed/simple;
	bh=Xvdta8H07qjeWe6JNeSDdGXR9ZFWRP14rZI9S+E8iUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LEe0qkWm1xyPA+RJY7FnGKpSs94ZKYDzmSkA11reMrL4q978xoKHihOvD7V3IrBl2hhxD8epokcdEfSlprLouSr50c+nsn9oEBqc2BwcLkyj/uCgeX7Ag6CdRGLSPSJE0UZ4olLfHAiQosQuxouzqisGrQpfOMjlRJWK/Equro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OIVuXf7L; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d09cf00214so8507891fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707989837; x=1708594637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G++Q//UTKWBjyGn3NpAbaYl4jCEX4Qya2uPC/VP/bV8=;
        b=OIVuXf7LmyhcaFqL73L3D0qiSvI1oiHil11WPvstGfbwN5Ckk8jQhhS6V1cy/5XXIt
         CtAePAg4AFWBlzlPQFISQn7c9BuXRRVaCu0/kjCM7m7Bg8J7n0CUtKp+ZLMOKctfluJ0
         G0BOSU1UKiVTRkDsUw/rBhvLTIYiiSlbOoAP8AxEp0hD7fGCSfE29L0RK8jDrPwn6V1a
         XeVN+SWlpD30y7Q8MBwsD6GZlyLTIZf/hJRwE7VdSxHMfVo324KRJasUgZCNhCoqskla
         CuR6zMcn92iSZrN3WsAxwrsll741PW/ewpmtNuh0s7WnMQtmuXN+F5gbx+HtwnjgWsB3
         PJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989837; x=1708594637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G++Q//UTKWBjyGn3NpAbaYl4jCEX4Qya2uPC/VP/bV8=;
        b=c804ft1LKShkqAnZcX0O/dgoUpzblfufIPwLmTJMLQ86nD0EHyLtcNgH97LzXntrE3
         ixMB4obLVzj08UDvqtfqX5m1rejCMf8UkIOfeDz0Uf/3FZAdBf71GRvIRQJOxP0kIaAr
         fzguZwPDXBWKe1s/FYmIpKlTVn9itgumdlucXpK4+QOI4TrKLltl14Wf9wiZY3tJ9fFE
         j56a8KbK/mMWfl9xL/DJfaRXzlIb0SfGv1otyhFs5TZ97xNyOKGca++ZCEblssP23RDl
         ahU8wF2UPzPA0oog1YF9vC7ZInuCNbY8cZLoNirMv1R7A699ntvdq1DUuGiZEjdWyp66
         i0zg==
X-Forwarded-Encrypted: i=1; AJvYcCUVPpVGzdqH5zaKXsogNDRCg/MNLfc6CWdmB1qAfnwdBmR0lIgOkVi6hKv4SodckfXazaKeXib98LZ1kCVPKJsr8ATmd9TfUK4Z1+Sm
X-Gm-Message-State: AOJu0YwDptOhoYTp/7SMVfHhWA3ecO6tEqc0AcT5u1qWBjWCtmqFMF0p
	ElWAWKPrIjtUH6ZKkrV14ioqyFNiqRwi1AS7ddbAd+kvoz3dpUksyK3EoNlZWj0=
X-Google-Smtp-Source: AGHT+IH32l4NfBD+qboCs97erWXFSsqVtx/MGVcvJcLtl3DKbyT5liFC3zjMMfRlHX4MasSql3Uvdw==
X-Received: by 2002:a2e:86d1:0:b0:2d0:afc1:ffb2 with SMTP id n17-20020a2e86d1000000b002d0afc1ffb2mr893456ljj.21.1707989837217;
        Thu, 15 Feb 2024 01:37:17 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id w11-20020adfec4b000000b0033b7ce8b496sm1182058wrn.108.2024.02.15.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:37:17 -0800 (PST)
Message-ID: <d3d7b101-eb19-4169-94ce-25e6f969f035@suse.com>
Date: Thu, 15 Feb 2024 10:37:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug reporting on Raydium touchscreen
To: Vanja Pogacic <vanja@pogacic.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240215085953.Horde.oa0RoVvzrHmYsnVs_gHNkTT@cloud.pogacic.net>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240215085953.Horde.oa0RoVvzrHmYsnVs_gHNkTT@cloud.pogacic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 09:59, Vanja Pogacic wrote:
> Hello,
> I am trying to find the best way to submit a kernel bug for a raydium touchscreen driver (raydium_i2c_ts) which stops working after waking up from sleep.
> The hardware in question is a converted Chromebook (Acer Spin 512) with coreboot uefi bios.
> 
> You can find more details and logs about the issue here:
> bbs.archlinux.org/viewtopic.php
> 
> Since I observed the same behavior under Fedora, Ubuntu and Arch, I concluded it would be best to contact the upstream people :)
> 
> Any guidance will be highly appreciated.

Hi,

in your specific case I would suggest making a bug report on bugzilla.kernel.org
to collect your logs in one place. Then based on your logs, decide whether your issue is rather
input or power management and make a bug report to the appropriate list.

	HTH
		Oliver


