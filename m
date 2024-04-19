Return-Path: <linux-kernel+bounces-151504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF878AAFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7A81F21711
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA412C490;
	Fri, 19 Apr 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH1lJhAb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A2BE66;
	Fri, 19 Apr 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534604; cv=none; b=qijTVFL2eq4qMo9RcgL0fNpd7FcNT6+kvu2YsCxRyWcWE2TsiKDuG43QX/FjBxjSKswlm4SWPe+RsT8tvhtOw38Xvm6NXA1av9ZXoMad8aMk8Ce/XXchE30g2FzgBACBn819bWBleyCi6p2mrK10mrbkjWEBDhXYtxgECO8GCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534604; c=relaxed/simple;
	bh=qLGQC039YP1mKL2Sz3nuZKlS0eHVrQ82XtJIZS2Lvhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NWTH7AVO2EN/JTZQZVh/lH8qHUqenlXNgmpX3LAxfP6VfUP6Zesn+AEwV1L97pSHQWAjkGdY5cM4oaiQ6vEvoh4sKZW6RPWBXQlH/ZlT5Jvq61ayuiiSJbBtALZoXpIZIzJQTBO6RzMlKKPHMXz+iDVFy7csQ92BdZgQ4BeayHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH1lJhAb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d3a470d5so2558597e87.3;
        Fri, 19 Apr 2024 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713534600; x=1714139400; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vIsknCrVSWZfl5oPvdxVpxQxWqdz3p10OSkpUV0zzo=;
        b=iH1lJhAbBh4PF1LXSmhLSvukgOxQf3dMGQdIskGeHlxz1XOUFetI50t4TqhtKcs21m
         uX3+LbdYkTaYx9zkcfLSEE73/Je3m7k+LQpdqq7Z17AEd89HeBivhb33pKu5Ba0+zIKd
         levi5zQvSZaGngQ/gOa5+qYqnS3u0rHh8owXm9PXOAUfxfKy6f++t362ng3HAWAVwfDD
         LCnw5EbpNTcCtR/r9xou4HRyVkKgCCmtxJLEcBlN/FqO+vgQs6sXbUgGq6wepm9yn49w
         BHXHxEWIuF5R0HmX1NHf+7IqhOv3UgfES/KtV19faKyEY2rMgwGWduCc3skY72vqwmzD
         hfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534600; x=1714139400;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vIsknCrVSWZfl5oPvdxVpxQxWqdz3p10OSkpUV0zzo=;
        b=qhA2U07O5kKfi+FlWj/tnqcgY6eYHY0zLPiR7U4QgNOJpH465JZOBudBTFBUNJL5hE
         vhal3Og8gQVK8xWZfS1kGUM5vBhdqOQrYyWo4ZQ2+EdGnzkX183tnasJl4z+fFPvcJKe
         2EMzoojMTTm3gzP40+GWF/2QWDUphqfozT9vMDSXiiY/4AenyYryksrd/abAK1Jb/JPE
         fTbAbzYNkAagLCB6afYGnAffd48rdiJqAJoHikPHsVLOJZ9mTPweVX0Nxcavmz0YzixI
         npHW1Tms13I9OwJ+N8NHUGiepQ3Ys+Wjts2oDKtd9tujn8OiRoyZQxKrSUhA7kyAiQtg
         s+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEjSHw1qzUgkuchsIdfeJ70BzS1HmRjIdNAbG2NjrqIHppiifscD15ZvFdDwvepDgD1eQdx3kqcmwfnUCDfSfFGG5gg0HqB9AbwCma
X-Gm-Message-State: AOJu0Yw3Rbfd3hdVlSLf4iWC+JZ+Eh4dCmfv9LBKrulO47B0+sPnl1fz
	9nsnkDUpHU1fxa7P17tfvCPbiVP+BEN5wmK2vXVM4qAXkLpdJCWI
X-Google-Smtp-Source: AGHT+IEHw+SEFiGrQBt8zUaQM0t4WBX5YrJUl4frugN5OX333WPx5tu9dFwjFh5uFb0BVp3NpWQ8/Q==
X-Received: by 2002:a19:7019:0:b0:518:96b5:f2c5 with SMTP id h25-20020a197019000000b0051896b5f2c5mr1609597lfc.46.1713534599474;
        Fri, 19 Apr 2024 06:49:59 -0700 (PDT)
Received: from localhost (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id z4-20020ac24184000000b0051589cc26afsm708461lfh.72.2024.04.19.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:49:59 -0700 (PDT)
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
In-Reply-To: <20240419124223.2388295d@wsk>
References: <20240415124928.1263240-1-lukma@denx.de>
 <20240415124928.1263240-2-lukma@denx.de> <86mspt7glf.fsf@gmail.com>
 <20240416150359.7362c762@wsk> <86bk66hjyf.fsf@gmail.com>
 <20240418173706.206e6a2f@wsk> <86mspploa3.fsf@gmail.com>
 <20240419124223.2388295d@wsk>
Date: Fri, 19 Apr 2024 15:49:58 +0200
Message-ID: <8634rho41l.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-19 12:42 +0200, Lukasz Majewski wrote:
> Hi Casper,
>
>> On 2024-04-18 17:37 +0200, Lukasz Majewski wrote:
>> Hi Lukasz,
>> 
>> > Hi Casper,
>> >  
>> >> Hi,
>> >> 
>> >> Sorry for the late reply, I was awaiting confirmation on what I can
>> >> say about the hardware I have access to. They won't let me say the
>> >> name :( but I can give some details.  
>> >
>> > Ok, good :-)
>> >
>> > At least I'm not alone and there is another person who can validate
>> > the code (or behaviour) on another HSR HW.
>> >
>> > (Some parts of the specification could be double checked on another
>> > HW as well).
>> >  
>> >> 
>> >> On 2024-04-16 15:03 +0200, Lukasz Majewski wrote:  
>> >> >> On 2024-04-02 10:58 +0200, Lukasz Majewski wrote:    
>> >> >> > Changes for v3:
>> >> >> >
>> >> >> > - Modify frame passed Port C (Interlink) to have RedBox's
>> >> >> > source address (SA) This fixes issue with connecting L2
>> >> >> > switch to Interlink Port as switches drop frames with SA
>> >> >> > other than one registered in their (internal) routing tables.
>> >> >> >      
>> >> >>     
>> >> >> > +	/* When HSR node is used as RedBox - the frame
>> >> >> > received from HSR ring
>> >> >> > +	 * requires source MAC address (SA) replacement to
>> >> >> > one which can be
>> >> >> > +	 * recognized by SAN devices (otherwise, frames are
>> >> >> > dropped by switch)
>> >> >> > +	 */
>> >> >> > +	if (port->type == HSR_PT_INTERLINK)
>> >> >> > +		ether_addr_copy(eth_hdr(skb)->h_source,
>> >> >> > +
>> >> >> > port->hsr->macaddress_redbox); 
>> >> >> 
>> >> >> I'm not really understanding the reason for this change. Can you
>> >> >> explain it in more detail?    
>> >> >
>> >> > According to the HSR standard [1] the RedBox device shall work
>> >> > as a "proxy" [*] between HSR network and SAN (i.e. "normal"
>> >> > ethernet) devices.
>> >> >
>> >> > This particular snippet handles the situation when frame from HSR
>> >> > node is supposed to be sent to SAN network. In that case the SA
>> >> > of HSR (SA_A) is replaced with SA of RedBox (SA_RB) as the MAC
>> >> > address of RedBox is known and used by SAN devices.
>> >> >
>> >> >
>> >> > Node A  hsr1  |======| hsr1 Node Redbox |   |
>> >> > (SA_A) [**]   |	     |           eth3   |---| ethX SAN
>> >> > 	      |      |        	 (SA_RB)|   |  (e.g switch)
>> >> >
>> >> >
>> >> > (the ====== represents duplicate link - like lan1,lan2)
>> >> >
>> >> > If the SA_A would be passed to SAN (e.g. switch) the switch could
>> >> > get confused as also RedBox MAC address would be used. Hence, all
>> >> > the frames going out from "Node Redbox" have SA set to SA_RB.
>> >> >
>> >> > According to [1] - RedBox shall have the MAC address.
>> >> > This is similar to problem from [2].    
>> >> 
>> >> Thanks for the explanation, but I still don't quite follow in what
>> >> way the SAN gets confused. "also RedBox MAC address would be
>> >> used", when does this happen? Do you mean that some frames from
>> >> Node A end up using the RedBox MAC address so it's best if they
>> >> all do?  
>> >
>> > The SAN (let's say it is a switch) can communicate with RedBox or
>> > Node A. In that way the DA is different for both (so SA on reply is
>> > also different). On my setup I've observed frames drop (caused
>> > probably by switch filtering of incoming traffic not matching the
>> > outgoing one).
>> >
>> > When I only use SA of RedBox on traffic going to SAN, the problem is
>> > gone.
>> >
>> > IMHO, such separation (i.e. to use only RedBox's SA on traffic
>> > going to SAN) is the "proxy" mentioned in the standard.
>> >  
>> >> 
>> >> I see there is already some address replacement going on in the HSR
>> >> interface, as you pointed out in [2]. And I get your idea of being
>> >> a proxy. If no one else is opposed to this then I'm fine with it
>> >> too. 
>> >
>> > Ok.
>> >  
>> >> >> The standard does not say to modify the
>> >> >> SA. However, it also does not say to *not* modify it in HSR-SAN
>> >> >> mode like it does in other places. In HSR-HSR and HSR-PRP mode
>> >> >> modifying SA breaks the duplicate discard.    
>> >> >
>> >> > IMHO, the HSR-SAN shall be regarded as a "proxy" [*] between two
>> >> > types (and not fully compatible) networks.
>> >> >    
>> >> >> So keeping the same behavior for all
>> >> >> modes would be ideal.
>> >> >> 
>> >> >> I imagine any HW offloaded solutions will not modify the SA, so
>> >> >> if possible the SW should also behave as such.    
>> >> >
>> >> > The HW offloading in most cases works with HSR-HSR setup (i.e. it
>> >> > duplicates frames automatically or discards them when recived -
>> >> > like ksz9477 [3]).
>> >> >
>> >> > I think that RedBox HW offloading would be difficult to achieve
>> >> > to comply with standard. One "rough" idea would be to configure
>> >> > aforementioned ksz9477 to pass all frames in its HW between SAN
>> >> > and HSR network (but then it wouldn't filter them).    
>> >> 
>> >> I don't know anything about ksz9477. The hardware I have access to
>> >> is supposed to be compliant with 2016 version in an offloaded
>> >> situation for all modes (HSR-SAN, PRP-SAN, HSR-PRP, HSR-HSR).  
>> >
>> > Hmm... Interesting.
>> >
>> > As fair as I know - the ksz9477 driver from Microchip for RedBox
>> > sets internal (i.e. in chip) vlan for Node_A, Node_B and Interlink,
>> > so _all_ packets are flowing back and forth between HSR and SAN
>> > networks .... 
>> >> Though, I haven't
>> >> verified if the operation is fully according to standard.  
>> >
>> > You may use wireshark on device connected as SAN to redbox and then
>> > see if there are any frames (especially supervisory ones) passed
>> > from HSR network.  
>> 
>> I realized I should clarify, what I'm running is non-upstream
>> software.
>
> Ok.
>
>> And by offloaded I mean the redbox forwarding is
>> offloaded. Supervision frames are still handled in SW and only sent on
>> HSR/PRP ports, and doesn't reach any SAN nodes. Basic operation works
>> as it should.
>
> Ok.
>
>> 
>> >> It does not
>> >> modify any addresses in HW.  
>> >
>> > By address - you mean the MAC addresses of nodes?  
>> 
>> I mean that it forwards all frames without modification (except
>> HSR/PRP and VLAN tags). It does not update SMAC with the proxy MAC
>> like your implementation does.
>
> Hmm... I'm wondering how "proxy" is implemented then.
> Also, what is the purpose of ProxyNodeTable in that case?

The ProxyNodeTable becomes the same as the MAC table for the interlink
port. I.e. normal MAC learning, when a frame is sent by a SAN and
received on interlink the HW learns that that SMAC is on the interlink
port (until it ages out). This table can be read out and used for
supervision frames.

Though, the NodesTable I don't think is used in HW. As I understand it's
an optional feature.

>> 
>> >> Does it call
>> >> port_hsr_join and try to join as an HSR port?   
>> >
>> > No, not yet.
>> >
>> > The community (IIRC Vladimir Oltean) suggested to first implement
>> > the RedBox Interlink (HSR-SAN) in SW. Then, we may think about
>> > adding offloading support for it.
>> >  
>> >> Do we maybe need a
>> >> separate path or setting for configuring the interlink in the
>> >> different modes (SAN, HSR, PRP interlink)?  
>> >
>> > I think that it shall be handled as an extra parameter (like we do
>> > have now with 'supervision' or 'version') in ip link add.
>> >
>> > However, first I would like to have the "interlink" parameter added
>> > to iproute2 and then we can extend it to other modes if requred.  
>> 
>> Alright, doing SW implementation first sounds good. From userspace it
>> can probably be an extra parameter. But for the driver configuration
>> maybe we want a port_interlink_join? (when it comes to implementing
>> that).
>
> IMHO, having port_interlink_join() may be useful in the future to
> provide offloading support.
>
>> 
>> 
>> I did some testing with veth interfaces (everything in SW) with your
>> patches. I tried to do a setup like yours
>>                 
>>                   +-vethA---vethB-+
>>                   |               |
>> vethF---vethE---hsr0             hsr1
>>                   |               |
>>                   +-vethC---vethD-+
>> 
>> Sending traffic from vethF results in 3 copies being seen on the ring
>> ports. One of which ends up being forwarded back to vethF (with SMAC
>> updated to the proxy address). I assume this is not intended behavior.
>
> I've reported this [2] (i.e. duplicated packets on HSR network with
> veth) when I was checking hsr_ping.sh [1] script for regression.
>
> (However, I don't see the DUP pings on my KSZ9477 setup).
>
> 
>> 
>> Setup:
>> ip link add dev vethA type veth peer name vethB
>> ip link add dev vethC type veth peer name vethD
>> ip link add dev vethE type veth peer name vethF
>> ip link set up dev vethA
>> ip link set up dev vethB
>> ip link set up dev vethC
>> ip link set up dev vethD
>> ip link set up dev vethE
>> ip link set up dev vethF
>> 
>> ip link add name hsr0 type hsr slave1 vethA slave2 vethC interlink
>> vethE supervision 45 version 1 ip link add name hsr1 type hsr slave1
>> vethB slave2 vethD supervision 45 version 1 ip link set dev hsr0 up
>> ip link set dev hsr1 up
>> 
>> I used Nemesis to send random UDP broadcast packets but you could use
>> whatever: nemesis udp -d vethF -c 10000 -i 1 
>
> Ok, I will check nemesis load as well.

Nemesis doesn't do anything specific, just generates packets. The
command above sends a packet at 1 second intervals.

> Can you check the hsr_redbox.sh (from this patch set) and hsr_ping.sh ?

Running in SW I get the same results as you, hsr_redbox.sh passes and
hsr_ping.sh fails.

I haven't tried on HW. I'll see if I can find some time for it but it
might take more time to prepare.

BR,
Casper

