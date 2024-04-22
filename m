Return-Path: <linux-kernel+bounces-154036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A20748AD672
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC73B21AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C501CAB5;
	Mon, 22 Apr 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JEcu7p4q"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421431CF8D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820663; cv=none; b=VRKTuymPtxERZdXSBwrxqC7pSr6I7p2eWWVMW+0EVi95rCUOxPAvFtF9MPMssWzVcbtUmnoipv3/ej3oKni8GTrWm5IPqVGgqafUAmGRpz5491FsSP+Qn+ciTgqBEyh5xBqJvHLMqfkunj8pYk/eSB/2gvnvIul5IoBcER07/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820663; c=relaxed/simple;
	bh=4iw7ODXz7jcXnC9I/HtNNzAfisnjy5MrvL1n6NmWuIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+9aQL/DEXWLNIFxjrirFzmcBCejy+QxpPHIgeuKUCKVFIClr1G65M1faN7JYeDCJAwQLpXRjqK7L5yHiFqT50D28QJUXXEvtUEVzGq8pZppHi79A7oOQ/TFn2MnUSl1e98vwZ9yhL0WLFF/TAJDagovaPJEQGs4tZYmGLyCa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JEcu7p4q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso548168366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713820658; x=1714425458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2m/l3tOuUABljidnIMWozMhmQuiJxyH3dIJhKQ/b+4=;
        b=JEcu7p4qoVZpuWe3hbhvUJC83fW83yZlZk8Ke4ZBA9n0yJ9nVGoaVczYKURVsd0LKL
         qKhQgbbQA+25CFV92DR4QmxXWOC12qYw8A8rD3+/2wT3t6e+71eBn8mWAan+FbzEvMel
         KoKqulkXt+g5M3jZpJzrnREXA934xTlizrkqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713820658; x=1714425458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2m/l3tOuUABljidnIMWozMhmQuiJxyH3dIJhKQ/b+4=;
        b=duZklI2YPdZlpZE4MuLMXH5AsbIMBgz2WUIjBXP8F5qeCPO0hRrZqUJxmBTSN4i1QR
         TT7NtPiZF5D0RcZXDHYQu5+n538szLgMgfktIqIOgh4e8+AdUrTddRpvlFRX9A35wnjs
         x2p//MmhKR4XLJqnQTHRItZSYezx2GVef69YH/N/4s8/tgChhQXr+Wp0bDruMkzAYgVQ
         NAN4SSKR4gN3fhZVtNm+pqi1ecuasNoqHDrj5109pXlvNlQtwX1TXHioWCqT3s+Csv9W
         QVXGRNmmQ/oCGdncU6j+2HPUqIjxlI/S/c5vr+ycnalFJAcHVOjlAX6tz2T+sAZC5nYs
         B4KA==
X-Forwarded-Encrypted: i=1; AJvYcCUFBq8CBcl1TPOQ1eJD+B7gp/+vT9ZfIPi0AuLRe0+gsR9ZpdGbnnwRCKlfSsxuuxXLoo8tCZ5uaVfMRrOyh0MmxIrV/7A5LAbg7UnC
X-Gm-Message-State: AOJu0Yx8l+jtHMgbI/Srrmdrvt9jzsMEU7IBpl3I5B1qa8WyXsxlgSQx
	mj8bFf6G+qtcATRyilE77T46qGQiFR1+MNE3SLuHcLkVTFzHEoYvhtG0KCikY+jHfV9k9+VPTTq
	H+D5C
X-Google-Smtp-Source: AGHT+IHY8h/jzP21zboOQ+TD6MIcCjzRth9kdzbDjCOiNQb5o2cjyVOsEpdkhj5a7WB0jZlQ4MqC0g==
X-Received: by 2002:a17:907:8689:b0:a58:7237:6651 with SMTP id qa9-20020a170907868900b00a5872376651mr1410084ejc.44.1713820658257;
        Mon, 22 Apr 2024 14:17:38 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id d17-20020a1709063ed100b00a52222f2b21sm6161691ejj.66.2024.04.22.14.17.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:17:37 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41a428374b9so7645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:17:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUITxszayV3SB9Wd91PDfnPNcKLrB7ODKr/ZadYgE+t2fXTg4EDN++PYQESjzK2G3X9qkr7mtXqHD8nsoDM/9A3llIO1VVoNdnWw4Fe
X-Received: by 2002:a05:600c:1d28:b0:41a:4331:89c with SMTP id
 l40-20020a05600c1d2800b0041a4331089cmr55545wms.2.1713820656705; Mon, 22 Apr
 2024 14:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-4-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240422090310.3311429-4-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 14:17:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWNf6-Qtf91EkDZhLzD0J_SpSEmm=APjuaqV099QDj+w@mail.gmail.com>
Message-ID: <CAD=FV=XWNf6-Qtf91EkDZhLzD0J_SpSEmm=APjuaqV099QDj+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 2:03=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_NL=
6.
> Since the arm64 defconfig had the BOE panel driver enabled, let's also
> enable the himax driver.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

