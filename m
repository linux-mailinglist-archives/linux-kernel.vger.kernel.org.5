Return-Path: <linux-kernel+bounces-98051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9487740F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE16DB2199A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88451C4B;
	Sat,  9 Mar 2024 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrAOruxk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99E433B6
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710022168; cv=none; b=Ahe1seOEFZksyeqE7FGen4/L85+ZEG+pHJIFJ0bGQvjL5c6y7AgeMHaJ1SmsXSb5i5BFuZVMwn3B/DmrI8QXHkObpKsOGRSFYRsRsco1elMO8Lamc0iiwq9+thglTO5qjPsjHjOSbX5E/1Kq/RABn68saZXysYVa/fT+5tgdPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710022168; c=relaxed/simple;
	bh=doQPr5qE7jmCw02bjSdKCIowfe++8fhb9Kqtk30RSHQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uWPD6mcQfSxubWWE57S66R4izWilzeHEB/cfYXKcGb0JX+KNhmv0f1q1eO61yOwvydG8xZFT6wc1yqji8n9OM5wBwEPeoh9TSde/OdSyNlrt1jWzjJSla/8jcCwKyAL9T1/ubV7wN9Q6z41oGf5DLDTfwNl8sgKFaS38pA6qwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrAOruxk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565c4d0fa48so1676884a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 14:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710022165; x=1710626965; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoUSCQi/eFDOlpUwRftgrlRLAzvhB9clzneZL40gpr0=;
        b=mrAOruxkVx+7RLKbHJiUmfo/B7BRm6LXnoPS/3EtDWX0kplBv8WodM3jX20/lctjyG
         YUM2xWhohfObzECXm9+HJj7i1E8uClBBvulKR+EaIyJXrMtfvMXaajBO1P2sjnO841NT
         WXvjJnoEbstj4FeSGIIl/cYGNtiPe11x70BH5iC3sNCyHXSOuzjsM1VP94fmrJVXBGpk
         BSoOZoPNxWyhBJdAciH+uKd5ox4uZ0q/H5XVLYbtc4eFlBlMmkixXpUCXIyz0SADOurq
         t0cEJaMoPsER0VxFBaIabsO9Y3IXvrDSPlCMrNoFwQ3xXHy8ibjNeZE/mgULcGz7TeZd
         Pfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710022165; x=1710626965;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qoUSCQi/eFDOlpUwRftgrlRLAzvhB9clzneZL40gpr0=;
        b=t2jIjr2kE625Mqwe6bzndN7if8zS2ptbQ/pzkJ72HtB3BvxttvqLFoy7qzsMi5qFSL
         RZ8fXaAq9YuPPv5Jb0Ii3r95JVmy55dj3lRu4JZFAHDa3hRLbrsjxR5s0UFjXizru6sO
         GAvHOmMJX6JMf9+o8WOQTVY3qK+3Ha6gQ2KyZ6iEzKsqHO82oXuGsBDOasO5nlJxZVq4
         mc8hg2WjGcUy5a1ez3mS7mCx7ErbZB29MkY+fP8bF8DeTq0wJjgPiDjjQGmFL7DIy/zV
         pufC7vnyq0DuBhWEpwsyceXke2anbIkt4S5LcjAkBuAUlm6nSopR+hm7Ea1fFUmCvLzt
         CsBA==
X-Forwarded-Encrypted: i=1; AJvYcCVGQbbbTUwkmMLXHkahbvfYK6edYgKo6lQJo7pkXcDSqY9fd9AotlecttsEUMTC3hzDjUt+3VwLEA8ADGwANGSB+VGEUirc3icycGpV
X-Gm-Message-State: AOJu0Yxcrs10QGa1Qew9MsBXrLVsmGG/7AARLo0fAKFZiFDO83XVRDRp
	XumWe0IebYahyMuTuE0CzSO9dnTtL/jx4GDOJl3RcYBRSk8b3zql
X-Google-Smtp-Source: AGHT+IHq/zSw/ri/GPhvDZJiXlfMIVOElyVsyuzxM/D06auLvoCaLZ4Fsg9EH/vkQ4WdeY3Md8hNvA==
X-Received: by 2002:a05:6402:4485:b0:568:4bbe:b3bc with SMTP id er5-20020a056402448500b005684bbeb3bcmr535255edb.0.1710022165258;
        Sat, 09 Mar 2024 14:09:25 -0800 (PST)
Received: from [192.168.0.102] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id n23-20020a5099d7000000b005682f47aea7sm1324392edb.94.2024.03.09.14.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 14:09:24 -0800 (PST)
Message-ID: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
Date: Sat, 9 Mar 2024 23:09:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Larry.Finger@lwfinger.net, johannes@sipsolutions.net, kvalo@kernel.org,
 arnd@arndb.de
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I would remove the driver from the mainline kernel. What are your thoughts?

I bought two WLAN devices (DUT: D-Link DWL-122 and T-Sinus 111 data) 
that are supported by wlan-ng driver. Issue is that the driver is not 
working anymore.

The error picture is that the device does not receive any packets.
The dmesg says:
[  123.695917] prism2_usb 2-1.6:1.0 wlan0: Unknown mgmt request message 
0x0e4f9800
[  127.508211] prism2_usb 2-1.6:1.0 wlan0: Unknown mgmt request message 
0x04f0d000
..

A working commit 8fc4fb1728855a22f9149079ba51877f5ee61fc9 (HEAD) Date: 
Mon Jul 5 11:16:28 2021 -0700
A failing commit  d980cc0620ae77ab2572235a1300bf22519f2e86 (HEAD) Date: 
  Fri Jul 16 19:08:09 2021 -0700

This means that the devices are unusable since kernel 5.15.

A look into the bitrates shows that only up to 11MBits are supported.
static const struct ieee80211_rate prism2_rates[] = {
..
	{ .bitrate = 110 }
};

Would be interesting to see why this happened. But it is difficult for 
me to find it.

Thanks for your support.

Bye Philipp

