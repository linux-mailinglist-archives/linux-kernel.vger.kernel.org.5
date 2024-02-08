Return-Path: <linux-kernel+bounces-58194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB584E293
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEBD1C25918
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D978B44;
	Thu,  8 Feb 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGggg9Fo"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F576414
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400460; cv=none; b=uaKHOEL+fA5pgqpsLLVFUHFV0CQE9PFNqY9AGZz8psqUc6IfqXMIR+myJoXaPd1Pm9YsqGh1YYPZ6Yxx/taXM7wbf17bsZteDUAX85opLdonrSFQZytRiTL7nEvJ9ZNLvhTJOXuMI19q4Fh5PcXeQRbxU1Rb5aY+wbZPbss7uMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400460; c=relaxed/simple;
	bh=sAPBOJTqt0Eux7mZyQPffvBf26VAhOH69akvvfeddOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfN8iVLmK8SSB/8xfsnST3CeTX9u+BlsLEyL0YnmxSMEJ/W5xfuEZYxBiSh+7IhYkpDcc0FeLotjSfuMR6QHuAhcfOmkAq/UAu+fxBbWJZGxRjaGAvmsbS4no19JBF9cCXuAV8LN0wq4JU2/v6d4tOaar9SmLX+oRE/DB1ZwKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGggg9Fo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60492003050so17800937b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400458; x=1708005258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAPBOJTqt0Eux7mZyQPffvBf26VAhOH69akvvfeddOw=;
        b=UGggg9FoknxkVTBo3XyTIcoMSgPxsGAIkGqo7suhPJZI8qWpn/cpgKkoobrS23XoDi
         sDvwR3/ywrrQmp+KT7GlNBOOEbKOyoPaQm1/nCMXi8ojVtQEfMqKDwH6VfVrQSUH3ZBK
         TZReHWyQ7dEroLQwQ1P0rfkz/dmlkpqkOVDtLdcHNllSRvq9t5RzB//MP/pADzCw+ZxF
         hZxc1s9a3Q2RQcRrPrXzgWnpDUSP4M2M4RLQQGWKOFq//2BJflrENrhEHWToGstD0Nh4
         EOxe3XUUHn2S0gJ/5S0SPmmxXiHvO1//Fa6L0XfJxssZodEN396zJQxXylp8oaOXvqBr
         K1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400458; x=1708005258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAPBOJTqt0Eux7mZyQPffvBf26VAhOH69akvvfeddOw=;
        b=qRaS3KZKY10mdSSRpYRpUVutqJJP9UVMnF58/dbhOSU7KNE9N7nRt29RII2Th+jvXm
         lCxGFqhtfDE/dPwzksf/EVo/E4+Qz95DbiHUYa+bQzBn6XiPRtkon9TGgKlagFgdo3mD
         6Wg8U2ouv0ORW9ntGLDTS4aXO0CUjk3/Ialo/kNNQCEaG2/9EhXhy0U91f8r8rwF2Qsj
         ASEDt6Tsu9dV1MRGY3jcIUVUlpoabiBHzw5p29ZuQ3MZSnHFADBIvLecYKmznym3G+7l
         Yndetc5OWaAqIN6AMw6pG3GgCB6/AaEC8pDi1xFc55/ciOjYKCEoIyUAHPnCf73ABD+0
         CDBw==
X-Forwarded-Encrypted: i=1; AJvYcCWhaQnpD1QbnhOAOO4X6Acn2QosdBUpeFPlISj06v8zjRXF1Zn42liMR+Urq2J0vV/o/zKfCM4AehioDAG6PMMj6yonj5VXmMVRKrMr
X-Gm-Message-State: AOJu0YzDnON3RtgsqAGvsoU5IZEK1YMb3FRdW8fsp4t16F0Bm7GZ9AHL
	JpmIZq2iPj0hmbv0Usfujl030imNP7SQp06mMqQiLdjdPIr0ZgFhaFqVB6bSbH6svbGxh6sAI+K
	B+MCM7kVuE97ALshkjqkzCDCEUu/LZ2GFQ765f7QMhrEEUGC9rOHGwQ==
X-Google-Smtp-Source: AGHT+IGDiOneyfJfxmHJsx95/Io/iJWK5Htw1Hg2MZmkBm+216Ld2xxxMuBHMFUPV7I9NJDT+pGjYE+Cddkb3IyflOI=
X-Received: by 2002:a05:690c:f8a:b0:603:ebf7:947b with SMTP id
 df10-20020a05690c0f8a00b00603ebf7947bmr9533612ywb.48.1707400458134; Thu, 08
 Feb 2024 05:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207104604.174843-1-antonio.borneo@foss.st.com>
In-Reply-To: <20240207104604.174843-1-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 14:54:07 +0100
Message-ID: <CACRpkdZ=Lf+Db7-QwM-X1RqqRJUNH20Yc6tJYjz9DK4RDxP6-w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: fix PM support for stm32mp257
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:46=E2=80=AFAM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> The driver for stm32mp257 is missing the suspend callback in
> struct dev_pm_ops.
>
> Add the callback, using the common stm32_pinctrl_suspend()
> function.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Fixes: 619f8ca4a73d ("pinctrl: stm32: add stm32mp257 pinctrl support")

Patch applied!

Yours,
Linus Walleij

