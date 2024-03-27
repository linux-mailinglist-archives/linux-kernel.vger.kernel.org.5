Return-Path: <linux-kernel+bounces-121679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF1988EC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67582B2264A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20FE14A61B;
	Wed, 27 Mar 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqjAAPkR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1012D748
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559874; cv=none; b=hBNHuaawoj5aiKkXdzndBaiKdzGYgq6m7DUvOOZi5aGElmOcDP2VuZttQMoaXk40I9uMClkGggseS9AmDhZs4ANrOENEZiSoAe26+/ERZXkoq737fWC+wqZUrFcfqLUUvYzU/ns7sZ21oynibKcItJTHoKjvr30oUMdcyOpkw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559874; c=relaxed/simple;
	bh=UA3aAZ6OJD/YBTezWMH3e5Ei1wRNk1JwfdDlSOWXRl0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=E14Kqn3IWWGQnwv+RgkGlYTRg6BplCu6d1Cnr3M2YshEulPHUdFK+ErEAtcKsZCsm+83dbQmcPnfsp5xX5fGvP9KVa3U6i9A54Wg/4UzyqUEQQ4l15nu4NcoFLU+jUc7fl7Io/EFUiWXkWiuWxzSERYYx3hKMzCo5U8pYnijPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqjAAPkR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711559871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brnN/NCeTstfV3DWN+AFy3XAX/hGuMmV9sRUj5MIAgg=;
	b=VqjAAPkR3HQxyiXFU3+murtcAohBVP8NWZ6QTWUeg5xlapcpXWu1Cec0E+oZa2h59eLYkD
	3scWnnnv5JFgLZOFX7ARWS0DiTf98hGaJRwzvSrTrrWiMS5VX+kjecwunvasM1AWiDhvGj
	Eorgk0QX3PqaqJUsdD2tzgcuCp+8vzk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-ANzFHTBkPCSIIzq1MCJC4g-1; Wed,
 27 Mar 2024 13:17:47 -0400
X-MC-Unique: ANzFHTBkPCSIIzq1MCJC4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E894D1E441C1;
	Wed, 27 Mar 2024 17:17:46 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54EF51121306;
	Wed, 27 Mar 2024 17:17:46 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>,  dev@openvswitch.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: Set the skbuff pkt_type for
 proper pmtud support.
References: <20240322190603.251831-1-aconole@redhat.com>
	<7AFF5D6D-568C-449B-83CF-9436DE97CA91@redhat.com>
	<f7t5xxawlen.fsf@redhat.com>
	<4066cc6a-24a8-4d05-b180-99222fe792fa@ovn.org>
	<4C04D4FF-0ADF-45DC-B253-2CD5C997DA1B@redhat.com>
Date: Wed, 27 Mar 2024 13:17:46 -0400
In-Reply-To: <4C04D4FF-0ADF-45DC-B253-2CD5C997DA1B@redhat.com> (Eelco
	Chaudron's message of "Mon, 25 Mar 2024 13:57:22 +0100")
Message-ID: <f7tbk6ztwzp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Eelco Chaudron <echaudro@redhat.com> writes:

> On 25 Mar 2024, at 13:37, Ilya Maximets wrote:
>
>> On 3/25/24 13:22, Aaron Conole wrote:
>>> Eelco Chaudron <echaudro@redhat.com> writes:
>>>
>>>> On 22 Mar 2024, at 20:06, Aaron Conole wrote:
>>>>
>>>>> Open vSwitch is originally intended to switch at layer 2, only dealin=
g with
>>>>> Ethernet frames.  With the introduction of l3 tunnels support, it cro=
ssed
>>>>> into the realm of needing to care a bit about some routing details wh=
en
>>>>> making forwarding decisions.  If an oversized packet would need to be
>>>>> fragmented during this forwarding decision, there is a chance for pmtu
>>>>> to get involved and generate a routing exception.  This is gated by t=
he
>>>>> skbuff->pkt_type field.
>>>>>
>>>>> When a flow is already loaded into the openvswitch module this field =
is
>>>>> set up and transitioned properly as a packet moves from one port to
>>>>> another.  In the case that a packet execute is invoked after a flow is
>>>>> newly installed this field is not properly initialized.  This causes =
the
>>>>> pmtud mechanism to omit sending the required exception messages across
>>>>> the tunnel boundary and a second attempt needs to be made to make sure
>>>>> that the routing exception is properly setup.  To fix this, we set the
>>>>> outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
>>>>> to the openvswitch module via a port device or packet command.
>>>>
>>>> Is this not a problem when the packet comes from the bridge port in th=
e kernel?
>>>
>>> It very well may be an issue there as well, but the recommendation is to
>>> operate with the bridge port down as far as I know, so I don't know if
>>> this issue has been observed happening from the bridge port.
>>
>> FWIW, bridge ports are typically used as an entry point for tunneled
>> traffic so it can egress from a physical port attached to OVS.  It means
>> they are pretty much always UP in most common setups like OpenStack or
>> ovn-kubernetes and handle a decent amount of traffic.  They are also used
>> to direct some other types of traffic to the host kernel.
>
> +1 here, I=E2=80=99m talking about the same port. I think we only advise
> having this down for userspace bridges, but not in the case the bridge
> is the tunnel endpoint.

Okay, I'll confirm about up/down, but it seems like it shouldn't matter
and we should be setting the outgoing type.

>> Unless I misunderstood which ports we're talking about here.
>>
>> Best regards, Ilya Maximets.


