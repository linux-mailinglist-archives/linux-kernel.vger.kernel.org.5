Return-Path: <linux-kernel+bounces-4459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3291817D81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7944B1F245DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96149760A8;
	Mon, 18 Dec 2023 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gHETnA5p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77C5A867;
	Mon, 18 Dec 2023 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702940355;
	bh=XxSneoKB0phG9Xq6G4JnE0CG/YoBow6E1NyN18LLUPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gHETnA5p/lEpjV9CbNjCMYnR6kNnu4AhRFm+FRwHlwQJUiOVe9xWbRVbwXW01J2pl
	 rMEGm2Z/GC9xFC86vAB5MTbZdhgLkxTFfVB/O2IUILJSAPQP6sGKKl7lL88B0U7UBX
	 l47X7qcjTFIB314tc8qdAPvwZ58EIPp4pklot+331Ffks575JS7Tqffs4obDe6ODrf
	 oQxDUj11pP/nJnRD+XCFU5gs+SsPJMoe+HMSXCpmaSVYEL8ZxaVQeS2G6JRg7tNHC8
	 eJ4ymoeS1+9gludH6j87/vXb4AczG5rpiHVHw9xqreYgslJvTvJvY8FY55NhnM6XNp
	 tUfM53gKU7clA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C1FB3781453;
	Mon, 18 Dec 2023 22:59:14 +0000 (UTC)
Message-ID: <426f4baf-4aa2-48a5-a4e3-2fa361c0bc4a@collabora.com>
Date: Tue, 19 Dec 2023 00:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Enable networking support for StarFive JH7100 SoC
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
 <453e0abd-30a4-4abd-b5ae-63d9982ec1b8@intel.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <453e0abd-30a4-4abd-b5ae-63d9982ec1b8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 00:53, Jacob Keller wrote:
> 
> 
> On 12/18/2023 1:44 PM, Cristian Ciocaltea wrote:
>> This patch series adds ethernet support for the StarFive JH7100 SoC and makes it
>> available for the StarFive VisionFive V1 and BeagleV Starlight boards, although
>> I could only validate on the former SBC.  Thank you Emil and Geert for helping
>> with tests on BeagleV!

[...]

> I'm not super familiar with how the various pieces fit together, so I'm
> not sure how valuable my read through is.. but I didn't see anything
> obviously wrong.
> 
> For the series:
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the review,
Cristian

