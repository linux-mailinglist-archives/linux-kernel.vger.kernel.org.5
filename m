Return-Path: <linux-kernel+bounces-85407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8786B57D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22C11F288AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091FF3FBA6;
	Wed, 28 Feb 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj1JrxiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124F208D7;
	Wed, 28 Feb 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139821; cv=none; b=MhtxJG/SMx1IXEkvb3KMWoWD9aM5rkKbdBgGgQBpFj0weWjuMpi0o0s4J1OqFUQ/ZXkS+6rD2BIZ67MD323BhQAT8Vnv34ExajFy0/0wSxQ2SKW3DRPs2G57Jahqq1l8hgAOt2LzX7lbKxryCdAqQIHopB09Zsg+Ed6aA55Bldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139821; c=relaxed/simple;
	bh=S/6RXer/Iy4usF2UTMTh4mOioXIr0Eu6d5gI1EUscEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROxklc81Mdc7ItP6TDl7igTLR7iR5Bxp8ES5vaMt67I374SaVhRdnz9ZEVLUoCl5hRDv54akxrKf5CPpS6+uHp8N93yQheUUegRwcc200wVBN7GbEHpHFWGNzPM3WwT0zHIKwufHxp46zaGU332PhfIJf4CeKd5H/xSZMv9FJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj1JrxiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A94C433F1;
	Wed, 28 Feb 2024 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709139820;
	bh=S/6RXer/Iy4usF2UTMTh4mOioXIr0Eu6d5gI1EUscEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pj1JrxiE2ap21L8oriZilmCozDhK4djbGRyvjaMBqOvXS9dJJhvyfA6hl7D5pTiND
	 rwuNFKpEEZOoFATtUe57ZqQVGjuwUFFE3f0nrglB9YaTbzAxfzzaQ6/JofE5Wqj8fr
	 Gh+R4T/etyKm2OFRBT2ESUIpxbDniN4ahGAV1jx1ltdMsFv+Grd1z16iA9hFkaI/IA
	 l2ssZNbzb2F4rnYZLTO3Yon7/qbaS7pPIHruFS9pAVXMMoXNR61P52pTd7x6MccmLh
	 3eVMOte9WwNbZ9uVbDQWIrbX4cbT5p1AHZscaoCFTjOmayxOEDZE7Yg76TDAOPllAI
	 9+cF2nP+dalwg==
Date: Wed, 28 Feb 2024 11:03:38 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alex Soo <yuklin.soo@starfivetech.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Message-ID: <20240228170338.GA239206-robh@kernel.org>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
 <20240220-bottling-reverence-e0ee08f48ccc@spud>
 <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>
 <20240223002443.GA3877354-robh@kernel.org>
 <caea26e2-6598-4796-b199-4ee5b1b9cd30@linaro.org>
 <20240224-smudgy-eldercare-d5d8640d9961@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224-smudgy-eldercare-d5d8640d9961@spud>

On Sat, Feb 24, 2024 at 07:20:30PM +0000, Conor Dooley wrote:
> On Sat, Feb 24, 2024 at 09:46:53AM +0100, Krzysztof Kozlowski wrote:
> > > I would like a solution though. The only idea I have is passing 
> > > SystemReady cert, but that's an Arm thing.
> 
> I don't know jack about SystemReady

AIUI, Risc-V is working on something similar... 

The primary intent of it is to enable installing off-the-shelf OSs.

> - I had it in my head that it was a
> system level certification. I am wondering how you think that
> SystemReady certification would apply to a whole binding (I can see it
> being a per-compatible thing, but that would be a mess I am sure).

There's a lot of pieces, but I'll stick to the DT aspects (which is 
SystemReady IR band). Certification applies to a specific firmware build 
(which includes the DTB) on a specific board. The testing requirements 
at the moment (for 2.x) are every binding (compatible) must have a 
schema, but warnings are allowed. 

So a "stable" tag would apply to a DTS as a whole. That of course 
implies that everything within the DTS is stable too. 

One wrinkle is that SR has no direct requirement that the DTB come from 
anything upstream. Indirectly, the schemas must exist and be upstream 
(or acked on the lists) and various distro kernels have to actually 
boot. For that reason, if we had some tag, it would have to be 
distinct from SR.

Rob

