Return-Path: <linux-kernel+bounces-116992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CA88A863
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F35AB2CC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6877F7DE;
	Mon, 25 Mar 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elyGre4R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F558AC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369388; cv=none; b=l74EqwFNDjD7gSI5vE+EDuAr9Pi/pafMOd3YUk5CIq6sF6lb+S2Go7vB4hzefYnWZNTlM/a3BfhF+S7Ppk/tsjE54wG8W/MwKxtbpPQfqHXIyNE0MHati06K6wlQeV92UGRuhhPzyDt33G9y2bDijqeMVCHfugQkZcD6XDX3VQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369388; c=relaxed/simple;
	bh=Twb2snY/3F4lbKNfDJVPc78mWoAOfrQSWRoXdsnS2oc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uaAnh7M7VEVw2YBy8I1KoHwSCwbGS4WAJtQgJihW/Mev2W+56+HDq4Y/tF4PsTlObxy86Clq4XaV6RMpBpir8tmA7HwvlsCXU8BVQ4ETm5kJeCqQSljHbjL7/cqUx3VFnAv3ChlHuF9iswGWiqoJ1HiLkaqhsr/4fYlo5/a2uZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elyGre4R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711369386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzIgO84X7s3kibZ20Fhx+86zvMP8Parlw1wYFhjpBhU=;
	b=elyGre4RuGKJMcB6OOgR3vqTmVW8QDGa1SaEApij2UDIeIgYNIsNXZ36qxuO65DFqwOl99
	EYsijG06UMxZKvXKsjsbyy+i+iL6EE+4HFu+YA8pBVwCUCqzGM4T3dA2rZdTv0EZrAA+K4
	l9DpVAqplJ5OZX1kXfNgfuOD+7qzARs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-3fgJQE6BP2KLaF5Q6qGEQg-1; Mon,
 25 Mar 2024 08:23:03 -0400
X-MC-Unique: 3fgJQE6BP2KLaF5Q6qGEQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9DD2803633;
	Mon, 25 Mar 2024 12:23:01 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.32.207])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 811D7492BE8;
	Mon, 25 Mar 2024 12:23:00 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,  Numan Siddique
 <nusiddiq@redhat.com>
Subject: Re: [PATCH net] openvswitch: Set the skbuff pkt_type for proper
 pmtud support.
References: <20240322190603.251831-1-aconole@redhat.com>
	<7AFF5D6D-568C-449B-83CF-9436DE97CA91@redhat.com>
Date: Mon, 25 Mar 2024 08:22:56 -0400
In-Reply-To: <7AFF5D6D-568C-449B-83CF-9436DE97CA91@redhat.com> (Eelco
	Chaudron's message of "Mon, 25 Mar 2024 09:44:16 +0100")
Message-ID: <f7t5xxawlen.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Eelco Chaudron <echaudro@redhat.com> writes:

> On 22 Mar 2024, at 20:06, Aaron Conole wrote:
>
>> Open vSwitch is originally intended to switch at layer 2, only dealing with
>> Ethernet frames.  With the introduction of l3 tunnels support, it crossed
>> into the realm of needing to care a bit about some routing details when
>> making forwarding decisions.  If an oversized packet would need to be
>> fragmented during this forwarding decision, there is a chance for pmtu
>> to get involved and generate a routing exception.  This is gated by the
>> skbuff->pkt_type field.
>>
>> When a flow is already loaded into the openvswitch module this field is
>> set up and transitioned properly as a packet moves from one port to
>> another.  In the case that a packet execute is invoked after a flow is
>> newly installed this field is not properly initialized.  This causes the
>> pmtud mechanism to omit sending the required exception messages across
>> the tunnel boundary and a second attempt needs to be made to make sure
>> that the routing exception is properly setup.  To fix this, we set the
>> outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
>> to the openvswitch module via a port device or packet command.
>
> Is this not a problem when the packet comes from the bridge port in the kernel?

It very well may be an issue there as well, but the recommendation is to
operate with the bridge port down as far as I know, so I don't know if
this issue has been observed happening from the bridge port.

Since I will spin a v2 with a comment, do you want me to mention
something about the bridge port?

>> This issue is periodically encountered in complex setups, such as large
>> openshift deployments, where multiple sets of tunnel traversal occurs.
>> A way to recreate this is with the ovn-heater project that can setup
>> a networking environment which mimics such large deployments.  In that
>> environment, without this patch, we can see:
>>
>>   ./ovn_cluster.sh start
>>   podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
>>   podman exec ovn-chassis-1 ip netns exec sw01p1  ip r flush cache
>>   podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s 1300 -c2
>>   PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
>>   From 21.0.0.3 icmp_seq=2 Frag needed and DF set (mtu = 1142)
>>
>>   --- 21.0.0.3 ping statistics ---
>>   2 packets transmitted, 0 received, +1 errors, 100% packet loss, time 1017ms
>>
>> Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is not
>> sent into the server.
>>
>> With this patch, setting the pkt_type, we see the following:
>>
>>   podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s 1300 -c2
>>   PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
>>   From 21.0.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1222)
>>   ping: local error: message too long, mtu=1222
>>
>>   --- 21.0.0.3 ping statistics ---
>>   2 packets transmitted, 0 received, +2 errors, 100% packet loss, time 1061ms
>>
>> In this case, the first ping request receives the FRAG_NEEDED message and
>> a local routing exception is created.
>>
>> Reported-at: https://issues.redhat.com/browse/FDP-164
>> Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>> NOTE: An alternate approach would be to add a netlink attribute to preserve
>>       pkt_type across the kernel->user boundary, but that does require some
>>       userspace cooperation.
>
> I prefer the method in this patch, as it requires no userspace change,
> i.e. it will work even with older versions of OVS without the need for
> backports.

Yes - that was my thinking as well.

>>  net/openvswitch/actions.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 6fcd7e2ca81fe..952c6292100d0 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -936,6 +936,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
>>  				pskb_trim(skb, ovs_mac_header_len(key));
>>  		}
>>
>> +		skb->pkt_type = PACKET_OUTGOING;
>> +
>
> Maybe add a comment based on the large explanation above?

Okay - I can add one.

>>  		if (likely(!mru ||
>>  		           (skb->len <= mru + vport->dev->hard_header_len))) {
>>  			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
>> -- 
>> 2.41.0


