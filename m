Return-Path: <linux-kernel+bounces-14160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3C821894
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA611C216E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0BE63A6;
	Tue,  2 Jan 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G8rwhKaf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995215672;
	Tue,  2 Jan 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704185492; x=1704790292; i=markus.elfring@web.de;
	bh=gRQngYcZy6y4E1YmCNwv3q/eyg7qQXOiO5J5HOCzAIk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=G8rwhKafFmtWiWXQfWNh3tpuaRZr6Mk2aWJoOrJ0b4lmWjQetRASc3pr5DEb88nx
	 VFHooMhqWTMLSfrR0QohZ4LQw9svsrOWDuO+WDNg/FW4fN2OmDj+82apQTxx6cfsG
	 WOFp3baM+slSGd1P5Qn4uTIM131ye4UIC1hZ3rs7c9D0jYIc07ugGa9Zd5ScnhVYD
	 G+LijgTiUYT1PsNvp3iNxFCRc8k5SvGLrZ+JhRmZPdGcLyAx/JFO2lSt3w0D3VO0T
	 h4GuSnRqtOztDjvA4gm3xFEqn14Oi5dcL1AlupF1tJROQeglW8UZjfIXMmL3W9eza
	 htLpSBBaT0Yjq2/rBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1rZeXN2ylN-00OMWc; Tue, 02
 Jan 2024 09:51:32 +0100
Message-ID: <46fe66f7-dc3b-4863-96e8-7a855316e8bd@web.de>
Date: Tue, 2 Jan 2024 09:51:31 +0100
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
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D7e9v+p70Uavtehw0z0Xb2sbkDRqriuLpqQu+u5r14NX1TUymHe
 LXMlDt1kM10BUr8O572p/OpstZJJN8nWOovRzy7cASdjfkqNuTuaVvHL2fmrJYdEcupKrUa
 76/1C/cXcQhOxVDJ4WZDMZx9Zw2I5LcsfOTMdz1ASCG5gTg57003NFkD2JrNK+1ZDjk/bRa
 lkb+DfYDGH2pECsAkt3Dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hUZsy6pPc3A=;VPcqsyEzMWFoDwN8lau7PvfZ5eV
 uJsNtOu7tQX40ByEzy+i5qrZPUPS3fB84Bzt6mRThI8mDe91NmbS3L0kwWbPlk6as9LJiZCi+
 mAfz7Yda9XCsQXX7lf8nm00MuHO1kouS1SwePHtlsMq0+tldGn8jkThJgPM5yBtQx99QrgXgZ
 Cm1+ttGCPU2F+SryubfZ1fitCsePnuDJtfMs4tg4AQWyxFM70xNFo6w/pPRj6hy4IAu/pXNzX
 2XY+AErPNAYpH5dxEk5K8pIIAHPxqz9FEtoahHcd71BaAce9icH+JvaVmD82nTDpV3iWeKxjR
 CiWdHgy3rr2Rds87Q5wTz8lfyQWS/3y/KOdZYrIkUiYcJQQ/MXTPtXGxx5n4fT0oqMhpJVSR1
 oeKfuP8nz8MkXpxRH0sp9AuBVHuCqz/3Md635hqWkQWHlvYQ3VYLa7IOF1ApuMT8yVC5JrJYm
 x+5nPt7OuBsQ1DuOCPe1MmTanja12B1SDflKHN+ZpHVfZRn9sPXb34DY9yUO/KejmIXoNbgSm
 YdJQC/b3mB74E8zeQhzwRbJv3aXQi0Av9mEeLtKQJEzyyzMMBqAcU2Fusxh7kUvlM6kHvVtEV
 0hAI+5PLlku1x17JrfCXIZMh6NO/2YnHV+anfX3ZnLOH/+KXA6lFcl1Qry6gDfBSEVWILkOme
 1dugcyiVIT1ENxKN2aWlD0JCcQ9plLgrzZE/5aohO/V9mNyrY5xdxv4O0JVozcfSqOScv4EUW
 KVLeU1lrzUu4iqhpWRCXcJHO5KmsNs0H8OFFsD04Cj9qVb8Yv5pxPVOd1YOfts9gSaCI+88F7
 uzKAeNw7LaV3P7vjtJJnlbUyuGRLknjZSx7SnLrtcACgZJ83x7bPEJDpGY73VQOZhPj9HdIte
 5ZQDwnAN37nTzFKXapV3+cXI0+cgDUDoKnG3px0DJjZ2V07j/8WnaGcRo04oWKN0fJndKTVTk
 dNuvaA==

=E2=80=A6
>> A few update suggestions were taken into account
>> from static source code analysis.
=E2=80=A6
>> =C2=A0=C2=A0 Return directly after a failed kzalloc() in smc_fill_gid_l=
ist()
>> =C2=A0=C2=A0 Improve exception handling in smc_llc_cli_add_link_invite(=
)
>>
>> =C2=A0 net/smc/af_smc.c=C2=A0 |=C2=A0 2 +-
>> =C2=A0 net/smc/smc_llc.c | 15 +++++++--------
>> =C2=A0 2 files changed, 8 insertions(+), 9 deletions(-)
=E2=80=A6
> I see you want to fix the kfree(NULL) issues in these two patches.

I propose to avoid redundant function calls at various source code places.


> But I am wondering if this is necessary, since kfree() can handle NULL c=
orrectly.

Would you prefer only required data processing in affected function implem=
entations?

Regards,
Markus

