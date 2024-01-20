Return-Path: <linux-kernel+bounces-31782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E528333EA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4AC1C211D3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E20BDDD5;
	Sat, 20 Jan 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xof6l8ik"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21311D2F0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705751331; cv=none; b=FZSAteb+CM3yDTt9t7KBzi+iwpMNr2Am5xRJ+O+NFmoDpHJYQz2WNhs4ZtxY8u/Fi1WHTzOq8zrXuwomVPSUN6BcgwrJ+k02fGanj9IyGMdLcBn06Gyd6DxdgRk2BEnysKf22di0YzITVkJs9ePGg6RnH/j1p4D+H5kRMcmn60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705751331; c=relaxed/simple;
	bh=6HiuWdjhrWZWlLHUPvkmedFuGUPh6aqZO+fw8I5itiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjBNokZ2gYkGEuwNfzl1qDEDEGpKdNa56gM3I9MXKdRl95PgTWWtyW8lm2W5b2uHZm+L23iTyaJIwA/6XKl+a703k9ml/lpw2GoZtiRlic6wL2Uz8IDrY5LSnF8OrxwKc2KKZww6VUqAydqHpVdecTuOU3myBPTVVtqml2OVig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xof6l8ik; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ffb158b46aso1871687b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705751329; x=1706356129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HiuWdjhrWZWlLHUPvkmedFuGUPh6aqZO+fw8I5itiY=;
        b=Xof6l8iktoAvLuHr7OoGZvf74GquqG74FbpP+sjIGJJDloP46zuT5CMf+sh5Uof+bH
         /M6l5hzWtoUfB8ULzvqCvlYS3cHKJ9Dn7OKKJyMigjIJmrNFLKuqumXm6RIIaWyuHXk+
         75iVby1r4BCrW77/DflE6QxWWFW8NbnwrJDUC6tX1BDLDz25WMuBfjZ1rKCiGI95Tcmh
         KD2MkH++yXY6j8nF4SGdZL3Rfu09hAF+paK9Z5qKX+J/KcUKcvBVT/QUILzDxaYRxvib
         PUsgyFww7eiPWgsQK3gwhOKL3jxClxbahngZ8a6vVtKG3zKShsycqnQAuOvAT/OwSpo4
         kPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705751329; x=1706356129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HiuWdjhrWZWlLHUPvkmedFuGUPh6aqZO+fw8I5itiY=;
        b=RutXI+URTJ8nBknC0YxI8th+cOJyXp6uLuS3aVsLkUzkmPMW0kZQju7Wu4TywbTfzd
         admsvsomEYWaZqZr6PdrBkJszN5gAWx/pmF0Q4AwA6KhV1U2kjhCrwbG6jYQxMZyK6U0
         JwLpebWeKrQ9bTEBUSXSAfdp78D5aXwnQV0gjKV7Mm0eEA5KjoBFsqHzM5K3Cv79IoJC
         K3SlAv08ywlFjGnBfodM9q6gII1OUprha5+zkAatf3PhSD1kFjsc0n8FYEosAuOgj/5E
         S2u7//zN6ENkXWRh8OgOuecX88hh3PvEjGRH+F0+Kr/kzCHAPBkkdkpemYS0V0l3F9TZ
         Wuag==
X-Gm-Message-State: AOJu0YwadNX0DK1WTEoKtLECpm9/RRVFX9m3oJmOIbaBXJ9V6ErmCmOc
	of70grW9i1u6C1ss0whrE1hMhWvR6Ri72smXt0Cv9wZJLFUBHcljHYffHePONgZxjZybAGMAz7/
	bnjcAKFHRnB0WGZG8YWmioQ3/41cfxw6sUS3wlQ==
X-Google-Smtp-Source: AGHT+IE9mxqXrXrgw6wSsqxuoU2T+o8xtrvAv8HespblQnzbC/mwPV+6h7a95x2Y8sPoaGrRK5D0gYlejCg5XGSqESY=
X-Received: by 2002:a81:6557:0:b0:5fa:64fe:40d with SMTP id
 z84-20020a816557000000b005fa64fe040dmr1205142ywb.93.1705751328984; Sat, 20
 Jan 2024 03:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119201356.7903-1-ansuelsmth@gmail.com> <20240119201356.7903-2-ansuelsmth@gmail.com>
In-Reply-To: <20240119201356.7903-2-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Jan 2024 12:48:37 +0100
Message-ID: <CACRpkdZhifRVB3vj1b1wZXcPwjnGFkLTnm1YOx34n36SYndCXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: decompressor: support memory start validation
 for appended DTB
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, 
	Nathan Chancellor <nathan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 9:14=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
com> wrote:

> There is currently a problem with a very specific sets of kernel config
> and AUTO_ZRELADDR.
>
> For the most common case AUTO_ZRELADDR check the PC register and
> calculate the start of the physical memory. Then fdt_check_mem_start is
> called to make sure the detected value makes sense by comparing it with
> what is present in DTB in the memory nodes and if additional fixup are
> required with the use of linux,usable-memory-range in the chosen node to
> hardcode usable memory range in case some reserved space needs to be
> addressed. With the help of this function the right address is
> calculated and the kernel correctly decompress and loads.
>
> Things starts to become problematic when in the mix,
> CONFIG_ARM_APPENDED_DTB is used. This is a particular kernel config is
> used when legacy systems doesn't support passing a DTB directly and a
> DTB is appended at the end of the image.
>
> In such case, fdt_check_mem_start is skipped in AUTO_ZRELADDR iteration
> as the appended DTB can be augumented later with ATAGS passed from the
> bootloader (if CONFIG_ARM_ATAG_DTB_COMPAT is enabled).
>
> The main problem and what this patch address is the fact that
> fdt_check_mem_start is never called later when the appended DTB is
> augumented, hence any fixup and validation is not done making AUTO_ZRELAD=
DR
> detection inconsistent and most of the time wrong.
>
> Add support in head.S for this by checking if AUTO_ZRELADDR is enabled
> and calling fdt_check_mem_start with the appended DTB and the augumented
> values permitting legacy device to provide info in DTB instead of
> disabling AUTO_ZRELADDR and hardcoding the physical address offsets.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Looks like the right solution to a very long-standing problem!
Thanks for your tireless hacking at this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

