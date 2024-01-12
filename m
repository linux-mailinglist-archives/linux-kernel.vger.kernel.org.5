Return-Path: <linux-kernel+bounces-24180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DAB82B8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0661F25B95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E8814;
	Fri, 12 Jan 2024 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EFdQAvR0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071D379
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6db05618c1fso3696766b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705019832; x=1705624632; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6WPjrPY8sFDDNJtX2ESYEaz78JA5oWqN+PplwYcMfw=;
        b=EFdQAvR0L1lB5/5h/zbwzkjJIenkpuEzvEkl0uusSWWgtAVa4fBFQ1zcit71agCbZ5
         tDgMAE6oCAROcQHwW6+7H+Fq8cz7PT7ySdQotW4njef/I9WhepNkyZXJAcVPoXL2CBlv
         tOltMEs3j9yAGC63xv+qmyPxZtEETHcr/DoWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705019832; x=1705624632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6WPjrPY8sFDDNJtX2ESYEaz78JA5oWqN+PplwYcMfw=;
        b=IwQcoiEiCpOUsIsDoGKQ3ueQtblK3BiBG5neEVVSslcp6Lsu+BBNIfDAYSEqMTbkXj
         dhfahvLhwGVBPCdtOctr97+YVFk3pqOSVgtbAEWapNtZtpMSAex010tn+uM9G4P0gZcb
         xZdAIbdI5Z79nJUN0mo1wNKTDHGzSJyjzgLXYQ7H1o94+X6gDuqRtdOe3bWwhSI22coG
         PdpwDLZVwyqxehW7xTy0xr9dVhgnmGNk8G+9H6qVhn63o6UWavjC00NgmCoPUzzVsOVF
         KG8M6cP25hR/0ckgegVFCQwshraLJOSCKOkbeNFpwEifhreS63a3bnAkgHNrs645CX93
         yb6A==
X-Gm-Message-State: AOJu0Yzl6lBlwFbSuKRn5Xl8zQcDoPMVMcS1fwyn2aOn2DYlQB5XmWdk
	BWIGogWGRwDfdhWz+C+fhl7/2i9UeSnW
X-Google-Smtp-Source: AGHT+IEFme88khQtS//8rogiv+/CCsFZHwy6qLQAGqTm7PiF2FR5LbGzAH15zmoHBxoWMFakNdReHg==
X-Received: by 2002:a05:6a00:14c9:b0:6d9:b112:ef85 with SMTP id w9-20020a056a0014c900b006d9b112ef85mr176405pfu.48.1705019831763;
        Thu, 11 Jan 2024 16:37:11 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:70e4:ce9:9cc2:b930])
        by smtp.gmail.com with UTF8SMTPSA id p22-20020aa78616000000b006d998c11eddsm1845626pfn.62.2024.01.11.16.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 16:37:11 -0800 (PST)
Date: Thu, 11 Jan 2024 16:37:10 -0800
From: Brian Norris <briannorris@chromium.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] firmware: coreboot: Generate modalias uevent for
 devices
Message-ID: <ZaCJWfIUHYKHcu4v@google.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-2-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111151226.842603-2-nfraprado@collabora.com>

It would have been nice to get the whole series, or at least direct to
all the same mailing lists -- specifically, chrome-platform@lists.linux.dev

But I found the whole thing eventually.

On Thu, Jan 11, 2024 at 12:11:46PM -0300, Nícolas F. R. A. Prado wrote:
> Generate a modalias uevent for devices in the coreboot bus to allow
> userspace to automatically load the corresponding modules.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: Brian Norris <briannorris@chromium.org>

