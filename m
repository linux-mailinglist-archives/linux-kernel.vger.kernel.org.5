Return-Path: <linux-kernel+bounces-30583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C777C8320FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8AD1C23D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894CE31A6B;
	Thu, 18 Jan 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="VTg7IMb1"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D931747
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614257; cv=none; b=dLKLYS77RnqoIAydio4LnUI3OVMVB3jfufc1l10ZsaGOzn9bAvWSynEFPNFfL12BZ4T0c40wluEXfp48Dkj9AQDwMHPm0EjbadZr2cUUWXxn7MFJmrHJ5o/EVR5qccdk4n42azv+a9D9SPgo+2ygRXQlRGPRh4+62f+fU8812jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614257; c=relaxed/simple;
	bh=dxW94Xo16tN4F2/zNoyofSr34Bz4H0NPwZaMM3AQ/g4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2nQEOfMn6O9YfLZZVYyvpVCY7C6RA1L3DOF+u7OEidSJfKSPUxDmZcg+UBD23GGresq3kSAYhiNeN1FPvnyiRKC23cifcs/QQHq8CpvAKI/OlWRuFiky/0yq1B7O/Qt1jlYGlXjrPLE8dRRcvKtywV6TBJgbGrd0gzBWE4hoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=VTg7IMb1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc25099b084so145888276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1705614254; x=1706219054; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dxW94Xo16tN4F2/zNoyofSr34Bz4H0NPwZaMM3AQ/g4=;
        b=VTg7IMb1zVhXf1QNTbVwResuUQT7OxpH1Szt/hwTVevjSXxgt1byT5LgkjaimG6Jxk
         dMq9i0nuSRMnpg0YK+/jEWEGmJpV53dM9eQf2S5nl1fhv1mfllveHO9QPd0MRoqkpdeR
         RRt6gYtpGx1R9I4zZyt3Qpk1UOwXsuWc77JDhbT2K3LIbwGh8TE7QjCQqP1slz+SMgL+
         hZ53XV2lTjlmnMy1xkPENKT9AF5rGhlJOLl/dpQmxZg/lFcHvpeuQZbzzMUy1m7rSmqa
         8TugxhTsLNmcbOZ0pzBwhq1tttoeryII+gpqKAm6+mGQ7yz3zi6QEaaRWnWTYOoVOs1l
         16Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614254; x=1706219054;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxW94Xo16tN4F2/zNoyofSr34Bz4H0NPwZaMM3AQ/g4=;
        b=cfwB6kUMYF0MAExyctkUVtMKp/n4ofxbz8Vlxx9DrijSuiogydNgkZuV+XY+4rekAF
         Ysz/71wgv2b8b7WlMnXHVsGEBLVau5PQdc8KWCSLRGO0CdpLI36jPmn9k1eXVCP0eWAZ
         NfP3AF+L94yvK7WdPVCwgu4xMIk8NbHLGg0JzZXIUHz5QumrGJ8Xu46bwjkLqaA4c0wE
         1InOpmgFOA821XXm1d5CzO5DryRijocWmJQBe8Zp6rckRxooV3ovOGDDoyGWWHS4hcCr
         PtZ+9garSO4kXC1MH+KM+xnjyPtzyg+4hwt0E2dDEhsbMCbjxGtTSX8FIL23MXTmBWm7
         ggag==
X-Gm-Message-State: AOJu0YzFLfnplS45ux0KUTqeVhlumiltFyJQd8aSTlUU68/2IpXSrjBY
	yOZxSMb8oC5r855BsfMAAKfMWEnxz++isnEDXWh75s9cag742/Ggbm4KzsmSBig=
X-Google-Smtp-Source: AGHT+IFTpM/j9s/7BU5IuSX0nDJIeasuF97xldX5n/sHZyCswVJRa7EtsNcn/HwcYXNLgvUGcRpk9Q==
X-Received: by 2002:a25:d712:0:b0:dbf:22cd:b59d with SMTP id o18-20020a25d712000000b00dbf22cdb59dmr1343391ybg.101.1705614254061;
        Thu, 18 Jan 2024 13:44:14 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id on32-20020a05621444a000b006819a675e24sm346382qvb.69.2024.01.18.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:44:13 -0800 (PST)
Message-ID: <2f1f5657d0d16821f6fa1366f99b5ee5d8ae7fdc.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add Hantro G1 VPU support
 for RK3588
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: amazingfate <liujianfeng1994@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 ezequiel@vanguardiasur.com.ar, heiko@sntech.de, knaerzche@gmail.com, 
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, mchehab@kernel.org,
 p.zabel@pengutronix.de,  robh+dt@kernel.org, sfr@canb.auug.org.au,
 sigmaris@gmail.com
Date: Thu, 18 Jan 2024 16:44:12 -0500
In-Reply-To: <20240118080602.9028-1-liujianfeng1994@gmail.com>
References: <e01c9ab69f3e120cdb9b70fbacebbab32d5abba4.camel@ndufresne.ca>
	 <20240118080602.9028-1-liujianfeng1994@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 18 janvier 2024 =C3=A0 16:06 +0800, amazingfate a =C3=A9crit=C2=A0=
:
> Hi Nicolas,
>=20
> Wed, 17 Jan 2024 14:13:19 -0500, Nicolas Dufresne wrote:
> > In general, we ask submitters to share a fluster [0] score (this is jus=
t to
> > demonstrate that the integration has been well validated). LibreELEC co=
mmunity
> > have patch to enable this ffmpeg fork. I don't expect any surprise here=
, and you
> > can just reply to my email here.
>=20
> Here are fluster test result with ffmpeg v6.0 patched with v4l2 request p=
atches
> from LibreELEC and gstreamer 1.22:
> https://gist.github.com/amazingfate/1675389df382ff266d6f1318fd4675fd
>=20
> I am using Kwiboo's fluster fork[1] to run ffmpeg v4l2 request tests

Thank you very much, these are the expected results for this HW, indicating
everything works as expected.

Nicolas

>=20
> Jianfeng
>=20
> [1] https://github.com/Kwiboo/fluster/tree/v4l2-request


