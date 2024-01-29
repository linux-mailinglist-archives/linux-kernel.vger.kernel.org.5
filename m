Return-Path: <linux-kernel+bounces-43449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4708841400
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73511C24547
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095176056;
	Mon, 29 Jan 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffjbCkpu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FEF76043
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558668; cv=none; b=QTd1G/nsN+ydBuDKZ+hmwCdXnLyG75gDcNoS54O/NnPXpAmGb+29/hXPnHRvJrv4jgMM2dHSBfI1M5psOoZ9Cp0JzhXeFmrcps6MXCNJEF2y0wgSweOfdh+Gj8/f/SWq2iLqIBV6YNpNWRNz36j/F/Q4+yflsRJN7ZRlY4k2OFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558668; c=relaxed/simple;
	bh=CtI04kLJuk4+Mb+RGkKqdEQPLMzOvfYosi1DAHpmDKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxbm1xnEMQ8SzZj6pggWVWnq2FHUkQeVKX7ny2/XYTazbuIsdE0usjvV1MmZj3qYqeulJgB54VPUtpSsAnUpVAnjuv471RXBvuyUj/torFoeTh6WVdjGp9okZKSA8X0Ul05mJuQ7/lgzdvGbEdYjj4C0M9eoP0V3yaPekwC1Ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffjbCkpu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so1314314a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706558665; x=1707163465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=745A/9K2hSfoUx6RdWw0k38aK7Py4rNMCIysWo7mEXk=;
        b=ffjbCkpudwc1maV0nrJbHN3FIuTD4ukcPtIJQ5yxi05Sm2Q3n2LtRZUC7LNKyC7ZKD
         fO0VcRC0D0uDn4v8KI7fk6PLLSJUdih+XZ1acEh0sFWIPTbP/dgfaZBz/6Z1t8QgsdJx
         EXFpECqKN8YyuPbPoeWOnHm2KG7c8NX9uY67xxEQRwJVPJP48Jbz1wVbIolU50AGgx/9
         no/do4LBiWq41TD++G+mdGPCX1TwXDIvB02QMdwNjsDiH9OtsUynFiUdqJwB6j3IQbks
         GRdZe4BaYE11+7LeuNJ6KYCQ8ptM9GwYcIBP2YE6PHhgcc4NuI8f8FFH1fvqTzNvvTpc
         8+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558665; x=1707163465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=745A/9K2hSfoUx6RdWw0k38aK7Py4rNMCIysWo7mEXk=;
        b=FS8ZdFqBmV55XSpX763tppvglNkH1cV8exmWd5bNwRoWkjXXb20wJhrwMuphnpDz3i
         SlGgSBr2WWqRTPGcrTLZFs7swIUF+g9MBfVxC9U6/0nYU3dz8YrrolRUBXHYPpccv++Q
         hJWSLDPBm7WvZ2vcqmGtV0c02/yBv52cgd7N9AGVWmwphOvEpuLsiIJvmJOAdMnz++Al
         BieBoea9b4C8dFFl7IbeAvI4bSQQ0K1P/0/NcSbZFCNoDryo8Zg7Joj4SKN8qev6084s
         0ILhArwxV5VZ9GidBKKSpgDl1FEKgPLiAJ9vurf+PPljqHwoLI0XEkZo134HYbXwzht/
         LTSQ==
X-Gm-Message-State: AOJu0YxKh4LYev/suCv5EXdotYEgTCBW3X/Ns4y3y1Du2A/MOLH0meQ3
	/ssBXfEP95ApQExssW0KafjE3gB98k0Ka73BR3Obh8FYv2i9wQWD
X-Google-Smtp-Source: AGHT+IGruWOGvOeNgK1MI6oeKyd4AvOTOfNm3xyNHwJeVE1viMN8nttgbNoy7cZZz1Hf/kmgmLmyYg==
X-Received: by 2002:aa7:c14a:0:b0:55f:487:201e with SMTP id r10-20020aa7c14a000000b0055f0487201emr2132229edp.4.1706558664994;
        Mon, 29 Jan 2024 12:04:24 -0800 (PST)
Received: from [192.168.0.101] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id er7-20020a056402448700b0055edfb81384sm2189935edb.60.2024.01.29.12.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:04:24 -0800 (PST)
Message-ID: <3e67441a-aafa-403e-b332-c58c5fa75e30@gmail.com>
Date: Mon, 29 Jan 2024 21:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Staging: rtl8723bs: checkpatch fixes for rtw_mlme.c
Content-Language: en-US
To: Meir Elisha <meir6264@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
 Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240129141856.416532-1-meir6264@Gmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240129141856.416532-1-meir6264@Gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 15:18, Meir Elisha wrote:
> Checkpatch fix series for rtw_mlme.c
> 
> Meir Elisha (4):
>    Staging: rtl8723bs: Remove unnecessary braces
>    Staging: rtl8723bs: Remove extra spaces
>    Staging: rtl8723bs: Fix block comments warning
>    Staging: rtl8723bs: fix else after break warning
> 
>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 241 ++++++++++------------
>   1 file changed, 114 insertions(+), 127 deletions(-)
> 

Hi,

please also fix:

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Meir Elisha 
<meir6264@gmail.com>' != 'Signed-off-by: Meir Elisha <meir6264@Gmail.com>'


In Patch 4/4
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)

Please issue a V2 with changelog.

Thanks

Bye Philipp

