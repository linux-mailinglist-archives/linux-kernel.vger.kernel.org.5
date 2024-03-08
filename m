Return-Path: <linux-kernel+bounces-97653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A7876D20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B54DB20FDB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB92C6B6;
	Fri,  8 Mar 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMXM/1Z4"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BF1DA4D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937012; cv=none; b=FWmB+XsNmzHSbDRnUrNDnoxBOwNvX8P24MXafw7rYMKnNFQdtGAklgpbz793sK9vSY7ZNJBOauxqyO/DzvRwIJYPy5dZC48/IFskwGDYUJYtvns2b6vO3LQbxdEJwuQ8flLDYZBvYPqUD6BQqLfxQkRNiUx9ImaOq9hOk8ffxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937012; c=relaxed/simple;
	bh=9Yb0tKGCphHgv9gug9eNGiabFxNTTgVWrqYM7xEelTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAaNoDCxxszrWXSfSd2lAEXtuQLz6iem/H/S3KIXx60Llq/NWulO8hicO9gQVH8GCX0hZ0s89dAoffkqPi+86ZYOoUImddYugjaky9KdODBosHFgi6LUgaR7bKtss+HxqECHlUfuUmeOXaS5F6GlqXOYADCrjAsAXhbpaxxc//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMXM/1Z4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso1356a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937009; x=1710541809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw6aI2U8iMgTI80Vy6Cngmp1NxQFU6KchYrZWU57JZc=;
        b=RMXM/1Z4z5WvK1JBUjmaCvSsev/xeWI2Y2teE4rFz/rEKRW/r0YFPSBW/aXBucH1cE
         iFyEb7Fssk+641d7jiffEHsZHdtPdTxeMYoClieH1WxNhendz8/UdDxR9+sHGXd98Vvf
         50wvLL9xNv39nBbwDUtJvKTELb9xhh0/mht+xFdSTlxyBdCkDWoDVq1/95a7XNZx2sAx
         Kqy8LeV1GBxOUM7VLT4Ge7bbTh630AdGFxkkPszwHftl/XUiJDJCMX49j1F+O9X/QVp1
         NBrx+SHZG9Tvmr1PXDhzr2399poNHtiwX1mym+Epe7qQhbrBT/iJ8ohO/Qem4wbD0PbI
         JTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937009; x=1710541809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw6aI2U8iMgTI80Vy6Cngmp1NxQFU6KchYrZWU57JZc=;
        b=sCZRyZNIPEycC79joedsjOkwMeCoTVOiIX0yyT3r+2T9i05z+yRkFgMQSZF/sPDfzx
         52LDIhynuCGT7kJIFJXZvNZ7aO06OAk8PMbX3MmOGHI2BjLN8N9ytyeZOsXOqcgmB6k5
         aR+tGsC1hlcAuPx7bsabePo9K3g70DpoWuGf10zx5KQ3uJD3V4zeBPmpMbrqAjktJ9IZ
         hDYvleAicoEvIYGv7ZXQhNgKecMYGooZAdwY2xh1qJcXaSkieYTU4O9sBjM27xjrktLs
         NfGPWxNp6PtBcfYprswLzIJdXTveio+mOYZvEJVu9z0waxyfO8R+tE+scbDcnpwytviC
         IYSA==
X-Forwarded-Encrypted: i=1; AJvYcCW7nVdR9MWSiiszn+H9mFKMnj9BakwkbdDC6TONyvnTzJnpweuOYq9S05NxavhFhruOAj94IHm9Ygen7YfyFRVWCRIp2jDjBp+Qwe6f
X-Gm-Message-State: AOJu0YwpLI1uNbdScYlTcr4qxgpJ2b7hPOMmXJXPc110ODw39cAqKv5R
	+72X71d83N4ZOCbQ5xzx4aTg9c8CQOljgRxZIuofFfAJVr94N+7LbJqsxAxoymvhjiozfmm6Bbj
	6PqU5exN7U/4syy1bmiGZu9CibdvA8wKo0FqL
X-Google-Smtp-Source: AGHT+IHV6AhGANFiDyy15Fvo+rk4aBbO1T6U/3zon3JNMNdRpPazffwprxZD+YxrWfXDE4hr5wZomo/QG8sng4bDeRU=
X-Received: by 2002:a05:6402:190d:b0:567:6314:c894 with SMTP id
 e13-20020a056402190d00b005676314c894mr721781edz.2.1709937008675; Fri, 08 Mar
 2024 14:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307111036.225007-1-herve.codina@bootlin.com> <20240308200548.GA1189199-robh@kernel.org>
In-Reply-To: <20240308200548.GA1189199-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 8 Mar 2024 14:29:28 -0800
Message-ID: <CAGETcx8ReCH2z64_PGhmbqdH_ge3B_xOqTOP-yanRf3T8TkzLg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Synchronize DT overlay removal with devlink removals
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:05=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Mar 07, 2024 at 12:09:59PM +0100, Herve Codina wrote:
> > Hi,
> >
> > In the following sequence:
> >   of_platform_depopulate(); /* Remove devices from a DT overlay node */
> >   of_overlay_remove(); /* Remove the DT overlay node itself */
> >
> > Some warnings are raised by __of_changeset_entry_destroy() which  was
> > called from of_overlay_remove():
> >   ERROR: memory leak, expected refcount 1 instead of 2 ...
> >
> > The issue is that, during the device devlink removals triggered from th=
e
> > of_platform_depopulate(), jobs are put in a workqueue.
> > These jobs drop the reference to the devices. When a device is no more
> > referenced (refcount =3D=3D 0), it is released and the reference to its
> > of_node is dropped by a call to of_node_put().
> > These operations are fully correct except that, because of the
> > workqueue, they are done asynchronously with respect to function calls.
> >
> > In the sequence provided, the jobs are run too late, after the call to
> > __of_changeset_entry_destroy() and so a missing of_node_put() call is
> > detected by __of_changeset_entry_destroy().
> >
> > This series fixes this issue introducing device_link_wait_removal() in
> > order to wait for the end of jobs execution (patch 1) and using this
> > function to synchronize the overlay removal with the end of jobs
> > execution (patch 2).
> >
> > Compared to the previous iteration:
> >   https://lore.kernel.org/linux-kernel/20240306085007.169771-1-herve.co=
dina@bootlin.com/
> > this v5 series:
> > - Remove a 'Fixes' tag
> > - Update a comment
> > - Add 'Tested-by' and ''Reviewed-by' tags
> >
> > This series handles cases reported by Luca [1] and Nuno [2].
> >   [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
> >   [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v=
2-2-5344f8c79d57@analog.com/
> >
> > Best regards,
> > Herv=C3=A9
> >
> > Changes v4 -> v5
> >   - Patch 1
> >     Remove the 'Fixes' tag
> >     Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
> >     Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'
> >
> >   - Patch 2
> >     Update comment as suggested
> >     Add 'Reviewed-by: Saravana Kannan <saravanak@google.com>'
> >     Add 'Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>'
> >     Add 'Reviewed-by: Nuno Sa <nuno.sa@analog.com>'
> >
> > Changes v3 -> v4
> >   - Patch 1
> >     Uses flush_workqueue() instead of drain_workqueue().
> >
> >   - Patch 2
> >     Remove unlock/re-lock when calling device_link_wait_removal()
> >     Move device_link_wait_removal() call to of_changeset_destroy()
> >     Update commit log
> >
> > Changes v2 -> v3
> >   - Patch 1
> >     No changes
> >
> >   - Patch 2
> >     Add missing device.h
> >
> > Changes v1 -> v2
> >   - Patch 1
> >     Rename the workqueue to 'device_link_wq'
> >     Add 'Fixes' tag and Cc stable
> >
> >   - Patch 2
> >     Add device.h inclusion.
> >     Call device_link_wait_removal() later in the overlay removal
> >     sequence (i.e. in free_overlay_changeset() function).
> >     Drop of_mutex lock while calling device_link_wait_removal().
> >     Add       'Fixes' tag and Cc stable
> >
> > Herve Codina (2):
> >   driver core: Introduce device_link_wait_removal()
> >   of: dynamic: Synchronize of_changeset_destroy() with the devlink
> >     removals
> >
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  drivers/of/dynamic.c   | 12 ++++++++++++
> >  include/linux/device.h |  1 +
> >  3 files changed, 36 insertions(+), 3 deletions(-)
>
> This looks good to me. I can take this given the user is DT. Looking for
> a R-by from Saravana and Ack from Greg. A R-by from Rafael would be
> great too.

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

