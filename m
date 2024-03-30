Return-Path: <linux-kernel+bounces-126282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C18934B5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E21B235E5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44FA163A86;
	Sun, 31 Mar 2024 16:44:02 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C214A4D9;
	Sun, 31 Mar 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903441; cv=fail; b=Tr3IKI6JE8HBe51KmuyQtTmHdoYl0LKVSLRdxO1e+obMWSwOrj35LNp4zaoVWVhnxwlu5PG8g6lwZH1Wi6dYwg/YI4zHNQkniYEj8cPX14DSA017ax3BGoAKbI53oh8PBRSSasv+cRmdqek7kq9Q/uFMkhQ7vFpwCHD/WMrTPD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903441; c=relaxed/simple;
	bh=9WphwCVi05LVrDNKtbCDVwpKJ1Wsrq2jwUo2S8lj2XM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQYIHicUpFPwzAf4V2brSWXWksX3KHiZ5LHyRyDSy8w1sEi27yqx8tUX2HdvilI1Svv2BpNKLRpij65CKDV0NPl08kTjLZ79FvMdPBabAX2nLzARu5Id8lehKnV3RN4kxP95084oAkfS9XlMdczHYqKsp7Gbm/JL+6hJly4tmxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A9DC320896;
	Sun, 31 Mar 2024 18:43:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6FZ_I6U5ETr; Sun, 31 Mar 2024 18:43:55 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 48C172083B;
	Sun, 31 Mar 2024 18:43:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 48C172083B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 3B221800061;
	Sun, 31 Mar 2024 18:43:55 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:54 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:51 +0000
X-sender: <netdev+bounces-83487-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoAIU+mlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 7580
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83487-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8E3BB20897
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


X-sender: <linux-kernel+bounces-125571-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAJE+mlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 7581
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 03:30:50 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 03:30:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C4CB7208B9
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 03:30:49 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -0.751
X-Spam-Level:
X-Spam-Status: No, score=-0.751 tagged_above=-999 required=2.1
	tests=[HEADER_FROM_DIFFERENT_DOMAINS=0.249, MAILING_LIST_MULTI=-1,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=unavailable autolearn_force=no
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 54D5NqH_Y8vj for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 03:30:49 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125571-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1A27220897
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1A27220897
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 03:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50611F2232D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC225660;
	Sat, 30 Mar 2024 02:30:31 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BAA23;
	Sat, 30 Mar 2024 02:30:26 +0000 (UTC)
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
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V61QH5V2nz29dPk;
	Sat, 30 Mar 2024 10:27:35 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A44D8140113;
	Sat, 30 Mar 2024 10:30:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 10:30:16 +0800
Message-ID: <dc74b6fc-1edd-4532-b08a-a55a49c56fd8@huawei.com>
Date: Sat, 30 Mar 2024 10:30:16 +0800
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
Return-Path: linux-kernel+bounces-125571-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 02:30:49.8254
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: adf8e3a8-6a21-49db-6ef4-08dc506169e2
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-02.secunet.de:TOTAL-FE=0.024|SMR=0.025(SMRPI=0.023(SMRPI-FrontendProxyAgent=0.023));2024-03-30T02:30:49.850Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 7035
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy


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



