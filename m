Return-Path: <linux-kernel+bounces-52771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FD849C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1C61C24974
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B392374C;
	Mon,  5 Feb 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Cycndj25"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA022F03
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141655; cv=none; b=jjCYY5FIqZjW8FX1XHMNPwFGPIjaTDlSkqtoG28xluxx9hoM70p4p/dsZhCz5fFb2RkpCuAp1kM9s7UQtDo8Hbx1Gj6Ku2HcjoCUz4Dv8DE4FoP5jsn3+Y1JrRfs7bi2HerVry2FSj5ztJ55tRI++zO85olljc6Y277LhwR6EFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141655; c=relaxed/simple;
	bh=Nn+zFg3BF72yIkvoigw0uDhO/0F3UMA9iXOV2TIbEIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9bx5/HDBNtFOhUCo83AEhZujw/wecPwFlain3qQFWzKxtIFK5ifg9p1jFgKwkNieaIXKGQBnl5q/cgckjLgh739SWGTXGcbhZjKxMRD8sZh7uwNvj0BZjFru3QI/V6NhdCukka4OY260UoViwfspkAfEoEluoeW1R3QBMunHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Cycndj25; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e03f7f427aso457244b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707141653; x=1707746453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn+zFg3BF72yIkvoigw0uDhO/0F3UMA9iXOV2TIbEIg=;
        b=Cycndj25eEI+wMvzGxTFuR6qiGWWuG01ksgcfF7VtVtqNuFkkoO3DHWQPQeDWj8sV3
         bG4+vPZjfNn0Jy/oF64bmsveewaC0ZY86L3+O5r0sA/Y3gso8NQoG06zhDpt5cJ7dFuq
         Tm/ERH0reBbsfp5ljEibpRYYOtmg3eovMijGudPboszNTbxZ97m5MDb/WTXu5aCl0HtL
         96EG8igto8vWb4HPX4Bv9Bpo2pCfvsft8SH/l0r2TRm111COKvmP+J+VIEhIl6awkBYT
         qXA1XJRSw8dPeO3+9N/tsNh8qsLp2d4xSVW09/beId/bAuM1uxRy9xFnc4Q490WSo1YM
         6OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141653; x=1707746453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nn+zFg3BF72yIkvoigw0uDhO/0F3UMA9iXOV2TIbEIg=;
        b=aKQs7TZ3RbObWo9Ln/dOcEfCq8Jtp8v/45j8e15b5mK0aNSed8rD3l5/bqRZfk9tMH
         mrxMBuvP+7rJMfwgM4NUHMBfXKYBkRrtK8E9adCudlsc5UzdZHp2xXx/q0KBHkUNtBi+
         3pX8+w5P/249DY9GuDA/bGyG75yiw/rv+EE+hvUtuNUXcGSLz1yfWhlgkfGHXA2jfGb+
         H+OCU8XaYLInfiuWlFnJilEyM27Dlo/+wIxOmIrxDo+LzkR0P3dhortOptvriVVs8yaR
         nddbVkiFgXtFG3qpo59bEhMEld6ph5yAsORFsiowqH19SW53aQRlFIW8Qq3pIEyL4XoU
         jMvA==
X-Gm-Message-State: AOJu0YwS0lOlcIk2Qnc6J87stjjUwrE/Pk/BywBf9FEJ7gd6Vkm+TwJJ
	FGsjtscRr1v+bT45ajEgyfI3+1sWP7Nt1DJPqpit+SEULYj+pNL4DH2KMZ1lpHgIk5+TrIQzWr7
	qTgRlNVPjo0UZEd8IQPmygwQJq5wFyy+N9aG19rp9YlN0b7PtP+quHg==
X-Google-Smtp-Source: AGHT+IE8WBqBQvo8jBkPQqUNiYFekrg34j5wGyAPLwnKHJEKphSj7nJADPNOZe2xKFhR+j14cBzCk5fKYH5C+rm9Ges=
X-Received: by 2002:a05:6a00:26f3:b0:6e0:46ac:edf1 with SMTP id
 p51-20020a056a0026f300b006e046acedf1mr1825022pfw.18.1707141653501; Mon, 05
 Feb 2024 06:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110244.676779-1-naresh.solanki@9elements.com> <8714b420-58b9-4d5b-a489-31670c8d325f@linaro.org>
In-Reply-To: <8714b420-58b9-4d5b-a489-31670c8d325f@linaro.org>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 5 Feb 2024 19:30:42 +0530
Message-ID: <CABqG17jfHpi5oDt+=E925Fp6DN2OftmDEjpmvb5=3nxMt+d2iw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: Update pattern property case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,


On Mon, 5 Feb 2024 at 18:38, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/02/2024 12:02, Naresh Solanki wrote:
> > Driver expects regulator child node in upper case.
> > Hence align with the same.
>
> Did the driver have DT support before? I think no, so why aligning that
> way? I would argue that driver should be aligned with bindings, the
> moment you add DT for the first time.
Yes the driver has DT support already.
This patch is to align with driver:
https://github.com/torvalds/linux/blob/master/drivers/regulator/max5970-regulator.c#L381

It was aligned but I missed on case sensitivity.
Driver expects it to be SW0/SW1
but DT had it as sw0/sw1.

Regards,
Naresh

>
> Best regards,
> Krzysztof
>

