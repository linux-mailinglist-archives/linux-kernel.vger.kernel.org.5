Return-Path: <linux-kernel+bounces-127938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB0895300
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F64B1F2612B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493837764E;
	Tue,  2 Apr 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcFkuFOJ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F201EB37
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061109; cv=none; b=YPT3Aq4mQSsxe+2/nivuuWAahxvTigX5cIn7rNcLnwC+vFue+RbaGEh1AFOdh88G+QO6XuYbPC0l5PpKSldUUA+UTJkd74ICwNl5++YqWSgbssUiTUow/M2WafJQubssfR3aHr7LhSgFptqJs+qyQsedayT55YVLkJYxWEBIa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061109; c=relaxed/simple;
	bh=p0a8acw+7ULihTf8lE/ghLH059TUPnJn47JiEnYgccM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgQS+pGB2zEiNtYHM0BrSo7Gbj3TA+NHn9jHiJnDW/AuVJTSZ/Vlp7D9+QxdMEF9Tt9STQcbvio+jm1SfqbxKVWOlqGLtppDpbu+GlALtm4NVM32mdR9J/ZsyIy56aejG2ZZrXgRc/NODcMvsAme2khes4zHIks7iECbKVHZ9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcFkuFOJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4719318276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712061107; x=1712665907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0a8acw+7ULihTf8lE/ghLH059TUPnJn47JiEnYgccM=;
        b=AcFkuFOJwh6/OSIC2P6CN+t5N8yM49Tio8HVEsm9NC1HNJCNNVgKc2/Dkb3jTefFL6
         SeBWPt1GUPkHUPEA9RAVg6Y+DQem3a2hYwXwjdeecWrWv1EQEpH1aiq0vqDRzLrTDWLD
         1qUj9oYWttSSh3vHU7vuM4JujJOGMQU2euPPH0oeogAB0iOKUCfie3ASXqXjXmrOxYfH
         zU+INEwdROhwLAR4DP9QoG7ndxdwbChFbCZ1efkgoIr88olR6HnpsCdY87zdd2smTu7N
         95DuzmryhyQFqmoxoACsUTZSFgUpsaITa1qGf6PmP71lC3NJQ3G4i7kG2ZqihM8JjY2+
         MWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061107; x=1712665907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0a8acw+7ULihTf8lE/ghLH059TUPnJn47JiEnYgccM=;
        b=W4rvelbWW9hJLpOFEaU8qaZl0Ux6JeWB3QoRtushXTRYOgfiFR3Kh4aCyrk4wArJ9N
         +4Y7sV0zq1JYltUzuz6xwAShW0sN67iN3/9Ld4c0U00I6+PQBthtlQNKFdZvNJxrZR6N
         SVnpAjQk8BvcLNhe4ecwsE5Ulwwbav+SYAdBn/0+gNZNB7j8xCOvcusV/th7s3oonzpm
         MHyNV2gj7drETeLm62ziiighPKZRSPnhvFsGfvM0h7XeD72QjO/AfpM0vqmz2QA/8GUc
         /Fma8bXfJYORDqLfMn7C06V3c3HpakBs6Ve1SGK80YLRbRSO/tM0bgJtjsmYk0ByjuLu
         1dVg==
X-Forwarded-Encrypted: i=1; AJvYcCUUJ6ck2YUq0zs2XROT/ZdGzHM9wFRVK+z8NI8UN3d9EcKYgRh0CfmngQBTUMHutwJH85B644b8mCObHoAhvzmHy6sRDC6FB/WIEc2v
X-Gm-Message-State: AOJu0YwWl5DI+oYXRk53wi4JrCxxNEOAg2URnWNCwzFamUzX41zgh/UU
	EAdwAySXriSGVxDgrzgceL13QEIo3+Nyp9J2Tgtz3FpN2tqNxaFVZNyEObbzGIaCQfJePeU5A/4
	Xske9K8My1M+VLat0ymf2Lj7r53YN3hMh4IMLSw==
X-Google-Smtp-Source: AGHT+IE0J84TqRbakQrC6l14h9si7x2di9LmRSJuCIgA2LQ8vJmxYu7A/iE7PWTtStw1Hw8SCsS1GQo4L/akposnPKg=
X-Received: by 2002:a25:a14a:0:b0:dcb:b3dd:4f95 with SMTP id
 z68-20020a25a14a000000b00dcbb3dd4f95mr10698210ybh.43.1712061107020; Tue, 02
 Apr 2024 05:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com> <tencent_6D10A9C63E3E0F412EED33477B5CDB98C207@qq.com>
In-Reply-To: <tencent_6D10A9C63E3E0F412EED33477B5CDB98C207@qq.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 14:31:36 +0200
Message-ID: <CACRpkdY1wpGM7M5QV5rN0M6JMN_yugQJ7CEtnQjzsheD5AT23A@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 1:13=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> wrot=
e:

> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already on the mailing list [2,3,4], we remove the use of
> SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,
>
> Thus, we replace its drivers depends on SOC_CANAAN_K210 and default selec=
t
> when it has the symbol SOC_CANAAN_K210.
>
> [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@ker=
nel.org/
> [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0=
a@spud/
> [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46b=
b29@spud/
> [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655=
a4d@spud/
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Is this patch something I can just apply to the pinctrl tree?

Yours,
Linus Walleij

