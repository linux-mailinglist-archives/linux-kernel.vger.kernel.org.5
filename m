Return-Path: <linux-kernel+bounces-74195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089DC85D0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39C31C21AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94113A8E7;
	Wed, 21 Feb 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hypXGlrE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C83A8DC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499547; cv=none; b=RetVPSAkMhfTt5tGSCFwhOWuMWeGL1qn+W3Ms/+Qkw4lRgmrtvgTjzGM3YkR2knoF3Mn5AN3RENTSoneFyeKlKj4gcsaeyddwPS+o8xFmf+2dGFAx99tS5bu1+DajWnwVyz/YS4T31Dswwmczs7sN1PjjCGEmW1DsGabra1Ymy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499547; c=relaxed/simple;
	bh=uFniHpBzQNLjviF0hn99aaIkPFFKe/rR54mSRZQdSAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XvN4kRAoQelVI1G94iIl3ZEsTrtteVuBqnWx9kIGmous2fjFQIoa5z9WGEymd7R6yiHxteL68X6oDHovwP46QO/yOGesbm1RswoeISkTkCGO/nd3g1qjpZwHyp4Ops3Pz38ePi3atOxFlC25K8Wfe9qnv4AJA9sHVm1aoAeuSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hypXGlrE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso2136997e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499543; x=1709104343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttP8vyLKUQDDslR3D29CPSrFs0rHJqNuSZ9pkYxraoE=;
        b=hypXGlrEnaAAzfVWa6T/DyyOgKbD9mPqgRomrWvh7IHHB3/9yicEhoSkzkWMkZJUa5
         7sJj22vh+E+zZvpnFXEkpL52M0xigIzfPNxqkJ7YqNyw5lwT1kJWgxACBebVCEV0aViq
         MHx5zvR3TB2c8SYgBeP/cx10sZ+9JbSxjU7mwICNh9cdR3ux9DPoDTqtUCZx8BtAcJfh
         qua9KhFCy+DM5u7qLsj/h0MJeIFAxfuTKxe1F2IEDa4ue5qkzlsrttieHcOouv1OSOA2
         P6F5u0kwtKV91lNsYU5xWvrPUebS3G3wfBGah/EGKeUngEe012yAsH8/2hpxQWHEND67
         sS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499543; x=1709104343;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttP8vyLKUQDDslR3D29CPSrFs0rHJqNuSZ9pkYxraoE=;
        b=E5IzofH7nmHGXAw2KmlCq7i3gB4je/fPU6wKz6GESo4+83bUceL4h09NTCtSAd0jiu
         7pihpDfF6NgnEV1Fr2gDm6zCFljSTQ+qK2hIfTh20lSnhM/BtkA09lpCotNQI7tel9Wc
         8/Ceht8sGXZ60SHSgL366Aky9qvFnydF+R8chkkqnZXP2qiyqJUGI9zSYvnpob4o1e3t
         J1YPYv1coiQ3hgnxQ941s1PQIgAOIvCglcWIjUbMccktJB8gvt3jYSE1xUIMadPUGob+
         oYSHrbYyYst8rFSTsy5GI8VMOI2WAILSdHAsMSRNrNXAV9WuPEDZaKPNt0hN/KybBwRT
         K45w==
X-Forwarded-Encrypted: i=1; AJvYcCUmP42ZDIpTHCjOSInh3CXyKCm/POfGySVBEcqw/qbyfs7t7ILmD0twMVhdLxrQDnYCjtjP/oaZocb+JqShoa78673PoRYZHN6w7e+v
X-Gm-Message-State: AOJu0YwR9V9I4q8XCuYJyDR7OmusFV9fcPDhBm+NsbgIRjoIa4BrBI2g
	DabIBTosne5SXM2dBFXD8uoXcpNi7rbNv11IupGmyQr7S4KooIiPlScdkaz+yUrtpuVSLWo6T8S
	q
X-Google-Smtp-Source: AGHT+IFEdi8saWQbwnpqUNhkDftIErViIHBa9SDA+dwrNNSpYpRdbFSaqbC5zLzQuguT7JFHWZ5Yxg==
X-Received: by 2002:a05:6512:794:b0:511:ab37:b1be with SMTP id x20-20020a056512079400b00511ab37b1bemr9770320lfr.69.1708499543024;
        Tue, 20 Feb 2024 23:12:23 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id t9-20020a1c7709000000b00410ab50f70fsm1444335wmi.15.2024.02.20.23.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:12:22 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Michael Walle <michael@walle.cc>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130100714.223468-1-msp@baylibre.com>
References: <20240130100714.223468-1-msp@baylibre.com>
Subject: Re: [PATCH] nvmem: core: Print error on wrong bits DT property
Message-Id: <170849954121.23242.6996516422641770317.b4-ty@linaro.org>
Date: Wed, 21 Feb 2024 07:12:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 30 Jan 2024 11:07:14 +0100, Markus Schneider-Pargmann wrote:
> The algorithms in nvmem core are built with the constraint that
> bit_offset < 8. If bit_offset is greater the results are wrong. Print an
> error if the devicetree 'bits' property is outside of the valid range
> and abort parsing.
> 
> 

Applied, thanks!

[1/1] nvmem: core: Print error on wrong bits DT property
      commit: 8bb130f38373b5e405b7d81c6ebc36107e518a99

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


