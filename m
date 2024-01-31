Return-Path: <linux-kernel+bounces-47254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481F844B05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998C21C261E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856439FEA;
	Wed, 31 Jan 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="a0IxyXcY"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725539FEB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739727; cv=none; b=YQ9PQLSQxLDii3QDqrRWckK/4nQTU0mjgUbbkbxVTZlL77aWNqTcUZ0j5wxWA4buw9BK4Av0z15yml6/6phMA3Zxc0ch19+lpaptZriEjRitY3pW1N0B21IFlMIkAu7QvgHj98D1KMOUQJ0PDNzeZMWVNAS4JeIfBGWeIfhUkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739727; c=relaxed/simple;
	bh=vcScM3cpdf7Pja37NGeK6Yly0/J61B5EtMzfdpq0CFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P7EtdQ27KDFgo1uuCLaaPcfhMTA6p0hPOFiiyzbUSxen9emb47uero/hymFuV9n55CjsOmiythWvlqDbnKRuMaVPml8j1D0s5fEP9sL7Gq7bPMmJSfOjhE1FPcJMIkXTaRhw4llICiAGMentAmlycpo+iLsvWT7Dj6+dQPzx8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=a0IxyXcY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a4516ec46so2270461cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1706739725; x=1707344525; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcScM3cpdf7Pja37NGeK6Yly0/J61B5EtMzfdpq0CFg=;
        b=a0IxyXcYWUS0UrNbcJkKcy0kjVdzpNm2qnbggSJj3XN8vuN3WRoVmVp6dWoim0I08b
         i54pYRG/sKToEfVwg2LTGWrMU8lt/YKiNTpyxZQ/dS6cw5TqmvXFVDHS6OJQL0TPJA1l
         18nT4JpW5Hf+cNO5LPKtLHg1GVPdabkI542vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706739725; x=1707344525;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcScM3cpdf7Pja37NGeK6Yly0/J61B5EtMzfdpq0CFg=;
        b=Qvo8+9Kp13hDCGi3/koqLbf6g71sk2gEa4roo1SGIuVft79Xg/hsIwl79s/WAvxIwN
         fZDTcSW1QJ87P6sd+MSCftiKTHS4xI6Sw+BuZYyWeKo9vNVF1Dec8QljPC6RJnSHrtiL
         7leJg4SZif2+2yGeYCqbd3eqEwLxt0gxBUxzOJ78s0TJDIdXrehiQaCLFVKoCIYT0ntW
         yckUMv2ij+1yhQ738OPj9SEdeEJwHyA0/6al1Z2+fVCOBmQUW98rgNCE5Aj0X4Aw9Wig
         MDfkAc5EreYLIP0Uitu6kLpVoW5F2LG50hRL0F1Td2eDjOMdxTCTQ98WrkvsSD5N0YBT
         vXOw==
X-Gm-Message-State: AOJu0YyM6OVOZUdA4/3mWNw6c0MlrYQOaGSauqMo+lkRcZ1bPibt46Js
	X6OnMfjCgBNuLjD44KoJf4O8Z2d0C4+RA9cfQCaSd5NTgXolo+bMLZYmFeJdls0=
X-Google-Smtp-Source: AGHT+IHT6U2Z6r+BnwKmbGRGJKdtoLhCF94IFwTmfyoXINLyl1O7n6F0NJF3d2P84mNPLywdHvL9eg==
X-Received: by 2002:ac8:5a04:0:b0:42a:9d70:7f58 with SMTP id n4-20020ac85a04000000b0042a9d707f58mr6949131qta.49.1706739724907;
        Wed, 31 Jan 2024 14:22:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNPF3itdhRp04csr0g5GO3JreHvCYGEIEA/une96Tw0FryJ0AUsks6nkPc9NxQycBHkdbMDKYBVjTcz2IjRJuyJkHgxNyySC5weAtSxjO5EEaYMVghfNH7nKD4OL1lxjiGUjUEI7dg4/tfEA2tPW06FBT06l8h5qTN/ZKeRaBEiSsjKlk/w8lTGiQA7XkPmaR6priWatn7TyQuVpp3HuVi7JRILUR0tzT73HALyiZHrMrUYSL6iJ59uXeozc9BZprHUPJ3nr0SnhhiPljScq+3grTguB6aez9TEeN+149b7uSCpWNPtbIx8KEoBFtMBaboVIJrCAZbJ/hfkzNfAWBjTQ+9QfVsmuYbogN8Hz0VnU9yp7Y5/WBWK5TAX/hi841Njiv6orz8GwTLsOAH
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id ci13-20020a05622a260d00b0042a729d17dcsm1896082qtb.86.2024.01.31.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:22:04 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: luzmaximilian@gmail.com
Cc: corbet@lwn.net,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ivor@iwanders.net,
	jdelvare@suse.com,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	markgross@kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/2] platform/surface: aggregator_registry: add entry for fan speed
Date: Wed, 31 Jan 2024 17:21:45 -0500
Message-Id: <20240131222145.3320-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8552a795-9ce4-417a-bc71-593571a6b363@gmail.com>
References: <8552a795-9ce4-417a-bc71-593571a6b363@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> I assume because of an older MAINTAINERS list. Ivor, please add him for
> any next submissions to platform/surface.

Yes, mea culpa. Guenter also ran into trouble applying the v4 version of
the patch yesterday. I'm sorry I didn't base this off the correct branch
everyone, will be sure to do so in the future!

~Ivor

