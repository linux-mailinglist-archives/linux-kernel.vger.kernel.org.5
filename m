Return-Path: <linux-kernel+bounces-82905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922F868B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FDEB2422B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA373135A7D;
	Tue, 27 Feb 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F14Kc37D"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E91350E4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024711; cv=none; b=GLvIaqx3eeb+j8DzP3oLDwlOvF+UBlwjX/NDE2gdYhiovc90mE1zieqSq71C8ysDY9i6FfwoL2oIqHbrQRBoCPGoA6K+wNz+MQvh5KZVv93bZmgHP2RCCjGW8stXkp7jEgFZFMplEseLe+Ac9iuBBqsSiOZLcWdpwogS/Dsx/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024711; c=relaxed/simple;
	bh=WBe6ga2pwLP2qHgi217Nz+cjjBzoXfuuCdkvtlbLF4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT1oB4bjs0TKJhEHpMYz9VkNWqsEPsO7ZThiSNl+JubTXoKqa02NB24NeQJop64z9mTmnYAniPznEHa1igolRtfRaprW1t5gcl5eTPOQiHTtT0TmWqS1WZ23DGVssnZIac3BBu4f8/c9TZLIrq4tMeZMWBIP1sSo4Y4c4vxMngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F14Kc37D; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so557592466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709024707; x=1709629507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCD6F3e3P3I+Zgk/2guSviAQKEfOfySNcNBt5UHEyXo=;
        b=F14Kc37D4Num9JJ7X0m0kszo6RDhV8CtzHX4Rj3+1qHBOrIAXjE4MN3+cnUdGFyaPk
         nTRzOX1QtDxWi+PDZgbqjMQnZFFF0JcCEq3mrUmUbNJ7c43dijsvAtZciq94eP/h8gaV
         EqtPAaNnrNWoUTTrz7YDTP4JAnXMxHFwtQTGtdV82u/82iS95dI6Qzv13v8IWRLcEzZg
         aCPN/gaG7CJMODQvIidIMKKFfoBID6rb4nvVPSMZpC5cgDEFJnn6h4yq+0MjkHBubwGn
         cSL7vetUlu4kRhHgRofrNBSdKFfkjd5CH4H4swtfmUqZn42R/+xuD9CxTL2mpWilYmst
         uhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024707; x=1709629507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCD6F3e3P3I+Zgk/2guSviAQKEfOfySNcNBt5UHEyXo=;
        b=ifb6LdNQLO2juzp9dWc04kZZHpA0vcz2fqbr7OIy7GMEF4k0yj/kXtM9C106Ev9AND
         7iTI+D/Kv808PsTXEqO5LkmmTgqTqZtlVyFUW80w+tGVHfZgL8RAlQGgFxJVdzoSKEma
         oXS/B3+yYFq1YPWhg7kypuIyPdXNvyfvuReaNJYnhbLjIUCd/rX59OCSRJW783r43P6s
         NAxoXyWW74fZowDlesPR4FZzFClVYuStCCZBL+IOuTJxieJcSSQh3LDaNGYNaK1yrEQ8
         ompwYWvM1B+OPhaavLwcCIYPdhJYspz+ChhKmks4nAY7JFQjMzY3zkQOc0fLkarsf24m
         u3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs50FPd4vnH+hp2pJlYqDNWnS+XLI6L4NZlY6LObOL8U3PaPVEEn2PoAni9HoKbH2cwLYIknxo92g1LtlWqYtqPC2uU1ql77qlub9N
X-Gm-Message-State: AOJu0Yyhhk0XHQ2z+oyae1JJ/oSUP3x6BBZ3wD7drmoEKJVkw/HNgFfL
	OqawEtA7RJITsw68idIObe2RYIEfqVYdDQPLGFTwMhzOVs1NaQvD0jXoDj/lvg0=
X-Google-Smtp-Source: AGHT+IGmE8MK4gkN9ZDkWYcSJldVKxnmTp00nCPleWmQ8of4pKV4ikWCBrLzgOeJlaMUry+8f5Wkfg==
X-Received: by 2002:a17:907:9950:b0:a3e:bd4e:c87e with SMTP id kl16-20020a170907995000b00a3ebd4ec87emr6151888ejc.36.1709024707227;
        Tue, 27 Feb 2024 01:05:07 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090603cc00b00a433f470cf1sm552971eja.138.2024.02.27.01.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:05:07 -0800 (PST)
Message-ID: <8f4fe820-2385-40e7-a3c6-51102e57acad@suse.com>
Date: Tue, 27 Feb 2024 10:05:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB:UAS:return ENODEV when submit urbs fail with device
 not attached.
To: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
 Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
Cc: WeitaoWang@zhaoxin.com
References: <20240222165441.6148-1-WeitaoWang-oc@zhaoxin.com>
 <3ff16f34-07a9-4b7e-b51d-b7220f08d88d@suse.com>
 <41daf1a9-590a-e220-84a3-648eb895272b@zhaoxin.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <41daf1a9-590a-e220-84a3-648eb895272b@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22.02.24 21:06, WeitaoWang-oc@zhaoxin.com wrote:

> Maybe, my description was not accurate enough, here not add new return
> value to scsi layer,it just add a case to tell device is gone in the uas
> driver internal and the ENODEV error code not return to scsi layer.
> Here just notify SCSI layer of device loss through flag DID_NO_CONNECT.
> This is also hope to fix this issue in the uas driver internal.

Hi,

sorry for the delay. OK, I see what you are aiming at. Could you redo
the patch with a better description, like:

We need to translate -ENODEV to DID_NOT_CONNECT for the SCSI layer.

	Regards
		Oliver


