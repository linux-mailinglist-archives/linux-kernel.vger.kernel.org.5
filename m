Return-Path: <linux-kernel+bounces-14119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783882180A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1121C2156F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977523C3;
	Tue,  2 Jan 2024 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DAo3I87Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FD20F8;
	Tue,  2 Jan 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704181113; x=1704785913; i=markus.elfring@web.de;
	bh=4njice7TZkWFEO2ORipwga62AkVl5tLjIIrG5yvHNOw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DAo3I87Qcp6nkZVpLswU4ZBX8RZfBSPwittpiQmcr8H9YN9aaF4VHZeIxP4i+uNh
	 ky5xiIarNI62pcOpcDtGzO8vwRcYfNRvw1GUuSGEhPG9NpRv+obqCvt+cy7F4iVH/
	 iJZ5D6beXX97Tr7zj8DClx5ZCDICq+7MQ6RPluj4wc+KF7a5f4ETaYS/a4NDiYoSN
	 uB5PoDsrgod2U6DQuluudB0UvxmhTgk8x9MfmeO6P+ZPQsgQpie7cuJwEMcID6uxW
	 Ds1Pe4WxzsJ/3Y1IWhxqjpBvSkevIplZsTQJuaH2H3lJrnYIBuqHeLu1SvlTuetnZ
	 NJEqxBWiB0STyZkZGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1rKZM83i1g-000R6n; Tue, 02
 Jan 2024 08:38:32 +0100
Message-ID: <8123a895-c7dd-4a75-94bc-6f61639621eb@web.de>
Date: Tue, 2 Jan 2024 08:38:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/iucv: Improve unlocking in iucv_enable()
Content-Language: en-GB
To: Suman Ghosh <sumang@marvell.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Alexandra Winter <wintera@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <cde82080-c715-473c-97ac-6ef66bba6d64@web.de>
 <81f7db31-a258-4dc8-b6e1-c1ef1844a9d2@web.de>
 <SJ0PR18MB5216C27127E46490951A1E5DDB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SJ0PR18MB5216C27127E46490951A1E5DDB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cqHRG7UKZQaS0q8IliuDG48Y4tyhs8cnh4prGvo1r0odVrIpBGf
 O7yRr+9J/cgQIS9CL+gr2lonIkMhKzk7qoIcf395+5e4U1VedHkNmUIyfeJgKmD4Bcz46IC
 1xU26WW3PBtELuZQ9sYN6eV1r7ovhNYn2Ctqgl3Ku1yPKaYe1OI0qDrNekJxYXZZcrEw2gk
 WcxJWadYNVpBeTgg2/YZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p3uLdUUnCn4=;QP+s2+l1t3HNNqicb2JuvNRmosA
 Pkj9/fzolJkqBMMHCsfnJk8JnOGt71C2ip8+RuUntITroyW8MCOZima5CfdbGToDrcBRImEs+
 G3cGpRyN6erza4HqN4VvhLRrSxGd8hMMEMZ3IX3UT4KEr3SyXTIBCOc4pmW/KVCS1SlOy+CiM
 AXzfzaeTR9TjkmQaCqZvG0XGX7hI2eMKlD4b7D1oDtGCYe14sQ8nN/EDwVGHGnprL+D/oblAP
 SUGCrjo3VBilR/0TYfWeVuq5HmysVi7V0RFG9qaqcPL1oZlCzGdB4+EaOgJHl8Ohlt6rmFcRw
 z0GOvYUJL7B2nA8cBl+9XuhnKhw+eik7xlzj1pYllwGeCiNCehA02oHTWUzzj8ttYiJ5obLQ0
 8Vd3bnaedbhtKDcUzNrL8zzFuzaLWBb2lYh3lBAvqecJ58kEDDSvYtfZCJ75Nerh2mLuDZKzu
 WwbdNTMRHWr9bfPa3bIpyocyWYPLsyawIacZ2AeS5oIf1I03i+sEF0gXuy/YdFeOLKDvMf0xD
 PUyVtHhoke9gGQdQP5sNIbX+SsJy3oiG36MK5ydKzkLaTr7Y1HBtiLIDvdyeNVamyqlDTaQpc
 Xr1kWM8g0yhdl/ujzfD7AcRRyxSxhu+DbUyGQiLgfxZkuLLhQW4p3ZqcNs8Ro25F8bNMqOHdX
 XyLGf2o9ZEMy9yxuIOkjD42njHup6PAnBGu+ByzZs+xdhacsHqGXR+iJE9p247DD9fVNtNGlR
 AlLEkwh8P2Skphc/Wn3S3dkoOa0wbQQpm74xhuP5/HWIrdWiJBSmoy27XEC6lhH2BWLjTbI2m
 ytbfDvrydfB6ln7+wCBtQOhaagt9pqWsxnaZczjEsG7mbvLOcMoxzPhIpylx0+d/8OcKAvdYZ
 Fo8j+F81xtx1ogVZ28FjssyMeZJW1Yde4SQvlRTgbmku9lwqsPIKJiDui2EXXIOeg5inp6r7E
 LgczCg==

> @@ -555,13 +555,16 @@ static int iucv_enable(void)
>> 	if (cpumask_empty(&iucv_buffer_cpumask))
>> 		/* No cpu could declare an iucv buffer. */
>> 		goto out;
>> +
>> +	rc = 0;
>> +unlock:
>> 	cpus_read_unlock();
>> -	return 0;
>> +	return rc;
>> +
>> out:
>> 	kfree(iucv_path_table);
>> 	iucv_path_table = NULL;
>> -	cpus_read_unlock();
>> -	return rc;
>> +	goto unlock;
> [Suman] This looks confusing. What is the issue with retaining the original change?

I propose to reduce the number of cpus_read_unlock() calls
(in the source code).

Regards,
Markus

