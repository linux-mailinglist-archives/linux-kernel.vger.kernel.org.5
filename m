Return-Path: <linux-kernel+bounces-157029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351218B0BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03C71F2756F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2015DBC1;
	Wed, 24 Apr 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="lPLRKmLA"
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5215AAB1;
	Wed, 24 Apr 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967291; cv=none; b=pPj0SonUpUSWMQoSgMyWERp/I1kUI0N2DkOqGpHkruQ+rKH5IhOG7evvj3jUTBUCuaH6OcrNlNeiTiUMOJ10FCf5aAnEzhhbWMniL1AhWch0Pr/y7mWzSG5lmeCxJPEl/tRomrJpLXHrdIhK2iBQzd0ck9qlMujy2M8TNohtals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967291; c=relaxed/simple;
	bh=j/iACYga1p4ALh5Eq/FqbTtkXQ5ecREm3EWO4B+ireg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plc151nwGRLCHBo+LvzLehNbf1iHJC+Swy7Yle75F/Y9dG8RG5JEcUk9nzVBarT9GGwBzdog3H/0lxynb99KKExNGlg3G05m95UsoXdo7Y00TygcVP1/yCvQ5j6uAJYjdILRNjwosNBAnI5HhjtyEQOFbuqG2le7aAYb8/cN/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=lPLRKmLA; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
	User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	Content-Type:Content-Transfer-Encoding; bh=JmPMccEVXAH6bGesdu2XX
	zoFfwwUc2sDrfebx2z6tcg=; b=lPLRKmLAvXfBAnTDqq5NrP/90whpuXNVkSRcO
	2mRUrkAnR34ybCTENGxXAMnEqlRF7BX/jlMtZjWerThppDhOFFd1ED1ML3gdGt56
	LkNW0Fa0mEZPSAnUfsxkxdufgD7bdTDs8Egt8S0+36/nGncEA2SoPkqdraDuPNT5
	FMheIc=
Received: from [192.168.1.103] (unknown [10.130.147.18])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCHkzqREClmlm44AA--.27712S2;
	Wed, 24 Apr 2024 22:00:49 +0800 (CST)
Message-ID: <fdc7ada8-6ca9-4835-982a-3e45ee7ac009@buaa.edu.cn>
Date: Wed, 24 Apr 2024 22:00:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: Fix null-ptr-deref in pn533_recv_frame()
To: Krzysztof Kozlowski <krzk@kernel.org>, Yuxuan Hu <20373622@buaa.edu.cn>,
 gregkh@linuxfoundation.org, johan@kernel.org, davem@davemloft.net,
 u.kleine-koenig@pengutronix.de, Jonathan.Cameron@huawei.com,
 francesco.dolcini@toradex.com, jirislaby@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn
References: <f229256f-ceac-4a82-afa4-ecea67712ec3@kernel.org>
From: Yuxuan-Hu <yuxuanhu@buaa.edu.cn>
In-Reply-To: <f229256f-ceac-4a82-afa4-ecea67712ec3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Nyz+CgCHkzqREClmlm44AA--.27712S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4fur13Xry3ZF15Cr4rKrg_yoWfKFXE9F
	Z0v3yDWrn3Xws8K3Z3KwsFgr4aqas5CryUtrZYkrsrKr1Sva98uF4DXws7Kw4UJay2gF1q
	krn8tw4UWwnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
	x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE-syl
	42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrXryUJr1UMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

Hi Krzysztof,
Thanks for your reply.

On 2024/4/24 13:36, Krzysztof Kozlowski wrote:
> A bit better solution would be to NULL-ify dev->cmd at the beginning of
> pn533_send_async_complete(), because that seems logical. The complete
> callback takes ownership of dev->cmd, so why it performs the assignment
> at the end?
>
> However even above code will keep the race open for short period.
> Probably some locking would solve it or checking for dev->cmd in few
> places with barriers.
>
> Best regards,
> Krzysztof

I think adding a lock seems to be a better solution, however, acquire a 
lock on each access to dev->cmd does not seem to be an appropriate 
implementation.
I wonder whether you think it is appropriate to acquire a lock at the 
beginning of pn533_recv_frame(), and release it when 
pn533_wq_cmd_complete() is finished, thus ensuring that another work 
will not start when one pn533_wq_cmd_complete() work is not yet finished.

Best regards,
Yuxuan


