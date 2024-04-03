Return-Path: <linux-kernel+bounces-129881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C758897194
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCEB1F22119
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB7148834;
	Wed,  3 Apr 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd/SRhp2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14514831D;
	Wed,  3 Apr 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152245; cv=none; b=s/PmdrCY/so6wAe7I9XxDBXlzSlEZABL6vZP07RL5AHATPhYOlGjNGcATqkF6QQy2Jstn9whBlUKbCiWQXiWujXMKGydt2H8W+mumljah3QZC7Y9My1Uz0sh3DG813Opo1mKjzcrDrbmS1C9CMdSz7z7EtRa+6XkDdD0XhPY8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152245; c=relaxed/simple;
	bh=ik1Yx7g2yV54SqbOiKkosaQPOUnk7YH54MIOwB7vzuU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=X1FkB1SEfvcRCCs6BjmbUqfrNdjrPugY9xQuTOL/ambXcRgaFzo/7RaGLYVdwTVjl1P2KCpJ0X5uH9+458P0SpRbSFgvsszX/ZDiYYbmIw15a2CqqCipZtAYtTEDJBDrfVieBd7ZECT6wb1qWhZCs6+nb4GZkOITm+femHiQ3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd/SRhp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B22C433C7;
	Wed,  3 Apr 2024 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712152245;
	bh=ik1Yx7g2yV54SqbOiKkosaQPOUnk7YH54MIOwB7vzuU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Xd/SRhp2o//KNgIe7V9q/Vqg3uMo+ldj6QJa3Gna1jr+O1daos75LaAQurJDXj7S3
	 SQpjuyBXs8LKDZxlP2b6Q+t74wd0XPqaj4IOEZ9K2UETteki/AyE1R7VudIVAZaENq
	 t/G855WrxmaMUoZu26xsKMpeZo93MW9/e+9u1lhhOArsZyD+c7TpDuzQUFPvqdAEmp
	 W8NBlBtB59+jYcGHqyzg+EJ0sbaweDiylmVe3DFIzAQgGQgLIfpS/KYgZlRv/jGOB3
	 +sqnbyIPXuYuM1xTlr7CXju+xbTt6y9gynfhQrsH0cgQH3XmKWrXtymyAWFJXgOp63
	 NXFLXnaF0P3OA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  Brian Norris <briannorris@chromium.org>,  Ajay
 Singh <ajay.kathat@microchip.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  <linux-wireless@vger.kernel.org>,
  <ath10k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] wifi: ath10k: sdio: simplify module initialization
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
	<f78fa061-3b34-47d2-a40c-bbec744f0f97@quicinc.com>
Date: Wed, 03 Apr 2024 16:50:41 +0300
In-Reply-To: <f78fa061-3b34-47d2-a40c-bbec744f0f97@quicinc.com> (Jeff
	Johnson's message of "Fri, 29 Mar 2024 10:22:00 -0700")
Message-ID: <87jzle5zda.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/29/2024 10:10 AM, Krzysztof Kozlowski wrote:
>> This driver's initialization functions do not perform any custom code,
>> except printing messages.  Printing messages on modules
>> loading/unloading is discouraged because it pollutes the dmesg
>> regardless whether user actually has this device.  Core kernel code
>> already gives tools to investigate whether module was loaded or not.
>> 
>> Drop the printing messages which allows to replace open-coded
>> module_sdio_driver().
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
>> 
>> ---
>> 
>> FYI:
>> I have ongoing patchset touching few lines above this patch chunk
>> (sdio_driver) which might go via different tree. If that patchset is
>> applied via different tree, it might result in a trivial conflict, but
>> there is no dependency. They can go via separate trees (except that
>> trivial conflict).
>
> I'll let Kalle respond if he'll take this through the ath tree vs letting you
> take it through your tree

I prefer to avoid conflicts as much as possible. In this patchset I'm
not anticipating any conflicts with wireless trees, so if we can avoid
any conflicts, please take this patchset via the other tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

I'll drop this patchset from my queue. But if I should take these to
wireless trees instead just let me know.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

