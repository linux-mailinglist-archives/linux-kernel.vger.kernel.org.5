Return-Path: <linux-kernel+bounces-111034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0288672A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CE91F23A42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308210A3B;
	Fri, 22 Mar 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MG9nFrld"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2E10A17
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090394; cv=none; b=nhUA+/ASWd9PdM73ZPRQbEg1512MT71EK7/HJleMAGQ+X85pZx0Avowau1v6OYy/I+u/E1s+WwNHlW6D52Neg+sMhmIq6HwQvypK5HEr/CNFELfK+F4+2VAbqHvxNpbxpDArtTQzQNMQR59LdHPGxFUhRyHMZ4O/gWyeVf1Fn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090394; c=relaxed/simple;
	bh=TE/0hmyWh1Qw3fzYdhGjheA+rIirx+o8SmFEoJfqJEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8oocW9QxEzbPLYjpk7tZ6dBSZr31YDkTtY1bOlLrafJ6sBichIva5EX7Rga9GcIDZbi+17IQGmPT6uy+mo+NGywwWpuhQncH97z2+d0M1jYXXvMV0pIXmBtK5gDupy6GvFLGKe3nOz3D0kJpLz86BaZ+/HTWuULD9AbO0PSfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MG9nFrld; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4733ac2109so22295966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711090390; x=1711695190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqvOkYG7PGR/60T9a+vecv0YvaykQSrN8+SAoBmbKLY=;
        b=MG9nFrldGmo8g5SLiIre5Hf2u8db2QJ0lz5Gp2WXL0po1/gFtjkm8bAU7B0gZF/0Si
         dDHrnbuQLZfBBncbLRz52WRUm7O4hy+MSLs5xjxZD/tCBC2wiXM+4Xc3hchBFXo80EUC
         ZhBSt6lrcz6ZU0ltVdD7yEKRUWwDb+a7iEaqylXf/gwLd0xfMq3oYAMf95tB3XrjxxQw
         5IyAMNBupfuKucMviYXxSyEpC85JtLTrafHKzz7tzBUWnNeBUcY374mZhjz0+eeyRBFT
         r+Hl5/ouacjOJOBrkqPU1bjGqwF4y2kbl3nRGZ9khDrLxS7Y8D2+wLu1parvdoiVW7ET
         TFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090390; x=1711695190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqvOkYG7PGR/60T9a+vecv0YvaykQSrN8+SAoBmbKLY=;
        b=vf8t44I2LwXmwGaTczO6oqziHuQG6RwNyBHDvctsTgaqQyj9oMC+g5zghPgK3T4KHU
         5pJB5UMATBbom9ubXWA+GhSjhb2qnGRa5MtO0pBt9Aa4Hy7HZYwe4Yi472m6fyLdNSLe
         Q/34uK43XhQ/ETKCBhmVK68akWU1FaYKNetkvoFTn4uoOiLHO6SOg0Z3yK5mAF2y5cOa
         IBS7+TqZNUzYHsmYVEY2okR2v87yH37QT8wWBZfjV4eJvcdGc/gc7P4bGEca9/JMI8qF
         121T4yeA3i+IYTUFRKueWrbI+wzr67hx+xYaJdF25dlT+4jAIrmDmt+Rp9E5ChITgdW+
         3Nzw==
X-Forwarded-Encrypted: i=1; AJvYcCWhF/XVdPJFFgNVuVnnVNd0J3bzPIMQJ/9ya9aUWoUuMNlIxXM2d+lmC8zUlAn4Ie/2LBd6RY29NYgBsw6UIJn8kYghQTJfQdseedM4
X-Gm-Message-State: AOJu0Yz+HHlsoGzVJHeioFIHkWCRGz8Ux3Qs0kbRqUZzoIypmVxk9AbL
	g225Wm2JsJIFmMBb3UP2N/3z5n/MM2aH4z0wWav46Ngx/TrELm9hE+Pa8JKDE30=
X-Google-Smtp-Source: AGHT+IFlkBu7bgRCcPm1ksy6ar+oWKKLT0QxCo9cXoRVYuAvIvMat/Nwchd03Pt+Yo+xx4szyR3oHw==
X-Received: by 2002:a17:907:940f:b0:a46:75d3:dd46 with SMTP id dk15-20020a170907940f00b00a4675d3dd46mr1107120ejc.17.1711090390380;
        Thu, 21 Mar 2024 23:53:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709060f4a00b00a472c4b9486sm460730ejj.84.2024.03.21.23.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:53:10 -0700 (PDT)
Message-ID: <51389495-4b99-430b-9ae8-7f938af34bec@suse.com>
Date: Fri, 22 Mar 2024 07:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/x86: Remove duplicate include
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240322063957.94159-1-jiapeng.chong@linux.alibaba.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240322063957.94159-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.03.24 07:39, Jiapeng Chong wrote:
> ./arch/x86/xen/enlighten.c: linux/memblock.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8610
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


