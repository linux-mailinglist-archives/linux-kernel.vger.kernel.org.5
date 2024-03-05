Return-Path: <linux-kernel+bounces-92304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24F871E24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A2B285119
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A25813A;
	Tue,  5 Mar 2024 11:41:30 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363B29CE9;
	Tue,  5 Mar 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638890; cv=none; b=CrB9zHIEk4lV5712Q85AHhMpJFo18O30S2b5jbiCm/PiZzoTA15/P1TKqC0mfqxpdNp/tPTc6f2nsYMlUWuaPK7c+lOiCyll8Dn9AwhK0Ix3qCd8rRql/+bMNWFordi661KwPEhUi/qRDSb7N7n1m2nHwcQc9m5KcGkDQQc/CqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638890; c=relaxed/simple;
	bh=tQtogeCkIHDDEnVG1cGYdwDp0nwyyUrX6V4UtNFlljQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu8H5Xj9Tm3uzt6x2H/gh7+T5phvegR6TQOyv8nTOawwfrdFd7Kc9rEZdwsenk/SIHHpIaTB5e96+z0mXckZc7nFV7Wg6SCI/ESagwBVjIFiTzQeyQWbRFghX8Qa19lkx2OtPxIo6jm+Epef9Q2metJmLd2EvDwkiUcsjgKeZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a1358e7e16so546546eaf.0;
        Tue, 05 Mar 2024 03:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638888; x=1710243688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0v7RjgmO/yDuWlF3/kTo+sHgoivtGNOWfDVn+nq/Ik=;
        b=ZRvN+1LQyPgl/8G8Kuj1r/r2YNcHSJhcB0y5tLWTB3iuTSAd28FpmBSijRbnE0OyBb
         9xn6QZUChw/uFHgIBT76FC7P/JXVasxJEsd35XYibMCywksjuZQZOg87MLanWr3uB78o
         bYUU8VAzLK/HIk8+j+Q9tTkWzDB94Rz/lhfm1CZsKfJbYTyDjkUavsKRCSuL8ntx1DRV
         nq3XqzNedeKfIgdHpQs3is3C6NeFPaV41osKNdBPd63UUlXc2VQcRBYciVqpfQB4WTdm
         oChirUimjYkYTC4//wCifazBzMx/tgUx/ljJdkN1SAevGcOPRBHXh8k00GrNCqjCN9ey
         p6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXKPeG4ejE+i0QV48l/dy2iDLUuQf1SJKjTl9uEVEX6IoY4mM3XiEadKOlklWni4YCYPdHstfrwHDWEwiMDYeTDYhuCNz9aOXqHDtv1qrIeqce4H5BfKXl9V9XWvKbqEzf9472CdB4=
X-Gm-Message-State: AOJu0YyHxC+xvHeWchKMx+HnOlQWVyMpcs4V/HfaN+UbhiWApTbxYAgv
	4ISJJd+ky3YjdIP4qcnlTuwfA9MIQiyCBr7QYUWhDzX1TFDulVOcnYl8cLAZBfEBj+rQVAnXmZI
	e0tQ7j65yx0GPWgeM5FIGH2Wn2+4=
X-Google-Smtp-Source: AGHT+IHF4dBKyk4hRdjM6vf7T079M6yi9lKk8JmaNs0S9UveuRzmmaiok7o5fr454KPibdMqlJlfLpZYpB8AMdLmm0k=
X-Received: by 2002:a4a:d4d4:0:b0:5a1:31a1:7f75 with SMTP id
 r20-20020a4ad4d4000000b005a131a17f75mr154574oos.1.1709638888053; Tue, 05 Mar
 2024 03:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301092657.15528-1-qingliang.li@mediatek.com> <ZeXmcl4ngEm1RccW@hovoldconsulting.com>
In-Reply-To: <ZeXmcl4ngEm1RccW@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 12:41:16 +0100
Message-ID: <CAJZ5v0ifq_ZsrQnq3b4LSUJxAVMO55=m7tL+L3nNP7ixBb9yHA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: wakeirq: fix wake irq warning in system suspend
To: Johan Hovold <johan@kernel.org>, Qingliang Li <qingliang.li@mediatek.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:19=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Fri, Mar 01, 2024 at 05:26:57PM +0800, Qingliang Li wrote:
> > When driver uses pm_runtime_force_suspend() as the system suspend callb=
ack
> > function and registers the wake irq with reverse enable ordering, the w=
ake
> > irq will be re-enabled when entering system suspend, triggering an
> > 'Unbalanced enable for IRQ xxx' warning. In this scenario, the call
> > sequence during system suspend is as follows:
> >   suspend_devices_and_enter()
> >     -> dpm_suspend_start()
> >       -> dpm_run_callback()
> >         -> pm_runtime_force_suspend()
> >           -> dev_pm_enable_wake_irq_check()
> >           -> dev_pm_enable_wake_irq_complete()
> >
> >     -> suspend_enter()
> >       -> dpm_suspend_noirq()
> >         -> device_wakeup_arm_wake_irqs()
> >           -> dev_pm_arm_wake_irq()
> >
> > To fix this issue, complete the setting of WAKE_IRQ_DEDICATED_ENABLED f=
lag
> > in dev_pm_enable_wake_irq_complete() to avoid redundant irq enablement.
> >
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>
>
> Thanks for the fix. Looks correct to me:
>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>
> I think you should add back the Fixes tag from v1 and CC stable as well:
>
> Fixes: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
> Cc: stable@vger.kernel.org      # 5.16
>
> Note that WAKE_IRQ_DEDICATED_REVERSE was added in 5.16 by commit
> 259714100d98 ("PM / wakeirq: support enabling wake-up irq after
> runtime_suspend called") so no need to try to backport any further than
> that.

Applied as 6.9 material, tags added as suggested above.

Thanks!

