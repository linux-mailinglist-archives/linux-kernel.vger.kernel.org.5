Return-Path: <linux-kernel+bounces-144890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4288A4C35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DAB23A03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90557863;
	Mon, 15 Apr 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TUefnbEi"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD424A990
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175669; cv=none; b=TA6EaCy9qqpC/4XA/4x79hals/dcL0pM7MrKEcpyNblnWZbbS/zzemvrmI3dR3Fh61KLQWjyFY+GZ1lfg9I/C1w7Zu1aPT3VS/5lvcxb2bUszBGuGpVMoMY0FcU9a2bLxUpFVz/JYLSJJa5LXhCXHh9IAPd/7VC3dzIq0OnLCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175669; c=relaxed/simple;
	bh=id75fa+tTn/RJ7CUFo2GkCpLq+g1xjJIztsBFlF4Vho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3Ei60v9p+eH28f73sc0EvB4DxHGaPrUeL7b6Y0ja3aIXpMaoYbba6gBQw5IoicqYYMJYEWNo5KUFOWc7Sa3TG+0sY8hX/gmu9VzOHScKy1jjgmMUtN2uBviVistT0DbPoCc0XqLxpqUCrqucAAmqDNfXgdYwIrELgwMHE7ksRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TUefnbEi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2da01cb187cso54268291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713175665; x=1713780465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3p5b6rT+mGLgou+/VagUR7xOBuj29Jc3WH/R/sXbro=;
        b=TUefnbEinIJG07DakKNOlRJ8ImVJJqwkk/qAareUy8u+ynWunKawgFahzHtfu4+UBn
         4lBbncYENVyiQAS+eF9O6aGjQIYFYW4dSmvNf0e7mpKjVsDYMVCC4jGOFjEhDk1VY8UH
         D/5D52jhjO3oJG2WEwFliz3vDBZqf4wSt+K8REfJhWK1WVB0i7D8Km4NFR9BtoKi0SZQ
         849BDPG4ky+RBAPj0vJaefR96RJnc+PE7x41zSSQ8Bocb7p+eEvAXLgI1BOcifUf1Pph
         25PYuh8jsnYLne51qzDrKjw8KpJTIacRLiamqp5vT6L4WvVYwU14J5VPRT3MDhTsHaIH
         CO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175665; x=1713780465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3p5b6rT+mGLgou+/VagUR7xOBuj29Jc3WH/R/sXbro=;
        b=gdSE/S7cpQprAPM7TWHA09hGGZJfW4jeXLgWShRL/YKcLrcwi/mQAIlQNrKlz7s9Gz
         BMBrZLyzQWuOHMxyLLFlSQ29f3aJzlmAOU9t8B1W9ugs1pnlsRx74NBJ5eseJyGMuxRH
         MiKKP6Ao9Z3k/g7JaHZ6gWsW21yiUHUtr3tNYiwE6rCgmzhSHyfSg5bkgf8Jc5CVBT1e
         T02BeCORa1G69HV9CMoL5Ru4BqgHamNPq7Bse6s1Y75AD3OonaRFdDE1E0a15+Hcvaa0
         GIhlmYXj/Vijy/SnfRWZy01EJ0cbv/SV+jlTb6Mh0ChSwSbwwQbHNsNfaBlSXK3Mvic8
         Pw2A==
X-Forwarded-Encrypted: i=1; AJvYcCVu0YNkiQRbBi7PY9mh2j+SfqS8mUbNkP8EZ0MFCqlmVHkdPyL0a7NxiFk+9biTqzTqiY1QB+1AYhNfcHNAVYgtV3NBID2KuPMjV6ZP
X-Gm-Message-State: AOJu0Yxo2+3+qxkCQdL1+zzJdrHt5V1Ay8SXpLEKyBleopybU1UXQSlO
	ngISHKjoEVNaRyYIl1wo0Qskg3HomcfyyFB9XoaZjWOMzfEavKmsf8DmLNmjoEc=
X-Google-Smtp-Source: AGHT+IHIwDEdFesD8NI1TbzY5+XQB0v/7ooFBQFQbz3Lv+vCUJ8oHsIM3AgRfyDUgf6ESvutnbVJkQ==
X-Received: by 2002:a05:651c:14b:b0:2d8:3ccc:60e8 with SMTP id c11-20020a05651c014b00b002d83ccc60e8mr7330991ljd.48.1713175665487;
        Mon, 15 Apr 2024 03:07:45 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id cr12-20020a05600004ec00b00341ce80ea66sm11704722wrb.82.2024.04.15.03.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 03:07:45 -0700 (PDT)
Message-ID: <374782d3-ad38-4583-b598-0d6c3671151d@suse.com>
Date: Mon, 15 Apr 2024 12:07:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
To: Greg KH <gregkh@linuxfoundation.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
Cc: Oliver Neukum <oneukum@suse.com>,
 Aleksander Morgado <aleksandermj@chromium.org>, linux-usb@vger.kernel.org,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, ejcaruso@chromium.org
References: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
 <87mspvi0lk.fsf@miraculix.mork.no>
 <a6ad34d3-9cce-4178-8271-0e09ced2b6f4@suse.com>
 <878r1fht93.fsf@miraculix.mork.no> <2024041536-simile-flatly-824a@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2024041536-simile-flatly-824a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.04.24 11:52, Greg KH wrote:
> On Mon, Apr 15, 2024 at 11:26:00AM +0200, Bjørn Mork wrote:

>> Nothing more than the obvious;  Get one of those modems and do some
>> usbmon snooping.
> 
> So for now, should we just revert this problem commit?

Yes. A regression is a regression. Please revert.

	Regards
		Oliver

		

