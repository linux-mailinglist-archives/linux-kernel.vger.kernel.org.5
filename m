Return-Path: <linux-kernel+bounces-48628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D9845F06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AB12881C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9B82C9B;
	Thu,  1 Feb 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lS66ruUO"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67982C88
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810344; cv=none; b=O2+d+hXOVIjVNdZzLOav4rvxge94jeDG4S/0d2Zv1D7xMSFxNMF3M9l0iyRk1rFItipTXgkHM2jsEpiOxpWLEzoJOFTjNNRi2TXVkbPtcGc7CKKqHGIX+zrFB3tVhjEQZuwghCkF2vBGl9Aro0iciut3EARPJHjCYNVwRkkRMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810344; c=relaxed/simple;
	bh=X3v6maRX2Wil4RU0hQz9iObnHNwbKfLz6Uw1mrFS9MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skTB6M7HhQ4P4Notn4BzW7i0hiY5Ym5f2F68UPn7tOI45tuXUY0TKgSGIiWWSTEkdwMm/Ad6OxIIeOG/7G3ZYU+PU/bVUEgxbqBcv93g2V78eFU/DEtKy+k5bTjTdioarGfbq4TwedinnWJrZK15JXdph6NNc3KLkcQ1EMDQT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lS66ruUO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so920353b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706810342; x=1707415142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZhsmua/d0p7gDylZQVPgbUSXpCAitwJXunt5F/HsC8=;
        b=lS66ruUOWf4DciDRnaks9cVngyg2MLsVNech9aeSVkGT7Z5orHa/pQT7V0Jq/A+RSj
         AFBNBiSsMXzJtAW0XorsW73ACWEQFowRVoNPPZd6xkh6LhkJ93FAkiLyqW/4qJxTqZ0A
         G0PctXwL+rykRR+G/MAeI4jX02Mh/iwRzsszM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810342; x=1707415142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZhsmua/d0p7gDylZQVPgbUSXpCAitwJXunt5F/HsC8=;
        b=XVQwn37B7unvpgJvo13xqUjEEsimRkWMhl4a65S+qHyXpxWz6FYYigCCoegCd4QEF/
         5MpnsrOHmhrGe4OscyEzSANEgTgUtXKvbmXSoR6a7t1rFvC/gCkludG7B5SGgDPppIuT
         ZSP+GbEYIwhvLgHaKX4FcjyjL2SrTLJ2P4YYz29B7awetfqpJKhd7q5FXwycgubPoD/w
         JALXPka6h3QVj+g7gfn4KG2EPwg1srx4t5kvTWjbZ1OUvvZpdXovEvUxewGmg4yheu+9
         txKy9hFTfdqoEHpDhf/2BYNbx8ce+I5m/yfNRVEdalTGhMsqEORjZCA0uVc3ydGZ7tkK
         cllQ==
X-Gm-Message-State: AOJu0Yw3GyGNE6Lud9J/tuQrp/w806tPQUoYBTsdiu/1JA5VX81tOkAq
	1YHUhdqypOrp439QwTcEyZhqzq0f894eSiGUZX/E912R2OMfYOt6KoLKXAmJ3Q==
X-Google-Smtp-Source: AGHT+IHt50oMnV5XTNvwgkginPdBitaypl2W+xtm1IShOjsyc3cq8czDGkJKmW0jOMCVqjElbFtoPQ==
X-Received: by 2002:a05:6a00:99e:b0:6dd:a0a7:ad9a with SMTP id u30-20020a056a00099e00b006dda0a7ad9amr7200358pfg.25.1706810342669;
        Thu, 01 Feb 2024 09:59:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoEP84EnFFlZw2GM8/0PhEMFHSvVM05LBl0T0p3g/PfufTqKO8NblqQG9/Hd+HD8cLBDK1JFsbx1nJVNcRXEINhCucLzCDCoR/vITH6dgH/wMDrcyd3ccDwsi4pwcXtihPniW0bhACycIrXi692al+qNkNe7tb6TwU6WUFB1b1GExOIfd+Em5Kh7o2Dg8lKmJ10Ut+LR0y4DiEkR8adgzsPWBiwQW614Mi7yV/eXfYopDebL+ZgKV/TTYyzLbB918I0kXG2WtMbxUOOVOkvtd0uBO4JIcVO75tsjNc5f/JKXwlILX6IUHyaGRhISxYs/q0sd0qPwkhRGhQkAqrSehzLG0e3bo0yNr9JdSJs31iddfkx5MZjmYZqZfM2mZ0QqvZsokY+TwjFiDAG566WSCm0Axxe0LGia6ngl0Jm1h6zocLDquXzaJ4kIGfWJ4tJYqh35wydsDn59gLQLanQPLfDCZWcjxId47D8IH9Xi45goHyETSDaoJlgZCQltOdNm8hkr+B2CsEbu/ONS/IefpOaTukJrRHzbJPL0Rf6+fO8pgweRrGspsbnrpgC6YzyLSMxTwOG6uNrBLGSqLeOuOv9nH2APIeS4FHV1k61EEuS3YTvdJH8k5ii+DUVFmAa0cut/6akkHQzsBG9R1JqNSCNMobGsk=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a70-20020a639049000000b005d8c07588b9sm88259pge.10.2024.02.01.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:59:02 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tony Luck <tony.luck@intel.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable PSTORE_RAM as a module in the arm64 defconfig
Date: Thu,  1 Feb 2024 09:58:51 -0800
Message-Id: <170681032908.3615624.2380873910802248311.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110210600.787703-1-nfraprado@collabora.com>
References: <20240110210600.787703-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 18:05:01 -0300, Nícolas F. R. A. Prado wrote:
> This series enables the PSTORE_RAM config, aka the ramoops driver, in
> the defconfig.
> 
> 
> Nícolas F. R. A. Prado (2):
>   pstore/ram: Register to module device table
>   arm64: defconfig: Enable PSTORE_RAM
> 
> [...]

Applied to for-next/pstore, thanks!

[1/2] pstore/ram: Register to module device table
      https://git.kernel.org/kees/c/d8c70720ebfd
[2/2] arm64: defconfig: Enable PSTORE_RAM
      https://git.kernel.org/kees/c/393bd157dbf8

Take care,

-- 
Kees Cook


