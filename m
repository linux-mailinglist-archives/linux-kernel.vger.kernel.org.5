Return-Path: <linux-kernel+bounces-86758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198C86CA58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA0B22A41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E408A823B0;
	Thu, 29 Feb 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYTHdjbe"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F17E566
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213690; cv=none; b=I+53rmFVn8T1GRmikGTb3BaYEihpOOHO2SElvm9g5PJV8fkSmMQv8ybPsleubYQsfc82/XsrvNiuiWVrTxj6UyO8t0inVDPMioG2MdN4i1wyFpKUwc9JdOAu7Ud56Mh6vMGOJv/fg0mAirQj11AUsIe6yFJdFYbx5xsGUOFAfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213690; c=relaxed/simple;
	bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFBjSXwau+YzBC7wdM8I5SSe+FNEWyy5PxUpFH0tc+ne05J6a5gh+mtVsRXGoW5B+2Wkv75wxy4EdBhGnfMKgh+b8ZbvbmtEp3/9PBO1FvkDe4wX66QdQSqdOqEsjnrSogo3bVDEU7/iQK3bd8StOcda7JkrX1fMNtofzH4x+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYTHdjbe; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso712581276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709213687; x=1709818487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=rYTHdjbepJHMdVjx9Imtk329wSoXnJZBxYtV726m28GV/V7gkGQXPfFJS2NlI0S+Z3
         pXj8RmkMOPs3Jb8OVqphW3Napgbwm1MIUNERMqYj4NC7ltvi8pWlz+H7gayZ6OINuFIs
         2OVx+oS+NV3eE2ZEX02/Rm9ABRCLur7+SmPKQ9hKv4p7d2wFX/CJXyoayu9c+vgIBTzW
         8wK5fPlhwVYHyYN2E86WCIwXywoAeodSrA5Fseo5fERoN2K9XEyGZOQw5KPl57WMELqa
         EfxraAKLsT0oNEysbw6hjhZJblor543ZwdklXGAAb1Tl4oYZgENGAgeCEVQK+lmfcI54
         1h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213687; x=1709818487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=vrVfYHCFqx7Go4hO7jkUZMCZAlMRxTZOQDQcRstK5lw8nwsKLDBMviCcyjVp2Ec1KX
         QPQ7I4pShGhk3AUx7BYde7r4ukdy3UgbwpBfn0fg6kuoCxooNRt9wBTTwKkSZ72ZUng9
         6bHVJ7PAICoukrgpVlKcdqDgOnOLsELA3lQ6SsQ8WvmAq9Swcc8VNTshkaijD0KDMegL
         +c3JEKyNQU7R3qqVta9ZW9cyke1F4BIHqfhrmxATpdm3uSzUgYQx89cbIcwLQzDWhhb3
         p8cx8EyvfwsI8/9mlt/qxSX+faPGImviuH7fBwijVkYt4C7F+daksQGEbdh5OcZwLpza
         HfoA==
X-Forwarded-Encrypted: i=1; AJvYcCWZXVa2Nfubs8CfhjXMDFN+PJI36O+9tyHL6bpqJmsYvH9RP6hqRaX8OBt+KN0GL+buF58y261zoWPdGcZpbfNt6m8DCMFTFW3dwyBO
X-Gm-Message-State: AOJu0YwbsFfh1tru0nheLMynyDNlbRV3QnJjGcnHvNisfdmILvsh97+r
	B8u98hDI3G6K9a2RZk9lbA4VUdFrwRmQOFt7468mC4aOX3TgmtLrtyd+56PJaZuWxFru5EX8xOy
	rJhpOP7FSot+SG8OfTtHvt2mPwk0nSiQ7xs2SMw==
X-Google-Smtp-Source: AGHT+IERWkObLg20g5CkQl+tvX5B3XTQSnYQFzXQbIMveAsaz3h9XahcBzBqENPTvOu/rO9KsYEoYLjXlY8xXBwHNlw=
X-Received: by 2002:a25:a347:0:b0:dcf:b5ba:1403 with SMTP id
 d65-20020a25a347000000b00dcfb5ba1403mr2165256ybi.6.1709213686916; Thu, 29 Feb
 2024 05:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <20240131055740.2579-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055740.2579-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:34:35 +0100
Message-ID: <CACRpkdZ_XUmW__y=8R3aJkci+h-pHRh8-xH7ZmfRyQ=jjCbajw@mail.gmail.com>
Subject: Re: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead
 of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:27=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> Apply the page shift to PFN to get physical address for final VA.
> The macro __va should take physical address instead of PFN as input.
>
> Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlin=
es")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

My bug, obviously. :(
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I thought this was already applied with the other fixes, but maybe it
was missed?

Yours,
Linus Walleij

