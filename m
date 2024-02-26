Return-Path: <linux-kernel+bounces-82287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8018681DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84101F22A03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70ED130AF0;
	Mon, 26 Feb 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="pEmQVxxq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068F1F94C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978849; cv=none; b=XOztceve3mWHA0OPUpYeKIf2NUsNvWaHrvnsy32+i+fkV7e3yZhhYUuYKv+yxiWYU6o274MgWN1wPkL6jW7J+qZgV0F5UlJwAT2dhyJnVtwaCEJW9xlxdYivnjYy4p4BfWTY/vCT6TxglR4VDwd3W7QadcYZwQnedmohE46VuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978849; c=relaxed/simple;
	bh=TA8ltfZtZHMJ9jAIBP34kiLwum/S26Js5pWwanPu2M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ4ZvMWi/tO+lygZvwfFzFcStwjw+yOTWYAd8q7xFZi61kNPT9/BQWgQsKg1LE98+1PNaAF7wNWPrAomOvCQL1wybV9h4kvErZhbBPDTpWNYBiHlxWOvNBosB4NW1u6SdSEiT+jRqLGNqjmrY7eg/9DwgiTftkXeo93dLxY/a7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=pEmQVxxq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4e7e25945so1642221b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708978847; x=1709583647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ShDnaavgO9jOj5Fc4lvKVUeYKF5ykoCWTmxeShV2cgI=;
        b=NkLua+IYGbmFxFmguMl8XDd8+AxAFx6QVNVgrBt02Y0791m8gTpOpTLVyEK0HNUFbp
         Bvi94mddyBzpXNiI0bfVfgNqGuGD+r7ozHlkN42X3d8QIpCIBR1v2vIO0T+RzqQKHkRU
         uOjbJ1K1y8eGXYal15GMEFYXmdtKlMbrrnCLAMbcQ+wgupqzewMWeTkS7y0+gQ9yfoOg
         BXLA8KRy1/BVA3xlP9l4odrMpQOzEsP7OvaCclGfxjsPoURbY0fGn7BMhH0iLCesGrBH
         zw+sxVWHFnyyUPH4204h0Qzyc+MVdshw0x1sAoRJaMuve625/5vOT4+s7RTmhpWMVHLQ
         p6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+yN7SBFL25LKS6q8mhCyayGzylErzS/hagrL8taIg0zUvHTJnBS03joafz/e5OdVUfxfurddQHhIVD34SyYjwehxU7DYj857qre0q
X-Gm-Message-State: AOJu0YzcEneyUHfI17CRQ13eJhyjtj+jTrLUqN2JvMn1bU4TVPuvRIiw
	5GqWtWnmXz62C6cPVRn1tW8GiVyA61DdUjumKK0Y8bT24aiVCGcH
X-Google-Smtp-Source: AGHT+IGkVTMzlozrOa/n8pAWspnUX1oUfLFxCwS4KJ2FptoKapNPY3SX+2TkHDBqaEqDzyYuAzu8tQ==
X-Received: by 2002:a05:6a21:191:b0:1a0:c950:9eb6 with SMTP id le17-20020a056a21019100b001a0c9509eb6mr184560pzb.27.1708978847231;
        Mon, 26 Feb 2024 12:20:47 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dcada71593sm82108plt.273.2024.02.26.12.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:20:46 -0800 (PST)
Date: Mon, 26 Feb 2024 17:21:37 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708978845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShDnaavgO9jOj5Fc4lvKVUeYKF5ykoCWTmxeShV2cgI=;
	b=pEmQVxxqoJhX4v8Z5ezIIwsj1cU+kk368ieeHNnvwJ4n5TKP5EKzSJvf+RIHhZNrsZpwoQ
	GKHHeV3iZsOo2Ygd1mIQM4lBD3jNcLtTeMDEl8YO+0pndRENcGxM2CnLqRzdJUDmNWb2KR
	fA8yz3dd2agtR+fDoLJf33Iho/aBJDaz2cnrlyN60ugDM0RKwIPdg7+9rutmIoP12nVoh8
	d56++uTZiTShRKU8M4aXuJSSzwqevlt8zD0IOrg5vV20wwE9vE+xvz+f/VlPHzaqeoS4gr
	oZXCwsl6EmtZ11kVOi50gkcPy/HmneK6zIkTznMZ+GKKQFvupmm4fMJbOcqbCw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Alex Elder <elder@ieee.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Message-ID: <xsotlft7byeu4iyyzty74dgzxtszmvyj4nuhga7qwuqc2tnubc@lp4ut22lc622>
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
 <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
 <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>
 <2024022553-deepness-sublevel-73de@gregkh>
 <yru2ywkyqwhg3rpyuqkkx73fxkkgsfj3vcbttnzrjq662ctrov@boh65bhxjjgo>
 <17e89261-d46b-4845-9fca-05dac3006a39@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e89261-d46b-4845-9fca-05dac3006a39@ieee.org>

On 26 Feb 13:50, Alex Elder wrote:
> On 2/25/24 5:04 AM, Ricardo B. Marliere wrote:
> >>>> On another subject:
> >>>>
> >>>> Johan might disagree, but I think it would be nice to make
> >>>> the definitions of the Greybus device types as static (private)
> >>>> and make the is_gb_host_device() etc. functions real functions
> >>>> rather than static inlines in <linux/greybus.h>.
> >>>>
> >>>> It turns out that all of the is_gb_*() functions are called only
> >>>> from drivers/greybus/core.c; they could all be moved there rather
> >>>> than advertising them in <linux/greybus.h>.
> >>> I guess it depends whether they would be used somewhere else in the
> >>> future. Perhaps it was left there with that intention when it was first
> >>> being developed? I agree, though. Will happily send a patch with this if
> >>> desired.
> >> Let's clean the code up for what we have today.  If it's needed in the
> >> future, we can move the structures then.
> > Sounds good to me, will send a v2 then!
> 
> I might be misinterpreting Greg's response; I *think* he
> agrees with my suggestion.

That's what I thought too.

> 
> In any case, please do *not* send v2 with the purpose of
> including my suggestion.
> 
> If you send a v2, keep it focused on this original patch.
> You can then implement the other suggestion as a follow-on
> patch (or series).

Indeed, this one is good as is but I thought of converting it into a
series so that they can be taken with no dependency on this one. So it
would look like:

Patch 1: move "is_gb_*()" into drivers/greybus/core.c
Patch 2: move "device_type greybus_*" into drivers/greybus/core.c
Patch 3: make "device_type greybus_*" const

But you're right. I could simply send 1 and 2 after this one has been
applied. If I were to send them separately, how would I communicate that
there's a dependency? Something like:

---
This series depends on [1].
[1]: lore://link-to-this-patch 

?

Thanks and sorry for the noobishness

> 
> 					-Alex

