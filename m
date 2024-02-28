Return-Path: <linux-kernel+bounces-85797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2186BAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B6F28A276
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF92372901;
	Wed, 28 Feb 2024 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKz4xn2w"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17F71ECC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160322; cv=none; b=YODO0qikiXtbDwLVamHxbbucXYiq7qB3XTgdS+XH1h15Xl/HFSjrjHXLoH5rBBcKI+9gbypua2aGqL6/n8RSJpEu/wdPPHMTc0j/euhjyx/WksYQ/dwmQyk+LgoCDMgGUZ0/QDv/TDRmE4bCO3kgNSPamE0PZXULgJ1T9QTOlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160322; c=relaxed/simple;
	bh=1/CGCY3jhF/evFGu5DL8ruxZKJOzhM2yszIHb1BXMFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtwVYQmHhxsZjJgbDSRIcFXWnDocKMl8+EchqpU/OvPj4mf3eJfUZNL76IbE3TRS2g8919w/c0e6Czlm34BVH7NrpPuwrk6sELp3Mo9vCOpjDeN0aq5XGA10PWAlY9I/3yUtMmJCCa8Wr3FNCNyasSXx8P8P3MXlIuD42EYkS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YKz4xn2w; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513235b5975so235878e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709160315; x=1709765115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxABPZ28o1U9eMcO7y1qUMLxndBrASNoz0KbMJJ/fIg=;
        b=YKz4xn2wjxE5QXqeBGaAqLix3SQvnOOsn5GBSNc5BhlQiopao0kls/SlDlxahbPPdv
         Y+M/neUquTqYcge+AED5teN5qJduuZgUB3uBYlKk7FToB4U+/XoBwfcmHMEy5+NLSEXy
         UJ+0KxBb3yTqxMW/aW7FIWHyA3VCaEDjZ0xtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160315; x=1709765115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxABPZ28o1U9eMcO7y1qUMLxndBrASNoz0KbMJJ/fIg=;
        b=OEf1Ju0eOR0SyrlwNL8WE+x+o2HpJLlPOYNkpikiu2UN+RsSRxjppUKzqkLvWD3lG3
         OaFprouMbnX7aO9Fm+jt06QNQNtiDx7pXcXquETYI8j9WxeqCIHZPPNG63eQumYTTk7Y
         nQaK2CZRR9fYoHMB1XPRyRzCapEZr4YcwwVPdjY7rZwY9NgGARMaVgd6hOkS7firt4k4
         2RGpBH0F5gFEspnwPfD5Pn7RZkuaybPGfu2VSQwL9Vo+N+B+u7WRewyrYq2a5qUuYUGk
         HRnOD7fnzC8RN15FbIV2b8hCPsEQ1Ytryi07x+GffwMkErctZHsAVAsezrDvAF1/oQUP
         ae8w==
X-Forwarded-Encrypted: i=1; AJvYcCU+QGzwDKyJRNmfPzZnXVTlP+6qKH4DPYfrT0vL7sUBPEUbLFopTlZPOgnEDqirP7fyPR+7tOeSZ1K5arskdAnyLxHq3cVuNN8Am3FP
X-Gm-Message-State: AOJu0Yx5cei2h+WhsdAwP9LJiMnF3yzgSeQSD7KnCcpv7/MJa4FuL+Oa
	2n0NoyR4IY5SNavl5tfwA1NselbU+320S6v/4Xkozwy4p/eZxJrpratnOWeZLx4qBPOK7JCtbYX
	WH/hB
X-Google-Smtp-Source: AGHT+IGnwYGToetGFMd4TXKKIWYqBqZeGh2cAzZ1Pli1eZW4Ogxm2cNYjHSmTg3lhnBr4um95wYbxQ==
X-Received: by 2002:ac2:4d10:0:b0:513:2347:4b57 with SMTP id r16-20020ac24d10000000b0051323474b57mr168319lfi.66.1709160315694;
        Wed, 28 Feb 2024 14:45:15 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906b09000b00a3fce8c0f99sm2307333ejy.191.2024.02.28.14.45.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:45:14 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so9865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:45:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXph1xa+aLqQ356A4enzTzq6OyGLe5jno/uMSPKNlYTM6pTVmsw/DF5KOCASJezFKwaJsWfmuCHynTOOPO0qwPKZLEhI/a789EC6Z2P
X-Received: by 2002:a05:600c:538f:b0:412:b689:5d88 with SMTP id
 hg15-20020a05600c538f00b00412b6895d88mr18372wmb.3.1709160314368; Wed, 28 Feb
 2024 14:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228072216.95130-1-yaoma@linux.alibaba.com> <20240228072216.95130-5-yaoma@linux.alibaba.com>
In-Reply-To: <20240228072216.95130-5-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 14:44:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xgr4--NJ3dAh2ggxbFUV9-QR6rW+YXyMHZYXPVSkmaAw@mail.gmail.com>
Message-ID: <CAD=FV=Xgr4--NJ3dAh2ggxbFUV9-QR6rW+YXyMHZYXPVSkmaAw@mail.gmail.com>
Subject: Re: [PATCHv11 4/4] watchdog/softlockup: report the most frequent interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: tglx@linutronix.de, liusong@linux.alibaba.com, akpm@linux-foundation.org, 
	pmladek@suse.com, kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	jan.kiszka@siemens.com, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Bitao Hu <yaoma@linux.alibaba.com>=
 wrote:
>
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> most frequent interrupts could be good enough for further
> troubleshooting.
>
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by comparing the counts of interrupts.
>
> [  638.870231] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [swapper=
/9:0]
> [  638.870825] CPU#9 Utilization every 4s during lockup:
> [  638.871194]  #1:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [  638.871652]  #2:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [  638.872107]  #3:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [  638.872563]  #4:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [  638.873018]  #5:   0% system,          0% softirq,   100% hardirq,    =
 0% idle
> [  638.873494] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardI=
RQs:
> [  638.873994]  #1: 330945      irq#7
> [  638.874236]  #2: 31          irq#82
> [  638.874493]  #3: 10          irq#10
> [  638.874744]  #4: 2           irq#89
> [  638.874992]  #5: 1           irq#102
> ...
> [  638.875313] Call trace:
> [  638.875315]  __do_softirq+0xa8/0x364
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> Reviewed-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  kernel/watchdog.c | 115 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

