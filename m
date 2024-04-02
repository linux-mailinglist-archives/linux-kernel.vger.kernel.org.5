Return-Path: <linux-kernel+bounces-127824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8568895178
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371F81F2361B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75C62147;
	Tue,  2 Apr 2024 11:09:38 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E34604BB;
	Tue,  2 Apr 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056178; cv=none; b=omqOCpQrRqhd0cO2+pjIdJMbdx4Cb9WaZJV4qGB3TFs+nC1h51rpYGbm+BVFG0wpHAT+kn+lQAHrU4td1SIlClDtqum2rTZjC3xDvBkyWxkIc2k3x3gi6kH4FA7ik+FYcVj36vf1FRIG6aQdql25BVZgCdulIrAuFdTYHs3cdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056178; c=relaxed/simple;
	bh=Pz2W/JmvhcbrLHGMtbP+oMEqjfIqVmg5RzHfv2V/y3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHG2lqA6fmIZJzF2wRzczgQySNZPM/AjsSJLbwfu8hX76JsFjYwadKCglGnMJdsj2xpzqmSRoIL/1HVWzTNQow6ILNmWQ5GUIeZcKNafglFjIaeVK4b4yLnTngnB28tUWGNf+1jVsa2jR3xIlw2FIGv5VaqQL2AA5vGhyGoHPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e89d0816so5923103e87.0;
        Tue, 02 Apr 2024 04:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056175; x=1712660975;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL/SUQMEvTD3atN+VbztFSimA7sFWSFKuIGeBQT4IQc=;
        b=JFFAynjMXh/yh/ZM1pgpbvZfi/Sj9x+gf1OTQ4ZzrqGIilE23jk/OmBOW1WLc+FrAN
         GW+5+QWTmywkbD/X5YbdMlXwsIBTEJeF5+zbCWg45Ncebk8Y83gAOtg8PyGR5uPeCIxN
         9Lyc6hFKXimw88v1hMLXZRpEvhxdN7NYX2xbknhS4tHL2LwSywWrtQJym2pFVOE8+shi
         yTXFnTl1lUhP68fLj+ZWhauBJH4saUUQGp7DnfgXIVkys8d0eJ6ccOyHxsdPRNb/cPb5
         u+DRZmJGlKxLsUgAnCDBgJbqngvgV52yUBgmw+rU7xucjwcEcOJljypS59lwQYa/dP9L
         HM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaqtVljsE77uXhXsgJbfyVHQ5JEqEjA+KGV6V9Rfb2Hhxno+Rk0oS12XjSybkAEk5JZgLF37xCJmS6V8m3codn4i7sMT69oM0jPSmLcVgdQwiGJL6V2x2r+zSDAzPVlNM64VuTgw52Sblte3ElOFo/2oCSdwm2NlOpj56U6Wwui576VyCEbPFaKdmHc1/fL2b0Imandmzxkn9XcVvALuEIGxU=
X-Gm-Message-State: AOJu0YwEqPgtUvU+6m9pMq2Kp4FTLqZI3VI0bYVXxHYq5WeCWNwqFJNs
	kl6lEyHnG6IjDmf3WERpCsY9vs6rGUvqdXRPse22DO3cyr6Yi7yUCrIJUgz/Zl4=
X-Google-Smtp-Source: AGHT+IF0YdHd7ok9JRJmyKYA0oAkP/eBrCU6csCg08svcx755Oi82Vnlkarv6abMZpR0ABaLmAz/Hw==
X-Received: by 2002:ac2:5edc:0:b0:513:e17d:cf37 with SMTP id d28-20020ac25edc000000b00513e17dcf37mr7474872lfq.19.1712056174555;
        Tue, 02 Apr 2024 04:09:34 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c00cf00b00414041032casm13502060wmm.1.2024.04.02.04.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:09:33 -0700 (PDT)
Message-ID: <b3e0cb29-9487-4709-8150-77bff3e80920@kernel.org>
Date: Tue, 2 Apr 2024 13:09:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] VT: Allow to get max font width and height
To: Oleg Bulatov <oleg@bulatov.me>, legion@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1708960303.git.legion@kernel.org>
 <cover.1710252966.git.legion@kernel.org>
 <78fcb9ad77b88edee8768806ce6a4d23f6d33118.1710252966.git.legion@kernel.org>
 <c3wrf2h7h45h2vee7gc42zmy43rsh7niueknvsrlsibnae4pdw@4u6b4qulfe6r>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <c3wrf2h7h45h2vee7gc42zmy43rsh7niueknvsrlsibnae4pdw@4u6b4qulfe6r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13. 03. 24, 18:40, Oleg Bulatov wrote:
> On Tue, Mar 12, 2024 at 03:23:58PM +0100, legion@kernel.org wrote:
>>   drivers/video/console/newport_con.c | 21 +++++++++++++++++----
>>   drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
>>   drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
>>   drivers/video/fbdev/core/fbcon.c    | 22 +++++++++++++++++++++-
>>   4 files changed, 81 insertions(+), 8 deletions(-)
> 
> newport_con.c is an interesting one, apparently it's for SGI Indy and
> Indigo2, both are discontinued in 1997. Do we still have a way to test
> this driver?

I doubt that.

Care to submit a removal patch? I am afraid, there is no other way to 
find out anyway...

thanks,
-- 
js
suse labs


