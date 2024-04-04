Return-Path: <linux-kernel+bounces-131352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53B89869E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E125C1F2701A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575CF85C68;
	Thu,  4 Apr 2024 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsw+jQrm"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0384D30
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231936; cv=none; b=YuoHB+lCekA+PKek/7vGw7G301Z/ohv5sJZGlM3s/7B0U8S+bvPyGzPRWoxHC4YwdyBYsBa4j0PDUsZloe+F+xOGNLNdFqWMZI/noqI/ekUmCMVzV+0rnTuKHAGAGs0HDaMgmaEKBX9hv/na/kp3UVqabieBfnk07PYUeiiLRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231936; c=relaxed/simple;
	bh=qH4XZ2IFxQPw0iadjvJVCpAIxzbzeVvAzyXBRoeAy9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqFQuU3YnkccNzOFS9TMCELL3PC9vRYQvxWozSrqbyafg44s0EfBzrvxP+OCR0Q8jrLjSTJx60zRoctQ9OrbqhXjOYAdGm/FW/hhY4K6fmzqtj0upGSiSy/IXMRLmeuSNUAA8jzA95W6PmBX4VsHEJU3FsZYHSsFOYVdtBw23dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xsw+jQrm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso723884276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712231934; x=1712836734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH4XZ2IFxQPw0iadjvJVCpAIxzbzeVvAzyXBRoeAy9E=;
        b=xsw+jQrm1KpOqQxUmQbfq8duBd1OWU+07iJ2C+uyLW+C99sj5S5tU5N8GuKILcGlv1
         4oG853kUn/EUEW7OEDtZHdYk6sePmOkBietyxKm3EdC6T3B1KPYkCbtRWMd+EkO/Rd/B
         W8xsw+olI4/8Xp/DRznMC94Myb2MrSQDZuRL6+z/1yFYEVLigF43lzCOyz6L4H1Xzc2L
         ZaU/MivG8o0Xa8GomBgFG1ms1IFS178SKOQv5X9L2TNNBesaAikvf/CdTAFh+s3j0lTF
         VKg4QQMcI96gvNXVOSWqglWDWQK6jBTmuN89NyfzVh9sVZmKC+5/ADV2/b7IzkqQXd14
         qKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231934; x=1712836734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH4XZ2IFxQPw0iadjvJVCpAIxzbzeVvAzyXBRoeAy9E=;
        b=XIvD+BVU1Uq+h//Da86FJyeGCNZ6CZHKs4LacIvAJ6Bv+Q2PqqW5SzmCP8CNcbgs1U
         HiTeQLPoGjvLflI9Sm6Vgj6A2hNndbQqWJGbXnNHwJFQRXOuJHGKJLHZFDJCqYka6+CD
         gUEIxqZpk4FpML4wHxZLcIBChBmmnK/1N+ojh9A+cHLcKbKf00i9JbufqXDp1jm/vIpN
         175+b7F+59H57S7ocZVeFx9R76OhOfXRe72EWuTE+hgXjSASxs9fKzNdiPsJwX0Yb3hj
         QIAM4gIinn4iysbRu4BcO0OaDMqVtXquwzQmRwttMZn4kEkgBjkJN6/i4VFz5ME9O72o
         bW9g==
X-Forwarded-Encrypted: i=1; AJvYcCU0BGTQYIDicphYJR6qQQGL0h7qFlKNqCbpk4XnSVChZwfUeUQ1+SqCVH4mFOUd/WQG2fT/nBUcQsEXCzxkf3waJztLX4phH/c75jmB
X-Gm-Message-State: AOJu0Yyr0eMz1R8/ZXrsCHlCBNh3xkVVgEyNPvkR5W/9BUPe7fYczvcA
	KSHyGpyGTCxfFCM9DK6IOPdFg1my5OPpiSvhfOLkouXoaqktA7wAQSotou15sy3PgbYtBKMgIqA
	JXlrCn0QYS/GHQLNIo/CIRlsGjijfAFZBeWZ3oA==
X-Google-Smtp-Source: AGHT+IG8yq2enP3IQcY0tQ0zROWSYj21wUUMvwbt1fBAPBhrcUUxHgaEhfw3RVmcgwq6VENuY6ZjFW5jBZpK4n3+YRw=
X-Received: by 2002:a05:6902:c0d:b0:dc7:4265:1e92 with SMTP id
 fs13-20020a0569020c0d00b00dc742651e92mr1948021ybb.23.1712231933979; Thu, 04
 Apr 2024 04:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_6D10A9C63E3E0F412EED33477B5CDB98C207@qq.com> <CACRpkdY1wpGM7M5QV5rN0M6JMN_yugQJ7CEtnQjzsheD5AT23A@mail.gmail.com>
 <20240402-automatic-radial-7bc7dc342987@wendy>
In-Reply-To: <20240402-automatic-radial-7bc7dc342987@wendy>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:58:42 +0200
Message-ID: <CACRpkdZbCJWWZkJZbmCnGqKq=ZxJB5gT5RHBLMz2cBoz-UDFUg@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 2:58=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
com> wrote:
> On Tue, Apr 02, 2024 at 02:31:36PM +0200, Linus Walleij wrote:
> > On Sat, Mar 23, 2024 at 1:13=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> =
wrote:

> > Is this patch something I can just apply to the pinctrl tree?
>
> The new symbol doesn't exist in the pinctrl tree, so the driver will
> cease to be compilable. Yangyu sent a standalone version of these symbol
> changes:
> https://lore.kernel.org/all/tencent_DB11214C8D0D7C48829ADA128E7BB8F13108@=
qq.com/
> That whole series needs to go through one tree though, for the same reaso=
n.

OK

> If your ack transfers to that (identical patch) I can take the whole lot
> via the soc tree for v6.10.

Yeah that's fine, go ahead.

Yours,
Linus Walleij

