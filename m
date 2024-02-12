Return-Path: <linux-kernel+bounces-61728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8308515BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9DB1F21642
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E313D54D;
	Mon, 12 Feb 2024 13:44:28 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBA3B298;
	Mon, 12 Feb 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745468; cv=none; b=h1rnITC7C8KJoFtwQycOI+O4VYVGFfGCMmU6wNzC97EoGAs7CS9NywyLTmdOPpbHeMTmyzzMKOcuCj4wcFwTFEtvvyV8IzkOoVkeeHRBAcXCKyqEa2P/kuY4gK6MDlcx/aXC7nbekETDpmMS03O0+iCMoQmYHD4Dg5EaAD/qTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745468; c=relaxed/simple;
	bh=ppWjXqvOz7E5NKyhtw98QvPMgUwleYBISgwi5Vq2qHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt/c01UIRgr7NtbdXHHjaoUEN4slpNrPgwip3Z586+zILPZW04SlRkcEVzzlRq7sXeUflr/YwJmGq/TaGKSZByQBceRgJnU8x3/UlNhtke3kdeYpz/epX46iwcMiE6wlmgQ1jmn3Jz7f4/J4q1vJlqVyT9OqB7rYn37ZvrOtZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59d249f8e57so172827eaf.1;
        Mon, 12 Feb 2024 05:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745465; x=1708350265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppWjXqvOz7E5NKyhtw98QvPMgUwleYBISgwi5Vq2qHk=;
        b=BXRMTHD0goX/tczpRb8GGH9W+cmgCwzYYcxU/Qop1Skb+mcvgHWnpShbFtk3s8w+I9
         ghVDVc9Ot1cUnbMWtDOVZEzgeS74YNHvpjh1qQVlpO3elR+U+0OXB8EirihZZwa8+QWg
         GtvVk/I0DLVjszP7NrslKiNaYvYdPEozptw1bNQUCCKg659LlRkxLWtmpEWfDKks+/YZ
         Zh5fVCXWr8rGtG1f60Io2k0k9lsFrBY0ByG+4NyGOF/mdyCEG7MZnU6eF3PY81oFJeo/
         eCZ3+5Z+s5NG29cXXvm/QvrgJjd+LpZ5Z5VEwhO3dTGphfbyf819XVLY1eXccgpDe6XR
         a8xw==
X-Forwarded-Encrypted: i=1; AJvYcCWVh6H8F9PGCXksjGlnKzV+iOwsq7HKUF5BGKwDTIuQyWGKwi6Icu0jXtxrI2I8oFn7VGdTJrx7UeMgfFHTvOCNwY1pZN/VL3EmXQW5JRWXmteVIY1p+rg1rwHT/YYGpqzViu5yiMhdBA==
X-Gm-Message-State: AOJu0YwNc5ejTJaxh40tkhOPKb1VTyz7RDWOqS1oVNeCDIURzBLoqnxt
	48sxdTtP2XKtCVOmy6gCnKZ9+1G9TBX9b5MDxwpvkHw2+/4Z7nCaeBVaIiklrIzsu9atuggjwpS
	znynUYBIvDgZ3zoy7pHaOxGk1ZXtXhz66
X-Google-Smtp-Source: AGHT+IFt5zZFUHvxaPO9xM2x/WE9iUUFA8RIXi0YERKym3ViZ6pXarboaXioZcO82blmx8jq0lZVwjFNXcBjvAMgJE8=
X-Received: by 2002:a4a:ee91:0:b0:59c:7c63:928f with SMTP id
 dk17-20020a4aee91000000b0059c7c63928fmr4934727oob.0.1707745465516; Mon, 12
 Feb 2024 05:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211-bus_cleanup-acpi-v1-1-08540c6e9458@marliere.net> <2024021222-overhead-kudos-3565@gregkh>
In-Reply-To: <2024021222-overhead-kudos-3565@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 14:44:14 +0100
Message-ID: <CAJZ5v0i3Qa+i2jx_G-0B3dYuD5av2NbCpXe=pGfrSFtSch3f-g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: make acpi_bus_type const
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 11, 2024 at 12:37:11PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the acpi_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied as 6.9 material, thanks!

