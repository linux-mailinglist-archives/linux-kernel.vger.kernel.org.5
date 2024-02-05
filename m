Return-Path: <linux-kernel+bounces-52744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCB849C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25031C23E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3882110E;
	Mon,  5 Feb 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i1IUhQE1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7A20DF6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140869; cv=none; b=G9CQxgwi32bfGUmhqSF9GWrNFWRKpPVcBE5vtri8SzWYZBAsWqHAEnxdIr7a75/bk4uXcV7cAlOdAvLjJLWpYYQ6FrO5s444IgUlTSRFPqTZdv0yOyWdeDqtXILvre2odSJFpOjMNHIEwqkXQhGl2lSUpsPQn3wgcYsFd47SE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140869; c=relaxed/simple;
	bh=wAGEOr0Mgn087CWWTknJfcnHdO3bj7kGa/hpbNTQVx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c/b0Uuk03FvdqC1deayI4I7DGwCvIjc20z+gaCj54YrHVDYl7YyY8ouWRZ9vOIFJlnNqTmbrvDyJfa0YeXep7FY2CVhMc/F6KdzdrYOMz2RMiVq/3hRnM9eeZuRvyhG3+cf6HubxTOAcFMowNIDvyaj2a2AszOi4YtonLeotZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i1IUhQE1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so27300215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707140865; x=1707745665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ck/8F3HKoSyZuhnppSqI+RZPs/hn8y64a8KNHoXfCTc=;
        b=i1IUhQE10qXnSXabNIZdADCa4g4G+ds7iM64qSNbg0apcbqvQGBKO9x5JQRnQc1rQx
         WZDiyL/+zdMmyZ54tHYjpHDsGIt+453neGsas+bN4FPXd6pGAmGSmIykJLx9HoY9kPB1
         fuawgXIcw7SKe0qVaheBALwxYX1rhmnsTZQjZAtZRGz3Zsvfb7f4o+dXHogE46FAIa8K
         nXysDjZxpGDxhpm/Np65CSjr0b/EEcFHCUXXkmQee4agkIn2EwwpJcmCZOFV8eqk1sp1
         7KZdPETJAefuSpwlDtPV4frE+A8+KHU2fICZoWYGvo+weyXoW7hcUhsRBgkDKi9Q9XgW
         yhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140865; x=1707745665;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck/8F3HKoSyZuhnppSqI+RZPs/hn8y64a8KNHoXfCTc=;
        b=i+zPKlF+K7I80RzE2q6E5qQ9YtxVzllsTDSX5q37ZwX21QoVSou0D93PZ1gsFN+vvQ
         +2SjSABYlZWgigYoUhwPSSGiOAvQPNbBnAfqOsLoqA7+CsmnAZZPiIhDQ4vuleXLlwe6
         qYH6pTqHIdzmUVDl2aukL01CxYGFWTOJnQrF9Afp0Ew+4djX5xeFHRTfkFpaMIaUvcLM
         qD0nLGh4YEU41rlDWgPcCA115PFziK2tHKl80wDrwX0CZrB0Rr4TzZSuJ3I8giEmPyfe
         SioyQF5Ifef3CPW43zT6TIZHz5l9uLTk3LTNC1XWrD3+En7fqavLQPVPn0KPKRnQqpqH
         GQTA==
X-Gm-Message-State: AOJu0YxO7n24JcYwbD1j75J+SKxpHzQ7P6Z1NV1yHIGSND4QHjezifbK
	hJ2xYPOZua1PKcqGaS2Z25SmLBYVYUN5D0pN3VTrqJYhv/5HfmsIIcRh34aps0U=
X-Google-Smtp-Source: AGHT+IF6/KewvaAkJ1Q8SfAC8adm8Mx0ayCEucOwh3EBJrclsw6tXwWO29eUTSHSDBLgVjbcE88VKA==
X-Received: by 2002:a05:600c:1c19:b0:40f:d3e4:8f85 with SMTP id j25-20020a05600c1c1900b0040fd3e48f85mr4138702wms.30.1707140865429;
        Mon, 05 Feb 2024 05:47:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXXJpGJ3MgADo1Aa30ZfzwcGKeWnLLpFgq6o7a7E/Fmflk3MISyH7x5S9dhYyu9XPAgFVF+A6QW44UVNUpdJ3Z2hgM7MMnkobzq/3+3BhVBAAIv9AIslBuMGFDgIyliboDZBM8kDbLoxw8WHWt4lZvB1JEMAqKKJkGHgNO593rCZx01wm0SOmOKW+K3c00Ovbzh3dQZ/n3jrd6BII+1EQjS/oN7Az9z3MHZ2QWJPbfSV6BpK2rVUoVOVkAWSU6Myzj9mKSiQRPuUuWo1LUcaAiFB9i7x69h5ZqKkjQFdDrQWyUaVwSnQpRDtRhCdZb63k1MjvN1YX7xBokY/pjfC+aZLIUCtKDu/1b77igqVgU5lPe4e1LIJFDMGKZ7EVpTH8CL6GacQ5vgYOhSDT6XokuDGhsemRDdkE4xGwOahFQQSQ==
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id bd27-20020a05600c1f1b00b0040fd0f7d267sm7368807wmb.44.2024.02.05.05.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 05:47:45 -0800 (PST)
Message-ID: <237bd5c8-184d-4e46-ba66-253e3ef0c895@tuxon.dev>
Date: Mon, 5 Feb 2024 15:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Fix change point of data handling
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, ulf.hansson@linaro.org,
 yoshihiro.shimoda.uh@renesas.com, masaharu.hayakawa.ry@renesas.com,
 takeshi.saito.xv@renesas.com, linux-mmc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>
 <ZcDdn2AVz8FIXzak@shikoro>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZcDdn2AVz8FIXzak@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 05.02.2024 15:07, Wolfram Sang wrote:
> Hi Claudiu,
> 
> thanks for the updated version!
> 
>> To comply with this, the patch checks if this mismatch is present and
>> updates the priv->smpcmp mask only if it is not. Previous code checked if
>> the value of SMPCMP register was zero. However, on RZ/G3S, this leads to
>> failues as it may happen, e.g., the following:
>> CMPNGU=0x0e, CMPNGD=0x0e, SMPCMP=0x000e000e.
> 
> Can you add the current TAP number (variable 'i') to this printout?

This is a snapshot I have saved from my previous debugging session (but I
tried here to check the values of cmpngd, cmpngu):

i=0, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=1, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=2, cmpngu=0000000e, cmpngd=0000000e, smpcmp=000e000e
i=3, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=4, cmpngu=00000000, cmpngd=00000002, smpcmp=00000002
i=5, cmpngu=00000000, cmpngd=000000ff, smpcmp=000001ff
i=6, cmpngu=000000ff, cmpngd=00000000, smpcmp=01ff0000
i=7, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=8, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=9, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=10, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=11, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=12, cmpngu=00000000, cmpngd=00000002, smpcmp=00000002
i=13, cmpngu=00000000, cmpngd=000000ff, smpcmp=000001ff
i=14, cmpngu=000000ff, cmpngd=00000000, smpcmp=01ff0000
i=15, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000

This is printed in this for loop:
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/renesas_sdhi_core.c#L700

> According to my understanding, we should only mark this TAP good if it
> is in the range 5-7. I need to double check with Renesas, though.

OK, my understanding is that it should be in the middle (beginning being
the tap that triggered change point of the input data, end being the next
tap with the same ID). This is what I understand from this: "As the width
of the input data is 1 (UI), select TAP6 or TAP7 which is

*the median* of next TAP3 from TAP3."

> 
>> Along with it, as mmc_send_tuning() may return with error even before the
>> MMC command reach the controller (and because at that point cmd_error = 0),
>> the update of priv->smpcmp mask has been done only if the return value of
>> mmc_send_tuning(mmc, opcode, &cmd_error) is 0 (success).
> 
> This is a needed change, for sure.
> 
>> This change has been checked on the devices with the following DTSes by
>> doing 100 consecutive boots and checking for the tuning failure message:
> 
> Boot failure is one test. Read/write tests should be another, I think.

OK, I'll try also read/write. Do you have in mind something particular?

> Because if we select a bad TAP, bad things might happen later. To reduce
> the amount of testing, read/write testing could only be triggered if the
> new code path was excecuted?

I'm not sure how to trigger that (or maybe I haven't understood your
statement...)

Thank you,
Claudiu Beznea

> 
> Happy hacking,
> 
>    Wolfram
> 

