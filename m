Return-Path: <linux-kernel+bounces-82376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6703A868374
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AF328888D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AD131E38;
	Mon, 26 Feb 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m3vpXWKR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FE131E2F;
	Mon, 26 Feb 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985093; cv=none; b=dZngdT5tO0VFbFHnKIknDyasRKI/3A+ysS6liz3El7xwWTSFwlha6s4BnhBGcqzdjJuuJ+Bp2ULlPi5rsoMFUBXrtZKqYoUBdRyzpqUGSA30+lXefHsIi9I6cwV9CSbnsNEfgAQrcvHp6yAugfUB7VQo7WYImYjfAHEmLposBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985093; c=relaxed/simple;
	bh=iYS44GJnUglVpw16XRePCj/31ios9ZoNG/L6JcUmnys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEqcY1sCdYqOWxIAhtcQ6/R9mVPmLfKZR0FOsTuOa2QPamZJoBhz4W2d82mvHm9Wv7cpY7ZHNM1nl5dG9661ufzokOxbmknqCpd7ounuM5ripEuxUr5yYLwq6VexsQjZgGNEfektmdDxiA+e5gw69NSaL7LgYKArfGr10D0OXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=m3vpXWKR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso29980295ad.3;
        Mon, 26 Feb 2024 14:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708985091; x=1709589891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYS44GJnUglVpw16XRePCj/31ios9ZoNG/L6JcUmnys=;
        b=m3vpXWKR530ZcAgHsiz2EYH2Hf3N20LjATy8KQv5XQ2MGKfUX8OASKu2gWXJ8JXbJR
         0VPTU5hW6SvW5cYiQPyagUryDe+3wr1bDbdeCJYDBCZ4W90mZIYEhTd8lispFygPV4/9
         UDW9VZbI0sT/1X6POVB/TED1S3VXTYmOWXEkOcB/XTr8y1gYN/AOsgsboXWwkgD0EZfU
         8B1mCsp8G/wJ3XhiOd3fZYPJwg/if42AA+WlhSqmvTy5Z0eanC4iwXYLEeIFMzAvS1SY
         r5LD6/s1shn9ZKAkPTOtAPt6xwIdqOLj3ap4jQ7rj+h1wQpfFkdqnrBZAJeH3OnvlNgI
         TmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985091; x=1709589891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYS44GJnUglVpw16XRePCj/31ios9ZoNG/L6JcUmnys=;
        b=XYZdemOHAMWmSZtqVyo5o1C7FiS5ZWsAE/mMEa0j0/5ZPF70HFQrRTPj9vrh+3ZY3u
         5UtpMsxDNEFcMPQbAXvUrZaDKdD7NjI5Gc3LCeGcuEaJQKLFUsb3uc8BFXnHvIyfbbqb
         s9H5pH/4Qzqj2dMOIfBvojX7tBjeVlcRa7aJ8/RvDdxTz1arJTiNQTvDa2WaxrYUaikB
         NceG5CJmFG7X2y4HprnUxF7CIYax6iaM60uT2a1X9zYAyLcTm3ix/B2f14I9InEnmcnC
         VUPzG73l0KxGpelECJjpcNAwzvSPhRBkRwis4MTp8XkdJiyVQWFBconOXdGl3ZpZyrT7
         lkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNmPJ7VFU7ryZSQCjp5eXOBr5bU1cJuwZR4EaXHXpZuIFYBepoqVK8GM/yDcHjuQXjUOAPJuyUIw+zY0Q03mx9zzsi/nwVfUU3C7bb3pa+iFAp98vTuydLH2s9f5VM5Uxn9ZCJxnEpGw==
X-Gm-Message-State: AOJu0YyMCHpbbH0Bkq48bMY7eZW6B52pG1VVJs8Rv7vhR8bxsI79cNYD
	XDmNT2QsYqHZc0ZmH6xxAeewK5OSNdb1ypIq7vDpCQ4Hidzr95gj4H6i8ig8FJ9m7eczUiElQZz
	9y/hpxXOtBFuSbrfci1KP4Jffg6g=
X-Google-Smtp-Source: AGHT+IH0mmWf21ud0BhhK6Inle4DUDOZf8NRaH5wh0RvBVjgneDT1DxKJRtsK51GZj3Mt43+iDf2MZKi7JEobZ0VZpM=
X-Received: by 2002:a17:902:bf49:b0:1dc:7bc:cb49 with SMTP id
 u9-20020a170902bf4900b001dc07bccb49mr7365633pls.60.1708985091116; Mon, 26 Feb
 2024 14:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org> <7d9221e0-8165-422b-abbb-e1566a7a733e@linaro.org>
In-Reply-To: <7d9221e0-8165-422b-abbb-e1566a7a733e@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 26 Feb 2024 23:04:40 +0100
Message-ID: <CAFBinCBRufbcoOvF23V0ObdJ_2tt-WjfkN=pPphTz_FiHpPvTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: remove unstable remark
To: neil.armstrong@linaro.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:20=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> + linux-amlogic@lists.infradead.org
>
> On 24/02/2024 09:40, Krzysztof Kozlowski wrote:
> > Amlogic bindings were marked as work-in-progress / unstable in 2017 in
> > commit 7e8634e821e1 ("dt-bindings: amlogic: add unstable statement").
> > Almost seven years is enough, so drop the "unstable" remark and expect
> > usual ABI rules.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

