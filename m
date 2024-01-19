Return-Path: <linux-kernel+bounces-31240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D683F832AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146DA1C2297A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D762853803;
	Fri, 19 Jan 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uv7CHGWi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2054645
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673439; cv=none; b=jrDJTRaTDyV0qZCW97O0Av4XtErTe3d1Vcy3cAKLDGYrIBD8g0K7aQ39DzAo9iIabhfbwx3wLRAlXNruj/P7NSXi7boQD3HlNTXspE19AFO1vnkYer8EX83HPMIjK3NAJF1snZ2SVxRTAtUdIW7bIqixn1QJzIxSEHobdqWraO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673439; c=relaxed/simple;
	bh=nHXK0M/RJcCyXcMUGL3CX69X6MS8uSHqxCI8rFn2VmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1+YmM+adLq0Fpa/7Ms4AxRkFQ/NkOaQ9AoijuSI4XlSnRnOngrReixO6RgDUHnNsA/dL64hGt+etsXSDTwn/U/659AX1nos1Zt4Ar8KsIk8XLHMTUXiUx8wpQqcrEGdp6S7vpRl1G24513glWspk7y07UWYmxADkFb1tQFMGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uv7CHGWi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso8945131fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705673434; x=1706278234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHXK0M/RJcCyXcMUGL3CX69X6MS8uSHqxCI8rFn2VmM=;
        b=Uv7CHGWicR/WsyJvp9agl3vC0H0xBXdFNhE6lyt0O+KoH8YZVLTiC+/XSzyDJev+EW
         3OB68hC/p4ngm1T/pV7JFoHHGA9BZpnkr/KB+fFtqDf+w4BSAkQ78Vkf1o2EjjjN6cvk
         MrUB9YJxWTEOLcJpQG8bvE2/M/+vROgbkJWSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705673434; x=1706278234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHXK0M/RJcCyXcMUGL3CX69X6MS8uSHqxCI8rFn2VmM=;
        b=cVzdVki09AOEpEa6Fhn094eO86qx8SykWbb8pec8rHIvYtca6UnXfN+TSQ0/C2xQr/
         cxb/3H23PkgboFTHidUGzCYUfhgnBytdZWstYuDfcIj1sWh7SoVukcAkCF38qYRDbrP/
         Mxr7VglAlsOV36dsIdBSUkhfvhRo5n0h4ML2c89GbQ9fFdse0mIV+TRiU4p+DpwkXY6l
         aq8hcRQSfW4QdJK1Y190MOVBrBeNSFhTTisJwSZqbQ0dEMMjeFpS9+OZ+Ogs1ocYclT7
         A00ZiPuYefejmvMt5kowmUSCXypjdPnOnCTqZDg7dT8wxqogHff1+LY66rutAmdSd9jI
         b6Fw==
X-Gm-Message-State: AOJu0YxuhRNyCsnwBQ6JMjRsE+ZHjQ15Jh/v9d2K0RVt90jWvUygQQYP
	7u0jYkrdAiLGe4+BWsal3n3zsThaonfPTP14OhW8DRFPJwLGP6IIdgrYfyuj/kInavoigVD6ViW
	PeQWKtfgWC1wyUbz5JfMPPIsLGm3PDcs56deT
X-Google-Smtp-Source: AGHT+IEFCjeV0kPn36vLidVc3VqzoEt8h6MuGqJE0fkj1ZsKwfkPt7HEFEvhTaN/u0H5BfClm2yPwTDCwB/jUKb8HV4=
X-Received: by 2002:a2e:3506:0:b0:2cd:2ac6:9685 with SMTP id
 z6-20020a2e3506000000b002cd2ac69685mr1271557ljz.92.1705673434623; Fri, 19 Jan
 2024 06:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119084328.3135503-1-lma@chromium.org> <d2329494-2c57-41bb-a9ea-2c9903500d1e@roeck-us.net>
In-Reply-To: <d2329494-2c57-41bb-a9ea-2c9903500d1e@roeck-us.net>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Fri, 19 Jan 2024 15:10:23 +0100
Message-ID: <CAE5UKNrU9YHoCQr8HLFf9-T4-NobQ4jWtryVqq9okFz8nVezgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce EC-based watchdog
To: Guenter Roeck <linux@roeck-us.net>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:50=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 1/19/24 00:43, Lukasz Majczak wrote:
> > Chromeos devices are equipped with the embedded controller (EC)
> > that can be used as a watchdog. The following patches
> > updates the structures and definitions required to
> > communicate with EC-based watchdog and implements the
> > driver itself.
> >
> > The previous version of this patch was sent here:
> > https://patchwork.kernel.org/project/linux-watchdog/list/?series=3D8179=
25
> >
> > Changelog
> > V2->V3:
> > * drop "-drv" from driver name
> > * use format #define<space>NAME<tab>value
> >
>
> I am a bit lost here. You dropped my Reviewed-by: tags, even though
> I specifically said that they applied with those changes made.
> Also, according to the above patch 1/3 was not changed at all.
>
> What else did you change that warrants dropping the tags ?
>
> Guenter
>
The "-drv" change was related to patch 2 and 3, and I have used
"format #define<space>NAME<tab>value" only in patch 3 (as
ec_commands.h is mixing those)
Sorry for dropping your "Reviewed-by" tag :( I've assumed (wrong) that
I cannot take it for granted sending V3.
Alos in such a case if there are changes in patch 2 and 3 and 1
remains untouched shall I send only 2 and 3 in the next version ?

Best regards,
Lukasz

