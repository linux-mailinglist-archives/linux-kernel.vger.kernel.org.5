Return-Path: <linux-kernel+bounces-43205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9658410D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C21C23780
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507F76C81;
	Mon, 29 Jan 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fv4ZrSUY"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D376C70
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549729; cv=none; b=rWAnEa+fMlb0pcCGxrc/ec/20PY843ytACG2CNOjKh9gc6kZ1fl5r6TAgd+nDrBhRZO9CYIIMvTCiDJvkupfbQ0ilTFs0OxL0h0g4Y/+2JKn8VOZ3b6NbyloBboPrMGpLACsPSK9bpsYJy1A5FbNTQxg68hqMcy6CllRIA+IzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549729; c=relaxed/simple;
	bh=FTGv+GMMo2t5GM5uIMBn9GRR6iqsAgPnWcYIHG2GhqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUOku1a52Hu9LgfWaLJ5FI4cDT0vtlg4hhVpfwBvP//VmVV94eAHgiyzZ6ALJREgp2atwuuMpDdDvCm1ZW5MAGiL2+lRTXLZrQYfio2Fkq+KZZE8l1Zgkh4o5ZhIV7ByxTO5x7mmQiYd+mHnqPirMU5jJn3gOJqSfkUD0NcuC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fv4ZrSUY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ae38df9d2so1742079f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706549725; x=1707154525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FTGv+GMMo2t5GM5uIMBn9GRR6iqsAgPnWcYIHG2GhqM=;
        b=fv4ZrSUYS/khOIFrsuzWg8PBhPlWlWx9awNOKEoymVtwwa5hO0WD2Fj6KpoatcOSYO
         6AyshUhF8TAdg8uUmX65+Rg7Z0PaPNIdt1uaBNuQvXVB6m+daD7nJPGAwgXMBE1QZG/h
         F1bh/JX2ZgnOEVL6Q0h6jCxOx3gd0Klad5Sp/hlKmw+lxPSspul36ZiMzCQsH+y+Osr0
         ka4Z8kwbVz8cp3krguHuuRIUuNZQJC6dCb+d47xxGiB7EfkBG+21YKGSPcSSV2KoU6VT
         9dS5CG1dr+k5Oe4ufThz/aUVuW/XyKxDMj2uRwDGwvJXbV6mXppGF3z26KP2yDS9N2TA
         z4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549725; x=1707154525;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTGv+GMMo2t5GM5uIMBn9GRR6iqsAgPnWcYIHG2GhqM=;
        b=AU7VJd4nuSAQTCVTFW85+RluIwv0smXxFx+6hGF8g+umVqAOOuOZBQgycfgijGikvz
         QbrKPK3msWC75IZTS6SiTC6lArlGyZtxFL1/+qHFgCPqm91AJ4NLXjCvuYwbZM2++xaF
         MGqISXUj4FEpvUoD2GKFgRhB4ZvwNK1Ue+gYw3KW9z+4AV/9qIkz2B9uZ4anlNgbANEw
         OuBaYObIGJp9/hrZMcAJMcTMry4hT3NilJJp2NaWUa/vJLwd88IPPx1ZkTrA20LJ9awA
         9toXFCkatgGAUXYT9uKRiKLF50dp3LfvuX8hEtm+i1HxUDM8536aM/KI7x7CHQh/vIBn
         Pyxg==
X-Gm-Message-State: AOJu0Yw38r/D8LGfmYQi+CUc5xnwmY/YxMbuRu9H99FoIqciKJ36Mxj3
	KLSmKr52pP0Uq9yDyaksF/Y8YsHhhR7pFIawXtjhu+Q+/XiQWTlgfEWiKW6JI8U=
X-Google-Smtp-Source: AGHT+IHgaSjXCvYQjhSkhL58cEx05Cv7+5UMQrnse7+ADEQOpBmYTLs4+jTxujxLVRhc5WnOYQ7pnQ==
X-Received: by 2002:adf:fd49:0:b0:33a:f00c:cc9 with SMTP id h9-20020adffd49000000b0033af00c0cc9mr1839524wrs.1.1706549725443;
        Mon, 29 Jan 2024 09:35:25 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm8706882wrb.45.2024.01.29.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:35:24 -0800 (PST)
Message-ID: <1dfe1bfb506a662d64cb15d1622f9ec84913b107.camel@linaro.org>
Subject: Re: [PATCH 6/9] arm64: dts: exynos: gs101: enable i2c bus 12 on
 gs101-oriole
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org,  willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, 
 s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 29 Jan 2024 17:35:23 +0000
In-Reply-To: <CADrjBPoTPzWo10VvFX1m83q72xqzR_y83TZ4JSFgK+YtyaRsPA@mail.gmail.com>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
	 <20240127001926.495769-7-andre.draszik@linaro.org>
	 <CADrjBPoTPzWo10VvFX1m83q72xqzR_y83TZ4JSFgK+YtyaRsPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 09:28 +0000, Peter Griffin wrote:
> As Sam said, you could be a bit more verbose on what those USB devices
> are on the bus as they aren't enabled in this series. But apart from

Done.

A.


