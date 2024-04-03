Return-Path: <linux-kernel+bounces-129801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E22897018
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7358287EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D50146A7E;
	Wed,  3 Apr 2024 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="OzTfZbDA"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007B147C9C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150352; cv=none; b=TJe//5IXXzl2wtaDDX6yNy1vl97UXgOVJhaW7F/rovXR0DltGcXgnOqM4fnfbPTfsnFYbkoMEFOH0AQDsjZwIdbYDAXiD9jjhw0z3RPHFLAe6uHiPbUXp1X/MhKKG8juQ+6kYjxaOg+vy92MGD39Kf0Q7DU2XwgtEiunHw+VJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150352; c=relaxed/simple;
	bh=cWyJ3cJLCpRglG8Yk4xFCKIFWdrd8x6dZaV75Jxrvbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca1u9luLkNqLowev60hsf0QyKYM2bIggJzuqjnXlW/V8j4wBvRtMmuqy81YxkdwxGdEQbHugdUTtgn1bIrrmEBAD9At0cCCy213r2qPrHtUDpZf0tHIe3bE/GH1j7kyEtyfn1dG7mkSeO5ojpUQpsiHzSfAnI2lMlkuAjGOdMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=OzTfZbDA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-432ff72d745so7666411cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712150350; x=1712755150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWyJ3cJLCpRglG8Yk4xFCKIFWdrd8x6dZaV75Jxrvbw=;
        b=OzTfZbDAK169DHvtiGLE1p56hWxrPJIvztF4HCEG28uzI7eK2DDmyoFnlpMcVff0Ju
         c7HfnRJdMT3cqqxjH5ta+XDwFfzxP7nhChJPfdXbCh/IYQgFfXapvkwDzhtcQKIMJDU6
         /AYta6lJ4gWauzOHkhmOzIjsNFqlePdHHn3xy9JT6hKwAeKaW0n7cYID5zC35uJ+E1J9
         MjmpsOIduTxUPwoUx60yV5mxx/3qr0JADBO7+Rf5akc1FV1XnIFH8emGKZpFjW7KCbm0
         cWNz6heaYM6CJ35L/MFmo5LBGu6IXNRGey0GQtZdKGb0oNwjKGxhdSPQYm+tHTmRafwM
         UqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150350; x=1712755150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWyJ3cJLCpRglG8Yk4xFCKIFWdrd8x6dZaV75Jxrvbw=;
        b=C/o5L4hiPedCIAh4gYwKsxvGoa0LKbJrFiTsgrVruVMT5tNoGvPOvkLCWbv8/eIoLY
         pWTzbUfEObupdUNAIVR6d92wtgKzBRweTKAeFae8zRAAW1c3mKnnF2BXenwSB7QAnSkw
         nRmpXgJn8qZb75P3QGL/ka4O1GYXnhUjGJLd7HIx+aYUiiZ7lF5mgP4WupgrxT+982QG
         ftntKoLCQwCjYoxi4jlOcrIiEDESyveFjSUVl4GTIXMf8etI+y6urtF8JlwHvL0vFXGR
         MfwsURxFG70Ek/eNg5YZsC3/qyuEppnqgIEKNrWfxBVT9OHdfjpFpo8ul+BGMFGvyG1J
         CW+w==
X-Forwarded-Encrypted: i=1; AJvYcCX0Zem1aaL0jv0HD97RG5HBwy84oA0VXzO5DILjSXuVT9lqs3dmv+DKiJX1AncxDPLgp0w9jMMvt+d1IZC5mlpyZ8sVfMkSyHByrbi2
X-Gm-Message-State: AOJu0Yw2emumiG+PAH/nXIRMRc/ZKy+70qnDHyID9/uaqqaJ38pS8WYY
	8nFM5IJjC5QHrExlhjBoeMW21ZPbGQx0Ml7RD/q0MAX/6EvGt3XEAo3/Bt+E5MrOAv5x1YC/4H7
	1ZbulhtWW5jTE07p246idrpA95lpllOdTKAj7pQ==
X-Google-Smtp-Source: AGHT+IEGVCWVaM3OZyGBYvZk7eIME6rUXSm4/CdsRsbb+oN0keiU95giarhKtyBsTd58XnIkGQv2TzNnxS90eOdz7ws=
X-Received: by 2002:a05:622a:104c:b0:434:338c:31ac with SMTP id
 f12-20020a05622a104c00b00434338c31acmr3549454qte.14.1712150349909; Wed, 03
 Apr 2024 06:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
 <00555af4-8786-b772-7897-aef1e912b368@google.com> <ZfTDUGSshZUbs13-@8bytes.org>
In-Reply-To: <ZfTDUGSshZUbs13-@8bytes.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 3 Apr 2024 09:18:33 -0400
Message-ID: <CA+CK2bC7jd65=eZoN7szWJKSO2TLsxxKFH8D6WjHS3_2U7=McA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
To: Joerg Roedel <joro@8bytes.org>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, krzysztof.kozlowski@linaro.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org, 
	m.szyprowski@samsung.com, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com, bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:53=E2=80=AFPM Joerg Roedel <joro@8bytes.org> wrot=
e:
>
> Hi David,
>
> On Fri, Mar 15, 2024 at 02:33:53PM -0700, David Rientjes wrote:
> > Joerg, is this series anticipated to be queued up in the core branch of
> > git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git so it gets into
> > linux-next?
> >
> > This observability seems particularly useful so that we can monitor and
> > alert on any unexpected increases (unbounded memory growth from this
> > subsystem has in the past caused us issues before the memory is otherwi=
se
> > not observable by host software).
> >
> > Or are we still waiting on code reviews from some folks that we should
> > ping?
>
> A few more reviews would certainly help, but I will also do a review on
> my own. If things are looking good I can merge it into the iommu tree
> when 6.9-rc3 is released (which is the usual time I start merging new
> stuff).

Hi Joerg,

Would it make sense to stage this series in an unstable branch to get
more test coverage from the 0-day robots?

Thank you,
Pasha

