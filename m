Return-Path: <linux-kernel+bounces-14311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA295821B32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD261F2289B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013CAEAFF;
	Tue,  2 Jan 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nhQYPxq8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7833EAD6;
	Tue,  2 Jan 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704196212; x=1704801012; i=markus.elfring@web.de;
	bh=c4TSuFiFOOo9FkY+Aknv57saIRU7nXw1AKJdpOYp6bU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nhQYPxq8uh/DsiJfbSD/ZPWYUxY5BYviPSL00BaXEsbLfe7JvmJMOMkj9OcILX15
	 817sRbxkylDOgrszH8R0ws/p6HMkxVdnjGaV/bOVB1m/JLMoNVI31OPkzay9QX+Oh
	 o19QLFZWeE7/QckgWesRsXK7stwrom1UVU1LRn8MJGSFNIeafjFfzfJYmCTSYvi1O
	 svgQpGrWYdJ9mz01AEJOLQ8zCvbDIkpHRT++oJQ7jiSCjVc3oS3mii7tTjfbI5VEm
	 4jKjLPYOor5vOfHWmmZnX7k7B8ZBh1pngSrguVXGpIDDrmu8KNPTdZ3cuU7s6qNBq
	 7sEFUbkO1Irof+6Tkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1qnUOS0Qfo-00bkVR; Tue, 02
 Jan 2024 12:50:12 +0100
Message-ID: <96b9d2b8-3f44-4880-a33d-dc281ca70161@web.de>
Date: Tue, 2 Jan 2024 12:50:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] net/smc: Adjustments for two function implementations
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
 <46fe66f7-dc3b-4863-96e8-7a855316e8bd@web.de>
 <b2ee4680-72e9-56a1-e0dd-9cbbe64a7dac@linux.alibaba.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b2ee4680-72e9-56a1-e0dd-9cbbe64a7dac@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fL22ir/94IlqNcjBk73dNW87D7iDSGg7z9ik73BWj7mqMtrTvxh
 j+V9tmvjN/oBHQTcXKjyUlbz3eVckEpzjzWYSCgCStu4IH79TjDwOhFqMshus/jKKTSgGIY
 rqXC07CnQD7oPULw0+ZLswbR+d/b/VBPwTupByi9JreZXuUA3i3T0dGgOyA8KXB+bawOhJ4
 RrrxHyhx+OYjJU0q/VPqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bon9xkLkqc8=;BnGmEViRLyUtFIXl3mCxKGATLqw
 pg2MakC/MQKfjCQ+3t0bzwv7sHnRbqUIiozRqCB8o86tq4YWYnIgcWMcpyk15T0OBMDVrlZ2w
 llH6+NCrXeDIIE/GdpEcPZKnFL3zW8EfGWLhDB202qTStn3fb5IyThYL0pUkurRXSwceT4gzl
 K2I6YaCW1L/ydJCsYcSHFUbMIrTIlemhKQyJR9pD0PX///iXL92dE8g0Wxu3pZhzdzfcURp7q
 MZ53REf/aWHcI5jlyk8qoPseJBR9x3Ayp9zl+ptbHBKLJR2uYq4HmroOW+dYBX62RGlOp656t
 W+P8ZadbS1FViPLO/hw/vOcYQShrMo/meWOLTk689yhtzOq2LcRe2YzsIRnMNM/uXm46BGjIU
 5DjzCqTcElqHEeTNBKLrVmp/7W44TuBW8iheLNgMyCeY3cxfrCGhAC0a+Z+a9tLm8c40dNjn2
 +n14/PePywSVpsEhKAef0Pfu9kwnizTnTlPVklgnbQePWpMjO5wNMfdN9NqZcOKG+KUOw6GF0
 rE7ps+C0dKhKjbePgohzTtTbL9A369WIvUaVRCIQ2v9xDO/aoHVaG8Zm1PWTCRNiDhibr1td2
 Z+Kc/pfIqKUdH0tIr5SRnZaqjpqLwMEplazIJfjAlpwKWTUfFR79mhD1XmSXS/W56+ZTbLP8s
 jg6O3r/TT41is4GxocTX1xL/SadkD9Ty063dQX8yZBE7rHYtG0HR82t5Ht+9V6W8Scpu2QdYK
 BEDmZbaUZy1OrFJvjvojzS91W9cPfVj3bLOlFJ9CxnLwBYSdpz596XdttJdO5fezssb5UL0nY
 ckjjslAnhdvWJDRy5DG+Y0gh3kcyZUN/eC5h5+HuZOK0wAAWSTf/tpXM1nKx3ctaHuSvCmiUG
 39J0FlLtvb75LZm9jRRhrMCQLPeNh/gsg2crET3gd7RJXKoBf9hkFGpKW1eZhMJKHWeAeneAu
 jbHFQIvsIoCsgrAWxOMBCZ+1u88=

> But it is not very attractive to me since the calls occur on low-frequency paths
> or unlikely condition, resulting in limited performance loss and the current
> kfree() usage is fine and common.

The prioritisation of development activities influences progress in related areas.


> So what is the benfit?

* Source code clarity

* Nicer run time characteristics


See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources


> I noticed that some other discussions are on-going. It seems like you are trying
> to change other similiar places.

I would appreciate if improvements can be achieved also for similarly affected
software components.

Regards,
Markus

