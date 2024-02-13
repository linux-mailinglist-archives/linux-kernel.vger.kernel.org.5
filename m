Return-Path: <linux-kernel+bounces-63840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B919F853555
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2D71C22FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DC5F564;
	Tue, 13 Feb 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4k9+K6j"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02755F47E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839710; cv=none; b=sdLIwZJ7B9SOB1JMeEt5P+7ybs0D6QAr6pWsn04PL0DDwrha0MH9zL3FcV/c11wAjbgLDgcXf35FGUlRC9uELfmx0ywDFG+R/Bl1lv/3I2CCICll9cRurQoBuVYS5qDParQpNqHGnDdyKWQq1hJ2EucRtW5gkCBbLxniIk2ItqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839710; c=relaxed/simple;
	bh=xsgxJAOX8DI/vf5lySI2U3o+0BDInfLVAtoc2OdnwzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD4ODO/wdm0vJIaiBUsvuLlouIB0nbf4S3kWDGMcUeZvbvpeweX4HUA785+hIp3UwNo8Dtwo/3CIBel89U6HrFNV8SXSYZkh1J4jFqlnmG4lgKXOkSo/+fQPGk3MWu4nTX0oY4vQefl8nLkk8p0FdE06m3ZAAsKKOMfL4v34zUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d4k9+K6j; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c029beb8c9so196238239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707839708; x=1708444508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LwxIniMZti5uVl7y9nWIeGEVkoZmsZ8d7f4xUj1DkA=;
        b=d4k9+K6jetezz6i7JYk4GPr+XlDtqDfmtsvES/VU4LCgfRL1qgKcYs8A3HcVtXk/Sd
         O4uLLZQ6ltxVGIlbuuolM7LHw0oeE3DrjVIUgfvt8n/ShR+E1eLaSRZwxgiRkdQ3d7/v
         cYtunPZ5I7+wHI4BLzxmPo+xgHOESN3x8tJwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839708; x=1708444508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LwxIniMZti5uVl7y9nWIeGEVkoZmsZ8d7f4xUj1DkA=;
        b=OvNnKVp2ZQBqjBjMlUegykwV8v0Ppa2pqJIICCIK5XwFm1BdEdjPKXTERAbDvJb5O6
         fAj+0adTYFN/7U7TONhLn3+1+2T+quje67PU8M1Wrn2+aaw4HcHpJ90rZ4t88bulYN0z
         rKxo+DhUdvREOqrMoFP28Zx5T4GT8S7bAwfrh+92o5yn2yS5aKFZjh7r06WVBUR8A1Hu
         tP1q1WDYLel1lvpqBA64k5xWn+hLcRg7FfN2sRiQ/yZWDHBVcYDPf+m2ryXiG8Em2Q5G
         rVjOqwnZLlnrQ8sUHc8lXt6kfbkDwN4kDvGHOFr/pJcI4snb32Ijk2RbK0nKYvOHMe0g
         p9tA==
X-Forwarded-Encrypted: i=1; AJvYcCVgDIfQrJeZEo72jZ0BWR929ZvqNIL4gNIUAtMyOvoBx7oInS6bjh7pJeWK5+n/PVy3VjpujDFv24skwzAsVTEm+CwgNn1jUqvbkTSc
X-Gm-Message-State: AOJu0YzgT4ETJiur5PT/itFciRyhuQrofd4I7/fHNvBvd6Fo8tSN6YtB
	pt5vK7XIilyj1ZPcwzdtF9OGqutwAHlmKOrnZNKOW2yH4MQ2ro25LLn9pKgltQ==
X-Google-Smtp-Source: AGHT+IFcgOAA9HVjaOg0HpWxj0MxMiSh/UkPsu8PJDLUVDOZnnTTC4P8loz4UdzdtTD9Oeefe/k+xQ==
X-Received: by 2002:a05:6602:234b:b0:7c4:4942:17b1 with SMTP id r11-20020a056602234b00b007c4494217b1mr37577iot.19.1707839707359;
        Tue, 13 Feb 2024 07:55:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOqsqCoVdk8nI6W22kovhNRLZ1NdvljX60EjeMsMLuZxFfQxF9/Tapwm6e0KXScCRgCIlvi68PjPXS56CrVyDqGiA2MryIoPpl3vxIgBuP+uJ66h0l3AYISYMXXznwIoyA0PjqMRcSeiwmMscMBENyW3bgv20pN1QW6p91K7yHf7zJBaGXuAtcC84yC/a4wQzF0Sbx2oPndH+qFM+FIIYEnM2lJAQJQztdBBHP3NCG6lKo/O3QZ86RZqytFI2xnpUnHxXtLt/bQ9TYlNzEWNDPbhVzjl9zrwmI2VlMYtSmWc8kqlpgFTyTD1fNvWd2yCMHBVcwEXiqbPuifseo7y2hFJF7Sqw6fssu8Fd/YHhYFUijyxIaSsQErcX/8yGZNKYMwNuXVQaCc+W+cy1CKeU2NNYedd6sVYmnRqmFLTekXrd4KWIDWIw2NPWX38YJkLPCoxADV3HXj50sZ70uag==
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id y11-20020a6be50b000000b007c44f8750c5sm1961995ioc.12.2024.02.13.07.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 07:55:06 -0800 (PST)
Date: Tue, 13 Feb 2024 15:55:06 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Johan Hovold <johan@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZcuQ2qRX0zsLSVRL@google.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <Zct_tB-y7HbZU1dp@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zct_tB-y7HbZU1dp@hovoldconsulting.com>

On Tue, Feb 13, 2024 at 03:41:56PM +0100, Johan Hovold wrote:
> Hi Luiz,
> 
> On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> > device address in MSB order when setting it using the
> > EDL_WRITE_BD_ADDR_OPCODE command.
> > 
> > Presumably, this is the case for all non-ROME devices which all use the
> > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> > use a different command and expect the address in LSB order).
> > 
> > Reverse the little-endian address before setting it to make sure that
> > the address can be configured using tools like btmgmt or using the
> > 'local-bd-address' devicetree property.
> > 
> > Note that this can potentially break systems with boot firmware which
> > has started relying on the broken behaviour and is incorrectly passing
> > the address via devicetree in MSB order.
> > 
> > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> > Cc: stable@vger.kernel.org      # 5.1
> > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Can we go ahead and merge this one to get this fixed in 6.8?
> 
> I've spoken to Bjorn Andersson at Qualcomm about this and he is in
> favour of doing so. The only people actually using the devicetree
> property should be the Chromium team and they control their own boot
> firmware and should be able to update it in lockstep (and Android uses
> some custom hacks to set the address that are not in mainline).

Unfortunately it's not as trivial as it sounds for Chrome OS. The boot
firmware is controlled by Chrome OS, however for any baseboard (e.g.
'trogdor') there is a larger number binary firmware packages, one
for every model derived from that baseboard. There can be dozens of
models. Chrome OS Firmware releases are qualified and rolled out per
model. FW qual may involve the ODM, usually there are multiple ODMs
per board. In an absolute emergency it would be possible to coordinate
a qual and synced rollout for all models, but it's definitely
non-trivial in terms of operations.

