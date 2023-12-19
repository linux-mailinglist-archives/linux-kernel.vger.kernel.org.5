Return-Path: <linux-kernel+bounces-4753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA13818198
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1431F23F96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369C8480;
	Tue, 19 Dec 2023 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JsHoQmYd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6279D0;
	Tue, 19 Dec 2023 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1702967772;
	bh=dZapiql6dORMYkuzo8ACY84YTF+SVpMYuJPWE7JODy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JsHoQmYd/y7DEd1QUkdrOp0AtmDfiEx+Ahy6pCOFZBB305LybiYv8qLAzsPD9FdfS
	 I0jsKNvNJD5v2DqkT5UYIdUmY1PmiIETgIE6OREzC3zrGuOrGuwq09dIq4xzyA6EqT
	 maTdTtALIdf+yac07zjPdrSYc8vwq3uiOHMuOFIgDFC/VQFS4wMKBn84DCTq9G5AFL
	 6FJgjcow++ryrts9gNjGCUFPkiV3OBvyniewyZMyrQeQiOsh6DFYiGkU6TjefRFvV0
	 jzB0+Ilfmc8wguojsrI5GH7QVF8j3j8IUBzxhQZSaw9VFvr4UkcGePYVAMl41ulpyr
	 /41G3v9TC4sgw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvRmD32h5z4wch;
	Tue, 19 Dec 2023 17:36:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] powerpc/fsl: fix the schema check errors for
 fsl,tmu-calibration
In-Reply-To: <7259e7fe-157e-4cc7-9e82-98cb8e32bfed@ixit.cz>
References: <20231212184515.82886-2-david@ixit.cz>
 <87ttomy94f.fsf@mail.lhotse>
 <7259e7fe-157e-4cc7-9e82-98cb8e32bfed@ixit.cz>
Date: Tue, 19 Dec 2023 17:36:11 +1100
Message-ID: <87zfy6lmw4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Heidelberg <david@ixit.cz> writes:
> On 13/12/2023 06:17, Michael Ellerman wrote:
>> David Heidelberg <david@ixit.cz> writes:
>>> fsl,tmu-calibration is in u32-matrix. Use matching property syntax.
>>> No functional changes. Fixes warnings as:
>>> $ make dtbs_check
>>> ...
>>> arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml: tmu@30260000: fsl,tmu-calibration:0: Additional items are not allowed (1, 41, 2, 47, 3, 53, 4, 61, 5, 67, 6, 75, 7, 81, 8, 87, 9, 95, 10, 103, 11, 111
>> This file name doesn't match the one you're modifying?
> Hello Michael. I mentioned this as a example of same problem (I 
> originally sent more patches to fix it across DTS files)
>>
>>> , 65536, 27, 65537, 35, 65538, 43, 65539, 51, 65540, 59, 65541, 67, 65542, 75, 65543, 85, 65544, 93, 65545, 103, 65546, 112, 131072, 23, 131073, 35, 131074, 45, 131075, 55, 131076, 65, 131077, 75, 131078, 87, 13
>>> 1079, 99, 131080, 111, 196608, 21, 196609, 33, 196610, 45, 196611, 57, 196612, 69, 196613, 83, 196614, 95, 196615, 113 were unexpected)
>>>          From schema: Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
>>> ...
>> I don't see any errors like this. I guess I'm running the tests wrong?
>
> Currently I see also no error :(

At least it's not just me :)

> If you look into 
> Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml you can see 
> that
>
> `fsl,tmu-calibration` matches the change I'm introducing here, most 
> likely there is a bug in validator or syntax is not 100% correct.

OK. I'll merge the patch as "correct per documentation" and just edit
the commit message to drop the error message so as not to confuse anyone.

cheers

