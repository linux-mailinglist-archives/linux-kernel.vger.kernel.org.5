Return-Path: <linux-kernel+bounces-122648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7A88FAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837551F29B49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A55FBA7;
	Thu, 28 Mar 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9nTBtX4"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AD39FD8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617318; cv=none; b=t2McUsiWhAfW+PYt+FhlXtsFKJolgtHGcy3yc03GjcCNJPn2iPFLizfv0SP3N/u56WF+N4sTAR4lls8GtMo2js9ReIE38DNWywUH5OREGwObIU3/x34oi84S8YjpEJ93YSA5GK9ombJunPy1OC7iAuVOiHihrBghZ6EjYe40PXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617318; c=relaxed/simple;
	bh=DK3WWLpghCazhNxnzpVoeZ6lBHInJGjDV4FWurbpgm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH0CZbbpSu1wtJ0JuFm4i6qupuURIWlDOcqkcH3MsEJMO+DtF6mtleIgaYw4wg0VaLieufNDIuo4jGUqKpLhscU67RSMVXxxLBdiqs3xsY700zm9ICdGqmYbksoh7i8xS6KaMhS99fpjuI4QGu/Lk/mjfUipRfNadJ1vvcuCWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9nTBtX4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so582186276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617316; x=1712222116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK3WWLpghCazhNxnzpVoeZ6lBHInJGjDV4FWurbpgm0=;
        b=B9nTBtX4Ml1Rl3ZO7w/cQZvClojyd4utcAjbyrjq8DN6EeJoephcoZr81NhKHjkE0P
         iq/vnuRF2B8DanFZY8dMMhhfXP+7UrA/Y/j2hhHhqskPD5UiwGBx6HUnVdZxrrqnwMOZ
         gWFnf7hjqpcYLZnh8tDxPfHTlxGnyNneinjTHMBQ8K6O+7p5DEE2En4EEKqckN6S3rK0
         I4AIS2aGX1uix1FghNU4X34hiyBnqfcosDPP7MeIO4Nwuzj3QSHdbidoh+X4Af/t72Vd
         wiMlzcBt7gkS5QpyYGTSadf9NYDjZ+7mYywOzJSu4LvFmsY1dikIeMzwupF4Mq8z60xA
         XK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617316; x=1712222116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK3WWLpghCazhNxnzpVoeZ6lBHInJGjDV4FWurbpgm0=;
        b=AYyDddx/BH/OTr64ua+6G8lQLFLKn83m6ei3bY5wK+MyFBakHxf+hc6x8dFvcLusrd
         a1QUy/1NGW1xVVCCDmnPvLyvCaQNq/+xyZS3mZr/IB95phcqrQX5u9/Yl+4woWDTuk2C
         V8McKIAsLe0v1TSdgOsjMoZV/J9DKn3nov+AmsETaKV2is7yGIw3O9SWUk8To92gNuvD
         5RxpLZM+XhLqsH+DL1lxzmCTs6baAEhhTiDI1rsWqX+9qhzRtP4c2oJ4LEAxGn60MjWS
         aK9/xS8GeKOcKm+seu6wiWqfVG3uSNDzcicnRmwW/mlDiA/Tfi0xvtAR4/1Es0DdhY4H
         NgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtIJth04wx0/tTGnfz96UvCgIgZ7Fd3p86VpZEG/f2JrvnGu6c59BY4IVtaEU92TvqKALfZcn+xuWRPnZpe1T+sV2oPjO9mRlDP1lv
X-Gm-Message-State: AOJu0YwQGxNSVZ725TjEaZrBxlPcjoPu/we8kdWVKfQ/EJW1Ua2Fjzjc
	s0uXwBBDomth8mSxZ53xBLH1Rki4DDZ7jJDG7+Wwi4k8NdPYc/zFMjcFettdvJBxSzlKuy1nfQ/
	yUK9Q04ylJ+xNnHhGi7JOoYZ52Gf5xzDSn8RHwQ==
X-Google-Smtp-Source: AGHT+IG4UAVC7NGDGidRJtRNWZfYlG/8nA0Xwk+zw0p4efi6wDiAGEzLWglCyWj8gtQ9WRg5ukXUl7W+4wfTKJP4AgI=
X-Received: by 2002:a25:9b85:0:b0:dd0:39a0:a998 with SMTP id
 v5-20020a259b85000000b00dd039a0a998mr2199704ybo.6.1711617316176; Thu, 28 Mar
 2024 02:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:15:05 +0100
Message-ID: <CACRpkdaxekb_E4ttW5XfRUa+srkjOzUaVXRAtHMYjkVir7R7xQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-aspeed-g6: Fix register offset for
 pinconf of GPIOR-T
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, johnny_huang@aspeedtech.com, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com, Ricky_CX_Wu@wiwynn.com, 
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:28=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> The register offset to disable the internal pull-down of GPIOR~T is 0x630
> instead of 0x620, as specified in the Ast2600 datasheet v15
> The datasheet can download from the official Aspeed website.
>
> Fixes: 15711ba6ff19 ("pinctrl: aspeed-g6: Add AST2600 pinconf support")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied.
I recorded Delphine's similar patch as "reported-by".

Yours,
Linus Walleij

