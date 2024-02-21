Return-Path: <linux-kernel+bounces-73857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD8785CCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EAC1F248AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBDC1FBF;
	Wed, 21 Feb 2024 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbe9sLT6"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF87386
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474800; cv=none; b=E4MeWeOf3h+91S2fht7RjQccoT726KXDB+ScUprohJLRwZCt1HmqCK7P456ZpjTF4VyDWIkb+fKTffpsxBRnQXrrWmVOCuywx5q6+JeNuUuB4TP337a6OMiJu3+pVMvzf1Qr7ianlMrA6oxOIYueZvtLRKV3q3U/zAEI7CI2BNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474800; c=relaxed/simple;
	bh=3OGmQp9jl/lZp1xDC/yACtLHUmqxrcuBnE1lkKvfFjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYnDQGsH7Qr3bLUQ+3PhbhcI8ka+Vu5XmFB8FkyL9MIf50xC1XfEv7IWlGb2Ad7LVUge8I7vP/GsjIxm6W+c+lbHMxP330D6pvgJczUyN0kf/ZENGcK0VLtUFOtn3svFOCJ5z+bJNv5CcHSFji62yg1R4kx56YZZz9jRayA5eO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbe9sLT6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so77981cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708474797; x=1709079597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/TQWtFPNQYwuUbM58vJfJouHPDo5TFgHn3V4mtboY0=;
        b=cbe9sLT6NBJ53qnrkItt+QfhMVdbzUzxbsjZGYYta/jIRaVA3Xk8RT4cT8e8dDjCbH
         0gwgLbIxQmRTppKGo+kKLZP3UbS2yHLox8LXJLN6he6yzFGFEA3jP1X2ykWNMkfOXgMu
         +VQJduYJ6FtTrdXn2s3G1suduUjpwyaP1qzIOQMZckXaVJw/i1Izew7CvpVdgL6yW6fr
         4BGslG7cGIo8+tC21MdK6F5wEcY629fFiIO7K4yCjO6eDFWoCxcBgzKLxW6jaLHnSIkx
         8+l2pvySGCy9FTu8g4nfBPniqnhE74DhYPNMH1BXSIohvs2UsPVLGLI34AT1SgULfbwD
         wJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474797; x=1709079597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/TQWtFPNQYwuUbM58vJfJouHPDo5TFgHn3V4mtboY0=;
        b=gVje25sjcuAYX/HGu6xfqDNsQYC7lW7tFaHar0Swmu87s70a7S1CqknDIe7l2ar9ka
         iC/jlmbNT/VMhgrxFi/qo3+JGqwRfdshAqQN/Naq9eWOQK7Xrm+9Hz7UhdWavEcMZrxA
         zrN8txJtL1CyStS62GGXf6FOM1jsD16pJ3OIzvjqGBZQD1bE2VozrTXqZRg7UsjEQQX5
         Qt4GjIrrYNQT9Y/lH1+AxGKAlPg2F2naPDqUJG5a6m8qNPgVWkNh/v+IdKzYmS/c6DjM
         KI/LoAl8q9TxK4U4HR2v/eFKxdQqHqzDXyi68BnHEv9VfjpwfzcnoDXsT8QupMcb7TzZ
         gjtA==
X-Forwarded-Encrypted: i=1; AJvYcCUt7UH5qgN6mjZT1HMQrRq3/LoyIQKslITLWzf2ooY3xddtBHbaXpA69w5Ztxqi3vao1ZwMAcCCgrkQuR4D6wLKILKkjyF97c6uNHPS
X-Gm-Message-State: AOJu0Yw+Jsii4IrvPetV9HuhatfVNGF2g0nyJGefkB1ajvcClICew2E8
	LGoiazaoEL6owH1WeTE9XtYUGotmGgKUrwP7OvJ02JmptOw4PzWprHUHJ7Z4/1RXmiPcf2lwjzk
	X86v0wIsg4QKWktZJFsiaEEbiduLXuHSkmDS1
X-Google-Smtp-Source: AGHT+IGRjMhTXMToPyT3CZJgKg9Mvn8SxquIAjAE3c8fR0p9QQqaZPhqkxRsGlOQtFhZiP7wJlLX+Njjx899K6P22Wc=
X-Received: by 2002:ac8:6ed1:0:b0:42c:5fd3:dc85 with SMTP id
 f17-20020ac86ed1000000b0042c5fd3dc85mr43812qtv.7.1708474797183; Tue, 20 Feb
 2024 16:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130174126.688486-1-herve.codina@bootlin.com>
 <20231206171540.GA2697853-robh@kernel.org> <CAGETcx-F8G3dcN-VTMrbya_=19zXP=S2ORA_qZqy+yND7S41_Q@mail.gmail.com>
In-Reply-To: <CAGETcx-F8G3dcN-VTMrbya_=19zXP=S2ORA_qZqy+yND7S41_Q@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 16:19:21 -0800
Message-ID: <CAGETcx_Lv3EW+Mz94LJqzh1QW+NVmxrw6_HS3vYU6K5t8fci-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Synchronize DT overlay removal with devlink removals
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 7:09=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Wed, Dec 6, 2023 at 9:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Thu, Nov 30, 2023 at 06:41:07PM +0100, Herve Codina wrote:
> > > Hi,
> >
> > +Saravana for comment
>
> I'll respond to this within a week -- very swamped at the moment. The
> main thing I want to make sure is that we don't cause an indirect
> deadlock with this wait(). I'll go back and look at why we added the
> work queue and then check for device/devlink locking issues.
>

Sorry about the long delay, but I finally got back to this because
Nuno nudged me to review a similar patch they sent. I'll leave some
easy to address comments in the patches.

-Saravana

> -Saravana
>
> >
> > Looks okay to me though.
> >
> > >
> > > In the following sequence:
> > >   of_platform_depopulate(); /* Remove devices from a DT overlay node =
*/
> > >   of_overlay_remove(); /* Remove the DT overlay node itself */
> > >
> > > Some warnings are raised by __of_changeset_entry_destroy() which  was
> > > called from of_overlay_remove():
> > >   ERROR: memory leak, expected refcount 1 instead of 2 ...
> > >
> > > The issue is that, during the device devlink removals triggered from =
the
> > > of_platform_depopulate(), jobs are put in a workqueue.
> > > These jobs drop the reference to the devices. When a device is no mor=
e
> > > referenced (refcount =3D=3D 0), it is released and the reference to i=
ts
> > > of_node is dropped by a call to of_node_put().
> > > These operations are fully correct except that, because of the
> > > workqueue, they are done asynchronously with respect to function call=
s.
> > >
> > > In the sequence provided, the jobs are run too late, after the call t=
o
> > > __of_changeset_entry_destroy() and so a missing of_node_put() call is
> > > detected by __of_changeset_entry_destroy().
> > >
> > > This series fixes this issue introducing device_link_wait_removal() i=
n
> > > order to wait for the end of jobs execution (patch 1) and using this
> > > function to synchronize the overlay removal with the end of jobs
> > > execution (patch 2).
> > >
> > > Best regards,
> > > Herv=C3=A9
> > >
> > > Herve Codina (2):
> > >   driver core: Introduce device_link_wait_removal()
> > >   of: overlay: Synchronize of_overlay_remove() with the devlink remov=
als
> > >
> > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > >  drivers/of/overlay.c   |  6 ++++++
> > >  include/linux/device.h |  1 +
> > >  3 files changed, 30 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.42.0
> > >

