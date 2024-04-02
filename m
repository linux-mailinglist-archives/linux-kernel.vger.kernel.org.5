Return-Path: <linux-kernel+bounces-127495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64F894C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC8B1C216D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182839AC3;
	Tue,  2 Apr 2024 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hranGnHn"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA238DD2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042208; cv=none; b=PWiusAv73Vc4AhW4iO40SdYMegIy1hALxcxb7/DsT/cVtpKVLIC89ARZ+Gprx0tRQ7E4qkKJR24fXi/Nc26O5v5ICJqSNuzp5s6iUwwjJYpIzEQw+mOd5CVJdA40IcMWINt0JwXzrIaK4Q54T4vt636VDOftR+SMn/4DuC6kWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042208; c=relaxed/simple;
	bh=x2F2rU1R2DjIHbCuLiIdKs92iSF6WV6lSUhIxPCUgiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NomNOEsYep3jGFj2OaysLQlIBR3mkap7zDafr+HbLvCNw4tBWFNZTSLmF9FKhigCGnsz+shvrEv6VBnL3lnHIwcf0IsjFSebmJ+FSxFuOujSlp6SXwz0EPhL7kvrFuL7qFHGHqmV4YMXiDhXi+f0+WcTIkflrZXm/3/NTc8Fqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hranGnHn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C328F240005;
	Tue,  2 Apr 2024 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712042205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MalrCMAsx389WOo6kyHlUvcg+zdx5CkaTnrL6g9pek0=;
	b=hranGnHnGGI9cjRhn8XdbuTzJAYjXYOt+nLNTmTP0XmD3DzvU3hzLjk5DMqnokTEkiYJ3M
	+OY2t5ofUZP/DFLgG+dZcw1bK4aAhRE+T2ToRhudPKe8omRCuycBcnJMLS/0GY24gjv83d
	rbnhC0DTCSAHq5IXxUMHxU+Ii/wtc1baWk01FT2lPqIqb6S0Qg4tBYi349yQMGKksjfN2M
	FzJcRz0ALgHk+8NrHmOjH4tYVOI3HGVOanN1yyFo/V+ghug/eF0aOR9sowTpAlFwZGaTvN
	gZj+dLxgs+9KFOW/u1i3jAS62+ekcb+cTd4epbETL10sDnGNZiwkU79rgCawcg==
Date: Tue, 2 Apr 2024 09:16:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Michael Walle
 <mwalle@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvmem: layouts: store owner from modules with
 nvmem_layout_driver_register()
Message-ID: <20240402091644.35c7dac6@xps-13>
In-Reply-To: <20240329-module-owner-nvmem-v1-1-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
	<20240329-module-owner-nvmem-v1-1-d700685f08e1@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Fri, 29 Mar 2024 17:13:35 +0100:

> Modules registering driver with nvmem_layout_driver_register() might
> forget to set .owner field.  The field is used by some of other kernel
> parts for reference counting (try_module_get()), so it is expected that
> drivers will set it.
>=20
> Solve the problem by moving this task away from the drivers to the core
> code, just like we did for platform_driver in
> commit 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

