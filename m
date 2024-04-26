Return-Path: <linux-kernel+bounces-159809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456A8B3462
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DE41F233EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0A14036A;
	Fri, 26 Apr 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="R5Bo7mRx"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57A13F42F;
	Fri, 26 Apr 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124651; cv=none; b=OrFZUB9ITAQy4XQWq76N0qGMCpJnrBiwlgK1EKDBn1hi/NMtmaXFOUPWPo2krks6+42gO8JbP4KIPHSLxqlmijqeV3lN+pz6x4NlpQynPF1R4jD/FqOGpjGdSPI65ENnxvj5/XPsCH9Y8vxuAVXFbpf1xWUOq5N+yxNo8JljbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124651; c=relaxed/simple;
	bh=5E3B17m8uLwC20aNoNMZoOGKpedUvgx2ahK7LQM5YK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwcxOH58zoOnN0XCui9Wt5mac6+OTsX33/lb0WMYcAbs/gpTahyuB/3NJuRMVWCseC3xAZCGNSsXB/WHirLSyRvh6YZCoBaLbi07JN/P8w36/6udEedTOiAgeqK8MFnBxwIQkEtjtOcWFRs9vK+SZKiyv47B7pHIGqXHJjNBXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=R5Bo7mRx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lrRX54MnE7N1SwDYnQYFuVjnKtKhZl0KPn/EaI2eehw=; b=R5Bo7mRxV11CrcOoUILAQR0VsE
	nfx+FD817knGHxCeFc4qGwtSD+YzVzxrVDg7PKrTZCnO+GVJwoFTcDgee040CPmp+3TQugxdEd4zi
	+gyQ/yN6+5aWmhVwrwNbByTSvKI8j+kBDMy37qtWk6OGK2Mubqk5km8mGDG47lXsNLXY=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0I7f-007t7d-0m;
	Fri, 26 Apr 2024 11:44:03 +0200
Message-ID: <c0161817-1bf5-4749-a20e-de962b76f651@nbd.name>
Date: Fri, 26 Apr 2024 11:44:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next v3 3/6] net: add code for TCP fraglist GRO
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240426065143.4667-1-nbd@nbd.name>
 <20240426065143.4667-4-nbd@nbd.name>
 <CANn89iL-4CB3-+mMtBQapXV7EaCzOWOU1MRp4X1tUtjaXfbk=Q@mail.gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
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
In-Reply-To: <CANn89iL-4CB3-+mMtBQapXV7EaCzOWOU1MRp4X1tUtjaXfbk=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.04.24 09:47, Eric Dumazet wrote:
> On Fri, Apr 26, 2024 at 8:51 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
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
>> index c493e95e09a5..ffd6b7a4163a 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -332,6 +332,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
>>         flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>>         flush |= skb_cmp_decrypted(p, skb);
>>
>> +       if (NAPI_GRO_CB(p)->is_flist) {
> 
> 
> Please add unlikely() for all NAPI_GRO_CB(p)->is_flist checks added in
> this patch.

Will do, thanks.

- Felix


