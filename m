Return-Path: <linux-kernel+bounces-117097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7188ACCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFEB23628
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB074C09;
	Mon, 25 Mar 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiGPx4QM"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0B58122;
	Mon, 25 Mar 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372493; cv=none; b=qJZC87NBTgtq3qRj3DKN2EfoPHf3UqF64kRhZIs+1yIa7knxD0rRR7rWBGfIWlhTJjTG9dTxoTaW8jv31Li2mU10lZhVI3s6IbOah6HJooHsyQe7XZkMOEsvgeJ3imSIxBSiA4X4gYbDSfymP9wLXWGluOKtQ06io8iqqmbc/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372493; c=relaxed/simple;
	bh=CSra3YthhrCHfS7IYgqOMfTftBpB8MN3q/Y9zvFN/bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlTAK7Q5EHOBmz/nc6eL6ZbfWkob2W0Tr8J7RpgEW6uHFkbjfp0uJnRIeGgiYqRmBGM3utVnMtvmMiRq6psZM6pIzbjQzASMQ890f8ggQFxsZtHEDPy2vu7B7k1IUHZ+M+1hmUQ/Kk0Uv6DuUs86D2POH4sa5CBZelcTvicVsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiGPx4QM; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2220a3b3871so2134522fac.2;
        Mon, 25 Mar 2024 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711372491; x=1711977291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSra3YthhrCHfS7IYgqOMfTftBpB8MN3q/Y9zvFN/bs=;
        b=fiGPx4QMUEXAT17OydPjChw8OeuhNrHICTMj2DU/ca+C6DyNdAX2VTpT4E8b7w2x54
         oiYWN8UyRFxv0lMLkLDk42nB37AtAQZrl8XU4vF1nnFhvw7K6rl0h4DCLOtzMCPjuPaN
         n4nrmk6Te6nb6nbSDs3PQzEQpAzfgRRPVla3ox4XQuRH+RaHqsCjfdUfxyCDOTRaDJ7L
         p3TemB1k5YeK2nYaxgzyjYz0tXcL3aKsJDF/RWwySM5k8jiwVpGyhI8TUYW4JYYvz023
         I0427OruqHXL9KZifLwHjyb+I2eP30bEqVU8RVG4+XkPpNukxU+jtc0Y5XU7zmfYCEjW
         DFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372491; x=1711977291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSra3YthhrCHfS7IYgqOMfTftBpB8MN3q/Y9zvFN/bs=;
        b=HMuv1MPk8U7ARjjpD952HCe0+EKGCg/a8/c1jJlEPYdsgojJAL8jeLpYA34Mc/16HW
         Aj4oAgVqwv1BhlPretBR/Ya7eLLqCAGSa0PQfPUmLAe0LqO5z/lZkkeCf6Uw7j7ppMMs
         yZHr95BgsC7DAinmWS3/kL9Z58kgrny7KKPTRwWIE6iGBFaswz5QFU6vHF4NADxAyy0P
         2MGUB3CFkVDmc9FQqUsl9E0DOw9B6IGUZ7rzNn6Bu3tKNQhdbQEX3Kebyc7AzNXQMTIF
         EQOl014exQH6RtrlUY0se7NLuea+wm7X2TvP7hsS1kkOPtnr2xcXUrM9CrmPNZlVlHr1
         4TRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz3scd6JGwvVl32GuQ/sYBkevzd/EXrFh+yETnxnhZc64Hg1Di5tBXeO6XHgElxdN5j6kMLy6vMBF0ZAWgIQ8ErducYsjReqlcH1jG/DioSaPowS8ngQjiSXcxibsMjzthvnZMSUFDE8LVQv4W3FrzHP8WF/ozW3hEvoJfpwr+lz0Cvg==
X-Gm-Message-State: AOJu0YzkkIHBBTENB/nTc4UbWGr3AhFp4kjo5sS+GffbSCqt1uqvxJyf
	cCgr3QxWOe8YgiOO7R77W8yKr6DFrDbELndvs3En6CPlGOGA8brVDUgAHuvpyYRaRfXWHrJnsH7
	BDsc3n7htEaoe2SxxgDfToxQW+gk=
X-Google-Smtp-Source: AGHT+IEurqRDv48Z8CVbJqzcgDi1BfQqhuj9Z/krmK1kUz5QXRPGdceUCiZyYYQ9mdNnDQKAudMzogwIgMhXNn14QoY=
X-Received: by 2002:a05:6870:e2ca:b0:220:ee88:6107 with SMTP id
 w10-20020a056870e2ca00b00220ee886107mr7582972oad.23.1711372491393; Mon, 25
 Mar 2024 06:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320090733.96828-1-animeshagarwal28@gmail.com> <1a7ec34d-b126-4193-9e0c-bbdfe4e7126f@kernel.org>
In-Reply-To: <1a7ec34d-b126-4193-9e0c-bbdfe4e7126f@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Mon, 25 Mar 2024 18:44:40 +0530
Message-ID: <CAE3Oz82QY8OWsbpNJw+bhwHd-R67bfhQspKoAdZgnALQtw9Gvg@mail.gmail.com>
Subject: Re: [PATCH v8] dt-bindings: ata: imx-pata: Convert to dtschema
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:59=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
> Applied to for-6.10. Thanks !

Thanks Damien.

