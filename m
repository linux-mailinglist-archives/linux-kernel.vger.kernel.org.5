Return-Path: <linux-kernel+bounces-66179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D861855830
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294C1286A14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276BB469E;
	Thu, 15 Feb 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SdvlYcED"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6ED33CE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955840; cv=none; b=aBObz927Rs+IyzpDddphCUMzPfj6rV55PN3AGrwHWNdKoML20CU7C4baEw6I/HVLo7k1+aGzjMzXkNtx5wJWX+N1HWVdH8zkiRYtTqiUmSvXXTEqBN6MJLtEF1IUSz+1JKFcMn2pOQcx7ZInmsbPRDJTlGYSR+x9Tghjp0ndus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955840; c=relaxed/simple;
	bh=MoY8zd5LHcnN/kn1Yc6yYVDv8A/j96P+/bHPEamCQx4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFjriB+NoYQxlFoQWwRen7FkqqIdq+8ltTzUprYBx0xf0euaTjZ63C/hHewwYWaC1YnWG2i12YC4btXjXL7dVcRJX8dCESTkMmJiycdv4pQOhoRRyGno5GUlxjywO6mjmBjQEk593bQJkj6pY/FAY1ycRA8XVDpYQaKY31h6zoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SdvlYcED; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d1094b5568so3984331fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707955837; x=1708560637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoY8zd5LHcnN/kn1Yc6yYVDv8A/j96P+/bHPEamCQx4=;
        b=SdvlYcED3qwr7cguSIyCzChQfqvWlAKphF/UNNj8vFjYHejLKdYQmvhVZzxqUHofVW
         NBy+6NmvTUg1NCvcWyzZhZmTNz0IphCPOHCs6n8zBMwW/HX/q9pFdukp1dhETyKb5Ub/
         fbt346SdNL2yBC/3GQBdWTLVQdEhmNg+yUjlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955837; x=1708560637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MoY8zd5LHcnN/kn1Yc6yYVDv8A/j96P+/bHPEamCQx4=;
        b=nzS4LAFkJaXbAvzxgJj4jIBBjo2HXQprVKJ93My8cty1AJ0wabJ/UoaX5uOBm8JFUX
         uQXNcqYaZs8+xYPoRczjL0MFt6EC2vZ6GaRDtRiPhGRHULpKFDC8f2F2DwvhMcia7pGv
         Z8+OVj5ytqRLSbWDSEd+845E/CrPBu4M+lBgFrLjfoqnzXs172lnMcWZN7DPDQ2AkC5r
         YMFJ+DYRKZ2KnvZch9TZdzCPK8cfxQ5mb3ZCjJwR4qRLlrHZIBx0JWtdp4qk1BtQoCcI
         y505KFzZacMnBZmK2yK571n4ZJFUEDmv9iWntXRCYPg8acwODCt2ezudKRUAiWm2ELm5
         ar5A==
X-Forwarded-Encrypted: i=1; AJvYcCWsZo8VhiMeQBNGQkOY5ZkPU3mpG6cSNxZY1WlVKymXQG/RjVz/dIGPoc0uZ7RIf7CAUwDeyDSKjSR8qYvNIoV/Q0L4p31YvpNOau/9
X-Gm-Message-State: AOJu0YxUg1t4PX8RANTp0217thz8SOpZv67sBWKhBvwMOkvgOumNJ+/F
	Owmjn8J3IRuv1zePaoItsLCn9uI0UhxJqtk97gTQgygRi9gbNRXsrsPTo6/35zMIPgrUfYHix20
	+44/qK/GYJd/S6XoI1S6T0LcwgqscyxrpZIqo
X-Google-Smtp-Source: AGHT+IGyK/V+b6ReG/wqHqXSPazELs/LPvoaEiaFNzPjPQahgGbt5hpPQ9anxbvIUKEHmI0AXlLFR3H6hDqkCDMBBq0=
X-Received: by 2002:a05:6512:3584:b0:511:ab1b:1db9 with SMTP id
 m4-20020a056512358400b00511ab1b1db9mr212121lfr.33.1707955836868; Wed, 14 Feb
 2024 16:10:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Feb 2024 16:10:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WE4bgwTWTKjPbQR9RCt-SEVZXfQtXoaXAjvTiZiMr=wA@mail.gmail.com>
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-19-swboyd@chromium.org>
 <CAD=FV=WE4bgwTWTKjPbQR9RCt-SEVZXfQtXoaXAjvTiZiMr=wA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 14 Feb 2024 16:10:36 -0800
Message-ID: <CAE-0n53H-WPSr4tnmjq2Z54daKYD3PPzmxy28GsYAd29MTXiWA@mail.gmail.com>
Subject: Re: [PATCH 18/22] dt-bindings: chrome: Add binding for ChromeOS Pogo
 pin connector
To: Doug Anderson <dianders@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting Doug Anderson (2024-02-13 17:17:34)
> Hi,
>
> On Fri, Feb 9, 2024 at 11:10=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> > Describe the set of pins used to connect the detachable keyboard on
> > detachable ChromeOS devices. The set of pins is called the "pogo pins".
> > It's basically USB 2.0 with an extra pin for base detection. We expect
> > to find a keyboard on the other side of this connector with a specific
> > vid/pid, so describe that as a child device at the port of the usb
> > device connected upstream.
>
> Can you remind me what the side effects would be if a different
> VID/PID shows up there? I know it's not an end-user scenario, but I
> have a pre-production "coachz" keyboard that's actually programmed
> incorrectly and shows up as the wrong PID. Presumably I could either
> throw the old hardware away or figure out a way to re-program it and
> it's really not a big deal, but just curious what happens...

As far as I know nothing happens besides ChromeOS userspace treats the
keyboard as "external" so things like smarter base detection, e.g.
wraparound keyboard detection or kickstand mode, may not work. I think
you get a popup box telling you the keyboard isn't the trusted one.

