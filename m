Return-Path: <linux-kernel+bounces-86660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0FB86C886
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99BDB25315
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293E7CF2C;
	Thu, 29 Feb 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HGQMKhTm"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763977C0B4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207546; cv=none; b=tvCVxqkgXhRZxSIlRrXArs75nML6+ukH3GypI3npTzRqk+vNiCmsmNyzja3oyoel8K9BCebT8gXI/2c48MYcTob9bzylH9JtwKqEIIWMEJttdDNun8NHtqYDzcvKtXYhPnDlXaLRoLMYhFVhQOkqMjzO0Yg1fBaqJ8smR/xJMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207546; c=relaxed/simple;
	bh=7d6CvrWmzaz6TNCwdkf499bxCEdW1K7nR/01VhW1RJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k353H0bfJeoQhslqFO5UJtcMTexDQc1cqGtlHXwMjWtsyDc5g9auiYB2Kx9fEYcby24uUCBK5YSSzcg/QiCc8wq0ZBeniOrZFmoX4s0N4IBWCuXjqg9wDrgVNztHUyXPHtIzdxsN3ywTnh81C8QFjYkDfkiytd5vRS0PtE6OU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HGQMKhTm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27184197cso9112351fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709207542; x=1709812342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79gNBOsuDeIYR+Lh3gRA6KG8pNTkHwRoYAWTsnujzmg=;
        b=HGQMKhTmMZ63lzVoTzex9HePv1nw+L0kznKo07FxUoEhDn3SN21QGPemUEeRKCjkIk
         xq894Z/ER8zch3mA6RgqfFqqIUO73VhbknagdGEgOlQgzvBpiNBEuVTGtiGKVvOs1Iik
         mjHtAAISejZNbTTv7TBDPyeZv8Bji+gbG9+bmbSxRzOxDKBlbj9AtyetNR8jpToZgchq
         KTuOWQSjXxNRD4LyuLLjp7rq/rht4MmtvdLvw9t4ldZrkhwGy0GOjP9tUTlTahDmWARR
         hgPPZ7JF3xlveDxrewDZjAy1AhNYZfh44V6Y9CvTupghnqSVQa0fdKQWqBOPmru7/w6R
         69jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709207542; x=1709812342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79gNBOsuDeIYR+Lh3gRA6KG8pNTkHwRoYAWTsnujzmg=;
        b=GDOM0pEoqW73spQhyYO0blJnUxfAwC8VRITs+TcD+XibNgY+JrxmXH+D6zjOMgk6u3
         Tl/2PbxUgTC3TZ5eIpCw+6HrLVjTKOVU9rHgshD/B4ldwYQ+i6tKLRMsoqcRcrClY5O1
         maIVlFG4Q+jf+abfO0LxRtMqLyMGT07aiTwScBFF4MCHEZzCIahozs4VZcAilh4oloqT
         PXkMmRSJDlRCK/1xbdx21usEenD90WuDWFEz2/2QYu245URjPULJj9fpU9RGqY5vcdCP
         I9NRntn5DpThvlrdeEX8ppA8JrvLRVr0z5140fXKPs+XXIkY99qnqsPC8kkE0osoIXEV
         5Psg==
X-Forwarded-Encrypted: i=1; AJvYcCVBKl1fqs9W8G69mq9Ax/Vex1Mabn6GDJ/v0Fpra6YlDMWPjWI8LkPpuaocNm8qr6PTuR8TCAk42U/LxoNUJ+cBAqkoARRX9FR2CB2p
X-Gm-Message-State: AOJu0Yx6u27dsc9b7YT8+8+4kmd82AHg9Pc/EsGh1t50T7XQRR8UldBy
	kQFiEtqixMYVHroqHo/cdD8u7XllfNIVK7SgHCFiPrWnNQz2+iwHhT0SZI+adJ8=
X-Google-Smtp-Source: AGHT+IGhwPu+Q2oxJ6EL93Dq/uuQN0NQLhyZbY884uXBca6OJ0LijbNlZgjt3A3mOMZBdiCsTv8nRA==
X-Received: by 2002:a2e:9f46:0:b0:2d2:64ca:7a2d with SMTP id v6-20020a2e9f46000000b002d264ca7a2dmr1304324ljk.31.1709207542106;
        Thu, 29 Feb 2024 03:52:22 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id bj12-20020a0560001e0c00b0033db0bbc2ccsm1690355wrb.3.2024.02.29.03.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 03:52:21 -0800 (PST)
Message-ID: <7a48c332-acbe-4677-b189-9dda01151d18@suse.com>
Date: Thu, 29 Feb 2024 12:52:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] USB:UAS:return ENODEV when submit urbs fail with
 device not attached
Content-Language: en-US
To: Weitao Wang <WeitaoWang-oc@zhaoxin.com>, oneukum@suse.com,
 stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Cc: WeitaoWang@zhaoxin.com, stable@vger.kernel.org
References: <20240229193349.5407-1-WeitaoWang-oc@zhaoxin.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240229193349.5407-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29.02.24 20:33, Weitao Wang wrote:
> In the scenario of entering hibernation with udisk in the system, if the
> udisk was gone or resume fail in the thaw phase of hibernation. Its state
> will be set to NOTATTACHED. At this point, usb_hub_wq was already freezed
> and can't not handle disconnect event. Next, in the poweroff phase of
> hibernation, SYNCHRONIZE_CACHE SCSI command will be sent to this udisk
> when poweroff this scsi device, which will cause uas_submit_urbs to be
> called to submit URB for sense/data/cmd pipe. However, these URBs will
> submit fail as device was set to NOTATTACHED state. Then, uas_submit_urbs
> will return a value SCSI_MLQUEUE_DEVICE_BUSY to the caller. That will lead
> the SCSI layer go into an ugly loop and system fail to go into hibernation.
> 
> On the other hand, when we specially check for -ENODEV in function
> uas_queuecommand_lck, returning DID_ERROR to SCSI layer will cause device
> poweroff fail and system shutdown instead of entering hibernation.
> 
> To fix this issue, let uas_submit_urbs to return original generic error
> when submitting URB failed. At the same time, we need to translate -ENODEV
> to DID_NOT_CONNECT for the SCSI layer.
> 
> Suggested-by: Oliver Neukum<oneukum@suse.com>
> Cc:stable@vger.kernel.org
> Signed-off-by: Weitao Wang<WeitaoWang-oc@zhaoxin.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

