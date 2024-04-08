Return-Path: <linux-kernel+bounces-135732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFFF89CA85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F148B1F22BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1C143888;
	Mon,  8 Apr 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TR2e+Ocw"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CB142906
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596374; cv=none; b=a7C9+xQm8xBPg3VUV0AR+reDNAHRUpesxGRK2kerahJ+3la1JEUN1Bi/h8OoflaOimC/kFCC1D5D9Tt6mbHj8PyjrW3+TbaJjyr6O+EfrTTWvXbCBryTchcsLsi9hYSseMrd1z/u1n+JQdYJ6Mwk5h0b1UryS1ki/s5FAZP9tTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596374; c=relaxed/simple;
	bh=MMK6LDRIXHQaIEX/xSO/ytOm4Z0nzdBmVfF6/7CVjLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCsbP7iuaCco32XKxMkFxZYZPB876MgyuHRLHVlgNg3HWa1cvMmMUwaA4+PgiKHyJvIBnjQ8dr1kzAYvOalvNu8tO2hafSM6EnCaVZ1Mu1re6EoJwDZF4GNh2mFXvsoZOoOGitehpSr+sAlIQ1AACQi5yCN/7pYNR9uJ3iiQu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TR2e+Ocw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51ddc783e3so132696766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712596371; x=1713201171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMK6LDRIXHQaIEX/xSO/ytOm4Z0nzdBmVfF6/7CVjLs=;
        b=TR2e+Ocw6lPng4KXMXumyQkqTmEiCkd2zreUEAei16Ih6w7kiVLQVgWipF2wOTVD71
         fQ7T/DhGv9GcykbvAi7jsLl9kn5ZUeH1Xn+3fef9kjRpXLUwIO091HoxRDZP/o69uYD2
         S3WOph1iYmm6nZcXapoVTVrof0NQrMJnRGLeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596371; x=1713201171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMK6LDRIXHQaIEX/xSO/ytOm4Z0nzdBmVfF6/7CVjLs=;
        b=wJL2wR3PnF5YiEHJKqTX+8lB45lLG5dixktntEbZY3ftQltfMtQgda0joQSjFuuPDA
         nbF9Vk6vhrS9rTG++X+K+nkUEGF3BMpgFgGktYijNADf0pR4dKVdV0W3PG/oa+K8X8MM
         dqW7k3UrgordI2vhUJjJSsUHEqNuwTRJTbeyXD3HKsGFSUSlkIRVD8i3At8Q9AdZ7Gd3
         NCMCXXLj07R4zHVutoQ7NaZCAL30naKtU+vnyF0JQF3GwYGt3UXQLXAyTr0nvEelIK4j
         s+wNPAzZpmPYvkSOFs4doVRdRnZ4Sf35rNN/zH44J0HQ7VMKWx1EFWjuNq0V+IZXBjhP
         OAUw==
X-Forwarded-Encrypted: i=1; AJvYcCXxuOfZ1qhegLnx08E9rylZmF/57L3ES5rfQQ3F0kUHES8UNazLElPUusmneJ7J4MSJd96EGMcF5QyRQj0mlfYT8H26kCzq3IW1c+Jr
X-Gm-Message-State: AOJu0YwGI/B2Vo6AfYj5TRvc4v4CxJC480ERj8SILq/JUrIcwvGLynz4
	y7KAM6ffWl0eGJbXzaqqUvjwpRSv5DLb4c8x1GP/3YW/1ad1CPAQIPkmPNAiNPqJr9vXcEY6zYN
	HEg==
X-Google-Smtp-Source: AGHT+IGmLRRfooYJojqNFUAAv2RbGhYYZkrxqOBYY7Rm6s5YOSmKh9AmuoHx1HWlB7ZGcmSnytn9+w==
X-Received: by 2002:a17:907:7288:b0:a51:cbbf:5214 with SMTP id dt8-20020a170907728800b00a51cbbf5214mr3410732ejc.33.1712596370967;
        Mon, 08 Apr 2024 10:12:50 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id hj13-20020a170906874d00b00a51c1b325e0sm2965972ejb.211.2024.04.08.10.12.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 10:12:50 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41550858cabso31556765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:12:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbyhXxuuEaHFhGhjycZcb9xglGftksmoW6gkICLSxvZvVpkXiVl0RdHkv2BhTDzXcpJr/DzlTz1dOvNv4SzW93WZ9yzQH5heMebPXX
X-Received: by 2002:a05:6000:1566:b0:345:fa50:ba8e with SMTP id
 6-20020a056000156600b00345fa50ba8emr1333371wrz.37.1712596369615; Mon, 08 Apr
 2024 10:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408151700.1761009-1-festevam@gmail.com>
In-Reply-To: <20240408151700.1761009-1-festevam@gmail.com>
From: Matthias Kaehlcke <mka@chromium.org>
Date: Mon, 8 Apr 2024 10:12:35 -0700
X-Gmail-Original-Message-ID: <CAKZ8rEOZ2bPkxNxSRGMWQH6frvipwYXc79Lw2C8xndZmybaUbw@mail.gmail.com>
Message-ID: <CAKZ8rEOZ2bPkxNxSRGMWQH6frvipwYXc79Lw2C8xndZmybaUbw@mail.gmail.com>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Disable the USB hub clock on failure
To: Fabio Estevam <festevam@gmail.com>
Cc: gregkh@linuxfoundation.org, frieder.schrempf@kontron.de, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:17=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> In case regulator_bulk_enable() fails, the previously enabled USB hub
> clock should be disabled.
>
> Fix it accordingly.
>
> Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock i=
nput")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

