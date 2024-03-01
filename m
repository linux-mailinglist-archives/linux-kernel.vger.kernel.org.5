Return-Path: <linux-kernel+bounces-88305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6972686DFE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F48288882
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC06EF1F;
	Fri,  1 Mar 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PAZ7hQ7k"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882846EB7B;
	Fri,  1 Mar 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291411; cv=none; b=k9H+jNqqZ9tPuau+6z+Hpd+vb3ZSw9iwOi15xcblBN+JCThAJbR8uT9iH6LZnZDZ6wm6RJXT0+0MFT/D42uofU54a3s9336lfw6uaOtseBAmjD/vw+Vtjfv85o2BYVvezfCn05iiyJ4h0O+K6Jodg4D3B54kXKxXHqoukx6BQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291411; c=relaxed/simple;
	bh=QRbExAMvXdH77Tuwests8b8zj5ZvrcJ6Ix6vLJ+34M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CkdupNdAWLWvt4iNv6BXZ3yzM5IqHzTnYKoD958DvLxKEvd6DEAgBeB9KA9e8z3rQcpi445KESc31hqZYw8nP7thG8mu400W8NM6YQ9y5Xs1AlzkOjQWN1220M1zV701c5egtVdod1fSma3OD0JnvMbGCcWvtXF5jLtT+tuaymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PAZ7hQ7k; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 421B9tBL120075;
	Fri, 1 Mar 2024 05:09:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709291395;
	bh=WthVMSlBC04LR7tfpauZDWEDm6N7t/Hgl+E1wPR/kR4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PAZ7hQ7kUNUaI1reBgkk8AFHWJ4SvLVGUkTqhxIpDJd++wVWfRoOpW24dN1AeFRQN
	 tfzcx2UJiUy48RQ/17pmLYaG+N7qApykx3i3JVOgFCh4M/KkNiB703kIb2ufU0ZdhA
	 tP/yRxbZD2DcOBzLZIA2Xb/zeYsY+TlouBKIjB6k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 421B9txW099588
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Mar 2024 05:09:55 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 05:09:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 05:09:55 -0600
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 421B9odN124584;
	Fri, 1 Mar 2024 05:09:51 -0600
Message-ID: <03bf515c-9f90-487c-ecfa-90d407dc5d86@ti.com>
Date: Fri, 1 Mar 2024 16:39:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= <Jorge.SanjuanGarcia@duagon.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
        "rogerq@kernel.org"
	<rogerq@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "olteanv@gmail.com"
	<olteanv@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
 <20240228200516.1166a097@kernel.org>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240228200516.1166a097@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 2/29/24 9:35 AM, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 11:13:23 +0000 Sanjuán García, Jorge wrote:
>> Since commit 8940e6b669ca ("net: dsa: avoid call to __dev_set_promiscuity()
>> while rtnl_mutex isn't held") when conecting one of this switch's port
>> to a DSA switch as the conduit interface, the network interface is set to
>> promiscuous mode by default and cannot be set to not promiscuous mode again
>> from userspace. The reason for this is that the cpsw ports net devices
>> do not have the flag IFF_UNICAST_FLT set in their private flags.
>>
>> The cpsw switch should be able to set not promiscuous mode as otherwise
>> a '1' is written to bit ALE_PORT_MACONLY_CAF which makes ethernet frames
>> get an additional VLAN tag when entering the port connected to the DSA
>> switch. Setting the IFF_UNICAST_FLT flag to all ports allows us to have
>> the conduit interface on the DSA subsystem set as not promiscuous.
> 
> It doesn't look like am65-cpsw-nuss supports unicast filtering, 
> tho, does it? So we're lying about support to work around some 
> CPSW weirdness (additional VLAN tag thing)?

CPSW driver does not support unicast filtering. 

-- 
Regards,
Ravi

