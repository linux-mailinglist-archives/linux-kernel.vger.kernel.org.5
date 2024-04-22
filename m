Return-Path: <linux-kernel+bounces-154034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081598AD669
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E25F1F216B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A41CA8A;
	Mon, 22 Apr 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PPCzB4SI"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F241BC2A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820559; cv=none; b=ae4LjdhNApFrnNSs0fGgtsK1nRA59ykLvZMoUiGYtqEDv/zu4Es4/4VPaqWuYJ5flpq5wO6b1L2pQcudeLY7OOlSnK1IGDmySFG2coNxt8JdL7r/0cRZGJlmxdo3qJBr2BYnP56g29JeDbmRdqiidtrYFgVCjdgdVamv23tBqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820559; c=relaxed/simple;
	bh=lf9q3FwHh8q66uQSPMgiZSA5CAzBB1McTifkB9D6GfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFPTRV+MST+OlO08sRparlqOWk1d/MU4LDGwCCvuicJyMkB4oLy2TMsFN5DWXqKtF4o+oiTp3eb9C5XGiU7uFfqhhpEqgvObGg1YjdG/Rt4HEY2/zINdO69tGJmp/c3rr87fuL9th2ObJLM9djU2fSfu3QVTaO7fIDA1Solawlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PPCzB4SI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5193363d255so6516010e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713820553; x=1714425353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf9q3FwHh8q66uQSPMgiZSA5CAzBB1McTifkB9D6GfU=;
        b=PPCzB4SIKkWPcBAC3EYyeYl3VhZdNzjG7Y5yD3gxl7EYjGBvr08m7/t1LOdgy2AYLH
         naSzckuYfwlEkhGTJ31cdrNO4AzI1QwPC1+zQ2i/rSMEeDxtTF/dF/t4LO7l0ETcsVTk
         fGIrzYiHlgcuswhGJNVN1eUHUTjajNQcqEwXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713820553; x=1714425353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf9q3FwHh8q66uQSPMgiZSA5CAzBB1McTifkB9D6GfU=;
        b=Blo1WcTnhFQ+ijzO5nZy5rkvlQbVZd8mYNlna1OGgGY11hfZeY/Gxg1b/TWeLnWyTS
         xQbct4ck/Nj6p1bik9g4sNnzF1ilpxDw+wnNJjTKBm4oH13VPF1tW/hf2U+3lHvOYYXy
         /Jn3TWAB9HAhsJy0nrgQcGgRFbb8Q++R6Gwt+hQaP1Nq3jbaPj7xe/HNZtf053q0CB3V
         ePuK7AzhnwIXOvBp0m7zfemwPv6goAHq5REj8lLN7hUj0ivN2FNeefBeXn5VEQwRx0k1
         FquCM4wbbssF+i7xxEdIjWXlf8Nd+ATF+S0zlUFs9ngOk2436X+swkHvX032FobFxhxj
         UJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCU9sOra/5LRmUSU5iPE0R+mxFArXZ+cMec6diwRNWVSrGc4+OK9fd9DIT9RCPpzls8tEeEdYI9QJ34ZiE4i9vU0Uz8VVDUH/h7/E0Jq
X-Gm-Message-State: AOJu0YxqqWWt7Xv7DE8Fe0shkXFyGVd6MTCVsdJZ6WyD8FZGcS5loE7S
	HnKTW75J8z0gXueO3sM7tcQqiDNV493bMX6V+WMxMyYVnnX12VzeCKmfn+3phx1cOxmMUJicBAz
	+1g==
X-Google-Smtp-Source: AGHT+IFrd46sDfDgC8YDtbGtLTNXnkkIs7AevocJA03pOO8EdShrce5XrWL3ZYY9+QwTEw6+9ZURlA==
X-Received: by 2002:a19:5f4d:0:b0:519:5b84:1038 with SMTP id a13-20020a195f4d000000b005195b841038mr6240316lfj.20.1713820553766;
        Mon, 22 Apr 2024 14:15:53 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906431500b00a521e5856f6sm6179485ejm.51.2024.04.22.14.15.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:15:52 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so2162a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:15:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4Lh//xpb5HIMxb9sp0GkuUY4dtHsHa0Xiupomh4JZdzSFrtxS4O6yiW3D3lGjQ7Fv4ek2ATY9A4XDhHWsGqwHkY3ho8fWsPQ6zSsc
X-Received: by 2002:a50:8d5b:0:b0:571:d9eb:a345 with SMTP id
 t27-20020a508d5b000000b00571d9eba345mr57099edt.4.1713820551808; Mon, 22 Apr
 2024 14:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-2-yangcong5@huaqin.corp-partner.google.com> <20240422151424.GA1273350-robh@kernel.org>
In-Reply-To: <20240422151424.GA1273350-robh@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 14:15:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCq9FmhFHfczxGAM+P=foz-XmNvO9r79=3=0SXUYQz8Q@mail.gmail.com>
Message-ID: <CAD=FV=UCq9FmhFHfczxGAM+P=foz-XmNvO9r79=3=0SXUYQz8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
To: Rob Herring <robh@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org, 
	neil.armstrong@linaro.org, daniel@ffwll.ch, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 8:14=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> > +additionalProperties: false
>
> Perhaps 'unevaluatedProperties' instead. Don't you want to support
> standard properties such as width-mm/height-mm?

For at least those two properties, it looks like the answer is "no".
From reading the Linux driver it appears that physical width/height is
implied by the compatible string. Unless there are other properties we
think we need, maybe it's fine to keep "additionalProperties" ?

-Doug

