Return-Path: <linux-kernel+bounces-154214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17418AD961
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2CDB24F48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072B47779;
	Mon, 22 Apr 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmOAB25G"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9244366
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829967; cv=none; b=nep8XZe5I0w7sgf7HLP+dZIqZgnmFzb8vZPMwgR/Yes6/SOQzfKS4PTXYr3PBk8twLtPviTty1I0Ox5mETtXBl5cj2iXgC/lI4WxdZGNssgCuCDjIpcFdU0Pv5SOu2zofG3HZrZNJszOWW08e2UeAxUDTTzAjT/xiPeIz+dHy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829967; c=relaxed/simple;
	bh=Jc5aknRuDoomxHjp8opKPk+0rkF4Bv+5R6HHAmccbDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VreS8ncKi5J+x9aUgZMy3S1VIQkH8m1QWaUCjh+B45+lPMWH9V08v6LzQ4CnZxXLJEkysnTT8NAATcFqgGGhYpYSL3gVpg6VueR8zcjRmYv/YVOLSnNDH539e1OvLnnUZNNnWAuUKpV++YR2IHXV9EuSx693Fmw+aPWgBxh4Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NmOAB25G; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c74ff209f6so1902806b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829964; x=1714434764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL2SDfOIVdnh5qofXf2kW8VQZSFUt39QV7Ink+MGMfQ=;
        b=NmOAB25G52oTf2q5nCuj0VZyV2cQenixsI1QP/BFVmKmNnQxsP8Kjfw8c/TO3ExXBm
         ailL+3JIYtQ8/CU6L6zpOJN1o7ID7TwuztGxR/JqrYlpdav3WDQIy9N8JAkKdtf77D5n
         BOpsy/T1rTNXPmKEAED4RXP9+vz0Rb3dDuTog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829964; x=1714434764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL2SDfOIVdnh5qofXf2kW8VQZSFUt39QV7Ink+MGMfQ=;
        b=m+sUltS7wi1/TakfFdM80YfrI3fef79bfYMAOVk/04WEslslDkSnli+4xx0dlmHE8R
         YL/fDq2fPacnwX6ahtT+3KVWdnLIfJRb4pvDdX7sgHLOIDm4Y5Mb91LGQDPxnJcrNULN
         wFrwXnuePVTD+OesouZrRLseGM6Tx/C7quxgrYOA7nTrpTBh/29mOEqAR2rMFr+Sr1fk
         HcPJEQzVQ4rg12BHD+P9E3CNg26I3vbsj2reAowJHta5O7YtuvACJpu5yCr+Vl2bmdcc
         P/wKUoIDkXVGU2iHZbNZ1S0Cypv99Ei7QwlwCHcAdto7hKNSQryFfjrM2KNflbaOgt17
         a4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3RZ7q1R2uNKTziT6QFeHb4B/UsSl4yg5IWCcA/LnrHWFZ5VKeXq8DNGl1mR4xkw042/6LD78uVv6V4b+MZyWObl2bWeZZVBNpJDt+
X-Gm-Message-State: AOJu0Yy5Pw1q+YfVNgfTt6UIe7c/wNItJRuI8hCMTZSi7BAnsT0S3JDt
	Rae1TSPpmZz3jtKO3+VF0eh9Vo3/z742sxpaH9zXAaZ3u0VabfpImL+roeBaccA2bJw9qbtfq/A
	gR3cf
X-Google-Smtp-Source: AGHT+IEnaEqHAgWlcBCtRGCAkn5PHVXLyybTGCmYt7dwrhwGAxvRQoqX9nGH7o5M+F+goZMPheSVQA==
X-Received: by 2002:a05:6808:1450:b0:3c6:fa20:6c04 with SMTP id x16-20020a056808145000b003c6fa206c04mr18101735oiv.38.1713829964018;
        Mon, 22 Apr 2024 16:52:44 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id q7-20020a0c9a47000000b006a08a7e14c2sm103501qvd.25.2024.04.22.16.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:43 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434ffc2b520so79151cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQcHZdzSG/a2vsygMKl4GOqfGMQWQr84njSJC+cBGE+/c36IV6QEOtP8yjEL/pCF/J3YlNttscgPghHkyuRo8vaJ5nTfc54js9ixsu
X-Received: by 2002:ac8:550d:0:b0:439:9aa4:41ed with SMTP id
 j13-20020ac8550d000000b004399aa441edmr126829qtq.16.1713829962719; Mon, 22 Apr
 2024 16:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-5-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-5-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcND6vBd4X6QkKESh-N8xB9L_Dbwi1nmOOfF9FDoSZEQ@mail.gmail.com>
Message-ID: <CAD=FV=VcND6vBd4X6QkKESh-N8xB9L_Dbwi1nmOOfF9FDoSZEQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kdb: Use format-specifiers rather than memset()
 for padding in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently when the current line should be removed from the display
> kdb_read() uses memset() to fill a temporary buffer with spaces.
> The problem is not that this could be trivially implemented using a
> format string rather than open coding it. The real problem is that
> it is possible, on systems with a long kdb_prompt_str, to write pas

nit: s/pas/past

> the end of the tmpbuffer.
>
> Happily, as mentioned above, this can be trivially implemented using a
> format string. Make it so!
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

