Return-Path: <linux-kernel+bounces-14542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F6821E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826F1283155
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644041428C;
	Tue,  2 Jan 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbaKQEvx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E912E7A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704208223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHtqiuFv0NX2cWrksYXkoFkjpAn1pYFyXkkX4b7K2+g=;
	b=gbaKQEvxQ4Aj8Wu1To4I29MQVyuNfuLWlKPi1qMFOvJtsXpMwQ8oxRKxYPTncl8hjjHCPR
	+mfk/giIbivEEiyFMlOOgg/x4VJDd0/BMJAuTSOkm5bsuT51tCdb532YsUm0nNh/KoD/nu
	geYMgJbo04ZeW9Jz7wxwSsTZaWTR8zM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ZI4YbdCQOISs_CZvDVPhjg-1; Tue, 02 Jan 2024 10:10:18 -0500
X-MC-Unique: ZI4YbdCQOISs_CZvDVPhjg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F839832EDA;
	Tue,  2 Jan 2024 15:10:17 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.16.200])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B97BF492BC6;
	Tue,  2 Jan 2024 15:10:15 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Brad Cowie <brad@faucet.nz>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  fw@strlen.de,  linux-kernel@vger.kernel.org,
  kadlec@netfilter.org,  edumazet@google.com,
  netfilter-devel@vger.kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  davem@davemloft.net,  pablo@netfilter.org,  Xin Long
 <lucien.xin@gmail.com>,  coreteam@netfilter.org
Subject: Re: [PATCH net] netfilter: nf_nat: fix action not being set for all
 ct states
References: <20231221224311.130319-1-brad@faucet.nz>
	<20231223211306.GA215659@kernel.org>
Date: Tue, 02 Jan 2024 10:10:15 -0500
In-Reply-To: <20231223211306.GA215659@kernel.org> (Simon Horman's message of
	"Sat, 23 Dec 2023 21:13:06 +0000")
Message-ID: <f7tle97eppk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Simon Horman <horms@kernel.org> writes:

> + Xin Long <lucien.xin@gmail.com>
>   Aaron Conole <aconole@redhat.com>
>   coreteam@netfilter.org
>
> On Fri, Dec 22, 2023 at 11:43:11AM +1300, Brad Cowie wrote:
>> This fixes openvswitch's handling of nat packets in the related state.
>> 
>> In nf_ct_nat_execute(), which is called from nf_ct_nat(), ICMP/ICMPv6
>> packets in the IP_CT_RELATED or IP_CT_RELATED_REPLY state, which have
>> not been dropped, will follow the goto, however the placement of the
>> goto label means that updating the action bit field will be bypassed.
>> 
>> This causes ovs_nat_update_key() to not be called from ovs_ct_nat()
>> which means the openvswitch match key for the ICMP/ICMPv6 packet is not
>> updated and the pre-nat value will be retained for the key, which will
>> result in the wrong openflow rule being matched for that packet.
>> 
>> Move the goto label above where the action bit field is being set so
>> that it is updated in all cases where the packet is accepted.
>> 
>> Fixes: ebddb1404900 ("net: move the nat function to nf_nat_ovs for ovs and tc")
>> Signed-off-by: Brad Cowie <brad@faucet.nz>
>
> Thanks Brad,
>
> I agree with your analysis and that the problem appears to
> have been introduced by the cited commit.
>
> I am curious to know what use case triggers this /
> why it when unnoticed for a year.
>
> But in any case, this fix looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>> ---

LGTM.  I guess we should try to codify the specific flows that were used
to flag this into the ovs selftest - we clearly have a missing case
after NAT lookup.

I'll add it to my (ever growing) list.

Meanwhile,

Acked-by: Aaron Conole <aconole@redhat.com>

>>  net/netfilter/nf_nat_ovs.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/netfilter/nf_nat_ovs.c b/net/netfilter/nf_nat_ovs.c
>> index 551abd2da614..0f9a559f6207 100644
>> --- a/net/netfilter/nf_nat_ovs.c
>> +++ b/net/netfilter/nf_nat_ovs.c
>> @@ -75,9 +75,10 @@ static int nf_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
>>  	}
>>  
>>  	err = nf_nat_packet(ct, ctinfo, hooknum, skb);
>> +out:
>>  	if (err == NF_ACCEPT)
>>  		*action |= BIT(maniptype);
>> -out:
>> +
>>  	return err;
>>  }
>>  
>> -- 
>> 2.34.1
>> 
>> _______________________________________________
>> dev mailing list
>> dev@openvswitch.org
>> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
>> 


