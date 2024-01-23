Return-Path: <linux-kernel+bounces-35826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F12839707
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4FB28E93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3781215;
	Tue, 23 Jan 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="awsL7LRn"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6B8004C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032463; cv=none; b=PfKI7YSm2WunxnttKgTJ8KZ/+LIo/wHRZi8LPycFt6OlRZ0UpGQm3eelgAovBQJLMqGRMpEvcJDUC/tBPUnn05vhXW/a0hFflbv2Z5c4o06fMqYmzzzxcQcgpLRem4XwFceMKSbOG+vZtcPYMy5FQnxXE2knUrY7E6dRT3afL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032463; c=relaxed/simple;
	bh=ymav3I7OIfk8X1HSTDNWXcyiXMBoEN1DizaaPQT1+Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkK6KqJHsr15C3wobAu6ZscBFqGvGRb9qHid/6t/24Tb9Bdemt09RJdfJS3Tq+ZNDvz5FLYrBpOc8KClAXJ6RG7kwcL1jtKgAS/NsgwoCy5652i1miXXjx8RX/KSIY+DGN8Mw5NLgYPUsGMcULr8Ij5cyTcZ8LvY0tDNxlExeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=awsL7LRn; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cddf459ba2so9814671fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1706032458; x=1706637258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ymav3I7OIfk8X1HSTDNWXcyiXMBoEN1DizaaPQT1+Og=;
        b=awsL7LRn7JEfeF1hk0qJTTdCauxlTXCXZZx3udaLATagpbJ9lUB+woVFHISSU97Rkj
         /b3pnEAs8b0HZFXvFHDJN9hNLSJfgND8sP/ii3FS+ktAOdvasdJEHlD6BtrBpfv2PHhk
         vDmtxceOJdSlSSUT51I3up/845QAAcWcl3B+ZDbmLzVsMpRqQSbZyvQE8u9okHzrBodT
         h7GYLsGtuxTQPgw+I4EKy64sslZCV1bDWdTTnvAxjNHZtH5BmmKrOfXq9eQ3m2eMFE/o
         Rb2j9ThuPGgft6f/qjO2mWCMW/YSiavirFECJ5dzILEs5/FC+gmh7M5PqVzbJnhhI+aX
         IMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032458; x=1706637258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymav3I7OIfk8X1HSTDNWXcyiXMBoEN1DizaaPQT1+Og=;
        b=tSJQ0Rq0gdIYJQWl0ZIE9Mz5uVkjRHfFf+0WL7ailJ7TRDozbTEu7KC9RsJyTk6edy
         KT2if7zr6RwWTouCfzquydZ0whCnEN3XARya1eQfYnCsnCNnIE8q6o8lQ/0lQa4Tnm5z
         oInm3XONTprm0oE6dQVsi1PVOy1vQLHZjbufoO6enk2bkGgLJt23ocrVdyqLZ4ChzyNo
         tZuijWaVE+viphzTglHnoy5GOvBC/CVjTjuTLfs9NwNUYVlm43gpJh8FLdnTFHLGdtXq
         ndYb14Ym96E4qqKkshCi/YpwQ0fCZ6gOZLhlPMysw0OVb8CAy0/WflByZaLzsSYZzTCB
         gcrQ==
X-Gm-Message-State: AOJu0Yy9OCASVAWzGzA5JdWb5dLdQn9gLNhDYYofVpR/hvNKTEH7DodR
	4bJSMVsunMaRICi8r/FdCWHjrWLtcwS5HwOsWqle1S3Q3rRcqjnlo5Hbe4uoWOai7BdLyoZis/V
	2t2eWPwuY/5ouEjzeRSm/NyDhUQ+g7t8/UvozZA==
X-Google-Smtp-Source: AGHT+IH5dOs4rVeRzijl7xfb6jmnW4/fJGG1C3+Cm0MCoVfunHt5sFT98pbl+4uKUnCzDyMItW8DhqfNf16B6C/6jm0=
X-Received: by 2002:a2e:a4d7:0:b0:2cf:d52:6ded with SMTP id
 p23-20020a2ea4d7000000b002cf0d526dedmr1804740ljm.3.1706032457838; Tue, 23 Jan
 2024 09:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220413083824.247136-1-gch981213@gmail.com> <20220413145843.46a3d9b5@xps13>
 <CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
In-Reply-To: <CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Tue, 23 Jan 2024 19:54:06 +0200
Message-ID: <CAM1KZS=tvEi6fed=BoynpkjfzZqKGb-wv+CVbVmAPYz5tNaNkQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Palmer <daniel@0x0f.com>, open list <linux-kernel@vger.kernel.org>, quic_sridsn@quicinc.com, 
	quic_mdalam@quicinc.com
Content-Type: text/plain; charset="UTF-8"

Hi Chuanhong Guo,

On Wed, 13 Apr 2022 22:50:43 +0800 Chuanhong Guo <gch981213@gmail.com> wrote:
> Their device ID aren't conflicting yet, so nothing will happen
> at the moment.

Since commit aa08bf187f32 ("mtd: spinand: esmt: add support for
F50D2G41KA") we have a conflict with the GigaDevice GD5F1GQ5UExxG
(manufacturer ID 0xC8, device ID 0x51), preventing our board from
booting.

> There is a solution for future conflict: Recent SPI-NAND chips
> contain a parameter page which has the exact chip vendor
> and model. We can do one more detection with the parameter
> page content.
> Winbond W25N01KV is a 2k+96 SPI-NAND with 4-bit ECC.
> It uses the exact same chip id as the current W25N01GV
> (2k+64 1-bit ECC). We need to support detection using
> parameter page for this crazy decision by Winbond anyway.
> I'll try to code something for this with my free time.
>
> My current idea is: We first do a detection based on chip id.
> If that failed, try to read the parameter page. If we got a
> valid one, match the chip vendor and model string.

According to the datasheets, the ESMT chips actually have a 5 byte ID,
the last 3 bytes being 0x7F (JEDEC Maker Code Continuation Code). Why
can't we simply extend the ID in esmt.c (as you had it in your original
patch) and increase SPINAND_MAX_ID_LEN to 5? Or, alternatively, only
extend the ID to 4 bytes?

If that is the way to go, I would be happy to provide the patches.

Cheers,
Ezra.

