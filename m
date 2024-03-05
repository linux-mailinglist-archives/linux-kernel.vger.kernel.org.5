Return-Path: <linux-kernel+bounces-91730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5D8715BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FCD1F21DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B526167A;
	Tue,  5 Mar 2024 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQARZ+fH"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227129437
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619491; cv=none; b=H4qhJxOYtUlDuTA5sNsoUDHklo05FFNwMcUPvjRG4L89KoOjrmsozEO34ze1r3ukdWlHiTqKqjqrfFHoV3I9NWcx7Oluw9LGJDRcKG2hkf7GhtJgyLJuE0yn+DFssoBZVXP/IAALgdaad8kXdtJYy+IhpGbjJyDl1yalq7r5dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619491; c=relaxed/simple;
	bh=5qYZ10DvM+5Hlz3LeLO00gLsDU/hwoXgt/RAltDcgpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOiiOqVM++srsDdgiNPPzYEaZFakQmEvCyVNCs8tdzbA5gUi9vP2D/F/0yx5Ugt+SxGlZ8MC9oVe1yGnEQEpVYKWznhyuS8hUWaHufZcNMC+YJseV3N1BHfNZIyMciijGeMlWnmC8kcStr30aQcSX0uj8EJR/Cf814o6YacWNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQARZ+fH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42f024b809cso50741cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709619489; x=1710224289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVjS40y9spM7MIt45tR4JQlRfFsmYBO+5d1kSRBBPBU=;
        b=wQARZ+fH14Yv8yohWglBkUCDGbQQEjsJ+pstdNZGwV8l3Dq6cvblt8tJezjg0mQyQP
         EhUPtpNcClPweIb6OhHE6PCgQb/3jDZjNYOsARPdhStLZFnC4nHkTbHdFGkS3CcUisas
         HCYPN1DTY3il42MXn9evFQmqeCuvROBPd/Aysjezkj8JL5LaOn34UVwSaMFNnIkOKytR
         Y5JYlR0YS7aA1BL8v4PnJTGIrkDDijs3N0I+NpENCWXIF0El2fNR3zvoZszqJNOujeZ+
         DgdgQ03ZrW9FKe5CuTVu5Y6NoNjsM50tRe8nq9ErqLVfxpSdsctl6Bhc5WOrjikLr3yB
         ksPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709619489; x=1710224289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVjS40y9spM7MIt45tR4JQlRfFsmYBO+5d1kSRBBPBU=;
        b=LWXTOWUVzZjXcj2ooXbZLGoM14VzGOopWi/uoiL2lwSryLZYJTm0HukPtx0NTCrLMb
         bhDV36VlY5Q0F5zVZm7C1Mz/YyXtnQ37W8UGebL1UJbrrHdeUvjmN1odDs1DCUaRp8tQ
         IuHN06cIImpxfjWQeNZynfS5DL7uxWp+bxRP0hbtanlvVRTVZiSVuiF5Bi2KpcIMXFDI
         uWSe01QosA04INdDIOIkewS5ML0jGgyNxl8VTtKyeBdwjTQOI2QE4vrNMX96GoZv+MJ3
         73vbODqcYb/RewGKEPPEF+9aoYUIM2StOTd40W5LcJCIX9g3LNi9R08J+i6iorCqXNgj
         upYg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgHsza+aEUKdhIffUMUlJgvNNVFe5fXX9BbNyiDYS5fwo3qkX+mkOF2R+ldcx0Py0Q66Txb72DlHOJMoSHc+FoqLuQP4cZxTNdYg3
X-Gm-Message-State: AOJu0YzeDt+aIhr/I2ld78I/TXrNn1s0Pk+KO78z4Do3Zn2fvd/kiY7F
	c8VCUnzwDi5nl43gM1JrV7GTPW8XBZOL5BBOmK0RiBW2R8vAwaVZcHR+sXtR9EHpydhXDZO+T1j
	+zXPkRHMTvWqiWZIF4DkXJwFRaBGvqvi49FQH
X-Google-Smtp-Source: AGHT+IFzqDdVvEEimN/5SXvHqPdktHEmah8wXgWqyto8zJ52zQQCbxrT1IudmHjpj2RhuMuov5fqSECKmFHTdNLDO0k=
X-Received: by 2002:ac8:7d41:0:b0:42e:cd1b:2421 with SMTP id
 h1-20020ac87d41000000b0042ecd1b2421mr117429qtb.2.1709619488625; Mon, 04 Mar
 2024 22:18:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229105204.720717-1-herve.codina@bootlin.com> <20240304150248.GA211460-robh@kernel.org>
In-Reply-To: <20240304150248.GA211460-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 4 Mar 2024 22:17:29 -0800
Message-ID: <CAGETcx96Nj1RnR2wFOZYJRr=kyBLkcobY0crxBFSLGWmNaXT4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Synchronize DT overlay removal with devlink removals
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

On Mon, Mar 4, 2024 at 7:02=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 29, 2024 at 11:52:01AM +0100, Herve Codina wrote:
> > Hi,
>
> Please CC Saravana on this.

Nuno, this is why I was replying to the older series. I didn't even
get this one.

>
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
> >   https://lore.kernel.org/linux-kernel/20231130174126.688486-1-herve.co=
dina@bootlin.com/
> > this v3 series:
> > - add the missing device.h
> >
> > This series handles cases reported by Luca [1] and Nuno [2].
> >   [1]: https://lore.kernel.org/all/20231220181627.341e8789@booty/
> >   [2]: https://lore.kernel.org/all/20240205-fix-device-links-overlays-v=
2-2-5344f8c79d57@analog.com/
> >
> > Best regards,
> > Herv=C3=A9
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
> >   of: overlay: Synchronize of_overlay_remove() with the devlink removal=
s
> >
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  drivers/of/overlay.c   | 10 +++++++++-
> >  include/linux/device.h |  1 +
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > --
> > 2.43.0
> >

