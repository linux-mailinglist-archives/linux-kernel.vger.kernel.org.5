Return-Path: <linux-kernel+bounces-126099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F289322B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4972DB2164C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC2145355;
	Sun, 31 Mar 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QriMG5bP"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB6145340;
	Sun, 31 Mar 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900898; cv=pass; b=pD8Uvo+Fu735KWGeahlOeDbqpwxlVdLO6dGvzSUZk2+u2smMy7K2mCyNOvAOQkmx0MxTZ6g6oLI1/hrO88/i6bVqlHhXl/PbMTSwm88jLLWIx4A8IyBdztWASEcmAeg0snvLOMFpPCoBw0WEJmTT2wEcoos6zKVPzYL+y59E91s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900898; c=relaxed/simple;
	bh=1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=;
	h=Content-Type:MIME-Version:Subject:From:Message-ID:Date:References:
	 In-Reply-To:To:Cc; b=BXnUfc8M215Lp4CF3t2NUkEtfQYj3TdrFFkYNuTfPV0P/zuYpHtRLKTHYaA6bf9StZ1cnS8qkyb8faA8CDmIkLIvqUdgheqDXz3FjJZ69XlZcTw6T+VKX6deYVU2Gh2RF1BGKtJSV7aZZPYqa3p+2jVxjE++igaAKLyjmg7YYnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QriMG5bP; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DE28A20799;
	Sun, 31 Mar 2024 18:01:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MONWvnqNRudz; Sun, 31 Mar 2024 18:01:32 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 942FE207D8;
	Sun, 31 Mar 2024 18:01:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 942FE207D8
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8663A80004A;
	Sun, 31 Mar 2024 18:01:32 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:01:32 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:41 +0000
X-sender: <netdev+bounces-83482-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoA+Q1rGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAHcAAADMigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12207
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83482-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com E4B95200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QriMG5bP"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752631; cv=none; b=eLispVzL4Rucdj5yrzfRgnSRePLp+Y1FD2BRZyUX76ykzaZw7VHi9YXASU31baAxoYFmxYlpOQR4UYS8gEjEpjt1zGwq62prz06qhAHc+483Hh1xmTXYFXP7I4YViQd6l9vns1N932S+E0brudJT0ir0I9KRIrHiq60XZoaVoX0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752631; c=relaxed/simple;
	bh=1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xg3OsV9Hn217vm8daSQu1usYD3ksPWTEpVZ2YL8e46SgPg+BrESFujNuqbVuhFeJowZ00pl26chFLpmFOjszBnk+xcfKA2Lv8VGoUK8QewV5y96v44UHH8h1j3HJYz3vCS+bWN/aej6pX4824HBLNpa31QWPvcxKcQWmCuSFNkM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QriMG5bP; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752630;
	bh=1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QriMG5bPxFDJal3+iK1Pb0iH9WyOvvWgwweQ2/D86v3oy/13nMNRcnZgIMYLJopSY
	 7KLJczmMCVMHyE0HUKo16Zlrh+oM1jIPi5sy2qLvR1xNCT85FR5iD28bsq3bhCic2E
	 9agT52MvYHoRihMvi5B1sSF3/Py9XPrQj9IBRigclTJz6rtPhf6vSl/5FSEsRqKbd5
	 AG+Y/Btm/xHAuRSBzBp5kwOLojbL6e2YNlyWE+0YcxgNg53lc484ELHLR7HwPJHh3Q
	 zxW5r1DkUTeEdz0tQrKVSD3O2p8NxXZGc3WAWBi8z8L8dwVHWkG0HVZicER5qqp8k6
	 laI6AElXluGGw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/1] Add property in dwmac-stm32 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175263052.1693.263504657362042828.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240328185337.332703-1-christophe.roullier@foss.st.com>
In-Reply-To: <20240328185337.332703-1-christophe.roullier@foss.st.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, joabreu@synopsys.com, lgirdwood@gmail.com,
 broonie@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 19:53:36 +0100 you wrote:
> Introduce property in dwmac-stm32 documentation
> 
>  - st,ext-phyclk: is present since 2020 in driver so need to explain
>    it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb:
> ethernet@5800a000: Unevaluated properties are not allowed
> ('st,ext-phyclk' was unexpected)
>    Furthermore this property will be use in upstream of MP13 dwmac glue. (next step)
> 
> [...]

Here is the summary with links:
  - [v6,1/1] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
    https://git.kernel.org/netdev/net-next/c/929107d3d2a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




