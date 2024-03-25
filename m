Return-Path: <linux-kernel+bounces-117073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3688A6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F961F61F59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3782876;
	Mon, 25 Mar 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1ceUppD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB9548E5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371450; cv=none; b=u3kez0luj2Ow7MpFOa1Mq2ItRasym+NfJQGpHMQoT2UmwEFexExjt/8O6g4y2eHr7He7PAr0E0d1nHUTls2g/RL9w+h3QykNuQ1nF7vuIrK8k/j8HVgoFy56Nqn2K87fvvcFdaCjTtQpmAMGieudL6S9tKvf9j7ka3tQrlPBozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371450; c=relaxed/simple;
	bh=cah+a4qLGLpMGGgjTvKbYvIZditx+ymKr2hdOv9rFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGqsSnvBLWH9+PFu/vgr9RUa0nS6mIyylZ0go+oRK3BoVP5dE1g4lGHKdKlW+tNj0IUTBR6TVW7v37/LMTfoD5J9sEEMxBOdQM2+RW00mUtuTCs3yswSkPsAGTbL3RjK38G6xPi9N0+HhjDM3fwvDKp8kF8FbTGDYmk+1DWUx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1ceUppD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711371447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eE5QNBSfrIetcHUg2xpk8XRpM1T1cbP2Uq+oi8Q+TKc=;
	b=H1ceUppDNm1CQx6ei8ut8+TuSxd1QxVrxP2VCCNmwJzq3ZjTpxGSvEw6gCO8ElOswoKBnY
	Yu7wVz8ugs0X4AlHW1RvFCI0px7HlnoROQFjr43VC16JQgszC6LRFGOppeFZOzmQxpTygA
	cJxhEVRjQ0iNSyE4xTCEinvHwsUZKRA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-jGv2tFwnMiGMdZEGJKhZog-1; Mon, 25 Mar 2024 08:57:25 -0400
X-MC-Unique: jGv2tFwnMiGMdZEGJKhZog-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5158a80cf1aso3823810e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711371444; x=1711976244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE5QNBSfrIetcHUg2xpk8XRpM1T1cbP2Uq+oi8Q+TKc=;
        b=kRT52BuFYhp22WD+oDemV8QJm339GwvwG1EpXudsZKtTGCptphojX2iB9twucLlXyH
         w6nAa9JzJRWI6I9ImtrFWpAvTkoU62JZWc6zfk1ssA6H1+dPOBM9J8Zt8d5BOwsI6tke
         pBAURs7GcgRxpxGij6k7o2TYF6mcekz8CWjSUlrKHChB8lMSjbmHxV9FuPLuWGFM+hDT
         jdMZxMSU9NLAhHQBYUuEEWxcgkl5LJXbZizy7LgcewstF6nPdA/AqC8m2IoH8j7iwHzj
         U/u9hYUxazRtA3iQj8JhOoviOBMvhy97QQA7moPfhMG1hqs4EXljjX87LOk/7zWUIQMH
         YETg==
X-Forwarded-Encrypted: i=1; AJvYcCU3IUT1y2g5QY2CEm4LMuaCAsn6ynAQjKxddcM/oX2ZyEJccXQtLGz67Q54aeJihtSD43HfxI01JZQfV8UqaZWFfr8nHB+3dJRQvqwf
X-Gm-Message-State: AOJu0YzxUZGBcbPUkRFYWYbtO+fTi+fzTGPTfRKVKl+yW2CNqckwMhsN
	qcvi3rwkzngAQUK3jJkgmZu134DfLUDvrqT0MdTNk7r3sbSkXUeOiroWE8IdGKw5AtHC12tCGWO
	BKHlD/wZ7By+MBGkmjZubGCS2ThyvmpKf1bzslLO19OqWmGJ24gA89E955Q4jVA==
X-Received: by 2002:a19:3808:0:b0:513:a05d:7e9a with SMTP id f8-20020a193808000000b00513a05d7e9amr3757485lfa.45.1711371444224;
        Mon, 25 Mar 2024 05:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgfn3Wqnnz98mip1IWNXWbVYKgDKaSOQVd36lu4WQH1Ag3gA+oqgkR8H4zcAFW02hxnCkT9A==
X-Received: by 2002:a19:3808:0:b0:513:a05d:7e9a with SMTP id f8-20020a193808000000b00513a05d7e9amr3757474lfa.45.1711371443756;
        Mon, 25 Mar 2024 05:57:23 -0700 (PDT)
Received: from [10.39.194.69] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709066bc400b00a46f95f5849sm3024197ejs.106.2024.03.25.05.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:57:23 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>, dev@openvswitch.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: Set the skbuff pkt_type for
 proper pmtud support.
Date: Mon, 25 Mar 2024 13:57:22 +0100
X-Mailer: MailMate (1.14r6028)
Message-ID: <4C04D4FF-0ADF-45DC-B253-2CD5C997DA1B@redhat.com>
In-Reply-To: <4066cc6a-24a8-4d05-b180-99222fe792fa@ovn.org>
References: <20240322190603.251831-1-aconole@redhat.com>
 <7AFF5D6D-568C-449B-83CF-9436DE97CA91@redhat.com>
 <f7t5xxawlen.fsf@redhat.com> <4066cc6a-24a8-4d05-b180-99222fe792fa@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 25 Mar 2024, at 13:37, Ilya Maximets wrote:

> On 3/25/24 13:22, Aaron Conole wrote:
>> Eelco Chaudron <echaudro@redhat.com> writes:
>>
>>> On 22 Mar 2024, at 20:06, Aaron Conole wrote:
>>>
>>>> Open vSwitch is originally intended to switch at layer 2, only deali=
ng with
>>>> Ethernet frames.  With the introduction of l3 tunnels support, it cr=
ossed
>>>> into the realm of needing to care a bit about some routing details w=
hen
>>>> making forwarding decisions.  If an oversized packet would need to b=
e
>>>> fragmented during this forwarding decision, there is a chance for pm=
tu
>>>> to get involved and generate a routing exception.  This is gated by =
the
>>>> skbuff->pkt_type field.
>>>>
>>>> When a flow is already loaded into the openvswitch module this field=
 is
>>>> set up and transitioned properly as a packet moves from one port to
>>>> another.  In the case that a packet execute is invoked after a flow =
is
>>>> newly installed this field is not properly initialized.  This causes=
 the
>>>> pmtud mechanism to omit sending the required exception messages acro=
ss
>>>> the tunnel boundary and a second attempt needs to be made to make su=
re
>>>> that the routing exception is properly setup.  To fix this, we set t=
he
>>>> outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get=

>>>> to the openvswitch module via a port device or packet command.
>>>
>>> Is this not a problem when the packet comes from the bridge port in t=
he kernel?
>>
>> It very well may be an issue there as well, but the recommendation is =
to
>> operate with the bridge port down as far as I know, so I don't know if=

>> this issue has been observed happening from the bridge port.
>
> FWIW, bridge ports are typically used as an entry point for tunneled
> traffic so it can egress from a physical port attached to OVS.  It mean=
s
> they are pretty much always UP in most common setups like OpenStack or
> ovn-kubernetes and handle a decent amount of traffic.  They are also us=
ed
> to direct some other types of traffic to the host kernel.

+1 here, I=E2=80=99m talking about the same port. I think we only advise =
having this down for userspace bridges, but not in the case the bridge is=
 the tunnel endpoint.

> Unless I misunderstood which ports we're talking about here.
>
> Best regards, Ilya Maximets.


