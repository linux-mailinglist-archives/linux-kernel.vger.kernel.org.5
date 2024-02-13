Return-Path: <linux-kernel+bounces-63220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE19852C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EB92835F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D392231A;
	Tue, 13 Feb 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="pJ73C4Oi"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F622EF2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816964; cv=none; b=FKV6C74kOhj1oOfFOJGuSZRFE5J9zZAQejyMEXHte7YQAKjrXDcvv4hqwcoAd0dgaCfMYN8vV06CcfJfcL7YySOTWKw+MSE8bfyU4syByin5hhXNJSOGSlt/AWgt+Fr1cgtAxzpvQ7Tu7EkVYnZ2ZXN35DmwT2T6liUrt4GArxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816964; c=relaxed/simple;
	bh=B6PIRF1YW9xcHfchIY+ftgkmT8yekQiVqKxqKwejxNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMj9F5rNunJVZFXKhG+OQ+r6XE5XYl78aXQOe8NZnARRiUjkZ45tMTFpa4tSpyEk07UGVXgwpKlD+O5qQ7O+Qn1DMARP6M442evj+ayqZLLzhLYXMkbUODkYy1cR1UKPLltL8zZdhZuFMrOs2nvXlB+h4v5GGMWSrS5I4wfhHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=pJ73C4Oi; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21432e87455so2635629fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816962; x=1708421762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV0A0nmKsy8PYCSYjFf9mPfVvhSNUYlYMjymmNOi59E=;
        b=KQFkPh/6E8licvd2q1x39PJCPGaCbHRcxkH71ik3To6czBLpUoy91SJLbL1XqKnMAr
         BlGsxswAi7I2lyrg8HMU6oBVORHZIFm78tOc/4MaFdNPwUc0rvJm1Cdo+MWNdPTN0u3e
         g4h+J6C856m5RaGRFFyyMeR88bQBftos2eafWE7NKIiv8M2WD/f6KO8AbHvJNY7JyMqj
         OM5zfgJkDtIIiU31OBwlx2yr4ziV0rybTx/Y8K3Gl0vOHxx3+Y2afVRwphS+LOq46sMd
         wbunfXztpFfpWgYjaOAo8ECR6Imn2ajSIwRKQjDyURUvp3d6CpFidyWsdFHBgodG3nIf
         pNPw==
X-Forwarded-Encrypted: i=1; AJvYcCX8kbQLzV8JKlQpbDgbwJ1RNNln9vwImveYF5aLcMf0GGfuLucJGgS1bbCaP8grIuAUOhnuka6LINqhKdto1s9eYi3OB3mzdSjQTE2V
X-Gm-Message-State: AOJu0Yx7He5ryBVcfr1wP/I2u0vDfpDwA+snOrEGmlasCXhbZaRdqdU5
	1BMG01uDpCo2caQwFOPQEGReom0t2VGAdxRGLXQcLhK0uaJDNdIE
X-Google-Smtp-Source: AGHT+IEV0juLyM72w0UTnpWw30aYu6RizsUl1I3jQAYodBCs15ZM0PcZkyrB9zcbfuSWzeJAe2rFKA==
X-Received: by 2002:a05:6870:f151:b0:214:dc31:a7b7 with SMTP id l17-20020a056870f15100b00214dc31a7b7mr9928943oac.53.1707816961694;
        Tue, 13 Feb 2024 01:36:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0i4xtDncFjiaK7ebXWKtgp4ly9pKcF9fdePIPWgOogcoPEm2clZQ0NtfYqe4a8vffssieCSQ8RvoDAONhD6sSlwTxuKxAU8ldG4JrYR95dwjogEOz+b2C3EADwJW3y+kRVcPvxltcouBB5yV+/u4xWt9UVwSAVR7Rew0Ai9hcL1+YD1yIdG9AkZDT7mVB6MZ/sDs1VNxi/7HtJfMHRAIpKqvhW2c9GtRA9QD683CDPjcdFB4mk3N9jVMSucsE/88/1ZKnsxd1nXOZmoVYgpU=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 75-20020a63004e000000b005cd835182c5sm1900121pga.79.2024.02.13.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:36:01 -0800 (PST)
Date: Tue, 13 Feb 2024 06:36:32 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707816959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV0A0nmKsy8PYCSYjFf9mPfVvhSNUYlYMjymmNOi59E=;
	b=pJ73C4OixTpldSUovTEuAHoBhghosBc1RxXObdohFcUEXsZzdeug1EOAqXziyMfbmqfK3k
	5PZxFCWzoIphrEHAe0vFzIB2aVyaBtWYBgHAiRXRxMdirgLSdJxN9oLRVGTmhCYTolPHxj
	HxkfzdQ3x0v2ve+pDbt4/ounJ48m76fv+X5drcqoVgh4YenV585mcYLPIV+W8WMS4UIy1p
	m+B4mZIHGhNk/MKo4kPnN/1KZjwH2yRkBf6i7XrUk+sAIE0AhpmTREGlg4sdR7ZcNK5wzf
	m3tu0bq1uzX7DUIsHQdD+wONmsWHm81pBj0LYpOuZ9VA1xaDQbqm0siKHvhCxA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] powerpc: struct bus_type cleanup
Message-ID: <h5f4bo5awkidvp75yusn4fkjybdrxdaz3d366zhd4xsu45cska@nxm362wm33g3>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
 <417a6531-b298-4d5c-aa4d-755bcef2f414@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417a6531-b298-4d5c-aa4d-755bcef2f414@csgroup.eu>

Hi Christophe,

On 13 Feb 08:05, Christophe Leroy wrote:
> Hi
> 
> Le 12/02/2024 à 21:04, Ricardo B. Marliere a écrit :
> > This series is part of an effort to cleanup the users of the driver
> > core, as can be seen in many recent patches authored by Greg across the
> > tree (e.g. [1]). Patch 1/5 is a prerequisite to 2/5, but the others have
> > no dependency. They were built using bootlin's without warnings using
> > powerpc64le-power8--glibc--stable-2023.11-1 toolchain.
> > 
> > ---
> > [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > 
> > ---
> > Changes in v2:
> > - Added a new patch to make macio_bus_type const.
> > - Improved changelogs to remove the word "Now".
> > - Fixed a build error: https://lore.kernel.org/oe-kbuild-all/202402102142.uphiKeqw-lkp@intel.com/
> > - Link to v1: https://lore.kernel.org/r/20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net
> 
> I see another series with the same name, does this v2 also superseeds it 
> ? https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=393570

Yes, please disregard the other one!

Thank you,
-	Ricardo.


> 
> Christophe
> 
> > 
> > ---
> > Ricardo B. Marliere (5):
> >        powerpc: vio: move device attributes into a new ifdef
> >        powerpc: vio: make vio_bus_type const
> >        powerpc: mpic: make mpic_subsys const
> >        powerpc: pmac: make macio_bus_type const
> >        powerpc: ibmebus: make ibmebus_bus_type const
> > 
> >   arch/powerpc/include/asm/ibmebus.h       |  2 +-
> >   arch/powerpc/include/asm/macio.h         |  2 +-
> >   arch/powerpc/include/asm/mpic.h          |  2 +-
> >   arch/powerpc/include/asm/vio.h           |  2 +-
> >   arch/powerpc/platforms/pseries/ibmebus.c |  4 +--
> >   arch/powerpc/platforms/pseries/vio.c     | 61 ++++++++++++++++++--------------
> >   arch/powerpc/sysdev/mpic.c               |  2 +-
> >   drivers/macintosh/macio_asic.c           |  2 +-
> >   8 files changed, 43 insertions(+), 34 deletions(-)
> > ---
> > base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> > change-id: 20240209-bus_cleanup-powerpc2-498426fccb98
> > 
> > Best regards,

