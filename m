Return-Path: <linux-kernel+bounces-42350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8984000E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620272847CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347A54BCF;
	Mon, 29 Jan 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QbQI+BoY"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4E54BC9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516831; cv=none; b=LcVgziOO95KWvRvwN1k8p+LbiqF6UvO26//7iJP+U71OYOD7Ij2thTEYIeeiLhr+RMXGqxwzV6XIcNIl1EXWuXDhBi5nOFIw2iCvwT12SgDIBS9RBH/aF3WntRv0+B2YQ2xFYoL6ubVSeWQWMAuWdTN6egCAgPE1vmBI4thVsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516831; c=relaxed/simple;
	bh=VTQHhMexm2ZM5TNPgBoAoj25r4Z4mVEM9XexsAZqek8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFm1alY7ojmq9ChrzKNQE3l88qNPHJ/gy29JAo6PNFPY60lIJT4a/aev46P+cimnYaxCPIaM2QXillZA/6qxWxe/5ft8G6SJ9RsfB+g8iMq35h/3Isy7RZlYm1iWLfDViwyI7jOT7y5wEu1wRVi1Lpy33Z2F9JGZ8pqMmCr01cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QbQI+BoY; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-206689895bfso1488613fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706516828; x=1707121628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTQHhMexm2ZM5TNPgBoAoj25r4Z4mVEM9XexsAZqek8=;
        b=QbQI+BoYDIq7HKvMtIK01yPd5Da13cQrh2e4KlQbxduVUciUPLLEXAmhk/qwcSNjaW
         pt9cgrsqAzUxqUZ1VUBkyTaw/sjuctgxwHUoP/djyOgs80UhFV73sIfwuBC7L/jX8375
         L8kmBOeTH3ADFyIr7CftYI9+TD3qY1AIJqEOwRbkImwm/ikDgmysKhlrWiS6vZu3Ivkt
         24InOEQrnaEIza6JssYEIUcaNY/CifLgv9mg7qm2fs1iHUYrAmJEcS2iz0fokHXaLCJO
         vk34ly7zEzsSDQxED7180beEtRph0SEDKOwTZKywZxY0NhFxJ3z7eFAaHOdM1zYNXyyn
         mfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516828; x=1707121628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTQHhMexm2ZM5TNPgBoAoj25r4Z4mVEM9XexsAZqek8=;
        b=YHMQ3FSCERuosq0uW6VMKNhSFE+DZ48BSJbU76Fmqux11UNF2gWl+fVt9bXUE6FzXm
         Tj6vBT5ugR+jMsQpwPQWeOYbD8JhUX7Y8hNe2piNvQ9yPZOR8saedHbYSbMVh769vAG6
         Z3j4+TYLGPbLW2lX1ILwcwOpQlOT8TpONWslVCc9/rR+kW28J3A7TQHFCcmaCv5SJjjk
         bfBEM/wjaw8YWPIZxfbAaVyz7G3dV9C6HVSXeXQ5yP2Qmp9Tl6267O0IqOtM2xoQfq2U
         YP2SANGUr8PeW0fAoccW1U6KL3PaGetjPCWBFoE9BTSb/Xpn+nhaLyR4veE1JX/oj2h/
         omJw==
X-Gm-Message-State: AOJu0Yz062I3VpU+ECMEukjMPp6onz4Th+xdtdlNAfPZsDBAosQVJOwU
	65E9wUhA9R88P8Pd3PJHp35tHvgQhaJLY14r2DCIbch1sLQ5I0q23aSv3TG3Oq9M44iGBh8X7pV
	D/K65RoFiSxFHYEDL6rTPM8Z6gUwIlL3q7OgIww==
X-Google-Smtp-Source: AGHT+IFPLAegwSqjHAvBOCSs83655JR4zi9SYuPyjsFZpCFEJQW3rQNKbNKDzJKKXiyjHErjX/NSRf+SuTel1+/ZIEQ=
X-Received: by 2002:a05:6870:5250:b0:210:da44:c885 with SMTP id
 o16-20020a056870525000b00210da44c885mr2554711oai.45.1706516828322; Mon, 29
 Jan 2024 00:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125062044.63344-1-cuiyunhui@bytedance.com> <ZbdYijWK1PnHXn47@xhacker>
In-Reply-To: <ZbdYijWK1PnHXn47@xhacker>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 29 Jan 2024 16:26:57 +0800
Message-ID: <CAEEQ3wnSN8dLh3FcmHq5yPwQRdjLQa_VjcuTH+7YYZLOqCzaCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: add uniprocessor flush_tlb_range() support
To: Jisheng Zhang <jszhang@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, ajones@ventanamicro.com, 
	mchitale@ventanamicro.com, dylan@andestech.com, 
	sergey.matyukevich@syntacore.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Mon, Jan 29, 2024 at 4:02=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Thu, Jan 25, 2024 at 02:20:44PM +0800, Yunhui Cui wrote:
> > Add support for flush_tlb_range() to improve TLB performance for
> > UP systems. In order to avoid the mutual inclusion of tlbflush.h
> > and hugetlb.h, the UP part is also implemented in tlbflush.c.
>
> Hi Yunhui,
>
> IIRC, Samuel sent similar patch series a few weeks ago.
>
> https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.holla=
nd@sifive.com/
>
> After that series, do you still need this patch?

Thank you for your reminder. I didn't find it before I mailed my
patch. I just looked at the content of this patch. I understand that
my patch is needed. For a single core, a more concise TLB flush logic
is needed, and it is helpful to improve performance.

Thanks,
Yunhui

