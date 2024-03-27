Return-Path: <linux-kernel+bounces-121967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F788EFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E54B2639E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03F152DF0;
	Wed, 27 Mar 2024 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/dXaIql"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0C12EBF3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570598; cv=none; b=M22ZGi6B66sNE78aN6+xq8R60Qdlka9oJqR8Hnkmfma7MN5RQj18lJzddQ1WlZbxe2Dq68FtwXt4kMXu2rsirYee9gqJWUNBX5B0MhVF7724E6UKnvQmVWwyjnfoGT9toOF/04cQJoera7Fkf1stXXza2bggQB1CynRJSSDoWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570598; c=relaxed/simple;
	bh=YrO2w4MQtMGQJl+C4zezHdk+MgMTRx1IBjbjBm7MeS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmNqbqO16SL2mscdz8L5F68759EK4aC06QSLlyq+eINwFUUbvjjO4Zt9XBqXReP6RdIuldsIwxUO6aFxtr/QVH9HAHap60bOFgrtpQAo3J2cXMRbu5zWTy9rSBtW47kZ3pIUHciDS2VoXJqkRRT7lg/Q2b9CnpCFbMWv0FT0VoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/dXaIql; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711570596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwEBfTVIpv7XvJsh9BUgL+PZXfXZtA0LjRzNOY4muX0=;
	b=L/dXaIqlvZuT/HLn/jHQKMYh6PW8+GRi7R3JShQztcD6lw8RIiO88xmDibqgcD1jiL/pZH
	9hP3n/3ZM74GY1fRPsFIxbraTNbrNvH/rXvVQKLgWXDE01CtvUpXKelWj6m4ewAOG2D3Fd
	FmrT9MTp1HPiTOD19wxMDtcGd9CWD5k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-xtM8QZyvMNaBJcA7_aE_gg-1; Wed, 27 Mar 2024 16:16:34 -0400
X-MC-Unique: xtM8QZyvMNaBJcA7_aE_gg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a473769f8d0so11610166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711570593; x=1712175393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwEBfTVIpv7XvJsh9BUgL+PZXfXZtA0LjRzNOY4muX0=;
        b=Oxdnr+MCQDW0vcGr/ZfUAyikyRllNFxZXSrjXxu7YCaIRW+hvavTA57CJ1fEFA5juw
         nMifgrnxVKNGL+gbvQcbUGgFxJOoHUmH76lEnvgxrHzzaJbfaLzy+5lAK3BQNb7A3DUV
         eg+qaYuU86cR2XbbwaGN86DgC2ZdMBGrh8Kr4AaTTcnjpXYEB/kMhrS5mrtD6M1PsNJA
         YBi3HUNe/iApYcWVEAhsypvh3lrgfRQ9LUH0w6Rtx84mfd6/Ty5FAyFc3MTo7priT/xt
         pBrNgigIP7VFoc/VaXZDQbC0Bezn4sZP30fFQcvQ0nd/rHXDu5ges502nTzM3UtclIAc
         sYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzLG/Kum1ViLJ89A9IOltWC7S409WjxCBxJ5lky1gWTBt3W5aCT47DCCXfQ3XEdO7t1DLvuQXRL2J42t7vZEfDNTnluTf/SqReXXGL
X-Gm-Message-State: AOJu0YxSJ1DiL6TK04DdFWlK14RrVJGujOsrBznQ8zYB1y8fzxDFGNVf
	Ly9KG8KgSo/mpIL0HyLSA8rdXjsdh2a9eMI3HaBTazq2GSBd9F1Idy1OMlJ2LpPu/8q1/Hw/nmr
	0NM9U2wgWP91/e9YaujsB8eNoy3ex0BZYXxXuLt8a84ujhxyuj4GOM36hwIQcUw==
X-Received: by 2002:a17:906:2a0c:b0:a47:3c66:b396 with SMTP id j12-20020a1709062a0c00b00a473c66b396mr331864eje.64.1711570593712;
        Wed, 27 Mar 2024 13:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB2nm6eBBuF/WUHUby6mr03fr0aGqm1maYoTObj3UaeHRr4EMZRSIjy7oYDqKHSbXactVRkQ==
X-Received: by 2002:a17:906:2a0c:b0:a47:3c66:b396 with SMTP id j12-20020a1709062a0c00b00a473c66b396mr331858eje.64.1711570593466;
        Wed, 27 Mar 2024 13:16:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id js23-20020a170906ca9700b00a4df3ea61a9sm2305759ejb.57.2024.03.27.13.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:16:33 -0700 (PDT)
Message-ID: <a337c02c-4e85-44a4-acf8-dd1b47e108d5@redhat.com>
Date: Wed, 27 Mar 2024 21:16:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: Add ACPI quickstart button driver
Content-Language: en-US, nl
To: Armin Wolf <W_Armin@gmx.de>, dennisn@dennisn.mooo.com, lkml@vorpal.se,
 ilpo.jarvinen@linux.intel.com
Cc: coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131111641.4418-1-W_Armin@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240131111641.4418-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/31/24 12:16 PM, Armin Wolf wrote:
> This patch series adds support for the ACPI PNP0C32 device as
> proposed in 2022 by Arvid Norlander. The first patch adds support
> for the device itself, while the second patch was taken from the
> original series.
> 
> Both patches are compile-tested only.

Not anymore :)


Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans






> 
> Armin Wolf (1):
>   platform/x86: Add ACPI quickstart button (PNP0C32) driver
> 
> Arvid Norlander (1):
>   platform/x86: toshiba_acpi: Add quirk for buttons on Z830
> 
>  MAINTAINERS                         |   6 +
>  drivers/platform/x86/Kconfig        |  13 ++
>  drivers/platform/x86/Makefile       |   3 +
>  drivers/platform/x86/quickstart.c   | 225 ++++++++++++++++++++++++++++
>  drivers/platform/x86/toshiba_acpi.c |  36 ++++-
>  5 files changed, 280 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/x86/quickstart.c
> 
> --
> 2.39.2
> 


