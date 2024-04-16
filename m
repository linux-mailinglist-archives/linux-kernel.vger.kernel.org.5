Return-Path: <linux-kernel+bounces-146459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DF8A65A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCD11F21C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B2136E2B;
	Tue, 16 Apr 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2qZYgyj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECC132492
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254680; cv=none; b=FcM3xHbpLZ44/B3GlJul4rF9nhohxLJ8yGqUXxVHwl8/2BsVYmM4Rum78GaNni8WrTxDILMpyPz62RJZeF3PMwDyLC/PsGmFMNEW+m7Ze5JJa3jJZn/+R9YMk5N8i7ObNKWJ9muO7wXulyAg0W7/hIOzM739Ph+kxAgXAmJHZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254680; c=relaxed/simple;
	bh=aFtDoP+ptsA+xiiT/L0BTr1limxkEohlLYO2fK22oWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYRWdUytvDTnl4nmkQmGyh2nEE7UGdgn8nIz9i/TIDw3I/xybBDEE/K+wMwwfr6is5I6uSjAYZyesjJJSJ/2u03f+fBx79wFnvOQg+9rfcBaD9SsVBXoa41SV6jJk0huk42FyMdrzcIylROfpIax1ITVbapepTnObkO1/Q/JESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2qZYgyj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713254674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mpnmnLcLPbxDi7bNweS52z62pdChPh+H06QF5Sioa0=;
	b=F2qZYgyjcDR2W5A3YYPrsNiM8JOf/aO8M1CWmBhMZ/5AC2cZxvnFJD6fPewwYjcYQyhH9o
	o9DjjDpiYHrpYveGsJlUfl35fI6NmvkhskR6lIkgRs/iJGRx/qOTmnZN0qG1n0cW2iB5Nd
	ryfAV+89BS6a+MI5Ia4wIrfGoLxOU0k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-xJHcP4_rPCO_8-01Z6Gu6A-1; Tue, 16 Apr 2024 04:04:33 -0400
X-MC-Unique: xJHcP4_rPCO_8-01Z6Gu6A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51abd0d7c6so332121466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254671; x=1713859471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mpnmnLcLPbxDi7bNweS52z62pdChPh+H06QF5Sioa0=;
        b=e3PyuHL5L5wDq38Dnp7qSttd/+1z9qUnCBj+NNyFUE3cmOHwwJ6DZaKb1CL+U832Fw
         tF/xEVZz8ebHkzUqOJvVPGdviu8hstpTPOdjSRwbPnbnsxzT6AT0hVuw95zXbIO+f1WO
         CX4hQcXnUX0ypRA/T+/m3DXmzVKTRsacBcLNfC1lSfKH5adNhtaJv5ghB54vQknPBLcx
         dWvoevQpSfcKRc8LQuvyaxEPY/RQHMqkGf9mo1hi+MvxqdbRO4NpG4ox3P0lUsdpK0kg
         iLpr3121VsdtIQlFNiGZHWn8dpFk4NvxxxN8ueeC/YvqGVTDjpAsVVIIlrRdLUTbfvRa
         axew==
X-Forwarded-Encrypted: i=1; AJvYcCWP2Eq2TRgAiS57HTcjESOeU/5FKn14Rb2Xe32okUlQi+5sv5CmrrblmMuHETaJgAU/YcVADx4xK4dBeGWT89PBNIMt9ezINLBFF+lZ
X-Gm-Message-State: AOJu0YyQNXS9BZVJ5dHYNKdwo4SGnFpsNXh459Yh71QftfSX0zD+ejjP
	JLEUIXtYttIPj+swh8D7Hpi+sOhbuTjFTltwIaQGh8pqAKZL9bo60DNP/BHm7E9lMrt52w1sESr
	LrIF5IIDae1qTCICy8BJ2572jEAFBELMo++l7rCWpKtzRMFR/APIiQ9yBCQ0j7Crxk4wJkQ==
X-Received: by 2002:a17:906:3110:b0:a51:dbd3:5ac4 with SMTP id 16-20020a170906311000b00a51dbd35ac4mr6705423ejx.30.1713254671483;
        Tue, 16 Apr 2024 01:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ6qRV4BzR4P7/mlY/Gcc8MwqwRiPtqgpsZtFWVOxC9g1J4h2RQXqbM+ckQZjDTocTIt3mMg==
X-Received: by 2002:a17:906:3110:b0:a51:dbd3:5ac4 with SMTP id 16-20020a170906311000b00a51dbd35ac4mr6705406ejx.30.1713254671065;
        Tue, 16 Apr 2024 01:04:31 -0700 (PDT)
Received: from [10.39.194.81] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906284800b00a4e07760215sm6503388ejc.69.2024.04.16.01.04.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:04:30 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Jun Gu <jun.gu@easystack.cn>
Cc: pshelar@ovn.org, dev@openvswitch.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH] net: openvswitch: Check vport name
Date: Tue, 16 Apr 2024 10:04:29 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <084E7217-6290-46D2-A47A-14ACB60EBBCA@redhat.com>
In-Reply-To: <671d3c3b-a5c4-4dbd-800b-fbfec0fbe4dc@easystack.cn>
References: <20240413084826.52417-1-jun.gu@easystack.cn>
 <9D534A61-4CC2-4374-B2D8-761216745EDD@redhat.com>
 <671d3c3b-a5c4-4dbd-800b-fbfec0fbe4dc@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 16 Apr 2024, at 9:57, Jun Gu wrote:

> Hi Chaudron, thanks for your reply. Considerthe following scenario:
>
> - set a net device alias name (such as *enpxx*) into ovs.
>
> - |OVS_VPORT_CMD_NEW -> ||dev_get_by_name can query the net device usin=
g *enpxx* name, but the dev->name that return is *ensxx* name. the |net_d=
evice|struct including: ``` |struct=C2=A0net_device=C2=A0{
>     char			name[IFNAMSIZ];
>     RH_KABI_REPLACE(struct=C2=A0hlist_node=C2=A0name_hlist,
>     		struct=C2=A0netdev_name_node=C2=A0*name_node)
> ...
> |``` name_hlist include enpxx and ensxx name and both of them point to =
the same net_device, the net_device's name is ensxx. So when using *enpxx=
* name to query net device, the ||net device's name that return is *ensxx=
* name.|
> Then, openvswitch.ko will save the net device that name is*ensxx*  to a=
 hash table. So this will cause the below process:
> - ovs can'tobtain the enpxx net device by |OVS_VPORT_CMD_GET.|
> -|dpif_netlink_port_poll will get a |notification after |OVS_VPORT_CMD_=
NEW|, but the vport's name is ensxx. ovs will query the ensxx net device =
from interface table, but nothing. So ovs will run the port_del operation=
=2E
> - this will cause|OVS_VPORT_CMD_NEW|  and OVS_VPORT_CMD_DEL operation t=
o run repeatedly.
> So the above issue can be avoided by the patch.

Thanks for the clarification, I forgot about the alias case. And you are =
right, OVS userspace does not support using interface aliases.

Maybe you can update the commit message, and add a code comment to clarif=
y this in your next revision?

Cheers,

Eelco


> =E5=9C=A8 4/15/24 18:04, Eelco Chaudron =E5=86=99=E9=81=93:
>>
>> On 13 Apr 2024, at 10:48, jun.gu wrote:
>>
>>> Check vport name from dev_get_by_name, this can avoid to add and remo=
ve
>>> NIC repeatedly when NIC rename failed at system startup.
>>>
>>> Signed-off-by: Jun Gu<jun.gu@easystack.cn>
>>> ---
>>>   net/openvswitch/vport-netdev.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-n=
etdev.c
>>> index 903537a5da22..de8977d7f329 100644
>>> --- a/net/openvswitch/vport-netdev.c
>>> +++ b/net/openvswitch/vport-netdev.c
>>> @@ -78,7 +78,7 @@ struct vport *ovs_netdev_link(struct vport *vport, =
const char *name)
>>>   	int err;
>>>
>>>   	vport->dev =3D dev_get_by_name(ovs_dp_get_net(vport->dp), name);
>>> -	if (!vport->dev) {
>>> +	if (!vport->dev) || strcmp(name, ovs_vport_name(vport)) {
>> Hi Jun, not sure if I get the point here, as ovs_vport_name() translat=
es into vport->dev->name.
>>
>> So are we trying to catch the interface rename between the dev_get_by_=
name(), and the code below? This rename could happen at any other place, =
so this check does not guarantee anything. Or am I missing something?
>>
>>>   		err =3D -ENODEV;
>>>   		goto error_free_vport;
>>>   	}
>>> -- =

>>> 2.25.1
>>>
>>> _______________________________________________
>>> dev mailing list
>>> dev@openvswitch.org
>>> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
>>


