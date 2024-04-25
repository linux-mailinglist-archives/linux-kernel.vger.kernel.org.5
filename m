Return-Path: <linux-kernel+bounces-158799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D668B250E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD870B25C13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4F14BF8D;
	Thu, 25 Apr 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ASKA0V/T"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515814A4F7;
	Thu, 25 Apr 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058783; cv=none; b=CCFRiPJtnbFVudI8Q1HGlxIPxzq1Y7Lr0E5isu+qWGfGGVWjkhHocwML4oe5AG7YYPhhLQ94u4nGyXdzHuaUgDo11WP0kt34jCYh9Lgu52abiMTjiPBb6j4wXIni890/Y4ZpO9nc7Lorz5bQhwO4dKOnrx9NkBCsS9hAeWZgyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058783; c=relaxed/simple;
	bh=7r2g/k9QKTYH0/rkJOxShu1To1RYmF5jrIAZ3dT6LN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNhNVqcQx8nLvr2gmsawMrLgt7RKBKZ6tvM3u9dxW+Jt4+kazc7J9am/3Zi4uV0fDHhtt9vl8MxOWII+ZpLRa/0kNp63K7JJIsHbeataIfKD/wodwod+lx7fZlxWD+tj1vIgWeuok6FtMwchuWjJF/b+gqsIKPTUmM6BDL/tq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ASKA0V/T; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Obb/rZ2G8UREVirSuXXXHYjBxvBYCMlhPz7vKypJhoo=; b=ASKA0V/TFeWHJmOPqRV087dYUo
	RNXsVPWwMYTbE4LFZ3efSMYj+x3y6qun61jikRc75JieeSypu/vmx4cy0NXg+vX+ROOs+yF+ddyET
	KjooURLJMneIpkiF/JlFAgAXid8DdLJfUx8Nh8vOsP8mekChJDDU01OAWaHrLpnRnI8M=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s00zH-007N8M-2Q;
	Thu, 25 Apr 2024 17:26:15 +0200
Message-ID: <13dd8a93-3bfc-4046-ac24-b3e188a53f0e@nbd.name>
Date: Thu, 25 Apr 2024 17:26:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next v2 3/5] net: add code for TCP fraglist GRO
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
References: <20240425150432.44142-1-nbd@nbd.name>
 <20240425150432.44142-4-nbd@nbd.name>
 <662a746130c38_1e1a1629422@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <662a746130c38_1e1a1629422@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 17:18, Willem de Bruijn wrote:
> Felix Fietkau wrote:
>> This implements fraglist GRO similar to how it's handled in UDP, however
>> no functional changes are added yet. The next change adds a heuristic for
>> using fraglist GRO instead of regular GRO.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c |  9 +++++++++
>>  2 files changed, 31 insertions(+)
>> 
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index e455f884190c..68157130c264 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -336,6 +336,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
>>  	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>>  	flush |= skb_cmp_decrypted(p, skb);
>>  
>> +	if (NAPI_GRO_CB(p)->is_flist) {
>> +		flush |= (__force int)(flags ^ tcp_flag_word(th2));
> 
> What is the purpose of this check, given the existing check above
> 
>          flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
>                    ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));

The fraglist codepath is not updating the TCP flags of the first packet, 
so the extra check ensures it doesn't have to.

- Felix

