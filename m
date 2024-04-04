Return-Path: <linux-kernel+bounces-131934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE7898DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDA928C24E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42525130AC4;
	Thu,  4 Apr 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAUlmAAA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192E1C6A7;
	Thu,  4 Apr 2024 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254018; cv=none; b=i6bLlBYjCawO37XvqIA6molv2GF7IB9vYX386iEMQwTSs1z7yv/JhF/j+6+6lwaIRpbn343IgFgjaCxmKRHjmHN123QGp86k+U5fBrJrLHKPZ61MGOK3ZFwhTFVkEllLMsoDqZnVsEFxvEumYFOafOVvk/eHZvYe/6u6l/SM4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254018; c=relaxed/simple;
	bh=zusms/ybvY0EBsrA7FDocXGlfT3sH3wDhrIWLT6+ny4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BOytSfa1gCIt8v/LN5OlGqsv9qjTbbkazkh3EB31WiIgh16gMpL/BMxwCILGt/QCRtYY9O5IDrnw7ceZMp4lSlo6Y7bdSoUIRtFYgp3vyPXncAPwwJjHMfzdcYyMVk9nzzAfNuz5u3ngSzvOKGUNiA8rvy1+SJQq+RWVVbC6ejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAUlmAAA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4162bac95d4so5215375e9.2;
        Thu, 04 Apr 2024 11:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712254015; x=1712858815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy7kg47oLg/+gMxBxUBvkrC3zJR95ziHDFd4yzE48Pk=;
        b=CAUlmAAAxV+OFTV//11EZwwmumer5t80MSRsvz2wt4D/nqR/xcDHIr5YmYSSEKJJeU
         RkfbFnQ6MsfT7ulNlK1RXmi2IXZUBQQRdlSj9xx7HBbyu0d7hHJ5FhkXymkw1/TjZEFr
         5duzALoqQq+/Z7HVR6Yq2UWvTVU54uQ8vyn9eRvH5aVtFze5XISUgGcUELAozno2LPHc
         CIU+NM04zglsqF0VJGFY0ry68/A9mwX5AAnhHu0uQm8DEsexVOeTP2qyNmW2Mc/SWuzY
         6UP4o/iSyY8Y2P4/Zp6uM1YCO1UjdctTcibSIOURTx001ZVh8GKPoHfkpajI36Nh0CNM
         ad2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254015; x=1712858815;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy7kg47oLg/+gMxBxUBvkrC3zJR95ziHDFd4yzE48Pk=;
        b=oY9WQjHSp0mDcIxESxmQ5gTDFXOD27nhGN0/haUd0CwrQGlLyNbhGkEAabpaI0tdl6
         0p+kih30EGnsMNr/dCTYOUABYzGNQf8uTqF2dCKHKmHNXJ8nvHx47xcsq5uKQXsgqNwE
         IZAhxhP1tSS1H/ayZqG2B87LwnseDS0oywn21pQ/oYQiAuHbP7J2y4uVGX97b161Huqx
         Qii9PxNRQwGvzlV8l700c6dN2m7mYyhce5wcEwEzVxvfg9Jx0czB5boJJpBR/qS3doGr
         T3IaBqVBeI+qWFcxb2p9yLBAErdQEvzs7lsTSCX5WQ/tLOKtFMSuyqHxNuDmRvSNybHJ
         QFCw==
X-Forwarded-Encrypted: i=1; AJvYcCX1sbo4MN5JzUafvnjEdBbDTnrxvErbeZb3cOBcoz35M44bwimGYRvQzg9AAfuVkIkhsQ/bJRY+OqRyRHdnsE1RVxaH3ivhnmEGprmItCDNKadiH1sWoSnZ82qrVjUFFozz1P0B
X-Gm-Message-State: AOJu0YzHUEZXz8MYbCMerEovyOQXvaWwiyPShSRZtKXcQ98wZjrrQAYC
	9/cfv/k14CLsxXWVt7DrthY++7fL52Kl+zO28gviKMaza7vPuz/A
X-Google-Smtp-Source: AGHT+IFuj2PFJNPDI0+yYN3g/kkN7zAmtKbcZzLJJ9MVWLdK0xcF6De3NCFwWSgcSN+nApFENyekRw==
X-Received: by 2002:a05:600c:5755:b0:414:c42:e114 with SMTP id jw21-20020a05600c575500b004140c42e114mr2269751wmb.39.1712254015080;
        Thu, 04 Apr 2024 11:06:55 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b004154399fbd9sm3540550wmq.45.2024.04.04.11.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:06:54 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org> <20240404122338.GI1723999@nvidia.com>
 <20240404074850.19ecd52e@kernel.org> <20240404174728.GL1723999@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d0b11055-1804-515b-7916-cb83a6274955@gmail.com>
Date: Thu, 4 Apr 2024 19:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404174728.GL1723999@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

#include <disclaimer.h>

On 04/04/2024 18:47, Jason Gunthorpe wrote:
> The configurables exist as they are
> and need to be supported, in one way or another, by the kernel.

Why?  What does the kernel get out of it?

Maybe *you* need them to be supported, but maybe you should have
 thought of that earlier in the design process.  ("A failure on
 your part to foresee the eminently foreseeable does not
 constitute an emergency on mine.")
If we let folks bypass our standards with a _fait accompli_, we
 don't really have standards in the first place.

