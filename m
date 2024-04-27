Return-Path: <linux-kernel+bounces-161005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309FB8B45AA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448EF1C20F84
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30014879B;
	Sat, 27 Apr 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L8Jv+9da"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872154644E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215763; cv=none; b=nAv4MRBP5gA38rhhk5waQl8RtA70ixa10AYkz+7WPtF+dLFCfd+vmvwnfUSvHsuVTOWPh+B98Xh3dyBOXQjqPQPrb6JkrUMshgjjjxAj06By7JQUinbxlwaxDkgWy4L8TApyhFgY8IPpVrqsHH66bzoM5ldjnszkH7SpnEdaw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215763; c=relaxed/simple;
	bh=SdVWyGuDCcQrIJ7fzWwR31HxNpM16sH3dH4YrTuBW6s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnQOsPX2kp6r6P4IX0iVadHQgMMHDDin4/z7obgCfCBlcNC8Z9UZ70Y42ajZZ6cHOrma5J9QuwfcvgM4a97gLclUxka14fUsfJaB0tD/8G4dRZVzwx0VkYQkIXXDRhLqPC4bvNMlNZU2SQkx3y4iFCA+GIfX4gHUd0zvLcMQfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L8Jv+9da; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a55ab922260so395069666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714215759; x=1714820559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw7YIWRgewiIjaQbILnrrX2snAdB7TalnWcaho2WU3o=;
        b=L8Jv+9daB332PLjvd4UFkr+9PNEDKLJtxZf85f4qL6T0VNvTHsQylSdlFHM/Wc0vva
         D/21lb9dpPSTM+DfwM2sdIY95boCtHze3kggayx0ysSeyg3Ylq6PNW1q4uQVVdc7LSxz
         R0tToW1r65zDtuswtPAXYhT2im59oTsVU2tvM55KGQAec6GNkZGD2rQczSjvPNcBW/ra
         YNQPLGpL3RO7fAPPWw8SvyXVcmgLIZF8ASmJy4/lvyK9S41pTif5VnAL6PHTTaK0m5/H
         vkGdOTIb6VMo8/+HBYYcZkILELGSh/BOQEEHeccfyX/Isvq01+MLMYCsefpdZuGCSFT0
         zrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714215759; x=1714820559;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw7YIWRgewiIjaQbILnrrX2snAdB7TalnWcaho2WU3o=;
        b=wFpeEpTWOnQgNv03Rlql0BKV/v8WIsP4UbROjmDA2lyaowB9iAm4NyCyC/4j0o6b0y
         +D4v5AiUlBjjp4igreryKuOSpEyq9iMedbH79pKIqE1tNkf8i7JPw7j5b6puWArldyFN
         hgL9j5ElcYnufCAONmu4vx9SQlb26aSH+l09PRcSIJFC77GyJRA+UoFzqfUl1R1iNzdt
         AHpjHkNXulG/GmXcy2fkU68npz6bDZo/i0gJ/5O3RUhbVjIfcl3tUifvFfHzi4MZg3ly
         HbpugXNfznt5VJzcqpC28Ca35XRF2DaCx1kjO2VU4+eIpdGoNsdD7/aUM5XlBUJTev7b
         zcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC5eU5YhMfh0kJGy8A8kahWwZueH3qmcPQqExvEMP5DhHCdXORtfPU0s4SOjcrCsYjfIwNHx7x7efyimRkF8rgR6YYUC8uA/MfqdJE
X-Gm-Message-State: AOJu0YyM2lnNR/ayPODdarbEbVHwQ0SC9yKDYv1h/t2j8YeQfOJprt9L
	a0lw4eqR1tRhSmfnsNsvJMHrqDOmmPc2OlJ+MYsHNHMgmW/jAKHA55ZeePzCNFE=
X-Google-Smtp-Source: AGHT+IGD03B2i7PKMy6HkJBPlBDJAzn/QclUOnQKtoK3JDSXtq9G1ETAVHvABI1pCX1NQAJQ0I3ePA==
X-Received: by 2002:a17:906:1759:b0:a58:7f48:18c4 with SMTP id d25-20020a170906175900b00a587f4818c4mr3406243eje.68.1714215758684;
        Sat, 27 Apr 2024 04:02:38 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id le23-20020a170906ae1700b00a4e4c944e77sm11516281ejb.40.2024.04.27.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:02:38 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 13:02:39 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
Message-ID: <ZizbT4Qo0XFB2m4A@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
 <198793bf-5ec8-4f33-aae7-75c635f900ec@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198793bf-5ec8-4f33-aae7-75c635f900ec@broadcom.com>

On 09:01 Sun 14 Apr     , Florian Fainelli wrote:
> 
> 
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> No commit message given the amount of lines changed?

Ack. Patchset V2 will have a commit message.

> 
> Please split this patch into multiple series that add basic 2712 support to
> the mainline kernel.

Please, can you elaborate a bit further on this?

Many thanks,
Andrea

> -- 
> Florian



