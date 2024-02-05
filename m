Return-Path: <linux-kernel+bounces-52906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC4849E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13421C20BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7042C85D;
	Mon,  5 Feb 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3yjfe70"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743C2CCBA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146901; cv=none; b=bBYhi0zrVNnZwE+IzuChacNWRIRRhCLAC0MGekuBYpFfLZJiJLIcWHwiUMJYN+RqTbGI/5CSl/BhoUzWw0Hm/B2WhMbktFSkOb5yEnEk3TQXD7ZiJ23xl56VeddlPd6SyXI/htaOl9bWyaRTO5Yczul8uPZN0FtSWwELOgt+1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146901; c=relaxed/simple;
	bh=sDRyLlC3gWqMVU08yPO/L/S4ZvFI/bD4jpF5C0pvcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odcvDywirpiBVcNpmUiaoaL80HAD8fqPSyvWaCSya6WWyFFQotXB25QQ8aQNSPcx9pqK9ap/RaX/v/5uXh5W2X+c7XhW97WA7DlLqkp4SwdJ6oowouRBb8hy7FCjcSgQZvUg9dECctZgMzHfOczOvr9Lnih2VnG5zv9LWVWQI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3yjfe70; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so2548894a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146897; x=1707751697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sDRyLlC3gWqMVU08yPO/L/S4ZvFI/bD4jpF5C0pvcss=;
        b=L3yjfe708OVoJaMTw+YHmQm6WG891A5Wo+0TLwqIDoDB9PI6r1DaaqNlJqnzAZWxki
         43YatYJD9YGeKj0kWW+2dPk26KjztHzX+ZDXV3IksLUnbzE31h4sRntWEup/w80+lTrK
         n+5ibOKnddHB0CaLj1pdl30BIYo03fBWj/eMGzgOEDGS3M+NjUwtrP9xdvWKaC66e5W0
         m/nEgS99/NgfAWAtBrxPtR1lNB5X5ZQHY0WS9P4Vv5yKUcyEInokdYQb6a8MFOAOJJtf
         LPFD4Ck7WE+A+TvKfZ3y2888tpfzSBVtXPCepnAxgj3ZmxMu1MyzK2FtZsEVGhHjtnbb
         zk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146897; x=1707751697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDRyLlC3gWqMVU08yPO/L/S4ZvFI/bD4jpF5C0pvcss=;
        b=gNEmsAPwKsTWlR/+27cb0pjQAjBSoshs6AHVENqQ1y6dLOl2gl+BLkf5B6jRPz9lY+
         5VPVt0pJlgvImdAZYMoz/LGJaDbsYeUnoMAxM8DuSmpYjsGylfECgqkmU53KnocRDsDT
         YEIIdZz9dmkhipXaS+GA6UovOeUHsxMK6OZW6RwO8nZM/M78e3VtNbCXWYG96oNKEQIt
         MssbWkM393DnlRZ7NHNqVySYZnBbP5Esh43TYz+KCb5osxBJS6L/Vx0bCR3/LCuY8kEQ
         CY67ODNh7MSWHyjancS0bv8G1LnzE8JNEkN8GHXL42Titb+5TO0ibOGRCg4TvUizxGyP
         ugKg==
X-Gm-Message-State: AOJu0Yz4b3X9E1xzGwWAtZl/ID86HBO6Gu+UErjZ2KcigOXNHdD5BIh+
	eUk7Jw5kv4fU0ZUtkryILCu3OcY+ONIaEm9wQBTgPVR0ucQV15pvVGNZGol8XFxhDnMBqDdTsFX
	8jd027TmoZLv88W12gna73OvpolAeaEanYZPrOQ==
X-Google-Smtp-Source: AGHT+IGIbSdPg2kJtN19Mb0Xsv1cjow8kPEkOEIXkMaPHkzoWnTMAKzZWW0SuSwM277zl/168CsT5ROoYE/L2t/1/LA=
X-Received: by 2002:a05:6402:545:b0:55f:a1af:a1eb with SMTP id
 i5-20020a056402054500b0055fa1afa1ebmr4776963edx.23.1707146897552; Mon, 05 Feb
 2024 07:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-6-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-6-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 5 Feb 2024 15:28:05 +0000
Message-ID: <CADrjBPqv2O+au=MOxCoaLAAuQqOPTL7QDKcmEUUWgfAXbuWmAw@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] spi: s3c64xx: sort headers alphabetically
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:45, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Sorting headers alphabetically helps locating duplicates,
> and makes it easier to figure out where to insert new headers.
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

