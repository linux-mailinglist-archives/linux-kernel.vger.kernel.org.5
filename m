Return-Path: <linux-kernel+bounces-131157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D18983D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7231F22C52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE1774405;
	Thu,  4 Apr 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi7uKq11"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFF73539
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221938; cv=none; b=XI6C+npwDjsbXkWVry55dYVgMcDK89P+aMcoboBn810NiVyXrta/fQGB+Ul19Mrtoj5aITCK/rTvuUxpChnt84pX4ZibTAV79yNBsOBc9rhFOACw7rnnr35safNgVzU8wzfRPtcX159KYWEq/pkwqQitVSPIFXb2M0sFfDmooEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221938; c=relaxed/simple;
	bh=pZpni4EiHanmzTu7Iv+OWMwcfI8dcRTpnbSmx9mToSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvDMDiGgp9AxOtwh93MpVuOryjdYupPLUQoE8tdhktQrcIUw9082WFChHBTmb2X/uMd6UNqaf5Ldxdkk1JaCb1cQlbwdOqNseHhQrxNATONIE7x+omF/A+eS/o0oAWVEpanc23pXdgiNU2X4t4XWNh7gcf7hq0q2uwhJ4+eyj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi7uKq11; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dff837d674so6354445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221937; x=1712826737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMQZYpq2WPG4pd57W344WCiEabGibXhSo4VA8aMzIZI=;
        b=fi7uKq11JfxUexxhsGnE5VRHWKw3geKNcrKpIVXjHrvsiGzh2dP3zClmIKtL/MSkyN
         lNwnpX+agWbEasP/MATBTEeONrYuCQMSY74T2ZFYRpRARepYJ3+xpl6XABdhHzfrX/JE
         bBKPCjXWBKvhKaRedml8qLVguMdrslkoLPERjcDBFZdTBGWKzTtbzfZLpO5NqTGt0CZa
         6j2MBlUszjRd4OVEYJFJsz+VVhQTuox/isc0CJLgKmuMdYuJYULCFMBSgMAp2cTnPHSj
         Fe4XgTow423ew5DrzdrLJaHUDYj7kFTlAoLmfOcNXQCgdk4Lhc0rmzl7sJtQMVMBiL/s
         f04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221937; x=1712826737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMQZYpq2WPG4pd57W344WCiEabGibXhSo4VA8aMzIZI=;
        b=OnAJixMiheAUkZPw3s0ANvwzTkN8s0iS35sRGx7avSdw+Wi/mmGC9tVwfnVd/lnMwg
         yErN8b3aRIGI96ydxPz/bRMPmKoo38OjK+NS/yeZv/yf48RW5pscrQA0BLfj4xql2Xdt
         ++L9Hhfx7hZTuMZ8yR2FHttO141en22ICVKRCAhEpyI/smfonjX3FKydsROAM2pdrJ2k
         lmPZI0UfxMrlIA8FiA0mWZJIjYRo6JhJTnZFbau/yUMTtsCo73tF2j6GMDaC0cVfcj7u
         FmIu7AbXmdmDMAtW3L6j5OypY5QWRpSm9Waw4aUS0DSBS4yip4bmf/Gs3XviV+xszNyd
         zc5w==
X-Forwarded-Encrypted: i=1; AJvYcCW9lMrkP+F73ozfm6tfi3Id/bM/u+M5ZV4M7Zyn5lBQNILwidueRqarTJXvRF+c6TTUKcRtg/32GNjX6erKUmDKuc9GfL/LM8rqurb5
X-Gm-Message-State: AOJu0YwQrFnQ/BIqPBpCH3JO+tLqL/l1uzpy9k4iXLLGosuSr88+QTIo
	sPuDO+FfZk5yaS6AT2WDHLGPe75fSV7g7SPg0Crji4cfGI0YNIdXhL85jRs7pA+KrBXFRAJVcZM
	tbf5uttayf5nwF4hfUliGNbjJUy0=
X-Google-Smtp-Source: AGHT+IFIzCiuqnt1Uo554eo+Cc2qI9SW6J7C5F5xxI9D0jPxYeocaIPaSRD+dE0ftVLlD2lhf8zCpIRlmmr3yIwtiO8=
X-Received: by 2002:a17:902:e78c:b0:1e0:4ce4:7e42 with SMTP id
 cp12-20020a170902e78c00b001e04ce47e42mr1391289plb.17.1712221936795; Thu, 04
 Apr 2024 02:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <528c6824-287e-4be2-82f3-7fcdd254eb15@kernel.org> <20240404075811.6936-3-thorsten.blum@toblux.com>
In-Reply-To: <20240404075811.6936-3-thorsten.blum@toblux.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2024 02:12:05 -0700
Message-ID: <CAMo8BfLbNRv0oy_75p_N72B9Yd3KhpBQA-oB2CzeO=zeFRF35A@mail.gmail.com>
Subject: Re: [PATCH v3] tty: xtensa/iss: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jirislaby@kernel.org, chris@zankel.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:01=E2=80=AFAM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
>
> Inline strlen() and use min() to fix the following Coccinelle/coccicheck
> warning reported by minmax.cocci:
>
>         WARNING opportunity for min()
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Use min() instead of umin() as suggested by Jiri Slaby
>
> Changes in v3:
> - Inline strlen() as suggested by Jiri Slaby
> ---
>  arch/xtensa/platforms/iss/console.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks. Applied to my xtensa tree.

-- Max

