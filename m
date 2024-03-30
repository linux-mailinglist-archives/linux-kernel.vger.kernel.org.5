Return-Path: <linux-kernel+bounces-126176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CC89332E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052F21C22548
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F15153BE2;
	Sun, 31 Mar 2024 16:28:31 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58D147C86;
	Sun, 31 Mar 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902510; cv=fail; b=DqhriBysgfzvgFPyByM5OOQurVwoHHq9qdb4SHH2fPtfsat4AuQBm/kJcBHMpF3uK1aznKF5cxtS5mdOakljesXB7G2RcqVTgGSIOblQ+1b7JAayshnxDmxdWEEPcVJxsYXXcyqarkBB3HlmfhIX3rBNrTUcojKbw7GzqUs9YSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902510; c=relaxed/simple;
	bh=zZSsRPz08MMKme6I3ata1GP69koums1t5Altt8W7Ayg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ddO+4onXzpWTZcbR/ZwlaErHyyrs7oXbrweX1BmV6uAE6+K2d6CvzB3NHZcihmdfk6ekHH6CXJN03569wF+xT8UA9rzob/BCkGTdttoxJqfSxi80NNyjAVkH2bHrxr5Er/pR7iZB3FxrsnvyqfpsZe7Sy6t/eUhCg3+D+ku7kXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5B79D208D1;
	Sun, 31 Mar 2024 18:28:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dqH9im2vDFPl; Sun, 31 Mar 2024 18:28:25 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E78D220185;
	Sun, 31 Mar 2024 18:28:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E78D220185
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id DAE34800057;
	Sun, 31 Mar 2024 18:28:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:40 +0000
X-sender: <netdev+bounces-83488-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAEZnp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBvAAAAkIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13315
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83488-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 752C820868
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766158; cv=none; b=OFalO2thJQuPlVYlGf+pYC6ntr9FDJOzrrsqG1q9Zx1tew5xfV1ea+Bl3v8fU5vissgyStq6PALfgeEw8Q9RBdsbHZb0OV5zecCpBZkOrZKVe/m301JF8XxLNNsi4a2A1p1fQrPcSynDl6LPIBhPF5wzAx9u5WC/p8qzPNtqRgA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766158; c=relaxed/simple;
	bh=Z8aquzYwrhiTPT1lynRcdUTIL4sI4DuQGZPhxVeaKGg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnbFOcMoqLrzUoRW1fZsG6hxaeAjRFunznG/p/o8bnP9yKUl+JiXH65e3OSiir0ixmdEEOqh+HLniHcqIuQyrhZm7Ln/+82lsbQnVEe2gRgseZuJJek8HChugf9fu7w93Izx2cZRuM+qU/su8tJB62YOOLn5Wiu6XjVKcgajcDc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Message-ID: <b679e900-22e3-47c6-b9bb-7aba56efcf31@huawei.com>
Date: Sat, 30 Mar 2024 10:35:51 +0800
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<rkannoth@marvell.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
To: Jakub Kicinski <kuba@kernel.org>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
 <20240327114330.1826631-4-shaojijie@huawei.com>
 <20240328191130.47242c8f@kernel.org>
 <d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
 <20240329081501.4460ad4d@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240329081501.4460ad4d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10


on 2024/3/29 23:15, Jakub Kicinski wrote:
> On Fri, 29 Mar 2024 18:34:02 +0800 Jijie Shao wrote:
>>> These seem to be duplicating standard stats from rtnl_link_stats64,
>>> ethtool_pause_stats, ethtool_eth_mac_stats, etc.
>>>
>>> You can add device specific stats, but please don't duplicate
>>> stats for which we have standard APIs.
>> Yeah, but these are not duplicate stats for ethtool or debugfs.
> Can you say more? I mean there are APIs to expose MIB counters.
> Perhaps your driver doesn't implement those APIs today.
> But (1) it should, and (2) once it does it will be a duplicate.

Sorry for the wrong reply before, these stats are already included
in the ethtool -S stats.

According to the suggestions provided by the chip, the statistics help
analyze the cause of the MAC-related abnormal interrupt.

>> Generally, driver will reset to restore the normal state.
>> After the reset, many registers are cleared. Therefore,
>> it is difficult to analyze the reason of RAS.
> Perhaps I'm missing the significance of the reset when it comes
> to counters reported via standard APIs. Are rtnl_link_stats64
> going to behave differently across a reset than these debug entries?
>
1. These statistics are the same as rtnl_link_stats64. However, these are n=
ot updated in real time.
    They are updated only when users query them or driver updates them ever=
y 5 minutes.
    However, these are cleared after the reset, which makes debugging diffi=
cult.
2. Currently, only a few MIB statistics are required, not all.
3. Are you suggesting that we use rtnl_link_stats64 to provide MIB statisti=
cs?

>> We wang to add this information only when RAS is occurring, And
>> these information will help to analyze the reason of RAS.
>>
>> these information does not appear in any new API.
>>
>> Therefore, we hope that we can add this information to
>> reduce the difficulty of analyzing certain issues.

X-sender: <linux-kernel+bounces-125572-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAMAAIAAAUAWAAXAEoAAADwxQktu=
QQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9=
c2VjdW5ldCxEQz1kZQUAbAACAAAPADYAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0Lk1=
haWxSZWNpcGllbnQuRGlzcGxheU5hbWUPABEAAABLbGFzc2VydCwgU3RlZmZlbgUAPAACAAAFAB=
0ADwAMAAAAbWJ4LWVzc2VuLTAyBQAOABEABiAS9uuMOkqzwmEZDvWNNQUACwAXAL4AAACheZxkH=
SGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2=
ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2V=
jdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbi=
xEQz1zZWN1bmV0LERDPWRlBQASAA8AYgAAAC9vPXNlY3VuZXQvb3U9RXhjaGFuZ2UgQWRtaW5pc=
3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCkvY249UmVjaXBpZW50cy9jbj1TdGVmZmVu=
IEtsYXNzZXJ0NjhjBQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAA=
ABQAVABYAAgAAAA8ANQAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RG=
F0YS5Jc1Jlc291cmNlAgAABQAUABEA8MUJLbkECUOS0gjaDTZ+uAUAIwACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAEZnp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBzAAAAkIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEPACoAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJ=
hbnNwb3J0LlJlc3VibWl0Q291bnQHAAMAAAAPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQ=
ADAAcAAAAAAAUABQACAAEFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoY=
W5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExv=
dw=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13484
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 03:36:21 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 03:36:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 66BD720897
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 03:36:21 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -0.751
X-Spam-Level:
X-Spam-Status: No, score=3D-0.751 tagged_above=3D-999 required=3D2.1
	tests=3D[HEADER_FROM_DIFFERENT_DOMAINS=3D0.249, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxteRk3fK-sp for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 03:36:20 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125572-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5E4BD20868
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5E4BD20868
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 03:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B8B22401
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126E5250;
	Sat, 30 Mar 2024 02:35:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7E17CD;
	Sat, 30 Mar 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D45.249.212.190
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711766158; cv=3Dnone; b=3DOFalO2thJQuPlVYlGf+pYC6ntr9FDJOzrrsqG1q9Zx1=
tew5xfV1ea+Bl3v8fU5vissgyStq6PALfgeEw8Q9RBdsbHZb0OV5zecCpBZkOrZKVe/m301JF8X=
xLNNsi4a2A1p1fQrPcSynDl6LPIBhPF5wzAx9u5WC/p8qzPNtqRgA=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711766158; c=3Drelaxed/simple;
	bh=3DZ8aquzYwrhiTPT1lynRcdUTIL4sI4DuQGZPhxVeaKGg=3D;
	h=3DMessage-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=3DUnbFOcMoqLrzUoRW1fZsG6hxaeAjRFunznG/p/o8bnP=
9yKUl+JiXH65e3OSiir0ixmdEEOqh+HLniHcqIuQyrhZm7Ln/+82lsbQnVEe2gRgseZuJJek8HC=
hugf9fu7w93Izx2cZRuM+qU/su8tJB62YOOLn5Wiu6XjVKcgajcDc=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dquarantine dis=3Dnone) header.from=3Dhuawei.com; spf=3Dpass smtp.mailfr=
om=3Dhuawei.com; arc=3Dnone smtp.client-ip=3D45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dquarant=
ine dis=3Dnone) header.from=3Dhuawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dhuawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V61Xl57Vzz29dPH;
	Sat, 30 Mar 2024 10:33:11 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 919B61400D3;
	Sat, 30 Mar 2024 10:35:53 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 10:35:52 +0800
Message-ID: <b679e900-22e3-47c6-b9bb-7aba56efcf31@huawei.com>
Date: Sat, 30 Mar 2024 10:35:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<rkannoth@marvell.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
To: Jakub Kicinski <kuba@kernel.org>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
 <20240327114330.1826631-4-shaojijie@huawei.com>
 <20240328191130.47242c8f@kernel.org>
 <d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
 <20240329081501.4460ad4d@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240329081501.4460ad4d@kernel.org>
Content-Type: text/plain; charset=3D"UTF-8"; format=3Dflowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
Return-Path: linux-kernel+bounces-125572-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 02:36:21.4350
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 126887fe-1e3b-446e-089f-08dc=
50622f8a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D23055.164|SMR=3D0.338(SMRDE=3D0.034|SMRC=3D=
0.303(SMRCL=3D0.101|X-SMRCR=3D0.303))|CAT=3D0.058(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.021(CATRESLP2R=3D0.018)|CATORES=3D0.024
 (CATRS=3D0.024(CATRS-Index Routing
 Agent=3D0.023)))|QDM=3D9874.509|SMSC=3D0.165|SMS=3D4.418
 (SMSMBXD-INC=3D4.363)|UNK=3D0.002|QDM=3D13163.327|CAT=3D0.023(CATRESL=3D0.=
022(CATRESLP2R=3D0.002
 ))|QDM=3D5.247|CAT=3D0.029(CATRESL=3D0.028(CATRESLP2R=3D0.026))|QDM=3D5.06=
5|CAT=3D0.004(CATRESL=3D0.003
 (CATRESLP2R=3D0.001));2024-03-30T09:00:36.618Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8330
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.018|SMR=3D0.010(SMRPI=3D0.008(SMRPI-FrontendProxyAgent=3D0.008))=
|SMS=3D0.007
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAW0FAAAPAAADH4sIAAAAAAAEAIVVUW/b=
NhCmk8i2nLhBN+
 z93tpibpo47dDlIUVaYFs6FCuWAUOfAkaibS6SqFJSMu937Afv452k
 uMmGBYJMUnfffffdHfP3/nTiCpofzl++OH4x/57mxydHr2b0Xl83V/
 SzTWxRXVu69a42J9PJKf1S0A/ezgimH7RnRzp6fXL88uRwTt8evj48
 pPf2D2voYqXdnd/pKf22MpWhypicakdXhtKmzGyia1ssqap1kWqfhk
 Vd0cK7nHxdZJeZLa4v+fC7lzMBMvWqdi67LHVTGfk26w/xe5nr5O44
 OWAvcf3kGkp0QTpNKTU3NgGh0iR2YRNqPa6amsrMaHBNXfGk7mkagW
 gJOk+3K5us6NbQSt+YuwzOPp5XHJM+Gb0SwJpz195Q4TYQN8Ba/oRl
 aq6a5YIx6B3IrkG60mvKnTdv6Jxyg0MgekEM8YKi5s/SIciH87eUuK
 aojReIj8avdFkFGGB7e2Pw40wVcrM5Us1NERgG5xYr1Wt2fQvqT4+e
 ka2pWrkmS2eEJOnp/Bm5AtrhPCCF31ubZaGo+i47QEwnF877NWcIxq
 EfUGxvymwNY5yaWauNKBHy0Zk3Ol2TLZKsSU06nVhOt5fo+YVYM/5Z
 kjifhhaCBMGqapZLU9XWFRWV3t1YQNDVmr8lK1vOxAoAFlZJRSuTld
 OJLnS2/suIWWgscgvefDh799ybDPmkpK8K53OdgRvk9U1ZMweU+kdT
 GK+zbD3rJGZBPFKrAzMsamTLiC1GoGCkUc4WgONv7DCjXBdrrJegiD
 KyLAl60pv0IMyRF+nYF9rbilK7QA83GQfbzAVaVhhwJPPr2cUX/XD+
 JKfcVhVrFySxyyIMgg6VbZMX/rcrU4Q4ictNFSAQo2uxUEzngzg3Vt
 8bAjoD7wdTHACWrq3YleHhCfSRVVGjL3TiXYWcO/FW0u1hHsNgEKy8
 NdUb4EwnRwfdvXJXUN3qXOkc3VQ9ZHBAP7lbgyLN7g1mU6ZcZzQcdM
 uotnmoEOEPUdZs19m4AlxZGTQLdPjcGM9dlvMMSxOIcSXHIeKaXkH0
 osFhC/wvVNpSk77fFnLj5PoakCzGMsjY1x6I8wN613hRciYcNS3MLV
 8L9zTy5nNjEWfGuaN54X8sReMrpx0kbg9dh4sujMUDNUMZ20G7F+VN
 Oxy/Y/C11DtcvPUKDWuLRRiDMKcbUqJHQze7JEESiDyjsyJlDFFn04
 sHLAzv/7b86X8g8N3FuZclFA9lD3NXQC70753n3cTxbe9K0yvS/TN5
 kFPt2BXyNonQ6su0DtSEcBA3Mb7WCI1RbIxcamprS23vDFSMR0UDbA
 fbkVKRGkVqOFZxpCYw2FbR1kDt4gnrnZ1BNFZqPIjZcohnR0WR2pMF
 7PHsqj12DyfAf4y3ikbq0WigvlZj9hph/Y0aAxAPtttqX9Z4hmrE7i
 NZwz5W+3iz5TBwVuAQ76jJTncojrGayHqkxjAbqb0eE5ZIkKkOeRuo
 DjnEWE1hjxNssRAQtpxsDyCLGnBSQ7DttuK++QZ4rB71TESZYZtsS2
 nc6ok1JN8CftydiGKylqQmaheLEUskWQfkUAWBimP1OFa74CxJcb7j
 TrHdTq7wFVEkKGSUAknc3p7Bx7KV956aSsS+rBHTQ1w8LFosPDfquy
 s0AIh08OYcRckgwmgwFfWwRnZdXSJpwg4kHnHnyFepY+iioEYkJ7yN
 +t6TiHIeDYYcYis0W4cz4iqIGuKF9OPBnpCJGRkuElGIjVmx7RZtu/
 8k4b7MetwrOVFf9f0gqUEHYYstyw7wQKY/f1CFaf9141B6eAr3To2o
 P5coW2okzTxhGyQI2OE/oqyUx3cLAAABAsAEPD94bWwgdmVyc2lvbj
 0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8VGFza1NldD4NCiAg
 PFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxUYXNrcz4NCi
 AgICA8VGFzayBTdGFydEluZGV4PSIyMzMiPg0KICAgICAgPFRhc2tT
 dHJpbmc+Jmd0OyZndDsmZ3Q7IFlvdSBjYW4gYWRkIGRldmljZSBzcG
 VjaWZpYyBzdGF0cywgYnV0IHBsZWFzZSBkb24ndCBkdXBsaWNhdGU8
 L1Rhc2tTdHJpbmc+DQogICAgICA8QXNzaWduZWVzPg0KICAgICAgIC
 A8RW1haWxVc2VyIElkPSJrdWJhQGtlcm5lbC5vcmciPkpha3ViIEtp
 Y2luc2tpPC9FbWFpbFVzZXI+DQogICAgICA8L0Fzc2lnbmVlcz4NCi
 AgICA8L1Rhc2s+DQogICAgPFRhc2sgU3RhcnRJbmRleD0iNDEyIj4N
 CiAgICAgIDxUYXNrU3RyaW5nPiZndDsgQ2FuIHlvdSBzYXkgbW9yZT
 88L1Rhc2tTdHJpbmc+DQogICAgICA8QXNzaWduZWVzPg0KICAgICAg
 ICA8RW1haWxVc2VyIElkPSJrdWJhQGtlcm5lbC5vcmciPkpha3ViIE
 tpY2luc2tpPC9FbWFpbFVzZXI+DQogICAgICA8L0Fzc2lnbmVlcz4N
 CiAgICA8L1Rhc2s+DQogIDwvVGFza3M+DQo8L1Rhc2tTZXQ+AQ7PAV
 JldHJpZXZlck9wZXJhdG9yLDEwLDA7UmV0cmlldmVyT3BlcmF0b3Is
 MTEsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUG
 Fyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9z
 dGljT3BlcmF0b3IsMTAsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdG
 ljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwy MCwxNg=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 2191
X-MS-Exchange-Forest-EmailMessageHash: B1979681
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:RC:REDACTED-af51df60fd698f80b0=
64826f9ee192ca@secunet.com:82/10|SR
X-MS-Exchange-Organization-IncludeInSla: False:RecipientCountThresholdExcee=
ded


on 2024/3/29 23:15, Jakub Kicinski wrote:
> On Fri, 29 Mar 2024 18:34:02 +0800 Jijie Shao wrote:
>>> These seem to be duplicating standard stats from rtnl_link_stats64,
>>> ethtool_pause_stats, ethtool_eth_mac_stats, etc.
>>>
>>> You can add device specific stats, but please don't duplicate
>>> stats for which we have standard APIs.
>> Yeah, but these are not duplicate stats for ethtool or debugfs.
> Can you say more? I mean there are APIs to expose MIB counters.
> Perhaps your driver doesn't implement those APIs today.
> But (1) it should, and (2) once it does it will be a duplicate.

Sorry for the wrong reply before, these stats are already included
in the ethtool -S stats.

According to the suggestions provided by the chip, the statistics help
analyze the cause of the MAC-related abnormal interrupt.

>> Generally, driver will reset to restore the normal state.
>> After the reset, many registers are cleared. Therefore,
>> it is difficult to analyze the reason of RAS.
> Perhaps I'm missing the significance of the reset when it comes
> to counters reported via standard APIs. Are rtnl_link_stats64
> going to behave differently across a reset than these debug entries?
>
1. These statistics are the same as rtnl_link_stats64. However, these are n=
ot updated in real time.
    They are updated only when users query them or driver updates them ever=
y 5 minutes.
    However, these are cleared after the reset, which makes debugging diffi=
cult.
2. Currently, only a few MIB statistics are required, not all.
3. Are you suggesting that we use rtnl_link_stats64 to provide MIB statisti=
cs?

>> We wang to add this information only when RAS is occurring, And
>> these information will help to analyze the reason of RAS.
>>
>> these information does not appear in any new API.
>>
>> Therefore, we hope that we can add this information to
>> reduce the difficulty of analyzing certain issues.


