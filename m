Return-Path: <linux-kernel+bounces-41319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1883EEC0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703491C2139A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749702562A;
	Sat, 27 Jan 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDKgMhgU"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3413FF0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373660; cv=none; b=UeNDw5+slcGpnNloPik/UPIqAr/jKicje9mgakyMxC1tCN9eHPUGcbLeli2EFg5Yr6rAteGLdPW+/t2CUKBMgFj4E5Vcjy2u5KKdwJJ4zd6ZoQduWW3KY1gePs0TrrdMDsfQNtCpKjgLVU/Z5eWwGhFgxrDsVmXyD26P4qNTgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373660; c=relaxed/simple;
	bh=7RvZT44YBgdiwiKgWuRjay2EtoYYF+GO+FuLqTpQR7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMvFZoJhtjb0FrGqpRb05B545WbDV3H86fcToNQg7o0pF6M4ZIAt2fi5j2rRy2C5F0uZl0Kc5uAXQVr5sNy5fHpeQNr6O/cd70f6k9ePN1S2qtJD7fgo03scuUz5Fe4mFzX6hp13GPQbuDpT1TyPjM9uyzFufQcQVwaxDRA4Q5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDKgMhgU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc223463ee4so1706129276.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706373658; x=1706978458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT1Exo5HZPUej7pl3Sf7KYOhUnetXTHlbzzBJvg05vo=;
        b=JDKgMhgUGu56d4U3qs0ZdD+WNV4L6cU5Kdhg8nCynGL5vhtdf34Tf5QKv9jIDU/a3k
         /5teiCWp1SUoCSrKrDQfREeLebWIg02oF6BTqoCycIStNz6egAzQsVTqW5RwNhYRbmVn
         10LoUxuYXdtWuqxLCaWycctgGnsP30j3meqB27InL9eY1iWTMbT39JSyAEhhrDGfDxSP
         I+x3yYoIPVBh7syUX7hybC4eaMGM9KaZ40daaQIx63L8j2J7slGlzdN4Ky88Qx68ge1o
         sH78rbpxScGn7QCQLnEEAxGmLC0ARP8kQEF5+zIoQkTuYixmC6sqFr/bncQwsg/rV0X2
         3xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706373658; x=1706978458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT1Exo5HZPUej7pl3Sf7KYOhUnetXTHlbzzBJvg05vo=;
        b=VI9uwZjHV/lDBjXclRjc6xLHWV328unY6GTxKCVKlBoSNACSWYrJ5wohKup8TRultZ
         ZoHoY1JyUlb8KmEbPchnS3XUrsAkmq26z7swMzy5612ceZyQuu2hZZUq4AzyDR4GG+B3
         w+pf5rDplMPBB3Lf+KfTCQJSWtDQj89TpBlFPFK9/vsLEnkehD5ot6b0ni2nFlcCwUr4
         AGdJ3H8/1ya0LSaX+6WDfUjlEZyWvhdHduyJW8UrxBAKN3Harn0OglKON3k5i1Z9ZbKp
         FFZo85G1zQbcikKo5C1sK8V9KXUdqKLeBTWw41h1/9dKeIUuxbFjr4F+d+6/X3PhYAu8
         TqRw==
X-Gm-Message-State: AOJu0Yxkxwy/K1CFr6CoX4HJw19qHE5xmMxZb7u0r/qF6r43vgG59qba
	BD3QYynjFB8hgeS0UQ2+TyQUCXnAyQCSAYfpaE1azgeKL6NJ/asQRqD5FM9+VhHGnm7JxHbYbmj
	nY4LMGA7Cc1b9TM0CITZt1Fvi0xCLwmyY2AfN4D+ZvhXgDe+D
X-Google-Smtp-Source: AGHT+IGxWylb3x6PvuiGls+63CDlOR2to8X1Yhb884+I2Osgi3EG4M3tSnJurIDqx6qxvZppFEGLmso+Wb2uaWlxFsw=
X-Received: by 2002:a81:a00e:0:b0:602:d04c:4402 with SMTP id
 x14-20020a81a00e000000b00602d04c4402mr1878416ywg.81.1706373658282; Sat, 27
 Jan 2024 08:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127152821.65744-1-dario.binacchi@amarulasolutions.com> <170637290174.2797231.1548285445759438647.robh@kernel.org>
In-Reply-To: <170637290174.2797231.1548285445759438647.robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 17:40:47 +0100
Message-ID: <CACRpkdZRvGv4gKxuYpt+fczWCegsQWjP3yfrW=RgOLBFJxtjqw@mail.gmail.com>
Subject: Re: [drm-drm-misc:drm-misc-next] dt-bindings: nt35510: document
 'port' property
To: Rob Herring <robh@kernel.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, David Airlie <airlied@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 5:28=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/panel/novatek,nt35510.example.dtb: panel@0: compatible:0: 'hydis,hva=
40wv1' was expected
>         from schema $id: http://devicetree.org/schemas/display/panel/nova=
tek,nt35510.yaml#

This is because the checker is applying the patch on something that is not
drm-misc-next.

I think the patch is fine.

Yours,
Linus Walleij

