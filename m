Return-Path: <linux-kernel+bounces-16671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745E582422A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC9F1F21507
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA982231B;
	Thu,  4 Jan 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFf1h/U2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F612230B;
	Thu,  4 Jan 2024 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7815c5b69e1so29377185a.1;
        Thu, 04 Jan 2024 05:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704373301; x=1704978101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T58SQKnZ9f/XAhQbGGB3bCkUckh7sbRsHba15J+0qeE=;
        b=eFf1h/U2AiR6u549cfIt5SUeQ24WfroIj4rJ25GxCcSXMnFL6+Idh4Gd6PmN5ErKa+
         TNLKGIPyaSmxp0s1YCJ3Me73o3tKbeelr4jtstI2wWiddkOCuLQAfYkTMax5/I3qhoXq
         Pk1dd5MALIRGA027Pw1icJ24l7WF+o6OGij3KGiXptKyBdcugAS7Gf0EjCYSuaHcvdRw
         15NxvHiDLs/8mYosjLpDUbMW+vLxbexO+U61VcwTqOzWeQkqDSTNmUBXXC5ehesaYDac
         tgT97CPEI+IIqSx/BNN6NFR2sf06qD/KCa57xdQUn/L2KLYPBI656qodLsZCmDwEonyu
         8BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373301; x=1704978101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T58SQKnZ9f/XAhQbGGB3bCkUckh7sbRsHba15J+0qeE=;
        b=DatJ6HQ9Eq31BBtimJXaVPPKHaMfKLVu358xicSSKu+87gie+SI2itm9+bdrhP96xd
         ejeDw6SBaw3ML8cgPtJXTH487NcVAaKefJ1uh6tRbB4HOpb4GIK4T3jO6noLS57jZUs/
         qUX/X2SVwieWL69bty6O3sipcZUm7Ph6HrGgY+4JyVCx7Bn+xzMtavwqMU3+GSkTg2GC
         LA6FLVQ5iivHyjA7FwPWxoaSfXQSyRxa3unieQhTWptRUttvMc0hwO8qtC1tOOwJICxY
         yAeu0VtrpLCQSHQNeoMU1oPLKiVVQcVTyzNHxKGn3nL5OzlH1Hw8ywdI2be1PXoRreCU
         VKVw==
X-Gm-Message-State: AOJu0YwLi/0xLkC/+7kiaeXhBvzf0uHSDuqsb+9J0hNcO01XgtwcJc7u
	89nG1bwHncHPd3LrG73t18hE2HwTDVTvGMuWy68=
X-Google-Smtp-Source: AGHT+IFcDZI9hrCkMltXk9QWR9FnqhH+RH0B1LwJDugeCrbUY7Qgi2qlTd+dNkV+hbw7m7RwWabWZ2FnZohJHiUE88c=
X-Received: by 2002:a05:6214:c64:b0:680:8373:4932 with SMTP id
 t4-20020a0562140c6400b0068083734932mr552788qvj.69.1704373301098; Thu, 04 Jan
 2024 05:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-4-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240104024244.12163-4-Wenhua.Lin@unisoc.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Jan 2024 15:01:05 +0200
Message-ID: <CAHp75VcUU-FUYJKN40dzMbe5KmmAR7--0JV00qdgnbNwHqFjQg@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] gpio: eic-sprd: Modify the calculation method of
 eic number
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wenhua lin <wenhua.lin1994@gmail.com>, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:43=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com> w=
rote:
>
> When the soc changes, the corresponding gpio-eic-sprd.c

SoC

> code needs to be modified, and the corresponding
> Document must also be modified, which is quite troublesome.
> To avoid modifying the driver file, the number of eics
> is automatically calculated by matching dts nodes.

--=20
With Best Regards,
Andy Shevchenko

