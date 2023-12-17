Return-Path: <linux-kernel+bounces-2574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC2815EF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03061F220ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BB32C95;
	Sun, 17 Dec 2023 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="P76naHpD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0532C75;
	Sun, 17 Dec 2023 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 296A660002;
	Sun, 17 Dec 2023 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1702815753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ9+X8UPHQ1C4KdlT7sb5rWe9T6k+4CZlMLjRudRS3c=;
	b=P76naHpD1ejJeFeHEeU02JVcJ4Mw7kDeqFc+q3LbT0mYGVKMQErzpJ6D3Ud0Eyd8nESW3Z
	OafvuwKIUMqp/3NU3DNN3zGrrgzaDXn4Aheh4nWBsg0LvIgH250awevxCF2IkCz3cg3S98
	18iRVuQfaaxwn/xSU1BC/SLzssPafOZrS3Mkx4dZK9FC/ZXFDM1gTD5zoAdL68hy9VmlOY
	TtZ5zy0a6hjlcaB/sTzadHUHVLi+dc6/WsN61tIEW0svDyaXFkxjPWiv+C8SqvajS2YZFp
	wc4bjs4FPpKKuShXmGHbtZBidjGtHUUtPMRccgUZC2UvVgsszl7DTyHFBCDBVw==
Message-ID: <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
Date: Sun, 17 Dec 2023 15:22:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Horman <horms@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231208184652.k2max4kf7r3fgksg@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 8.12.2023 21:46, Vladimir Oltean wrote:
> Hmm, maybe the problem, all along, was that we let the -ENODEV return
> code from of_get_phy_mode() pass through? "interface" will really be
> uninitialized in that case. It's not a false positive.
> 
> Instead of:
> 
> 	ret = of_get_phy_mode(mac_np, &interface);
> 	if (ret && ret != -ENODEV) {
> 		...
> 		return ret;
> 	}
> 
> it should have been like this, to not complain:
> 
> 	ret = of_get_phy_mode(mac_np, &interface);
> 	if (ret) {
> 		...
> 		return ret;
> 	}
> 

I just tried this, smatch still reports "interface" as uninitialised.

$ export ARCH=mips CROSS_COMPILE=mips-linux-gnu-
$ ../smatch/smatch_scripts/kchecker --spammy drivers/net/dsa/mt7530.c

   UPD     include/config/kernel.release
   UPD     include/generated/utsrelease.h
   CHECK   scripts/mod/empty.c
   CALL    scripts/checksyscalls.sh
   CC      drivers/net/dsa/mt7530.o
   CHECK   drivers/net/dsa/mt7530.c
drivers/net/dsa/mt7530.c:217 mt7530_mii_read() warn: call of 'warn_slowpath_fmt' with non-constant format argument
drivers/net/dsa/mt7530.c:454 mt7530_setup_port6() error: uninitialized symbol 'ncpo1'.
drivers/net/dsa/mt7530.c:868 mt7530_set_ageing_time() error: uninitialized symbol 'age_count'.
drivers/net/dsa/mt7530.c:868 mt7530_set_ageing_time() error: uninitialized symbol 'age_unit'.
drivers/net/dsa/mt7530.c:2324 mt7530_setup() error: uninitialized symbol 'interface'.

Arınç

