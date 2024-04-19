Return-Path: <linux-kernel+bounces-151206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05218AAB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50C0B237E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A77C089;
	Fri, 19 Apr 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7R1LdZB"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B427BB0C;
	Fri, 19 Apr 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517274; cv=none; b=uFO135udfppg+pqTlKB9vdFwBlNzCArrkWd9I2HZnZkH7pnpR+sSv/RTlPywLkTUsThHMLOn2sglBCzFsNzb5hmFP+ST/R8vJNJQKXuCzz0n5Zub7LydcZzNj7He2FCiMRnOwOM/A/q5nj6Y2ygcorhRCW8Mifj1bcrXF+4MVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517274; c=relaxed/simple;
	bh=Ur4QL3hmvjchJ6gBpcZ6tiyYHaYB5QNLGzRytFBzgds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cK62saj827F69o9GM1YRlqv6GCVZWfW3ppOX1il1WHcsQCdMIIB4egEt3QhYpo8FEKzx4Gk66kqPFn27VOUzjkVLj9AQrEBb8LdqzWbXruh9nIyUG7TRfEcFgsLXnaqO/GcRRCrfwvw4LBCOySmgoihWAinrFfxuSpfC2k7FdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7R1LdZB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so32999131fa.2;
        Fri, 19 Apr 2024 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713517270; x=1714122070; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fY44b82kD7mfs1LDuG2tX7Tq5mE2NPHq5YvIF3/RCiY=;
        b=c7R1LdZB8HTBnbJqram9rto+PDaX0Uwni3Ku1iTx1pjzXTqo/csPDjzzHb2qxRvSEi
         6F4lNifwkx7SrR0ymizr85BwJ1eE07WCvvBus66SsfUK6PqYdfl6Z2Pps8va+a5mOM0y
         1nuzf4S7XNvmyFcd6f/OEbt55GKECwuTWRLTGbM0LGYp19P6388v5ZUYLifS19BNQKtz
         e+0u2TSL/36bTS5Kp8GgoCgMXQm+FnvRkbXdEgmsk5hvz7fZCzDKsF5bjVJ1mI/h/rx+
         sOCuUwN5UYkEtkfTob+3f9wZDORB3Xr/tCnKf4q4XaWxVzNYzKgclEeVpfJ0X5yCsx5W
         CJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713517270; x=1714122070;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fY44b82kD7mfs1LDuG2tX7Tq5mE2NPHq5YvIF3/RCiY=;
        b=ffKcXvSFBJJg0s7+sXzCnc4c/36vGypdACWR5J22C68AfBTNAv76OvSNf16gsTiqcN
         9UskkTIzOGQlrvZ2jorfj7fcWid9xwEO8SwKDmFGV/A9zr5yLnf8+GRarp9T7iNes26N
         QijcTnG+Ufik8aIT8lz8i6DLy8RBBtPL9aMgRZJ1+dfzAPllJHaLSFrehY+h7dWna7tn
         KeXNLBD8c/muh6Z+7zL/I+yRLX8tWHh/jBpG80eWxDdetITOyb6Ypp1LNKVvx1NZ8+gn
         3e9BpSUT/Sin27A4KJmiQ45/preggmHTg/KYVGCnCoiknqRtYWdJiQezVj4Gy5kkfxvL
         Eimg==
X-Forwarded-Encrypted: i=1; AJvYcCUqHubby9MVWTWnZkwok9PoJ1pGKemOxBC22TovWo1gKlWeGEgsStNiMTc9IZA/uJ0YmiJ3abrt2JT5NGSRiQOCTQrI6IH19CrSq2CW
X-Gm-Message-State: AOJu0YyZSwiLtkQfydw+2+0aJ1p+/Pr+ir8wJyTgJmvWS6gYaQAD9vAM
	jlrxgpPE6b38VyXmazNv7EQzLJmsuVCNVhn4gl3XEd401c30DysH
X-Google-Smtp-Source: AGHT+IFf+yvsgfZdAfLc7jy1W6IzirSaZRzlIIEb41A56b6n1/Ucp1XQjLo7KbVBYLfKw0jyCLIRvQ==
X-Received: by 2002:a2e:9dd7:0:b0:2d4:676b:f591 with SMTP id x23-20020a2e9dd7000000b002d4676bf591mr1100350ljj.45.1713517269858;
        Fri, 19 Apr 2024 02:01:09 -0700 (PDT)
Received: from localhost (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id u24-20020a2eb818000000b002d9de64ab6csm518177ljo.35.2024.04.19.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:01:09 -0700 (PDT)
From: Casper Andersson <casper.casan@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Shigeru Yoshida <syoshida@redhat.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support (HSR-SAN)
In-Reply-To: <20240418173706.206e6a2f@wsk>
References: <20240415124928.1263240-1-lukma@denx.de>
 <20240415124928.1263240-2-lukma@denx.de> <86mspt7glf.fsf@gmail.com>
 <20240416150359.7362c762@wsk> <86bk66hjyf.fsf@gmail.com>
 <20240418173706.206e6a2f@wsk>
Date: Fri, 19 Apr 2024 11:01:08 +0200
Message-ID: <86mspploa3.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-18 17:37 +0200, Lukasz Majewski wrote:
Hi Lukasz,

> Hi Casper,
>
>> Hi,
>> 
>> Sorry for the late reply, I was awaiting confirmation on what I can
>> say about the hardware I have access to. They won't let me say the
>> name :( but I can give some details.
>
> Ok, good :-)
>
> At least I'm not alone and there is another person who can validate the
> code (or behaviour) on another HSR HW.
>
> (Some parts of the specification could be double checked on another HW
> as well).
>
>> 
>> On 2024-04-16 15:03 +0200, Lukasz Majewski wrote:
>> >> On 2024-04-02 10:58 +0200, Lukasz Majewski wrote:  
>> >> > Changes for v3:
>> >> >
>> >> > - Modify frame passed Port C (Interlink) to have RedBox's source
>> >> > address (SA) This fixes issue with connecting L2 switch to
>> >> > Interlink Port as switches drop frames with SA other than one
>> >> > registered in their (internal) routing tables.    
>> >>   
>> >> > +	/* When HSR node is used as RedBox - the frame received
>> >> > from HSR ring
>> >> > +	 * requires source MAC address (SA) replacement to one
>> >> > which can be
>> >> > +	 * recognized by SAN devices (otherwise, frames are
>> >> > dropped by switch)
>> >> > +	 */
>> >> > +	if (port->type == HSR_PT_INTERLINK)
>> >> > +		ether_addr_copy(eth_hdr(skb)->h_source,
>> >> > +				port->hsr->macaddress_redbox);
>> >> >   
>> >> 
>> >> I'm not really understanding the reason for this change. Can you
>> >> explain it in more detail?  
>> >
>> > According to the HSR standard [1] the RedBox device shall work as a
>> > "proxy" [*] between HSR network and SAN (i.e. "normal" ethernet)
>> > devices.
>> >
>> > This particular snippet handles the situation when frame from HSR
>> > node is supposed to be sent to SAN network. In that case the SA of
>> > HSR (SA_A) is replaced with SA of RedBox (SA_RB) as the MAC address
>> > of RedBox is known and used by SAN devices.
>> >
>> >
>> > Node A  hsr1  |======| hsr1 Node Redbox |   |
>> > (SA_A) [**]   |	     |           eth3   |---| ethX SAN
>> > 	      |      |        	 (SA_RB)|   |  (e.g switch)
>> >
>> >
>> > (the ====== represents duplicate link - like lan1,lan2)
>> >
>> > If the SA_A would be passed to SAN (e.g. switch) the switch could
>> > get confused as also RedBox MAC address would be used. Hence, all
>> > the frames going out from "Node Redbox" have SA set to SA_RB.
>> >
>> > According to [1] - RedBox shall have the MAC address.
>> > This is similar to problem from [2].  
>> 
>> Thanks for the explanation, but I still don't quite follow in what way
>> the SAN gets confused. "also RedBox MAC address would be used", when
>> does this happen? Do you mean that some frames from Node A end up
>> using the RedBox MAC address so it's best if they all do?
>
> The SAN (let's say it is a switch) can communicate with RedBox or Node
> A. In that way the DA is different for both (so SA on reply is also
> different). On my setup I've observed frames drop (caused probably by
> switch filtering of incoming traffic not matching the outgoing one).
>
> When I only use SA of RedBox on traffic going to SAN, the problem is
> gone.
>
> IMHO, such separation (i.e. to use only RedBox's SA on traffic going to
> SAN) is the "proxy" mentioned in the standard.
>
>> 
>> I see there is already some address replacement going on in the HSR
>> interface, as you pointed out in [2]. And I get your idea of being a
>> proxy. If no one else is opposed to this then I'm fine with it too.
>> 
>
> Ok.
>
>> >> The standard does not say to modify the
>> >> SA. However, it also does not say to *not* modify it in HSR-SAN
>> >> mode like it does in other places. In HSR-HSR and HSR-PRP mode
>> >> modifying SA breaks the duplicate discard.  
>> >
>> > IMHO, the HSR-SAN shall be regarded as a "proxy" [*] between two
>> > types (and not fully compatible) networks.
>> >  
>> >> So keeping the same behavior for all
>> >> modes would be ideal.
>> >> 
>> >> I imagine any HW offloaded solutions will not modify the SA, so if
>> >> possible the SW should also behave as such.  
>> >
>> > The HW offloading in most cases works with HSR-HSR setup (i.e. it
>> > duplicates frames automatically or discards them when recived - like
>> > ksz9477 [3]).
>> >
>> > I think that RedBox HW offloading would be difficult to achieve to
>> > comply with standard. One "rough" idea would be to configure
>> > aforementioned ksz9477 to pass all frames in its HW between SAN and
>> > HSR network (but then it wouldn't filter them).  
>> 
>> I don't know anything about ksz9477. The hardware I have access to is
>> supposed to be compliant with 2016 version in an offloaded situation
>> for all modes (HSR-SAN, PRP-SAN, HSR-PRP, HSR-HSR).
>
> Hmm... Interesting.
>
> As fair as I know - the ksz9477 driver from Microchip for RedBox sets
> internal (i.e. in chip) vlan for Node_A, Node_B and Interlink, so _all_
> packets are flowing back and forth between HSR and SAN networks ....
>
>> Though, I haven't
>> verified if the operation is fully according to standard.
>
> You may use wireshark on device connected as SAN to redbox and then see
> if there are any frames (especially supervisory ones) passed from HSR
> network.

I realized I should clarify, what I'm running is non-upstream
software. And by offloaded I mean the redbox forwarding is
offloaded. Supervision frames are still handled in SW and only sent on
HSR/PRP ports, and doesn't reach any SAN nodes. Basic operation works as
it should.

>> It does not
>> modify any addresses in HW.
>
> By address - you mean the MAC addresses of nodes?

I mean that it forwards all frames without modification (except HSR/PRP
and VLAN tags). It does not update SMAC with the proxy MAC like your
implementation does.

>> Does the interlink port also reach the drivers?
>
> Could you be more specific in your question?

Sorry, it was connected to the question below if it sets anything up in
the drivers for the interlink port. And you answered it.

>> Does it call
>> port_hsr_join and try to join as an HSR port? 
>
> No, not yet.
>
> The community (IIRC Vladimir Oltean) suggested to first implement the
> RedBox Interlink (HSR-SAN) in SW. Then, we may think about adding
> offloading support for it.
>
>> Do we maybe need a
>> separate path or setting for configuring the interlink in the
>> different modes (SAN, HSR, PRP interlink)?
>
> I think that it shall be handled as an extra parameter (like we do have
> now with 'supervision' or 'version') in ip link add.
>
> However, first I would like to have the "interlink" parameter added to
> iproute2 and then we can extend it to other modes if requred.

Alright, doing SW implementation first sounds good. From userspace it
can probably be an extra parameter. But for the driver configuration
maybe we want a port_interlink_join? (when it comes to implementing that).


I did some testing with veth interfaces (everything in SW) with your
patches. I tried to do a setup like yours
                
                  +-vethA---vethB-+
                  |               |
vethF---vethE---hsr0             hsr1
                  |               |
                  +-vethC---vethD-+

Sending traffic from vethF results in 3 copies being seen on the ring
ports. One of which ends up being forwarded back to vethF (with SMAC
updated to the proxy address). I assume this is not intended behavior.


Setup:
ip link add dev vethA type veth peer name vethB
ip link add dev vethC type veth peer name vethD
ip link add dev vethE type veth peer name vethF
ip link set up dev vethA
ip link set up dev vethB
ip link set up dev vethC
ip link set up dev vethD
ip link set up dev vethE
ip link set up dev vethF

ip link add name hsr0 type hsr slave1 vethA slave2 vethC interlink vethE supervision 45 version 1
ip link add name hsr1 type hsr slave1 vethB slave2 vethD supervision 45 version 1
ip link set dev hsr0 up
ip link set dev hsr1 up

I used Nemesis to send random UDP broadcast packets but you could use whatever:
nemesis udp -d vethF -c 10000 -i 1 

BR,
Casper

