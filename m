Return-Path: <linux-kernel+bounces-64085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAA8539FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E071F24D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96C10976;
	Tue, 13 Feb 2024 18:37:38 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C578F9CE;
	Tue, 13 Feb 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849458; cv=none; b=DvymZLm+HBRccAyAhD7XM0MZGQ7oitlvYVIwGmIKbBlmXF+XYhJ5pFRp1D5j0miVrKxfX8PuypqXwSpnbPPHWStvKIL6RsQe/teXBgkG8dqC2micSjxKiSF413kcnrgeH1ajMYqhDXUO9Cifw8ozvM4KdZJsWy/sbCyMjlYWeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849458; c=relaxed/simple;
	bh=Ud9knnaUmsB+E5Qpwy1rObIvxq+nMG0/sBG1OpEs8tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka+n3uUOdFe0Pw69pk8Mf9vm3EywbcZ7OxEbhb/9w6PQzLNyNNFzldyPaD59jxRwmGMJXdxFXjPwIUjQFiiULx87FcvctPbDQmCZN95Ob7GelqIm4goDQZHpVboyhDr6eSVvt9osQ++ewbdPOFOxav0kCABZ+HkpiUndlj6RzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59584f41f1eso1868140eaf.1;
        Tue, 13 Feb 2024 10:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849456; x=1708454256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuLwfhOx6LB/gNAPQEQzeunr2+RTjrvvERBDyT9II6U=;
        b=RlqXpbT2XX3dDiPLOTPGfjxfWFqdcrgZuMwkubNSj2TKgWHWN+hGdqd7ak2n/UyWa4
         VcxNHCbxOiijaX4VA5deZMbfxcpjmBq51xJkxOUJAJN4DIkkYX1O4ywDjG9tmR6uhOrP
         i3GslMqiCJp1YOlgrjegH2UsjbPbEmRAjRG2J0PPcctOjvX7DQkhXMu4pmVUMFjK8i6i
         HQjb+jcMBDO4Wo3twR+KmENrDurNmN4UDg20xhfKp7HsptLXGTeeBhKXX3TQKWkCGKbn
         Wlxqnr2l88Jl+6OSk1AdpEo77xQ+a6ArVR616vgOWwSZ+TzgB6gqr8DVQ/eyloVrGCDB
         PluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHRKg874b/KXWq+E/BOqebBGiBSbA0bNKvEk2Dd9HvcMbA5tNKlHcqJ8Gqc6WNcJrSjxy1V3auB9Hqzi394wjIIU1N8yb+0LNETK+kqna0L6L2PM3Pe58t7iG+STbSZWcMY/WDYpY=
X-Gm-Message-State: AOJu0Yzm+GEVHk5914/wRrLYEKWECKPLCBpJ95EkfC8SzTglSv6GxQoQ
	/njbty7zPTxIsqVcj2BGG4kWhrXAziS50GwA9rm6iGeBEasnbncvSX5Yf+k+iUtXCQHRGewlG/a
	XsqkOHl7TIabPC970iLjaUFjS2nu2Lfzq
X-Google-Smtp-Source: AGHT+IFSHY0qlhuS1b6Dk1E1q9DBLbsemsy0MfTeKfMJyjRneAaly2xDsoDodakWEpS3z4gynEV+SF2qJLO6/lCCaig=
X-Received: by 2002:a05:6820:a8f:b0:59a:bf5:a0da with SMTP id
 de15-20020a0568200a8f00b0059a0bf5a0damr526517oob.0.1707849455825; Tue, 13 Feb
 2024 10:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131113713.74779-1-rui.zhang@intel.com>
In-Reply-To: <20240131113713.74779-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 19:37:24 +0100
Message-ID: <CAJZ5v0jq6G3dfFFZRJq0oGrX3h0R84xVSAvsn6pQqvcJsi=A9w@mail.gmail.com>
Subject: Re: [PATCH 0/6] powercap: intel_rapl: Fixes and new platform enabling
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:37=E2=80=AFPM Zhang Rui <rui.zhang@intel.com> wr=
ote:
>
> Patch 1/6 fixes a real bug when MMIO RAPL driver is probed on platforms
> that are not listed in current CPU model list. IMO, it should be
> considered as stable material.
>
> Patch 2/6 fixes a potential racing issue, but I have not reproduced it
> yet.
>
> Patch 3/6 ~ 4/6 fix a problem that TPMI RAPL driver probes disabled
> System (Psys) RAPL Domains.
>
> Patch 5/6 and 6/6 are two simple CPU model updates to support MSR RAPL
> on Arrowlake and Lunarlake platforms.
>
> thanks,
> rui
>
> ----------------------------------------------------------------
> Sumeet Pawnikar (1):
>       powercap: intel_rapl: add support for Arrow Lake
>
> Zhang Rui (5):
>       powercap: intel_rapl: Fix a NULL pointer reference bug
>       powercap: intel_rapl: Fix locking for TPMI RAPL
>       powercap: intel_rapl_tpmi: Fix a register bug
>       powercap: intel_rapl_tpmi: Fix System Domain probing
>       powercap: intel_rapl: Add support for LNL-M paltform
>
>  drivers/powercap/intel_rapl_common.c               | 36 ++++++++++++++++=
++++--
>  drivers/powercap/intel_rapl_msr.c                  |  8 ++---
>  drivers/powercap/intel_rapl_tpmi.c                 | 15 +++++++++
>  .../intel/int340x_thermal/processor_thermal_rapl.c |  8 ++---
>  include/linux/intel_rapl.h                         |  6 ++++
>  5 files changed, 62 insertions(+), 11 deletions(-)

All applied as 6.9 material with some minor changes in the subject and
changelogs of the last two patches.

Thanks!

