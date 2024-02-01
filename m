Return-Path: <linux-kernel+bounces-48014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D7A845641
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8542E1F272B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1A15D5AC;
	Thu,  1 Feb 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+ZHcxmR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179F15D5BB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787000; cv=none; b=Cc7XNRJpbp8sxowQd2Fk9lem+WPiwIrbV3Gfq3ZFPiUKH1zt7otQxEN8nG9UZ0MdEQ7kvflzKc0FKp+BbP/3hghG+6w86TL8jfSfYCWTcUT41Uds0GEMApKNL0ilkXvU+yFLyyR3eByHbQJdtOMf8bSkhztjwoRbBQeqYwwd858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787000; c=relaxed/simple;
	bh=ZitQxPV/j7kl+XhlRgzQLGJOQKUAInvpVIP+LGVbe78=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VqqRnTAqQB4VuhMmbbt8SPXDbBI+jodoc6aZs/zvISs57LAiua1CEpVNpHsRhRAYtWHq97RFCsgmtzLQTyvCnwcyCrgUW0AUN0xHHzN8e24C0r1z3lx8smoeXwSHuieQDtqqS4NMRBhSJICMrO2ewinJlyh9tYbaQiuYjVRnebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+ZHcxmR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so7291755e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706786997; x=1707391797; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvrucEwAGcSRmbAvQav0oQhxQPPV6lCuxVMt41yI9Qc=;
        b=J+ZHcxmRL9wXaoRq5QRg4V99nq1Adu0kCXYPKtq3k1V2dO/wA0bGB2N2+ztZnr5d2n
         3DlbvvYUT5R4zvsIYjKPLCqkD4rDIZfPyiBC4NQ/DxDPJXIdldrB6XqGXBSrgONQZRmi
         HFlu4XN4nhlF3VzJ7dD8dPtONeLKS1YxurV8X72geD6LymZfdOxqlel/dhqOzmi06bRE
         fQNrtz3CNADG0SHj9tO3U/N3e5kfslhbVQ2kDJNOGRPUuKtmvX66NJ7ubhqbna2MJ1Rx
         oBqfwBRsyg6knb3SVSRxYI843w2eh3qR6awuGJaWx/gPX4ym9qWslvZLDX3OmOBV6W/3
         +XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706786997; x=1707391797;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvrucEwAGcSRmbAvQav0oQhxQPPV6lCuxVMt41yI9Qc=;
        b=nfMssIgr3FuZ/ZvFZcFLdcK4FG0JHtZ7+y97cj1m8+JchXcUw7Lxz2aEb73GOXPDRC
         1SXV8plwXi+NBHZoc4VSZFB88QNE4HX4ZhJoV233IrR9un7sKuxqmCVMmU7Iq13fiT+O
         V0f3cBu/0L7zFJQ/lHpYTg/jXeXUF+eiEwDpccD/ngMPpuawCalciF3C6gZLxfK5lLhr
         8/WrE17WQzkV3rwLLIfbSTnDBm+J5bXSK2SLHTjIR9O3MaMT129zAlofZAHVemVhbiU/
         kvq1+JcZEuYNuOq2BAwsXpkl8oYsuf1kEdDrG1z6gsHTTyuTkpsmWd1E6SG90Td367EN
         U4Hg==
X-Gm-Message-State: AOJu0YxQLp/VtIvFifUX4J/nq+iq6oKF+hntdCk+BJoS2ClS3jkaOQTQ
	Smc9gNopyobTTlNv+2ErMtYxguB226xI9bzYdYlKgcIIDqHOYwvS
X-Google-Smtp-Source: AGHT+IH7Fy1LmCo9sw/EShxyPOFY0NZDGCECNPaw+DBEQ8ikM4egxUb+TyBzpNXZyW/QZFuKFCES1A==
X-Received: by 2002:a05:600c:5650:b0:40f:44b5:111c with SMTP id js16-20020a05600c565000b0040f44b5111cmr4145606wmb.41.1706786996980;
        Thu, 01 Feb 2024 03:29:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXzy6RAItz0wfWQpomq8nxru73Grg/ZfzhqP+bRPezYsWovu3v30MuPyem60Rk4vSar6FAuq38qzTSGrO1krjqFAWsng8+W/XamkPIDuFUXy+7jY6xd2zN5n0Fe5oG2Q64bO0nePQ/RK2GDPQ31GSY0ZDMS9SCpVGChaiwNOhEOXCDRRzmgtesLmUuAs8aMsC4AMaRolemxA==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b0040ecdd672fasm4069475wmd.13.2024.02.01.03.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 12:29:55 +0100
Message-Id: <CYTPHTGKM7FT.1DRXMURTS246L@gmail.com>
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 <linux-kernel@vger.kernel.org>
Cc: "Russell King" <linux@armlinux.org.uk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] tty: serial: amba-pl011: Fix removal of the QDF2xxx
 workarounds
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.15.2
References: <CGME20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84@eucas1p1.samsung.com> <20240131213543.958051-1-m.szyprowski@samsung.com>
In-Reply-To: <20240131213543.958051-1-m.szyprowski@samsung.com>

On Wed Jan 31, 2024 at 10:35 PM CET, Marek Szyprowski wrote:
> Commit 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx
> workarounds") removed some quirks specific to QDF2xxx SoC family.
> Unfortunately it removed a bit too much code from the
> pl011_console_match() function, what broke console operation on QEMU's
> 'virt' ARM/ARM64 machines. Restore the "pl011" related string check as it
> was originally introduced in the commit 10879ae5f12e ("serial: pl011: add
> console matching function").
>
> Fixes: 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx workarounds=
")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 3 +++
>  1 file changed, 3 insertions(+)

I was about to send out the same patch:

Reviewed-by: Thierry Reding <treding@nvidia.com>

