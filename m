Return-Path: <linux-kernel+bounces-135753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371289CACE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA34B1F271F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33F143C6C;
	Mon,  8 Apr 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EF2fNNRo"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79C7460;
	Mon,  8 Apr 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597305; cv=none; b=UNI3cyNxTqiAHJaPByWlMIJju2dSv8xVUENYgbC9x0X/V4trGuc/KsEFQnevpHTRfQAReSkjlv6IWNQjavkbrTiKX2ENrffB3m3C2kaBEwNL/039oBhz554uImz/RKf1Kgg54u4TZLkPLSc4BbjCEw97AhOolDVmbsGN2Zc03/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597305; c=relaxed/simple;
	bh=KK8GiSvFSo2V8qUPnqrwK3403k5I7vbDgJq4v/eqDhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbUF8ZdlJd1D637izanEpzICs+7G40YlRfuCEGq3yTgnQA81xzHn9JkPDTpuqi0+e/+WJQ5NAW9BYxALdWhGtAQhkrUtmIh2G8SBHa1L8EPHOaO9kY3AhhLn2MmktLwAE7mPLbfyQ3IcTegeDQ+F5Bm/2yYjr0F4fBmjGWLdToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EF2fNNRo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3596605a12.1;
        Mon, 08 Apr 2024 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712597303; x=1713202103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK8GiSvFSo2V8qUPnqrwK3403k5I7vbDgJq4v/eqDhE=;
        b=EF2fNNRoXZnr9j1nOoBTEXaBjHpdFiVUMb49JXbx0MW12waqoyw3ZCCwiy34TKpqQB
         onbomXKvo4DSh2/3fS39oa99exR0nxl8zc08vtm185fiCrC7LtR9fwg06vKDJt90U7xs
         fqKllRjCX07yDr3nJUDnTW42ZlcbA54BBv/gN/jY4hB2zj3xalhdmGkF0YPcKs4NQy/k
         E3jQgV38mX8vpkazifYsmSWeUz2HZlLBkMMOWIgSv6y9h4ie9BYQabtGTV56jzrNjuzi
         ol7IHs4P25rcW2jpckey90bk2pcaTY7AOnNA6pRiP0blgpRBWjL4ipvL47VFXwagUUgO
         pzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597303; x=1713202103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK8GiSvFSo2V8qUPnqrwK3403k5I7vbDgJq4v/eqDhE=;
        b=eDREM0ngLVxbq2xd2d7MDzKVI4BpHTPQYsSwmmT+le5QQznD/zYA3n8sAlUX7grzL+
         x8knKtSAVZLZzbe7x2n/qC71dVzcHW1Sv9K+TCtNXp5F2gk72buMXwiqEWnzzzOajsU7
         GRx4SfCFdRcJizYZXyXKjwk+X5DuBRtIIRd4bfYirsGMGpLYdEAY9mGsYwWcQod/ES+N
         eEDGOO7TUsMBYCj/ixhpGI7WBI5IHgrEtNfELE08wMiZshsh1QjiRhSIbFc7A4Qc5aa7
         KVpey+knZcZHoepvU6pCEi0+Nhjvq3jAGU1spcQoYPF8NngE2i0mRsdel5IX38CmAwA4
         8wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA+YSSxSggcvPwgyZkac/qaL8WYqdfgvKYMFuI/lP6BiEbZ4RK1ZQEE7aT/45K6KlHoIoXKFg4YXRRhnpnQT47iRzD1Lh6XkHh0kBxK2FHCzGN41it+ri61a/Xhe1riEtreDZbGO9x06a456FEGtFR37J+uY3nGw0Huvs6Qv9+Shgv/LUDIQ==
X-Gm-Message-State: AOJu0YzPfQNuAcnl+L2kvPY8COjsc9We1VJrDMbBpXauLOw1qMO2ayfG
	r37vGvdiB/40iYtKJ51pd9VUCn4YxG2XGZazGITRmh1gqk+vmorFoLnu5rsokGx5MmcyKbfrIrD
	/F6eGF7JVtOXZXxezmYCA/ERygVA=
X-Google-Smtp-Source: AGHT+IFP6Z5pdRwrSLwARLzJ699fJGpW0H4+2+OpwDmZEkfRQGnMSXvUFgpa3p6th/TN1PAwzKX59Po/azxvXbfA8xg=
X-Received: by 2002:a05:6a20:9155:b0:1a7:49c1:d326 with SMTP id
 x21-20020a056a20915500b001a749c1d326mr7381136pzc.1.1712597303058; Mon, 08 Apr
 2024 10:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com> <20240401-basic_dt-v3-3-cb29ae1c16da@amlogic.com>
In-Reply-To: <20240401-basic_dt-v3-3-cb29ae1c16da@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 8 Apr 2024 19:28:10 +0200
Message-ID: <CAFBinCA1XchHvRuFNGeKOrpjzggM_LSNtA5ixn071=MkQvdc5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A4
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 12:10=E2=80=AFPM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Amlogic A4 SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add A4 compatible line for documentation.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

