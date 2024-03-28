Return-Path: <linux-kernel+bounces-122206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9688F372
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9995B298DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5DA63B8;
	Thu, 28 Mar 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLqueXr2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFB193;
	Thu, 28 Mar 2024 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711584890; cv=none; b=ZMNmRpfwZfpQckhrCZMy+Cl7gvHdkPbE16XXOJHpFqXn+6OF4W9lJiybb+X/MF3RlTMMpc/bzxxUx6aVr1HWSR3qu3a0xu9eQEycx7Rk8NcTKBbR+bpq8j5BHW+0FXz6bEcVifoErceXLShmWzCUhPKNJ6Ar7UzD8EjM7bNxxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711584890; c=relaxed/simple;
	bh=U3whqh+h92djJE+ccHeIUYy3OdXDp6502ZbzZd20Pn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bw7fmsXPgawrsEE36WAKW2k4oF/5sYh0Dy5FrspgQNjMvPOxPpExQ4JplS5Ux1DGu58r9wjXBZ4QH8YH6Kvsd957WJ6N6ncsWQshheQa6fqTujhDpdgNyijVy6G4Qq9I74lh9V9BnZ3Ymmi/VBdnsWhFqmzVaS14Dw/kVraxEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLqueXr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5326C433C7;
	Thu, 28 Mar 2024 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711584889;
	bh=U3whqh+h92djJE+ccHeIUYy3OdXDp6502ZbzZd20Pn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cLqueXr25I4JUW7585rVHtP94MotWv+ODQVGmFJiXRwpTgKY1XWSavwUXk839LPtx
	 /PaUrpm97GfJ6+UG/OMZfHNaAyz8KtAWdGKENsGEnZf+2PHElGhyVg3a4UItsZutIi
	 eRwkX7zWil/wNa2tfMfBGHxRXZKgJArgMrITAjWTvNMRDYh/i/ZdnKkhxKgi8NTZtP
	 A/4jPBhgn/uXPaK8qoJ3cQGEhXiKZJq8sXH9sXNmfL6fMMrxAh70yjntnFPPGoTEVX
	 OGT+Gkqz16Y2c5ExeyGzFhiLe6mLnYURo+l/RJF3Fu95FCUKY7tbkhOwgiVAV+YaNH
	 ltdmt2IY6e5gQ==
Message-ID: <5c4f29c7-2f43-4615-bb1d-081e62688707@kernel.org>
Date: Thu, 28 Mar 2024 09:14:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] sata: sx4: fix pdc20621_get_from_dimm() on 64-bit
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Nathan Chancellor
 <nathan@kernel.org>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145348.3318887-1-arnd@kernel.org>
 <d7fd5998-8813-4f29-a8d2-b82adbdec11c@kernel.org>
 <019b81ac-6ecb-44f4-b878-7a6f734010e7@app.fastmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <019b81ac-6ecb-44f4-b878-7a6f734010e7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 05:21, Arnd Bergmann wrote:
> On Wed, Mar 27, 2024, at 02:36, Damien Le Moal wrote:
>> On 3/26/24 23:53, Arnd Bergmann wrote:
>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Looks good to me. I can take the patch through libata tree, unless you prefer
>> taking the whole series ?
> 
> Please merge it through your tree.

Applied to for-6.9-fixes with a fixed up patch title prefix ("ata: sata_sx4:
.."). Thanks !

> 
>> In case it is the latter:
>>
>> Acked-by: Damien Le Moal <dlemoal@kernel.org>
>>
> 
> Thanks,
> 
>     Arnd

-- 
Damien Le Moal
Western Digital Research


