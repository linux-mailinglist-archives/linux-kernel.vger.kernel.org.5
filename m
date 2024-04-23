Return-Path: <linux-kernel+bounces-154665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541748ADF86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B199CB24E93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED164EB24;
	Tue, 23 Apr 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SFiaGA+o"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0744C8F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860122; cv=none; b=HxCF/a610/VT3jtKZpsbBA+eNYKO/A3rKGpuYEIc70kKrO48w5vWKLwZKGp+AFinIcRTkVPp6zac7t+YAByvsLRYJx1FAuZyBGtq2dAjq2GbF9Ep++c4UWM/iqOGE8FK+fSw7kbKLQw5FKzxJGmNOwuq+wl6QJKdqCoVJ/Lg2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860122; c=relaxed/simple;
	bh=JSja9lhqzBxpPm9Dl7Kn58mh7Qp72gcE6cOY/1FjgaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTyZFTvyAdZztUXYFI3EIPNfWMdpF7ppQ8iCKcx0fjpFjKUt+vknl4rDAGhHzDX/LUip8tPnBETjUzDGtGkNaaq7FdQQ9iycb7xJf2Iqj4QKdT08h8sVK4lcrR3ChS9oIiztcIUTQH7gxmQplq5hMNboPoTJsA5W4fa0lsgrQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SFiaGA+o; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d1003106so4468127f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713860119; x=1714464919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDLatT6z2nkWTiwdyYcUvvJq9+ZxXPToD0XAs9gY3N0=;
        b=SFiaGA+oIKBzpK79n/0IxI+5yvHjvMsQcjjh6h8KxdFVlThMAavVtyMvpOBGX2H4ER
         OV9PXQiewIOrtpm4q1E6RkonnG0sZAXBNeHbNJhx58RvO+pJoUe+K33WkOpX5dpErUb9
         ozHWh936i+2VHhCocR8gAU4xAbJ1epsbmXOZaJ8RsFbDmUwaryPYPwpFX7MIjit0nbhf
         rctzeo2dnS2cRc0OOOfCS9unPBol9TzEdsYqjQfwtrsSdwQwOWdS9e2CsbzK5IBkFVKg
         ifnHxHFxKZl/40FHeU8g/xUzUlCBet+1J0bvVVrgVjAmLHNrgH+f2MmZSRkB+aAyehIz
         5dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860119; x=1714464919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDLatT6z2nkWTiwdyYcUvvJq9+ZxXPToD0XAs9gY3N0=;
        b=Kx/AUm7cFEwfI2X2UFweDVJtBTYGFlSi1sT8TM0Z6AsAwbfJwlU5kb1r5gwVGOKNxE
         2pEqoLT2itQDsHUgHSAZNGmj5J+OM7VbIcV3L9wbruMbJLGAMWJiUzOaM3804UhP4Jev
         pD9UGdFWs35vv5pf7bmypuh2WzBtQnWeQEcMn6NfWHUynDewT5SdB/0Q3pJASyA92Iaq
         FruJKJo1dPzT8SbgBfcBNN/qSOatgaHuLy0VYReFbqz6JVroY36mkuj/f5NLmAYyWScf
         pMtOKIxuYtGMRQe2xOEcbFV3ADjXPc5XWhIN4QbAqbGFdd6f3FYhE79OQ2clgOMt2CDT
         nOHw==
X-Forwarded-Encrypted: i=1; AJvYcCUPKRMkR5RAyVY9F7q2O7gH9EluHaplO8KUIOa6/1eLtVN7iBfKIY9s2pNrOmczbv97KH1cLCvCokoqPrys8zRzrJiLM/yrcY1wHPdw
X-Gm-Message-State: AOJu0YywhKFvWvOPi+mp1A0pJsgsZmmoG8KxjssykQg23NmkHI7lvQyE
	dsRNIjR0jl4soc/rFBaWEQs2QYtuD2905N5JBDA59kEoEtc0fvXIS7tGUWzNBg0=
X-Google-Smtp-Source: AGHT+IHF3Y0Es/MAeH3w4xn89FySTBFml+iixjQpMYFzr+Kl0mNaN/Fe8NzBFtJSd4HVjcHyMEzJew==
X-Received: by 2002:a5d:658f:0:b0:347:3037:188d with SMTP id q15-20020a5d658f000000b003473037188dmr10891497wru.34.1713860119316;
        Tue, 23 Apr 2024 01:15:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:a046:fbef:467d:18f7])
        by smtp.gmail.com with ESMTPSA id x12-20020adfdd8c000000b00349f139dbe4sm13947434wrl.91.2024.04.23.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:15:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Okazaki <dtokazaki@google.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel-team@android.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] eeprom: at24: fix memory corruption race condition
Date: Tue, 23 Apr 2024 10:15:18 +0200
Message-Id: <171386010055.10921.7297413066417044638.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240422174337.2487142-1-dtokazaki@google.com>
References: <20240422174337.2487142-1-dtokazaki@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 22 Apr 2024 17:43:36 +0000, Daniel Okazaki wrote:
> If the eeprom is not accessible, an nvmem device will be registered, the
> read will fail, and the device will be torn down. If another driver
> accesses the nvmem device after the teardown, it will reference
> invalid memory.
> 
> Move the failure point before registering the nvmem device.
> 
> [...]

Applied, thanks!

[1/1] eeprom: at24: fix memory corruption race condition
      commit: f42c97027fb75776e2e9358d16bf4a99aeb04cf2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

