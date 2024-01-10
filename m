Return-Path: <linux-kernel+bounces-22483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC8F829E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F0D283568
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B94CDF0;
	Wed, 10 Jan 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JncVhoeV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73C4CB29;
	Wed, 10 Jan 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704903473;
	bh=+EtOCOtdFVZZmu0/IU+2UTQQvee0ExQODJbm8DNms3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JncVhoeV20g0Hsq8QnhH1inihewaLE41BKwEyxfDoEHDPo7rbIYK46svcliCMadTZ
	 I6XzbHYPrPvrwwyDFXcqJLNYTw16t+5G9TML8ZXXlXN3/VdmBctUuRt3Rnla/YbBLB
	 IePMdQ8QXupA+EuvfqiE57RuRzyeYt2AVUo3N+zc4XynYb+plyMdQ6DQnH6Kmk+Qmw
	 pTo4Czkfh+9yBombWlsZkthP6rbPd4JpQENQFDHo6rJ1x0xMmmgMeN9lDT2OMiQDlj
	 GoTwG3qJ7e6z9pR1b5YahIItC4Mg1OzqlwRpgjCMHTfHSPMq+dAzGNtUVkGL7BR2K+
	 lAk2xddcXaNBQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3A0737809D0;
	Wed, 10 Jan 2024 16:17:52 +0000 (UTC)
Message-ID: <ae15ab84-fb1b-4da6-803d-6fd5ad46ce24@collabora.com>
Date: Wed, 10 Jan 2024 18:17:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Enable networking support for StarFive JH7100 SoC
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Jacob Keller <jacob.e.keller@intel.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel@collabora.com
References: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
 <CAJM55Z9tKQ_hpxrGUq1Rx1kxzzs-dyd=4yT1z=8B7KQ=CZ4mjA@mail.gmail.com>
 <20240110-quaking-unlisted-dcae7229a9f8@spud>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240110-quaking-unlisted-dcae7229a9f8@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 15:57, Conor Dooley wrote:
> On Tue, Dec 26, 2023 at 02:38:26PM -0600, Emil Renner Berthing wrote:
>> Cristian Ciocaltea wrote:
>>> This patch series adds ethernet support for the StarFive JH7100 SoC and
>>> makes it available for the StarFive VisionFive V1 and BeagleV Starlight
>>> boards, although I could only validate on the former SBC.  Thank you Emil
>>> and Geert for helping with tests on BeagleV!
>>>
>>> The work is heavily based on the reference implementation [1] and depends
>>> on the SiFive Composable Cache controller and non-coherent DMA support
>>> provided by Emil via [2] and [3].
>>>
>>> *Update 1*: As of next-20231214, dependencies [2] & [3] have been merged.
>>>
>>> *Update 2*: Since v5, the dwmac patches will be handled via [4], while the
>>>             clock patches subset via [5].
>>
>> I'm not sure my rb my sense when I'm listed as a co-developer, but this version
>> looks good to me:
>>
>> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> 
> Cool, thanks. Cristian, can you ping this series once the binding gets
> picked up by the netdev folks after the merge window closes?

Sure, will do!

Thanks,
Cristian

> Cheers,
> Conor.

