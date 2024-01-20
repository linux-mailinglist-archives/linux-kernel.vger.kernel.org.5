Return-Path: <linux-kernel+bounces-31784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7758333EE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA3A2820A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D1DDDA;
	Sat, 20 Jan 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtTT9M0X"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A7D28F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705751480; cv=none; b=mPvAFA0hWU+WLJ3umiZfNExv/FgpHHMdJuyC0lDNVC+muSReXypcjXEIVgjsN6O/jAABauGFHWs4QW5rb60A5fty/3ncVl9xvibOpjkEeaI8AzDCHvZSL0SL/tngMonNKWz0yH1U39KZmVDgOonhMKuzchGfUky4VL5noRvTq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705751480; c=relaxed/simple;
	bh=mXR2jSYWZsRdY8dH2XN+EAzXQknljlJIseSJOW5lLlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiQ6QLuOp6O8uGiu8Te3LKESwx7VuS11ovVAPRJxkqHbNo5p0HWps7JmJvfk433DeEsAlMoZCfvNwcQrCzyRoDRt9gWfI2SB0lR7exhOYhSPRMOukAtFwJqXW0iHdrRAW9ps/rkDdZbwd6XTFMMu4/YjwzpkTfzwUxwS9bET43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtTT9M0X; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ebca94cf74so15398977b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705751478; x=1706356278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXR2jSYWZsRdY8dH2XN+EAzXQknljlJIseSJOW5lLlI=;
        b=JtTT9M0XSkQmyX3/nxcsZ90lWn0Dn8hZhx5xEeiqR03+eD0fP89mz8fH/qHjD2/PyQ
         jk1Jvoemj/W4r+KaXnC5ipStlLzQq0nrNHrcOv5HCVzulgXtOwTGcuFFi5AdosAxLKwe
         erWhOld78JNxt6C7Y9pYW2RX5Km50948bQ90mbGbLDK11S4Kz8I2AujnjyXlgixiCoxf
         xKIj4xfIb/jFbs5x2d8enm1U6AXtkH6rBkmOIf7GnQ4v1+joIcZ6+AcmgBvuB6FZn0eU
         iKrQkpQgIFrcmrg1NXj0bCETM6QknT1kqXRI74D0zhllk3lo2aA2GJShxHP5aIE2lO/C
         cZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705751478; x=1706356278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXR2jSYWZsRdY8dH2XN+EAzXQknljlJIseSJOW5lLlI=;
        b=kJzTRG6rsWPIdRhboQF5auyMbAMcw9kv4mojs0ej9NXtdJQpDs5+8Qvc9xHow6Iz37
         5UQ8hEz2SowC5PoQR+LeUH2C4O9haFVZ30o51VgnC6j3Da6rueTEAIA6BMFRYD81c12m
         1Hq1lh4PCk2Fpkei5K4xTauEtzrrYexOZv7M6wtPAEK6WGyr5Ya6WO75i91eiTOaybJL
         JKEjnjbQf+AARjUCidPokFNe+e21D43smSbDPvpu+wGuYGSQEhAjvOYNAr+kmuwwi4w9
         pxqn3KIoG+Xz6+E76qLy7fMdh7JPcCmHVDkRl06bl77CYi6PsYsk3ZCQE0r+0vi4qIRM
         jz7w==
X-Gm-Message-State: AOJu0YyAv0Cqyod/FZW8lQxQ6WKFDK/Wzrp/+5IvxD4t+GvpW0EQPJvk
	18quBcb+62vwYoHBpxMYckmNrooOENEAhf9tAjwqArGlncszLQQg2BqdJubnRtsqY7IyJu3mo8y
	PQHumPgwE/7Y/TyGrnIPCsszOP3crk7rHp3GvOA==
X-Google-Smtp-Source: AGHT+IH2cvfxCxXRB4YyKDmP/bhZTr526HrST4UQtCF7koBdUZfxh2XTsHRmUblquQ711jBXIXqt7XSD9OgjJI7DAno=
X-Received: by 2002:a81:6e84:0:b0:5ff:96a1:c5db with SMTP id
 j126-20020a816e84000000b005ff96a1c5dbmr899600ywc.12.1705751477547; Sat, 20
 Jan 2024 03:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119201356.7903-1-ansuelsmth@gmail.com> <20240119201356.7903-3-ansuelsmth@gmail.com>
In-Reply-To: <20240119201356.7903-3-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Jan 2024 12:51:06 +0100
Message-ID: <CACRpkdavA+OL-ek0JGBRFX=n_H4=j8DbB+nCr7=8htscAzrzFg@mail.gmail.com>
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

> Some bootloaders can pass broken MEM ATAGs that provide hardcoded
> information about mounted RAM size and physical location.
> Example booloader provide RAM of size 1.7Gb but actual mounted RAM
> size is 512Mb causing kernel panic.
>
> Add option CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM to ignore these ATAG
> and not augument appended DTB memory node.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

So you cannot just ignore all the ATAGs I guess?
If it's the command line you need, you can pass an identical one in
chosen.

But if you really need this, it should be there.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

