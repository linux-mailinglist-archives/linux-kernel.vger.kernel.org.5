Return-Path: <linux-kernel+bounces-156135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD498AFE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF94EB22757
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B9171C4;
	Wed, 24 Apr 2024 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2r/9rwsd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062618C3D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925702; cv=none; b=PgF41hkJTSXzbScBv3yQgeJcKhvff8INdtOXPBde8XOsA+vEX9j/CKQrWdBR8xPwYR4ICOTUyoH2o5nxd/yNb7JeoDc9C6/JbgxDD41njLNQxJQJfEATKst61AvTqz5mQVSO1yQn6NHgD931Pbtnos36hMsf5w4ZuzkyKiA4MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925702; c=relaxed/simple;
	bh=9z9OJbYgfrcfwWRX0GO88WwWFXb6L+Xo9Mu/0lbViUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQzuOThfcGLZ5seWI025DyrY6LjM4z9IJJ8F8pEqj6ZEsvum7EEdbIGpDAFyH/Q8r0ar/MUEKBpPIDrUVlvIGjP4/Z0yBM5kYP5pnfJAwqcvmjl/X/lOdSYZ/LTQG7SAm1cJ4nH0EA5jpCrY1a57xyZmrKsbyKkLkB/YlhQkAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2r/9rwsd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3f17c6491so51294655ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713925701; x=1714530501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze4k+50kKLUhtdOJ+MVcWkC0g+gDNT54b6uo5ytHs5E=;
        b=2r/9rwsdvb2hIXKLDWedx3j5xEpaY0tvYB0F5Hj6d8VdU7Tvsl50m3ZdDsuyDSJcUk
         1yAUyzq13p2ofxdJIx57AOV/aP8tsu+IwoUFIgKmFOz4YoyRWeVS7YaOw40lK71c7KCT
         b8VmxN87oz7ohSGAEYJmU1lAA6kBbbQsRHZGChHRIa4HxgT47ZMYDejcO89kd9BcyHGh
         /hpSRfnprxn0uU+jXV+NYoGMqHy9jvY81AFjIpHRGErDaNuHIoJE2hYYIixbhIFpneBm
         EDhCiZ49udFDD7NItvh5GkJuweNr7jFfw0n6g403s+dls7igWaGj5OoqlYIAcqx8Bnxz
         5z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925701; x=1714530501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze4k+50kKLUhtdOJ+MVcWkC0g+gDNT54b6uo5ytHs5E=;
        b=JePaVW7RnRa+p2uw/Ms3dq1klE2ByZm0E9rq6zHNEULpU0yfKscE5p3PF3OhVfaHpO
         puYx/S0tsAR5A3C0xu7BNRRBcY+t4l1cH7L/1fDJdfQxXNr2VWPslmQJeWunYEeFnj3B
         Al8f1dq6S220GQcKTeNGVpBVRl1+I3erwoB++7Q7zuW5vJdJBkzdNZw+r5EEuTzh0WFF
         WgBaF/kAeW0o4y4vUZAC5ZCoJdZ/nDdWKI1AVVj/5JLdObp9FqzSM2T/fS9kyMmLnrda
         RAdSderA1nI3A+2KToYNDT+MQUVFiKQq9+UA63jOab6zYZoezi1RtiqtoBokvk1gVfix
         uZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2aLpugWhjGU1hRJKTMSmCHX4GEX3TJKGlXLxhsYyGbranL0tNF8Pa3qM5BzScuYa5qel5jKXFCzIQW/qoZ2tu8prSsYUngbD4/H9m
X-Gm-Message-State: AOJu0YwZ33EYfAhs4zUIOKJ1/22WvFnpXbx1DyUCG7qlK9aJNvYn25wE
	ZRB8RFC5fzoyzpJSuHWXmcRH0zJOsX4cztcZvc6AxuL5C8gPfNO0jCJti3pX8xX/bGJTsuaSPFa
	dToH8wsTSDpl/87DZp9umxZHON8zcZmKK4Z7VwA==
X-Google-Smtp-Source: AGHT+IFBTLfPuGp9/IC945aJ33zSnp5IS3lA1sZQ97BsGnQxgo+apMlCKbEsg2kkINqPxswPBgsDmG5f6quE3YJGhno=
X-Received: by 2002:a17:90b:3448:b0:2a4:ca45:ded1 with SMTP id
 lj8-20020a17090b344800b002a4ca45ded1mr979782pjb.28.1713925700834; Tue, 23 Apr
 2024 19:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com> <20240422151607.GA1277508-robh@kernel.org>
In-Reply-To: <20240422151607.GA1277508-robh@kernel.org>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Wed, 24 Apr 2024 10:28:09 +0800
Message-ID: <CAHwB_N+M3Le2L=mECVMX1Ha2g+G=jog6zdfZCzJ-HSdkngHGvA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: display: panel: Add compatible for
 BOE nv110wum-l60
To: Rob Herring <robh@kernel.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
  Thanks for review.

Rob Herring <robh@kernel.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=80 23:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 22, 2024 at 05:03:07PM +0800, Cong Yang wrote:
> > The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nice=
ly
> > with the existing himax-hx83102 driver.
>
> From a h/w perspective, the reason to share the binding is the same
> underlying controller, himax hx83102, is used, not that it is the same
> driver.

Got it, will update commit message in V3. Thanks.

>
> Rob

