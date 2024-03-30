Return-Path: <linux-kernel+bounces-126122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0689326E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EC1F229DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772014A0A3;
	Sun, 31 Mar 2024 16:03:17 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF114534F;
	Sun, 31 Mar 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900996; cv=pass; b=YcRrEBY2NdDDjTxlnpUT3MGKMr4bEW44/Or1c3+F07YdQtDkwxoPTCcPTJIApOMoCY9NTUa7DBZ6S9IWcIowoHC28JqPv8zV5AnMPcZRGXWpIQKOxhOSzlXvqHv/F3n3fmgfrAX7Bv10VIMlvmcUaZaiDeyYgmpVFnpmgZJ4wFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900996; c=relaxed/simple;
	bh=FzYM06Gn4eXcMiYv8TDsNHGK5q7z2Q2fcZcDEpqm1vQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qS4LOkxAmKM0Q6KDJ0SOl47TEsYAgDXCokoNe77yj5WLGitUdXrY6lVadi+pzAzWlRiCTpFu/GEus+pdE6WgVUDdf8T0jC8IZRTZuQDTYCGBrF08maKHnnJJo2lSXu16cvYo5UYjXBCAeSfHLHqAue7WcvWNvOF3jih/vynKjJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6060F2083E;
	Sun, 31 Mar 2024 18:03:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TnKknTjDI-MR; Sun, 31 Mar 2024 18:03:08 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2F370208CF;
	Sun, 31 Mar 2024 18:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2F370208CF
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 218F6800055;
	Sun, 31 Mar 2024 18:03:08 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:03:07 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:49 +0000
X-sender: <netdev+bounces-83487-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=DwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUAbAACAAAFAFgAFwBIAAAAnTlpvhaBCEeyp1ntZSMfKUNOPVNjaHVtYW5uIFBldGVyLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoA6xJrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQ8AKgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuUmVzdWJtaXRDb3VudAcAAgAAAA8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAHYAAADQigAABQBkAA8AAwAAAEh1YgUAKQACAAEPAD8AAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuTWFpbERlbGl2ZXJ5UHJpb3JpdHkPAAMAAABMb3c=
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11911
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83487-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1175520868
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711765830; cv=none; b=AdmiDJNaC62JiQIcpudeV+q1EldsV5wM56FNl2Z/wX4eL8Czph1EVCslK+misTHJkNgIwF0ahlBOoCB+1q6aIj4nlV7ubC1ihdUul1eHX8n0gROJUgQKIVxsdvMKP41VRYiMTAPM8v9SV2LJNj52bqIx+R2fCv5/qvWrFD8rqdg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711765830; c=relaxed/simple;
	bh=FzYM06Gn4eXcMiYv8TDsNHGK5q7z2Q2fcZcDEpqm1vQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A+SpIEHd+Q1nUvxNhuX9m0asdAAI8vN4Hny3ilHVWsW5ICHBjkDMIuav3N3MlLkXJi2O58JLIXkw312ghmF7lSdYmYIsXjvF5WZMOLYrF4Xa0ieYIxC7gvc9ngmvETtIZQoyF9ec7h2p1dk0xzmrOKyJst7dIUmUb5I55F7KkqQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Message-ID: <dc74b6fc-1edd-4532-b08a-a55a49c56fd8@huawei.com>
Date: Sat, 30 Mar 2024 10:30:16 +0800
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
Subject: Re: [PATCH V6 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
To: Jakub Kicinski <kuba@kernel.org>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
 <20240327114330.1826631-5-shaojijie@huawei.com>
 <20240328190714.16e3f86a@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240328190714.16e3f86a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10


on 2024/3/29 10:07, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 19:43:30 +0800 Jijie Shao wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> Add support to query scc version by devlink info for device V3.
> What's SCC? Does none of the generic versions fit the bill?
> https://docs.kernel.org/next/networking/devlink/devlink-info.html#generic-versions

SCC means "soft congestion control", which is similar to fw.roce, but not exactly the same.
It is a firmware dedicated to providing congestion control for roce,

> If not you still have to document the meaning of this component
> in Documentation/networking/devlink/hns3.rst

OK, I will describe this inDocumentation/networking/devlink/hns3.rst



