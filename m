Return-Path: <linux-kernel+bounces-31785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8A8333EF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938A71F21F12
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4FDDC7;
	Sat, 20 Jan 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap5ZKfmT"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041223D5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705751567; cv=none; b=WB7mdrbk2UAeL95O4bK1yLJ5c0pBBjW0YzayqxZi7hsnE7fNy7bhQ16KP+pDnOJF8hCBcYa/xzgfDPjyktsTXwedHAgRlEpBVoEtChzhqtO2pyHq9oJMZDXIGLK491deosxXUyrTy/MleAJQ2s/9ZFsrVifKPpoz3Uy+f6gR3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705751567; c=relaxed/simple;
	bh=FdWTE8rBL6WlyK4WKqtjqIb6EM3VsYl8Ya80lcAfjKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krNQI0y8i3c5djK2YjAyMRk869c1TyGpFF4yYEdeuFlyTqG4FAKAG3tBNgys9GM/tacnIfxeMWb5nRWVnHtOpbmEuq31sRoSpp0IiDASg0j2VipvyHsCedYiffKt9SrHDVzL+9iLUOSdHbnwzo7JSAjIVkJZUjJFdfwv2tim9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ap5ZKfmT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f15a1052b3so15712297b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705751565; x=1706356365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdWTE8rBL6WlyK4WKqtjqIb6EM3VsYl8Ya80lcAfjKw=;
        b=ap5ZKfmT6NPYgjdYPy8KQ9VhWHqp/VqoowDT/bHdD274bM93MoNxghamoj5xPQ6FrW
         iInoN3qYjKB27Fz0VTdaeRY55imUnVtA2qgQXQD2BsQRMposzSfI3Nnk3zp1b3VCe57d
         xiljHHI0BewBIlu5nht2FgTG3dwF5cy/bVEAux4sk7MW8X8q+kJhofr7vPL66j50rJtL
         tO8odz2LpRseYkmeDRTIv6rULYPRwcVlSIZGVdE1xDy1DDipsKwfRhug4EawThy4Znwc
         8tvVVLugq5mcHPjnnfdlNaeILy+by7nrOh4g46ETs6kMlUAwYw4X56v5WUfCXwytHbN1
         AwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705751565; x=1706356365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdWTE8rBL6WlyK4WKqtjqIb6EM3VsYl8Ya80lcAfjKw=;
        b=FPg0XaK+ffSjC4owKOHwWYTsb+gDgVB+7lEOZwOO/cy25URmDsFtFHt6C1ujxcptrR
         Enpvmdo2wzMmWHw+i05b77wQ9LDtOztoRH6lTPvZm3OikR6am/pTbFNvJi7QZNipl3oM
         z68tmPZE9kcaieCG8wyg+h8/5uLR5uLXQiZkQFUmJdDZ/2xWhadQ9LEzh3AwpEKbJ1kY
         dOskBvU5p6LHJ69nJIpxGO/ozAHD6637QmDL2sK/U/hWQK+9KIlgBqydkxWE9oMKIOaB
         KLxahKL2UtRXg2GvQpDYWQeV3BEt94+NdQWktkfw9AuDAThu9dbDgd8xQau+CfnSiAnL
         Qu0Q==
X-Gm-Message-State: AOJu0Yw6aNfMtJfjqYTJqYN3IqqoCQdt7XFqyADctaucbPDqYYxTGW+S
	L8ON7POXOv72XDJxo/6Xls/EpdBaMjBWMZG0NJsgxp1NbEXosOldXTn6eDGQZ8Jz16E1jUK0/Tu
	AFugsUC9eqKiX5TbyxhFA9ANGoWiHA9/t5qXJYA==
X-Google-Smtp-Source: AGHT+IGuskCyAAa6qZaghntX4DBBWG6n9VFttNYSduH7QzdR3O+jHQC69MqTrldSbei+/ozn3sJp0MBIc2RR1IYzsfA=
X-Received: by 2002:a81:6f57:0:b0:5d7:1940:7d8f with SMTP id
 k84-20020a816f57000000b005d719407d8fmr951841ywc.102.1705751565060; Sat, 20
 Jan 2024 03:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119201356.7903-1-ansuelsmth@gmail.com> <20240119201356.7903-3-ansuelsmth@gmail.com>
In-Reply-To: <20240119201356.7903-3-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Jan 2024 12:52:33 +0100
Message-ID: <CACRpkdaR_gtW6VmenfV5=xounqV18-kZyNprJUtLWkpgXUnkvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: decompressor: add option to ignore MEM ATAGs
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

> +#if defined(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM)
> +#define do_ignore_mem 1
> +#else
> +#define do_ignore_mem 0
> +#endif

Is there a reason why you can't just use:

if (IS_ENABLED(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM))
in the code?

Yours,
Linus Walleij

