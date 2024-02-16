Return-Path: <linux-kernel+bounces-69175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9385855F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8792D1F25964
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78E1350F5;
	Fri, 16 Feb 2024 18:39:29 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41678132472;
	Fri, 16 Feb 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108768; cv=none; b=A1vNRZGfIB3QhCbhBOpirQINSp4zjKqfxNMEnTg2CeFyD8wId4acczDVP06VzmKnluQaZZd+SqDrTYJvMvAIirQ3PPAf/NR9dt/DST0zg7KXg1wIXo/cogXN465fCysjK7ZWvZZrosNNDLLGWh1Lh2R/UbwbTCKuz4x/lyfgxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108768; c=relaxed/simple;
	bh=gXvmd4u6S1j4zmau92N9xY3+n48hIWCmkw374m2LDII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH+1OazqR2VZizT1k8NSSRcp6kp1zZkVNugmWpZklvrbqsDp8dRvzluunmyQLbNcsTGYTkC+GQIjpkm15JVNJj+iQddnuRek3HEVMnrIxBrEFtkTlao/bZq3RilGwFxnrs4i1vW0nzordYzxvZ+TSXwrZGk/O1iccmCedgDPJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59f9f9701f6so121175eaf.1;
        Fri, 16 Feb 2024 10:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108766; x=1708713566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWPnmj/LdKe3Uawh5Iayj+Gh5MbkrBOfFGQpz8gSZkA=;
        b=Q1JgmCvN697NA1mioOuKsd6fvzmwxxb3ajt2reh7XQa56BHbySXTfpVB10c2z1Xo5N
         hOScqw1QYW/p247i175WGhfAnqcdD35SyhvpJ27LJG3iaxBabw0aqGuRJzo0FFr3OYuJ
         4DqzUDjtHPiURHtLm2E9fNoSPriXnRFWBnYULeR2N2hMUN8dK+QFO7xm9DsxWhElRz6x
         8WU6vEw8YGcQagkDd1D8sJ9dHg/gJw32DhFGxnE2cLh6JBBBrlczLF54lk6nRZVOyPVc
         LQNmQQ+TcYDR+4d1A71c/xmav2cMVaFCTiGilhtcsej3/VjMHpCeuR/yf6MC2f2ljEI/
         cP2A==
X-Forwarded-Encrypted: i=1; AJvYcCXsZvAFZ6+JUaovPD5tC0Kt26cDmbqAgn6Lq/1q/hjwd1zwL4xIdqh2x/vMgy/xvX8F3YtdIlUhziR2uo7Xgw/xd0qUoUbZOxxrqCcHDahY8g73mkbQLH8kSyOlif12nbOg22nzFLsZug==
X-Gm-Message-State: AOJu0YyVIuY218lQ8zxR1wmR/ugJf0cxfKS+rWJm/qQJiKYaa+t0wjzH
	v+tEy/k2bksntyKa7UwbDMmvWGU4Z4Ue0PjTG1WM5vYFTl4BCn73YnMpTp9iWfBC/iRVY30n7Yt
	Yvftrl/hiKipR+5/kttmXKFGD74o=
X-Google-Smtp-Source: AGHT+IEWmmUvbZ48dKNHLJOKC/sVXLnlJsXyjMxNfSgPv9uxGEnKwXe6D3hhg3JHKQ+DwwQlc9UuPDIVmzeJl4Y8oX8=
X-Received: by 2002:a4a:d12d:0:b0:59f:8466:16d6 with SMTP id
 n13-20020a4ad12d000000b0059f846616d6mr3300825oor.0.1708108766254; Fri, 16 Feb
 2024 10:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240216072906epcas2p407a2f85aca1b9b8677fb8aa458c53aa6@epcas2p4.samsung.com>
 <20240216072931.34305-1-hj96.nam@samsung.com>
In-Reply-To: <20240216072931.34305-1-hj96.nam@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2024 19:39:15 +0100
Message-ID: <CAJZ5v0gusbAKRQVCgbvK7A6G8KQ5piNdUS=Sm3H2tWiSp-beGQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Fix CXL 3.0 structure (RDPAS) in the CEDT table
To: hj96.nam@samsung.com
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ks0204.kim@samsung.com, wj28.lee@samsung.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 8:29=E2=80=AFAM <hj96.nam@samsung.com> wrote:
>
> From: Hojin Nam <hj96.nam@samsung.com>
>
> struct acpi_cedt_rdpas does not match with CXL r3.0 9.17.1.5
> Table 9-24. reserved1 and length fields are already added by
> struct acpi_cedt_header.
>
> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
> ---
>  include/acpi/actbl1.h | 2 --

This file is part of ACPICA which is a separate project whose code is
used by the Linux kernel.  In order to make changes in the ACPICA
code, please submit a pull request to the upstream ACPICA project on
GitHub.  Once this pull request is merged, you can send a
corresponding Linux patch with a Link: tag pointing to it.  However,
it is not necessary to do so, as the changes will be automatically
included into the ACPICA code in the kernel once a new version of
ACPICA is out.

>  1 file changed, 2 deletions(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index a33375e055ad..7aff8c39dbd6 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -571,8 +571,6 @@ struct acpi_cedt_cxims {
>
>  struct acpi_cedt_rdpas {
>         struct acpi_cedt_header header;
> -       u8 reserved1;
> -       u16 length;
>         u16 segment;
>         u16 bdf;
>         u8 protocol;
>
> base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
> --
> 2.34.1
>

