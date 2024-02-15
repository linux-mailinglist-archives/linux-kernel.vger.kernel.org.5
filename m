Return-Path: <linux-kernel+bounces-67170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F245856776
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B88F2897BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92F1339A5;
	Thu, 15 Feb 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JinHXn7S"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA613132C28;
	Thu, 15 Feb 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010597; cv=none; b=gG55H7SyDVgnKfEdegnyff7JZfPaPvNv481obg3ZQohOnG8KLOnyn5QwV6bYlr1vANwZqThuTkecmNqJRAYUY+JWqHv6NZRIjPiutO/pXd8Ppk7oyg3hv2ZQzamqLhFg0HF0RKE3tfUOL5eZkJrIYTfattxkGaN8fkwJ+Mnrlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010597; c=relaxed/simple;
	bh=76gpB6dQzuTmYHEHXlegw04p6Tcd02R8VowM9YqvLGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXoC0q2HxlArvS9/CthEf9fIDS5uER5yDsOM/wxs/x98fRDBeQGCdMfKkV7VJCiOvvSc8io5WLsJKJ7ASl6U9VoPacL7vcaw5FYS/yfZxSo31L8POIi7wdHBpeKRrxAqY3lLbp/e5qbsl9nufgpszKL9KjUIXOn5ylWHDqV7c0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JinHXn7S; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d953fa3286so8338105ad.2;
        Thu, 15 Feb 2024 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708010595; x=1708615395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OC/x8qlWcMFQdWFPJ3tzHkUQF/6/47D2PKzDjQg6g4=;
        b=JinHXn7ScqW2JfiG5rCtSjtbUXVZowWkEaiHUAbDtqcoKRUrNSvVBFfTtWC9gXcyGM
         FZd2n5iEfczE0+GgB6/g4BODfnYLuPHjbmkt+FXgAR/jyIjUG9gxGV+yIGj6QNGVAce8
         fUU6C8N2EOwfxqUvLPKpM6N40vOs6nBWaQAT9w908H5ewZ+DRroIK2ZUUTwQJoOq6W/d
         uJVYxcmOXu95uOW0Plow5DfYHVNKEWV5OS/nBhot5MAbeuH34qIN8ad3T3X5zHfSNxIx
         hkqghfI7JQKP7xXByzmVaeAPV7jNuilB1XeQBDv3P2KF56N0/UrbO3WtkculbuZIEMk4
         heng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708010595; x=1708615395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OC/x8qlWcMFQdWFPJ3tzHkUQF/6/47D2PKzDjQg6g4=;
        b=nYeP320CToFi9GfTKV8HQ1p07ijxo/UUL9+Y6nZ6mURSWD5nimud9AvY67Y+XyxBJW
         IsZzq+pdujiGZdNVhWQtmnYKe4F0MIhlH+V1aVddITIiHTX4FQWdbf3HceTvt2n6K4zc
         4qTWbh6lX078fvEjX1l2TXq2eHbYdpqijytp/oX3lFdUksTnqomBe5B/LbPlUJybxtF0
         uIFnxxZSYc255vyz0otqCm7PCKJtwC5NE8NrekXvBz/Nny6oxsxNG9VsI+RH5xXOe+q0
         3NOpF3ZVryQ6/LAX3Sisob+yxxvafoS/o5JugHblVtc3S1skm5+wgftpM4y3jPfIHlLO
         jtJg==
X-Forwarded-Encrypted: i=1; AJvYcCVGvQ3xj5nPdmNURC0VRX4loenkwS3NsRvKfVxIEoiAk8HeEOipBqlWgO7qoeKrqd/kU2JSr2sx9+Rhm12xWTwHw/uiPBedl6xjIYH++D1SlzUeINCAJFMnAOgEIk5EonfE1Ftt9mBxFg==
X-Gm-Message-State: AOJu0Yx6FqG+AX0LreKng4TjdXFZRPXKrFZbqeXXOy7HxoToHar/MAPC
	JpRttS3wefRw883Hb8af3yDfHTCu1enRD2DOrdzqmUu9IEyEOf18
X-Google-Smtp-Source: AGHT+IHYztxwJWPfFEJ1GAM5kJx7IGeAjelY0lEUitRzhi/Nkm6tu+VUAX33wsQY22VuVx5uEmw23g==
X-Received: by 2002:a17:903:11c3:b0:1d9:a4a5:7a6c with SMTP id q3-20020a17090311c300b001d9a4a57a6cmr2560480plh.57.1708010595241;
        Thu, 15 Feb 2024 07:23:15 -0800 (PST)
Received: from joaog-nb.. ([152.249.118.214])
        by smtp.gmail.com with ESMTPSA id mm8-20020a1709030a0800b001db57e999dfsm1397767plb.81.2024.02.15.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:23:14 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: aford173@gmail.com
Cc: aford@beaconembedded.com,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	kernel@pengutronix.de,
	kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	marex@denx.de,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	vkoul@kernel.org,
	will@kernel.org,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: Re: [PATCH V4 0/6] soc: imx8mp: Finish support for HDMI
Date: Thu, 15 Feb 2024 12:23:04 -0300
Message-Id: <20240215152304.307972-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>The i.MX8M Plus has an HDMI controller, which depends on several
>other systems.  The Parallel Video Interface (PVI) and the
>HDMI-TX are already in the Linux-Next staging area 20240209, but
>the HDMI PHY driver and several device trees updates are still needed.

>This series is adapted from multiple series from Lucas Stach with
>edits and suggestions from feedback from various attemps, but it
>since it's difficult to use and test them independently,
>I merged them into on unified series.  The version history is a
>bit ambiguous since different components were submitted at different
>times and had different amount of attempts.

>The previous attempt I did used the wrong starting point for the PHY,
>so this update includes a newer starting point with tags from that version
>and fixes from various people's feedback.  I hope I caught them all, but
>I apologize if I missed something. Any tags from the previous attempt I
>made were intentionally dropped, because of the significant change,
>but I kept tags from the newer version I grabbed from patchwork.

>Because several items from the last attempt were merged, this
>series is only focussed on adding the HDMI PHY driver, and enabling
>the power domain, irqsteer interrupt controller, and HDMI pipeline
>in the device tree. The version numbers are a bit strange since
>these all got pulled from various attempts with different versions,
>but I wanted to push them together as a series to complete the pending
>work.

Tested-by: Joao Paulo Goncalves <joao.goncalves@toradex.com> # Toradex Verdin iMX8MP

Thanks!

Regards,
Joao Paulo Goncalves

