Return-Path: <linux-kernel+bounces-85664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C786B8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25684B203C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F774418;
	Wed, 28 Feb 2024 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/gpZmEw"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC95E090;
	Wed, 28 Feb 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151259; cv=none; b=osKfML2GDB9UvPvb1rHMhI4/qw8Wz4zwOtupVBoI9cY4MY4hHwr13Z+OIN68LIsSgl7UBvkMM7cF3RTMjfav3LUuPKlQc6pjfZfxG2cI/qVWCHTvMxhDWydE64bTtCXVoAuTzvRE825ZChyEnPWBshl9DMXQJ+tOWoCPt2GhQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151259; c=relaxed/simple;
	bh=S/kBFAFK1JxGSRBxjvHb9wpGKCelBSL7wSHo55RJ70U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NRFckICdMI3YycW21nYPfaejKWKnpl6FGY9NQUkuW7GwDbbntPCpHS7fbxdUNJ6vxqp17mFgh3nMGdL3FiVhjWhaPyxc+FmB7epWIEyKOvgjOlUh8SLPguXAT02yGoqZ8LsK4hgMNapkbeuaR8x0daP/ZkMNN9c9NSqWPRPoNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/gpZmEw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690105304b4so565596d6.3;
        Wed, 28 Feb 2024 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709151257; x=1709756057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a/rY8nw5LZhhjrVDMwvjRYyAy1YxBmAbBSbPx3P8QI=;
        b=H/gpZmEwEEg55CZuZa7pU17B68fAQ7nEQjZfohIuWqx53q9r30TbnNVpDUZw81qwEg
         28eN+dTCvKqcTSfcYYop0Oz7QDq43LoBs0zqVTgpmjHP8jTNtmMLQinLdF2SosnC890X
         yWjqvVUFg9E7gtnxcy65xPZf5HZfXwIFVke4ENfLYlv6Wkjr2qHPCcnr8ptf7+HafCcz
         Tn7v9yECEy9qYM5C+qJflQ/hBjQXl3Vi+TAKZpS+SQ82Zh3ox7+DJIz308lG9Tg207tS
         s+Wtn6/X3xKXjsHTVN/fNuhlyvKELyDxGPV3cuHKkVnstZrLoRQmjiTVXxA+t01b1ouB
         6pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151257; x=1709756057;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1a/rY8nw5LZhhjrVDMwvjRYyAy1YxBmAbBSbPx3P8QI=;
        b=lcVq5oY0Cg7/hY1I0rDtB46/74CHY9GC1y7t+DIihV542xYujR8dNoygbgycgAVDu6
         +7ec02RNKjs4Im0Hw9jx2OEP/Nr3bEBnbolmvmeJxPBvGYl1/eHKTu/NzrxrYQZ5YwLU
         juIupqdJnKoIOX5q2/2brrEeOgutLjdmgWUQgbQu9SJfELhxksZyAwZ14MoIABui8VVo
         Zd4L2nCjaRGIZeYshwTBXXKD/umd7lObFQrJhXBETMV7NuEXCigFpzwfpMVU0bxSDfD9
         UEirHbOJIzI3BP/Ft/9JpAx/Nc+jG2MbuItfjlumqEdodW7oAFsrR2+kO08U0EdKhn8j
         pSKw==
X-Forwarded-Encrypted: i=1; AJvYcCXhoPsP0AM3VwEFuBZclYRw+3R1oZg3ovjvV34bNB3oTItw6dPlWvyyKDSsdi0JwpN5DT7j/wT7w9FcP573iOciI0bhqZ4+1eqWm4gGXK/Q5ODZozntb9yiJU0KujQymtgX4N0A
X-Gm-Message-State: AOJu0YyYJoBYLXBazjPahD/lMuC9zwjGfKAFTr5MpXgWig/BOBaaAi9E
	+UGQZc8YMqiWilyiOHX2qvRmsiV2XUYK/2CjxojeopqLdRJGr+5N
X-Google-Smtp-Source: AGHT+IHxNWyxCske1Sik3AzMuvEhMmss2UuSC/r9wqFpY78TS4gk9vI+gPwdO/qOu4IRTvOYF4TUPA==
X-Received: by 2002:a05:6214:16c5:b0:68f:e051:b1ee with SMTP id d5-20020a05621416c500b0068fe051b1eemr146433qvz.25.1709151256938;
        Wed, 28 Feb 2024 12:14:16 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id u17-20020a0ced31000000b0068f6e1c3582sm113429qvq.146.2024.02.28.12.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:14:16 -0800 (PST)
Date: Wed, 28 Feb 2024 15:14:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Message-ID: <65df94185a2c1_b2ad829442@willemb.c.googlers.com.notmuch>
In-Reply-To: <f38efc6d-20af-4cc1-9b8a-5fcb676b2845@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
 <f38efc6d-20af-4cc1-9b8a-5fcb676b2845@quicinc.com>
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 2/28/2024 7:53 AM, Willem de Bruijn wrote:
> > Abhishek Chauhan wrote:
> >> Bridge driver today has no support to forward the userspace timestamp
> >> packets and ends up resetting the timestamp. ETF qdisc checks the
> >> packet coming from userspace and encounters to be 0 thereby dropping
> >> time sensitive packets. These changes will allow userspace timestamps
> >> packets to be forwarded from the bridge to NIC drivers.
> >>
> >> Existing functionality of mono_delivery_time is not altered here
> >> instead just extended with userspace tstamp support for bridge
> >> forwarding path.
> >>
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >> ---
> >> Changes since v1 
> >> - Changed the commit subject as i am modifying the mono_delivery_time 
> >>   bit with clockid_delivery_time.
> >> - Took care of suggestion mentioned by Willem to use the same bit for 
> >>   userspace delivery time as there are no conflicts between TCP and 
> >>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
> >>   RAW and DGRAM sockets interprets it.
> > 
> > The variable rename churn makes it hard to spot the functional
> > changes. Perhaps it makes sense just keep the variable name as is,
> > even though the "mono" is not always technically correct anymore.
> > 
>   
> 
> I think a better approach would be to keep the variable as ease and add
> comments and documentation in the header file of skbuff.h like 
> how i have done in this patch. The reason why i say this is
> a. We can avoid alot of code churn just to solve this basic problem of 
> propagating timestamp through forwarding bridge path 
> b. Re-use the same variable name and have better documentation 
> c. Complexity will be as minimal as possible.
> 
> Let me know what you think. 

Agreed

> > Or else to split into two patches. One that renames the field.
> > And one that adds the new behavior of setting the bit for SO_TXTIME.
> >
> 
> Regarding the sidenote. I dont see how they are using clock_id to determine 
> if the skb->tstamp is set in monotonic. Please correct me or point me to 
> the piece of code which is doing so.

That's really out of scope of this series anyway
 
> 
> I hope the check against sock_flag is a better implementation as 
> it clearly stats and is inline with the implementation that the tstamp is 
> coming from userspace. 
> skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);

Enabling the socket flag is not sufficient to configure a delivery
time on a packet. A transmit time must be communicated per packet
with cork->transmit_time. And on top of that, it is cheaper to test.

