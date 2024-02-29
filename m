Return-Path: <linux-kernel+bounces-86271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53886C326
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D811F23983
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B550271;
	Thu, 29 Feb 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cHDNc0b6"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154EF4DA0C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194145; cv=none; b=NhoZffNqEmhUkFH2WTWYgFusMya7Y2fM1FRAW+GC0zwJQpbA48TspKATUgiunhNO5vTXeTRRGuo6zIgbNGfZ8/L3AyFrWke5Jx8y6OP9IfRP5crZcWzqHTG3pDOFbxDtOLO8eEzz9Oym2zZ2u/bcJ2dJkunuY9SEX6D88u5tQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194145; c=relaxed/simple;
	bh=kurHTtq2rspvJgMv43M46KVUb0L5q+U22TYTVcEIAOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbu3vfXOZQnk4vgnXMgUq+7wEy5EjRfqTZIJBp1LRUu2/3U25Z5OiCzDrVr48WZEFqj0RMnaGCa7f5w4PoMTXQegbWVU+iVOJYmBnEujADHi8hxzD90sVfKCi33HNypJbMg9m8/IJkzQ+XJociuZqeDimYewCSe87v6380Cr6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cHDNc0b6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d220e39907so7457291fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709194141; x=1709798941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6fUyesk9XtuEUwAKGfVFcYKYn8nCxiz5t4vTL0pI4o=;
        b=cHDNc0b6X2W23utcpiCwLBIqvSth4LUen5f9nw77arxlFGQBjpPQ5ivkrduHmTigXF
         cHLxCZtjh8n/2QvtIUVLmTsVgIUdIt5ljDko64YcwP4X3K9XOBnOta4REycdFwlusVHi
         mvSy0SjFToBz6RdCd+hMdpF1ZNjT7AjmlbMBL2iL6EpnYwaOKPC6ZSbKqdsPZJX2xtUo
         JDKrdRW0F6jENZJ/9SD/Akvxlb1acvsVNIMSepB6ynsCV8kQaxpC7PWu+mdG4qutEixq
         rZNfYdJbs2ZQrB23pZWW13wD1Sim9ceJBxZZFkDhyfzMBPNi6TJpDUVJOAVaOuEQTjI3
         4/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194141; x=1709798941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6fUyesk9XtuEUwAKGfVFcYKYn8nCxiz5t4vTL0pI4o=;
        b=WxRwjIRQD0nWM1QA9PMdhCuZ3xUfjJaiht+7ziNH/newI47AIUoMAX941oJdZ/fb8A
         x7CfixvPfdorQYrHm6QizMMzGS2xtfsqYVZtR6ZFmH57wWuRl7yXUw6/lAvzFnFBSTgv
         JnX+f9pohmRB5th5qAkjilg6LTca53NNXsqALPhPDDBVtCFKIAeM31dNuECc5u3hmSS6
         ZTNtNPcVXspngUS2/BqutApaXfgsRmUlePPaEhnhWTxUqb468NIdA6tLaZKpLrd4Eq1J
         VzFudluTJzqgDDRiF0XybLowlN4MiBoCQwu26MxM0p7MB2F/9JGA6P5/6WOqd/X0YabB
         06ig==
X-Forwarded-Encrypted: i=1; AJvYcCXLOWPT9IwC5OzdFFFKuKc8BU+ggaM+n8kSiFih5u41uh3JCyHdDXP0vxXLsGvVXVWTgYdKu4y08HNcGrEukpfk4pIE+z2GO2qZcHu8
X-Gm-Message-State: AOJu0YxFv3BihZ6q4CBR5oA572xUDQ9EJ7UM3UaCf5znyT4qFob+URll
	IkJFZvASNtDoirgsx8cr2P6u/6oB6aoETQ9y2RUssGeYTbO+RkFBbZ4YRaf3zOI=
X-Google-Smtp-Source: AGHT+IEioEBenaGBregM2gF1RR+HQbJWqUnI/Hp2B6pwGbY54Du2S+X2nxQx2LKNChi6zePmii8/pQ==
X-Received: by 2002:a2e:bc1f:0:b0:2d2:8290:46ff with SMTP id b31-20020a2ebc1f000000b002d2829046ffmr971230ljf.50.1709194141302;
        Thu, 29 Feb 2024 00:09:01 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id jn3-20020a05600c6b0300b004128e903b2csm4375201wmb.39.2024.02.29.00.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:09:01 -0800 (PST)
Message-ID: <9263b77e-9ebe-4987-bf7f-8f9fafcf06b3@suse.com>
Date: Thu, 29 Feb 2024 09:08:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with
 device not attached.
To: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
 Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
Cc: WeitaoWang@zhaoxin.com, stable@vger.kernel.org
References: <20240228111521.3864-1-WeitaoWang-oc@zhaoxin.com>
 <e8c4e8a3-bfc3-463f-afce-b9f600b588b2@suse.com>
 <07e80d55-d766-1781-ffc9-fab9ddcd33e3@zhaoxin.com>
 <49a365a7-199a-42cd-b8d3-86d72fe5bca6@suse.com>
 <0b0eefa5-71b6-dc08-d103-72b9aebd9237@zhaoxin.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <0b0eefa5-71b6-dc08-d103-72b9aebd9237@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.02.24 12:19, WeitaoWang-oc@zhaoxin.com wrote:

> When alloc urb fail in the same function uas_submit_urbs,
> whether we should replace SCSI_MLQUEUE_DEVICE_BUSY with generic
> error code -ENOMEM? Such like this:
> 
> @@ -572,7 +571,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
>           cmdinfo->data_in_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
>                               cmnd, DMA_FROM_DEVICE);
>           if (!cmdinfo->data_in_urb)
> -            return SCSI_MLQUEUE_DEVICE_BUSY;
> +            return -ENOMEM;
>           cmdinfo->state &= ~ALLOC_DATA_IN_URB;
>       }

Hi,

yes, and then you translate in one central place for the SCSI layer
into DID_ERROR or DID_NO_CONNECT.

	Regards
		Oliver


