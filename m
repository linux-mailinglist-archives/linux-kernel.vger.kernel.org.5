Return-Path: <linux-kernel+bounces-123795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A682B890E38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3891F23EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664F54913;
	Thu, 28 Mar 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ET4LfCM7"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A094085B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667136; cv=none; b=sf25+5xrb1w7c6VCqVU0CT/iJwkgoVFQTBL0yNHXzIfIEHGbvI4gKFTq3YSJJp1dyRUQaZFZxx4kVlxUbnEJ3zEYTQopgnE+bmnfNmqH9ksoGcyr3Rp/57SBpXDOBcx1w2+XW8SU8PUPxSc9OgoQSZGqofzRYdTmg45Xbl4ovkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667136; c=relaxed/simple;
	bh=KI7CEFgcmzK5wjsnY/Q5zxt2MYA7bviE7qSKhQfSO2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FycMoDlnuGFmjbO3zYBsfMzrUu2lsktpG4YUdkAfURmtzQRlyf928J2e+RNKB1c1vm9uaEq4pRFv1QR90LtXAxdmCtPF/akH1MPyze3lDzokvU5gG3Nh6HBZnvBuSnQ4mWKz7rumH7D+IojpSsmedzkcyd0FpwM2jHjOOBHFQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ET4LfCM7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso1456392276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711667134; x=1712271934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI7CEFgcmzK5wjsnY/Q5zxt2MYA7bviE7qSKhQfSO2s=;
        b=ET4LfCM7PHGTO8C0E/rLiu53iWDlfMXeXzG9V/hOpPvxxp+0Z0XQ3/0tqCFJofn/Te
         zSsesqG2kcN8uwgEg0ic7JNaJrk1BpS+XMNpIEWlm9NqrA0jhEqvlo/osHRpTdh3aHYG
         s+lUIhXory7aAtpw2oEqm4juzsTjU/8AhUfonmwV7eB+VSRQwxx3ZnNQvzGnXufQ+A1B
         DibBbdMRAlMaQKiII7XDTGH7uFbitqrBwziLHeNbuw70zionhns0lI3LHqgDmtuZa/tA
         HGIr3CT9DARLImMHNbOABlX7ka+fp19mmKpYOVHt/VXAv5NElwkzBlS9utbdkQXJxOog
         /H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667134; x=1712271934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI7CEFgcmzK5wjsnY/Q5zxt2MYA7bviE7qSKhQfSO2s=;
        b=GZSYQAWXwIVFO57KA1mwujyz31gvN5O9n4EEAssDcNYvaRlzTXJ3ad0NSSvyxY93KH
         7MzWGf0MqII4XeqFl7bnqV3ijqQ1Mf/tiQ/uL7fwK1/yK8+23ZS5QrxO77LGqymOb6Mp
         s7sWaMYhuJcSc9w5uF9Gf6RL9SotfmG9QKCgmd+mH8Q87rk+lNkoYsCdjQvAw0NwwCJ/
         oz28tQfzmxJ8YmKpJWkP6UpQDhMaZzOiEdSblvI/1K7pFD6D1gVTXvLVV4Dhd0WNLdna
         WP7QUZjFTkeYIh1Bo5DBKg51K7ioBuSCaKCafeEwP4w0K27jCYN9JXRUacd0GI0T8386
         1CJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhwAC6aPfda0jPUcJ7gK8e5nSa992fy3Xq7jfq0ByjcQ49Wt387HZmbtCAYp7/j/0pWfERVtiTeJdp1tIWOD+mWlKlUMhzcnxTsgKG
X-Gm-Message-State: AOJu0YyMyI2QoMK0Zeuz19r0Zfz5HNyGFc7M6ZDAyqmqRmArafH6njaM
	gXfdCkQJJ26PozdKcOoyvkJxtuLmGMiB0uo9CdfVd8Di0+4YpOWwIrTfX8I2cgLbPCIsr0PE6I6
	vbHs+Vd/H14nVT4Mo4AAOwiRdp3zSlDHG1UrDCA==
X-Google-Smtp-Source: AGHT+IHnYCZzEESPs5la4kmy6FqLn2ACVbVV+GNHRiZlp+4JYjbRsJEqzYox5Q+XbmXS/pU21NYc5OeGt7US3kPG2OI=
X-Received: by 2002:a25:bf85:0:b0:dd1:40dd:6631 with SMTP id
 l5-20020a25bf85000000b00dd140dd6631mr813474ybk.3.1711667133862; Thu, 28 Mar
 2024 16:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <578fbe56-44e9-487c-ae95-29b695650f7c@moroto.mountain>
In-Reply-To: <578fbe56-44e9-487c-ae95-29b695650f7c@moroto.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Mar 2024 00:05:22 +0100
Message-ID: <CACRpkdZw-iG=33gygqy75yzRsv575sqNE=4W-ppKm1QK6fiiMA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: delete incorrect free in pinctrl_enable()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 7:38=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:

> The "pctldev" struct is allocated in devm_pinctrl_register_and_init().
> It's a devm_ managed pointer that is freed by devm_pinctrl_dev_release(),
> so freeing it in pinctrl_enable() will lead to a double free.
>
> The devm_pinctrl_dev_release() function frees the pindescs and destroys
> the mutex as well.
>
> Fixes: 6118714275f0 ("pinctrl: core: Fix pinctrl_register_and_init() with=
 pinctrl_enable()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Great find!

Patch applied for fixes.

Thanks Dan,
Linus Walleij

