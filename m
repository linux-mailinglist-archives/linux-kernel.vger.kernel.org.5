Return-Path: <linux-kernel+bounces-79304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0B586208E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99791C22151
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7B14DFE5;
	Fri, 23 Feb 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="PG+nMijZ"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366514DFD9;
	Fri, 23 Feb 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730196; cv=none; b=mZENTp3CPDycEQsFeDVpkCPOxGYwETaERRsZJA1+h3MlIru23c4tN3i3aITufa5sII7iXCOyzLC/HYQkcrvZWqXN9tZkznF4o9KbB91s1a5YczQO8XK8lHct7/nv5l65DXXVYiIsYhLv2oCBYcrZTe4Xsrc0kkoeLvN4G13Wil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730196; c=relaxed/simple;
	bh=sD5o9ytpcDH7D0YW0iwMBjx+SPKuqMrI8GiCcndNMzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in25oqUyZXr6yvneiujeRmyQBYilJDMpDorAV88LAufafCkFC5gq6+BBI/64Fw0ZBdr+Rg04kZAQzibi2hMbj9l+mCWMusqFpv4uRlI8X0yBPJefajFg1lxfdDjTOoDaAuJD+rfjS90yyuYKI9I/+Re9UXrhaYxCCQhkDlCovQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=PG+nMijZ; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id F1421432C;
	Fri, 23 Feb 2024 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708730188;
	bh=ppx1ytb4Z5XMnVomPwe/hSvw18GYGbq/qxUl7v7Ia/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG+nMijZMei0y1HU+vJalvgYAtcV45FvoFJVUaVP3SYrst6foDMu2IPkKTv1DhJFL
	 TZRy96Psq3i9GHxw1YpnfuG5Q9c+hvzlsEAwkIF8JuXliMVHoNpc4YwnXl/qhFDrcS
	 WMxYPRkJEZsXgleLZm8CHNf0PbYxjFq+ynQoT/fA=
Date: Fri, 23 Feb 2024 15:16:26 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: Conor Dooley <conor@kernel.org>
Cc: linux@roeck-us.net, Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: Re: [PATCH v2 4/5] hwmon: (pmbus/lm25066) Use PMBUS_REGULATOR_ONE to
 declare regulator
Message-ID: <684ee927-2287-420b-aee5-f323e05ada47@hatter.bewilderbeest.net>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
 <20240223-player-buckskin-01405c5889c4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240223-player-buckskin-01405c5889c4@spud>

On Fri, Feb 23, 2024 at 08:21:08AM PST, Conor Dooley wrote:
>From: Guenter Roeck <linux@roeck-us.net>
>
>If a chip only provides a single regulator, it should be named 'vout'
>and not 'vout0'. Declare regulator using PMBUS_REGULATOR_ONE() to make
>that happen.
>

As mentioned on Guenter's v1, this change necessitates a corresponding 
update to arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts, which 
has a dependency on the name of the regulator.  Given (AFAICT) the lack 
of any combined dts & driver patches anywhere in the kernel git history 
I guess maybe doing both atomically in a single commit might not be 
considered kosher, but could it at least be included in the same patch 
series?


Thanks,
Zev


