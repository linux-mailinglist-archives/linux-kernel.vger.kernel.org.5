Return-Path: <linux-kernel+bounces-144364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126188A450A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B291C20846
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DD136996;
	Sun, 14 Apr 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZYVuZhhh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+nkF2OOL"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917B1D688;
	Sun, 14 Apr 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126124; cv=pass; b=i30Crf8oSrQbu1fHPYyXTgaGgeR/keYvyWTtBBboZ617zCoV3QUUHtI87oSFiYFM00fVT4JLZgNxtfjvj/9DC2jjC3U1PsUlZ/nQNMH6J2ahu5vkl6ZREh+YXiBAOBX+ZrRqZ7BI7lHHpFYZ0KuzfOVrIa+3Hosi4O3qwzQH02Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126124; c=relaxed/simple;
	bh=vT8KOr3SvikJeMpg2ktjqGTrpiUSVOwI7Ulj4Tcu88w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3zbjxtA/MGrvUSA0NLEden4UD8HV86HD7s8G9kjlLXnDYiyNbumdvsnlwIS/2ULaOSKq0j5s0/Q4o4zMoCfBZz0/r2Eec1yEq4MCSJgmnptux8OQYD8E5wqnDLQzDrn48p/plwdmdYtw/WhvP7lHykwOaqB0/QJfAcWVpsgt1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZYVuZhhh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+nkF2OOL; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1713126101; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nKKe3KUJgcml3yIeSAfS56G8gn/M7whEEmw5a5WE7fzwLxRAf4YgS3U8NaGBzH7EKN
    SN9kbiTMgjzC3HdfxggzC2C+pa4fZhoalOouQUD3kp8xr6IUKFkF0OIRTn5QwBqcV4Pz
    8S8DH7Tu870sSA+WqA15kFbfl7DUOq6JHzQriOqIzRtxWujt4beS0BpV09ip0z2wRjD4
    2lNLFsrTTA+rGiGp3ZEVgu0cc5jR91gw8YAViIx4OMUwaD+f1eiehji4TnYMkGUbs5xU
    HihvqqwdMTAJquFHn2bK4XonjIZADOExmrzz8qT2Mas8F2DGZcQBG9V63UnCDENsXtUg
    JW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713126101;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FFdZNeDIHKlI++tV+rJTXXExTAzAeIULgTQSTJmSCuU=;
    b=d+2z78jmUpVbWERrzidNkDGiRCzxitPyZ2tpox3AwqsqC3JvEgUdNG5uCXBcM9wmAu
    UgHUzNX1yYTKNUm+/tOcB9QZ/7LtSF/W5z7SUFj5GP3eqD/YyCpJslokiqq7on3KUfOj
    JlX//bb2fygswKgToU5A0T8XcU9lxZwKOHCPaa0wiFT4i9rz1H3dXjcA8Ej0uRgbQwlv
    axiISXyFHxFHb3rJUTirzl8MdzUSgItAVwS+6OQetwz8/2X5+Alo1VBaZCtH9kwu0dAs
    vQIigU063HdD99I/JZdXaBnEod5JnJDh89QXyeOLAvv/yK3UjMO5R7rFp8+wjLghDKRK
    lsuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713126101;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FFdZNeDIHKlI++tV+rJTXXExTAzAeIULgTQSTJmSCuU=;
    b=ZYVuZhhhuTXsfiqLhsPEg9wlcG8eThmmC3SBleBWs6PUuvW9kKG088eYLZb0T7bZDv
    Ak+c4F8bikqsCZa3SUQxA0mHIX1w6+NtSM27rgwtEdQolFnQc48REWOGpwzW7cWr8x/I
    +gHUrQYOgNgcshVn0/TdM8YkzkTsjKTaw7YdfZ9SmhXpERFqvGLxS8fSlgaihG78ocqt
    0z0Z7+lrsvciLpvsV0Kw4uGfTq7a9sB3WSEY+/wl5YEVO8OKtAP86Zc1gVSRIC20zCRt
    hPTW9mKqxNXClgLUadI/iW2eiNl3z7KoE3ATGPMVT4dvC7MZqmjbw/keLiY6Ht954K/3
    Hx8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713126101;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FFdZNeDIHKlI++tV+rJTXXExTAzAeIULgTQSTJmSCuU=;
    b=+nkF2OOLy0dmy4fcPZ9weFhIxlK4A9ibM3sS5vJCEe69AFulTfGJgtlCP8ET/+uzb2
    YOxnle5qTxrA0hgL48Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xpzl0="
Received: from [192.168.60.177]
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id K701d603EKLfKo9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 14 Apr 2024 22:21:41 +0200 (CEST)
Message-ID: <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net>
Date: Sun, 14 Apr 2024 22:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Francesco Valla <valla.francesco@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 fabio@redaril.me
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
 <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.04.24 06:03, Vincent Mailhol wrote:

> 
> This doesn't remove the fact that I think that this naming convention
> is stupid because of the RAS syndrome, but I acknowledge that CAN CC
> is now the official denomination and thus, that we should adopt it in
> our documentation as well.
> 

;-)


>>> Add a space between ISO and the number. Also, update the year:
>>>
>>>     ISO 15765-2:2024
>>>
>>
>> Interesting! Didn't know there's already a new version.
>>
>> Will check this out whether we really support ISO 15765-2:2024 ...
>>
>> Do you have the standard at hand right now or should we leave this as
>> ISO15765-2:2016 until we know?
> 
> I have access to the newer revisions. But I never really invested time
> into reading that standard (neither the 2016 nor the 2024 versions).
> 
> Regardless, here is a verbatim extract from the Foreworld section of
> ISO 15765-2:2024
> 
>    This fourth edition cancels and replaces the third edition (ISO
>    15765-2:2016), which has been technically revised.
> 
>    The main changes are as follows:
> 
>      - restructured the document to achieve compatibility with OSI
>        7-layers model;
> 
>      - introduced T_Data abstract service primitive interface to
>        achieve compatibility with ISO 14229-2;
> 
>      - moved all transport layer protocol-related information to Clause 9;
> 
>      - clarification and editorial corrections
> 

Yes, I've checked the release notes on the ISO website too.
This really looks like editorial stuff that has nothing to do with the 
data protocol and its segmentation.

>>>
>>> Here, I would suggest the C99 designated field initialization:
>>>
>>>     struct sockaddr_can addr = {
>>>             .can_family = AF_CAN;
>>>             .can_ifindex = if_nametoindex("can0");
>>>             .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
>>>             .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>>>     };
> 
> Typo in my previous message: the designated initializers are not
> separated by colon ";" but by comma ",". So it should have been:
> 
>    struct sockaddr_can addr = {
>          .can_family = AF_CAN,
>          .can_ifindex = if_nametoindex("can0"),
>          .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG,
>          .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG,
>    };
> 
>>> Well, this is just a suggestion, feel free to reject it if you do not like it.
>>
>> At least I don't like it.
>>
>> These values are usually interactively given on the command line:
>>
>>   >            .can_ifindex = if_nametoindex("can0");
>>   >            .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
>>   >            .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>>
>> So have it in a static field initialization leads to a wrong path IMO.
> 
> There is no such limitation that C99 designated initializers should
> only work with variables which have static storage duration. In my
> suggested example, nothing is static.
> 
> I see this as the same thing as below example:
> 
>    int foo(void);
> 
>    int bar()
>    {
>            int i = foo();
>    }
> 
>    int baz()
>    {
>            int i;
> 
>            i = foo();
>    }
> 
> In bar(), the fact that the variable i is initialized at declaration
> does not mean that it is static. In both examples, the variable i uses
> automatic storage duration.
> 
> Here, my preference goes to bar(), but I recognize that baz() is also
> perfectly fine. Replace the int type by the struct sockaddr_can type
> and the scalar initialization by designated initializers and you
> should see the connection.

Oh, sorry. Maybe I expressed myself wrong.

IMHO your way to work with an initializer is correct from the C standpoint.

But I think this is pretty unusual for a code example when an 
application programmer starts to work with ISO-TP.

You usually get most of these values from the command line an fill the 
struct _by hand_ - and not with a static initialization.

That was my suggestion.

> 
> ** Different topic **
> 
> While replying on this, I encountered something which made me worry a bit:
> 
> The type of sockaddr_can.can_ifindex is a signed int:
> 
>    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can.h#L243
> 
> But if_nametoindex() returns an unsigned int:
> 
>     https://man7.org/linux/man-pages/man3/if_nametoindex.3.html
> 
> Shouldn't sockaddr_can.can_ifindex also be declared as an unsigned int?
> 

The if_index derives from struct netdevice.if_index

https://elixir.bootlin.com/linux/v6.8.6/source/include/linux/netdevice.h#L2158

which is an int.

I don't think this would have an effect in real world to change 
sockaddr_can.can_ifindex to an unsigned int.

I wonder if it is more critical to existing user space code to change it 
to unsigned int or to leave it as-is ...

Best regards,
Oliver

