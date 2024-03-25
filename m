Return-Path: <linux-kernel+bounces-117889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797D88B0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592471C62643
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9140BEE;
	Mon, 25 Mar 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia4WQ8lS"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F03C6A4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397315; cv=none; b=FA8rUYqeyjfeCcPcsGlHLoTCItKboj8dXLga02pWA1yTc94WP64PwFXo7fpwjAD8HMs29C3/w6qsUzUtacuOunhzKi7xwpZGdU+46+wiDEHjIbJy09wZ0USqFqEhtNZ9na/WL8MabiSUjRnc76pHrBRvYsA2h7q/ZznbxAM67uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397315; c=relaxed/simple;
	bh=IjuxdHFO8cTcPCYWNzoDCm86BnzP3oIfsTOJhV2smf4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cG/9ks9UjX3bOxvyox00jkvxGWkQDqcXetytxttZerqM6rH7Myu2oocGPRTSfkHb/ATji0lLd+gBQGdW35DpaBupyDZqG23cuopyS/ezcugAyaFebYKzu5SjdoGs5j+f1/EclAfN9shQc2g5re230ZbNA7dIfQGnjMwPjdZINmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia4WQ8lS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341bba83366so785274f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711397312; x=1712002112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjuxdHFO8cTcPCYWNzoDCm86BnzP3oIfsTOJhV2smf4=;
        b=Ia4WQ8lS1ammLLbyOOB2UDxa0QJ/ey9Wafz+XmZnq0prpQhVb3GSkO1dfI94o336eh
         lA2KRE9D92wzInv4+58ljLuQQTQeFI7Tfp+GKm7FnDzi9KGQNR0oCr3eOcf+0Ay/9tCn
         ufGB1XbvMAaCgN9genF+szUhh5FgV9acs/molCbNVmRJJWT1Lm5qQK3FDHlOzAS5yvjq
         lUtIdAxqG+GBmSj/9z0zTG3Psjvx/bmZoMr0dxRSeGUC51RRZyCnJM+xu2od4MfQ2AwL
         24DF36sbMNOvtZKUbB1TWamuqsn9NeeXSvrLHFdFSjk+Haim7CGjV22FsZhilYZVa3Q/
         PtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397312; x=1712002112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjuxdHFO8cTcPCYWNzoDCm86BnzP3oIfsTOJhV2smf4=;
        b=t2iS+oXR42esxwD4DRy6Ry9pF0xlzCrbkbrVnpSrwKXsP3kS8hV5DLUjKrP62HdIcI
         TiT6wV/VJzUziNk4N850gwTqe+ROngLmrGkufTKyocv7dBXzDTsGZUZnv3pVVBmWRlaA
         EpcY1IW46Zu7/oS66gxnzmATq0PsgRrsULaErqomrUdCThLMt2O/9fPybJFPnHbuCcBg
         xhhvw/HSnbN2P+UKpukWkG2FFnA/5pj90sXATGAKrmjAGolKHUVmvOdvVXlvJH9Yzt+S
         p9dffmY9vw75aIctZczq3ssAwbXBDvEiKyvLrHjy8cj/wUApgV8cSZigfc3e7THY7OtN
         Aq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSQ2sGDtJZvYQruImCeudGPrSQ0SxBnbW2yspMNC04OwvcI8DXMvwILWloxP7Bv/FbiC17721FD7YX/cPdtk3VC9/ak1atuyU7rl3Z
X-Gm-Message-State: AOJu0YywPTiBSvsSDKz22Mw71hMmfQpG7P6pAoVfKZ/UE2JDO1Fx19OQ
	b1EubFgpldHBl6t/pS3tWoYtMjXon2lpZLnRDGYcmLEOzptnU3JJ
X-Google-Smtp-Source: AGHT+IE8D4NxyjSGCmzVt92tVvlkAao8m/O0GYRjEuokcPLxdToDjBNIzYiecePgrlHUFTnyAssfWQ==
X-Received: by 2002:a5d:5111:0:b0:33e:c974:129d with SMTP id s17-20020a5d5111000000b0033ec974129dmr5355058wrt.5.1711397312419;
        Mon, 25 Mar 2024 13:08:32 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d60c4000000b00341ce1b64f0sm3055622wrt.17.2024.03.25.13.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 13:08:32 -0700 (PDT)
Message-ID: <15892fec-213b-4b59-860a-491d28031f74@gmail.com>
Date: Mon, 25 Mar 2024 21:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: wlan-ng: Remove broken driver prism2_usb
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>
References: <20240325195112.GA17878@matrix-ESPRIMO-P710>
In-Reply-To: <20240325195112.GA17878@matrix-ESPRIMO-P710>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 20:51, Philipp Hortmann wrote:
> Tests on wlan-ng hardware have shown that this driver is broken since
> April 2021. Remove broken driver. Find fix for bug in link.

Missed to rebase.

