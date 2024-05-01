Return-Path: <linux-kernel+bounces-165573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8912D8B8E24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80398B21E03
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549212EBDD;
	Wed,  1 May 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4SUjDQQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E153368
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580717; cv=none; b=L8difLQRqrnsNrTpZQkeSUHlCUMSAJ8jxuknxiGM77xT0LfTsnt4yZYXhY8x+nrNcgXVdZ3b/sB3UUdtn1Sd5EkFNxgZ7mDejpr8/EKkT1QSTySb3RL+aiWNkIfyU1tWJYoymMk40t9ZBZIZvgsZG4XAxYQsXPAF7q0ACDwYPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580717; c=relaxed/simple;
	bh=xySl/6F9vmkkhJQOdNpW29G3nuG6LlVuR3geVfumGtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXaCeOrE3ExIHoUiaRd1qm8cGHHItyKYF6+fP/BPpEWRrSXdhcK3exENtEXj/VRcUe0Ezhupx8fRWC5BVw1wrxIhlVqc7FOWPyK25DU3LGJ++VDWan6NbdgTwXmMlK1VkvK51tijiKxmjiEQu4SSj8RcsLFNzKDaBUcJ5AF8V/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4SUjDQQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso8942619a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580714; x=1715185514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COCr1HZXX3kSa0Jzy9WUYGzTa3Y1xgy+oEKZSE+DBck=;
        b=R4SUjDQQd9iKpTh70xfHmrEnEsyg9HX0mxV9vDcEJDd1ZHvWs5aTgqR+DhclPpXXQK
         faItqy3aUscaCgOkEwWCDzdyxobJRoJORntjZTbEs3HXZZ4HNJhksalKz/w4ZtTo1TOb
         3nTHYKEHNa1DVEwq+WCk7Qnx8a1JCTHCntUK6ylpPEBBO6lWMY2dz8KS5geXF3N3O4xs
         cA6hPnAW7zrSTlnu5HRiinJTcOAIm9esRNyotH9VRk7tcnnr6qcRHIef8n9JW8oVhs6/
         s+WIiZBDALXdej7r87tt4iWy838n4Zx8gPIeIef4myIhZ96TNSqJ4nWKvJGjG0jwuwgw
         +mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580714; x=1715185514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COCr1HZXX3kSa0Jzy9WUYGzTa3Y1xgy+oEKZSE+DBck=;
        b=QyEKtWlId3h6k+vZHPQcnGC1P2PS3KLXMilJhBt8T1kMwSBBAtALFg6CvPKUv6L+PC
         QdVDC8AukPDjEKrF+tpOO7XO9Naft0ZFdRv5fedIoFtquxWY/c7JYZwc0+QCTDIX2cUm
         VI1RbjfL63E+knu4JwE1qMqwsHN+pxTROCf9D/DuJFwydskseWN7sqeKk601XyWLR/la
         JSEvI4UfpCbsyrcKzWkhQtenIxN9F6NwQpga5QrpIUm+HGu3Vc4t/dsqqM2MUp21lnI1
         s30l81Rh5mr6HWd88f7wXsE6A5X6/3caV0COpG9ENzHUS/jAc1+oFVhhRmz+iQvJ8Wg6
         DYhA==
X-Forwarded-Encrypted: i=1; AJvYcCWnT8TrTMgP8EMYvHCTOLDRm/dejXrMxmGDHPuwQCs9+f33pZHjhofGKCPshquXBYX6XWjdJZp6zUkkE3Jxr2XXaWhUrW5omIt0dRM1
X-Gm-Message-State: AOJu0Yxx7DmwmZnIcuiakNOPYlJ6CvxcA543XRDbQtWDPjjiAxfQnB2m
	bAyl/nUwflP3IfEvobP9HL5LXqWhj8txPHK45JAeUr/gtKYVztR32RUPZto2vm2t4GhlBIgVR1O
	sEhWIx8v1RjukEIgfFsAkK8Ldebk=
X-Google-Smtp-Source: AGHT+IF2cgfsPWgItDdfkCHalMNy+rDasqFxBWcG1EMNrynJTd2kzukgSy2OtomraFpOHYINK5DJTXhaAK1KNvnYJL8=
X-Received: by 2002:a50:8adb:0:b0:572:42ac:9b19 with SMTP id
 k27-20020a508adb000000b0057242ac9b19mr2489848edk.0.1714580713745; Wed, 01 May
 2024 09:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403182951.724488-1-adrian.larumbe@collabora.com>
 <CAF6AEGsWtJs2xcZx59P9_maxn1RqCO6-4GwEp2fL31bZtTyuoA@mail.gmail.com>
 <e6500d5b-0151-4c31-9032-3a23157b3126@ursulin.net> <4btlparspmb47v3nq3mip6cjr2adwejepnglvh6q5nlbmdzwvt@74gg6tjpngbv>
 <54ebd0a0-dc9d-43d7-b530-065832cda160@ursulin.net> <zz7tsf5ozqh24br7qgnslwmhgtgazeceif6ih22rjkl3bjfws4@u5bvmdjddzj6>
In-Reply-To: <zz7tsf5ozqh24br7qgnslwmhgtgazeceif6ih22rjkl3bjfws4@u5bvmdjddzj6>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 1 May 2024 09:25:01 -0700
Message-ID: <CAF6AEGu84At4V2GZvouOXkAKiKpA9jfxMtgxg=3hEai1iAqv+A@mail.gmail.com>
Subject: Re: [PATCH] drm/sysfs: Add drm class-wide attribute to get active
 device clients
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, kernel@collabora.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Christopher Healy <healych@amazon.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 9:19=E2=80=AFAM Lucas De Marchi <lucas.demarchi@inte=
l.com> wrote:
>
> On Wed, May 01, 2024 at 04:58:05PM GMT, Tvrtko Ursulin wrote:
> >
> >Hi,
> >
> >On 24/04/2024 15:48, Adri=C3=A1n Larumbe wrote:
> >>Hi Tvrtko,
> >>
> >>On 15.04.2024 13:50, Tvrtko Ursulin wrote:
> >>>
> >>>On 05/04/2024 18:59, Rob Clark wrote:
> >>>>On Wed, Apr 3, 2024 at 11:37=E2=80=AFAM Adri=C3=A1n Larumbe
> >>>><adrian.larumbe@collabora.com> wrote:
> >>>>>
> >>>>>Up to this day, all fdinfo-based GPU profilers must traverse the ent=
ire
> >>>>>/proc directory structure to find open DRM clients with fdinfo file
> >>>>>descriptors. This is inefficient and time-consuming.
> >>>>>
> >>>>>This patch adds a new device class attribute that will install a sys=
fs file
> >>>>>per DRM device, which can be queried by profilers to get a list of P=
IDs for
> >>>>>their open clients. This file isn't human-readable, and it's meant t=
o be
> >>>>>queried only by GPU profilers like gputop and nvtop.
> >>>>>
> >>>>>Cc: Boris Brezillon <boris.brezillon@collabora.com>
> >>>>>Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> >>>>>Cc: Christopher Healy <healych@amazon.com>
> >>>>>Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> >>>>
> >>>>It does seem like a good idea.. idk if there is some precedent to
> >>>>prefer binary vs ascii in sysfs, but having a way to avoid walking
> >>>>_all_ processes is a good idea.
> >>>
> >>>I naturally second that it is a needed feature, but I do not think bin=
ary
> >>>format is justified. AFAIR it should be used for things like hw/fw
> >>>standardised tables or firmware images, not when exporting a simple li=
st of
> >>>PIDs. It also precludes easy shell/script access and the benefit of av=
oiding
> >>>parsing a short list is I suspect completely dwarfed by needing to par=
se all
> >>>the related fdinfo etc.
> >>
> >>I'd rather keep it as a binary file for the sake of easily parsing the =
number
> >>list on the client side, in gputop or nvtop. For textual access, there'=
s already
> >>a debugfs file that presents the same information, so I thought it was =
best not
> >>to duplicate that functionality and restrict sysfs to serving the very =
specific
> >>use case of UM profilers having to access the DRM client list.
> >>
> >>I should mention I did something controversial here, which is a semanti=
cally
> >>binary attribute through the regular attribute interface. I guess if I =
keep it
> >>as a binary attribute in the end, I should switch over to the binary at=
tribute
> >>API.
> >>
> >>Another reason why I implemented it as a binary file is that we can onl=
y send
> >>back at most a whole page. If a PID takes 4 bytes, that's usually 1024 =
clients
> >>at most, which is probably enough for any UM profiler, but will decreas=
e even
> >>more if we turn it into an ASCII readable file.
> >
> >I'm afraid I still think there is no reason for a binary file, even
> >less so artificially limited to 1024 clients. Any consumer will have
> >to parse text fdinfo so a binary list of pids is not adding any real
> >cost.
>
> yeah, I don't really understand why you'd want the binary number that
> you'd then have to turn into a string to open the /proc/<pid>/. To me it
> sounds more like we want a text output and that output to be:
>
> <pid>/fdinfo/<fd>
>
> So gputop could just read this file to know where the info is.
> Too bad we can't symlink cross fs, otherwise we could just add symlinks
> to e.g. /sys/class/drm/card<N>/clients/*, which then nicely separate it
> per gpu too.
>
> But see below.
>
> >
> >>I did some research into sysfs binary attributes, and while some source=
s mention that
> >>it's often used for dumping or loading of driver FW, none of them claim=
 it cannot
> >>be used for other purposes.
> >>
> >>>>>---
> >>>>>   drivers/gpu/drm/drm_internal.h       |  2 +-
> >>>>>   drivers/gpu/drm/drm_privacy_screen.c |  2 +-
> >>>>>   drivers/gpu/drm/drm_sysfs.c          | 89 ++++++++++++++++++++++-=
-----
> >>>>>   3 files changed, 74 insertions(+), 19 deletions(-)
> >>>>>
> >>>>>diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_in=
ternal.h
> >>>>>index 2215baef9a3e..9a399b03d11c 100644
> >>>>>--- a/drivers/gpu/drm/drm_internal.h
> >>>>>+++ b/drivers/gpu/drm/drm_internal.h
> >>>>>@@ -145,7 +145,7 @@ bool drm_master_internal_acquire(struct drm_devi=
ce *dev);
> >>>>>   void drm_master_internal_release(struct drm_device *dev);
> >>>>>
> >>>>>   /* drm_sysfs.c */
> >>>>>-extern struct class *drm_class;
> >>>>>+extern struct class drm_class;
> >>>>>
> >>>>>   int drm_sysfs_init(void);
> >>>>>   void drm_sysfs_destroy(void);
> >>>>>diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/=
drm_privacy_screen.c
> >>>>>index 6cc39e30781f..2fbd24ba5818 100644
> >>>>>--- a/drivers/gpu/drm/drm_privacy_screen.c
> >>>>>+++ b/drivers/gpu/drm/drm_privacy_screen.c
> >>>>>@@ -401,7 +401,7 @@ struct drm_privacy_screen *drm_privacy_screen_re=
gister(
> >>>>>          mutex_init(&priv->lock);
> >>>>>          BLOCKING_INIT_NOTIFIER_HEAD(&priv->notifier_head);
> >>>>>
> >>>>>-       priv->dev.class =3D drm_class;
> >>>>>+       priv->dev.class =3D &drm_class;
> >>>>>          priv->dev.type =3D &drm_privacy_screen_type;
> >>>>>          priv->dev.parent =3D parent;
> >>>>>          priv->dev.release =3D drm_privacy_screen_device_release;
> >>>>>diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs=
c
> >>>>>index a953f69a34b6..56ca9e22c720 100644
> >>>>>--- a/drivers/gpu/drm/drm_sysfs.c
> >>>>>+++ b/drivers/gpu/drm/drm_sysfs.c
> >>>>>@@ -58,8 +58,6 @@ static struct device_type drm_sysfs_device_connect=
or =3D {
> >>>>>          .name =3D "drm_connector",
> >>>>>   };
> >>>>>
> >>>>>-struct class *drm_class;
> >>>>>-
> >>>>>   #ifdef CONFIG_ACPI
> >>>>>   static bool drm_connector_acpi_bus_match(struct device *dev)
> >>>>>   {
> >>>>>@@ -128,6 +126,62 @@ static const struct component_ops typec_connect=
or_ops =3D {
> >>>>>
> >>>>>   static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
> >>>>>
> >>>>>+static ssize_t clients_show(struct device *cd, struct device_attrib=
ute *attr, char *buf)
> >>>>>+{
> >>>>>+       struct drm_minor *minor =3D cd->driver_data;
> >>>>>+       struct drm_device *ddev =3D minor->dev;
> >>>>>+       struct drm_file *priv;
> >>>>>+       ssize_t offset =3D 0;
> >>>>>+       void *pid_buf;
> >>>>>+
> >>>>>+       if (minor->type !=3D DRM_MINOR_RENDER)
> >>>>>+               return 0;
> >>>
> >>>Why this?
> >>
> >>I return nothing in case of a non-render node because we don't want dis=
play drivers
> >>to confuse UM GPU profilers.
> >
> >Feels to arbitrary to me. Let them handle it.
> >
> >>>>>+
> >>>>>+       pid_buf =3D kvmalloc(PAGE_SIZE, GFP_KERNEL);
> >>>
> >>>I don't quite get the kvmalloc for just one page (or why even a tempor=
ay
> >>>buffer and not write into buf directly?).
> >>
> >>Should've used kmalloc, you're right. Or else I could just write everyt=
hing straight into 'buf'.
> >>
> >>>>>+       if (!pid_buf)
> >>>>>+               return 0;
> >>>>>+
> >>>>>+       mutex_lock(&ddev->filelist_mutex);
> >>>>>+       list_for_each_entry_reverse(priv, &ddev->filelist, lhead) {
> >>>>>+               struct pid *pid;
> >>>>>+
> >>>>>+               if (drm_WARN_ON(ddev, (PAGE_SIZE - offset) < sizeof(=
pid_t)))
> >>>>>+                       break;
> >>>
> >>>Feels bad.. I would suggest exploring implementing a read callback (in=
stead of
> >>>show) and handling arbitrary size output.
> >>
> >>I think regular class attributes can only implement show() and set(). F=
or a more complex
> >>interface, I would have to turn it into an actual binary attribute, and=
 that would be the only
> >>choice if we want the list of clients to be of arbitrary size.
> >
> >Yeah, i915 uses that to dump the error capture file which can be huge
> >and is text so it is doable.
> >
> >>>>>+
> >>>>>+               rcu_read_lock();
> >>>>>+               pid =3D rcu_dereference(priv->pid);
> >>>>>+               (*(pid_t *)(pid_buf + offset)) =3D pid_vnr(pid);
> >>>>>+               rcu_read_unlock();
> >>>>>+
> >>>>>+               offset +=3D sizeof(pid_t);
> >>>>>+       }
> >>>>>+       mutex_unlock(&ddev->filelist_mutex);
> >>>>>+
> >>>>>+       if (offset < PAGE_SIZE)
> >>>>>+               (*(pid_t *)(pid_buf + offset)) =3D 0;
> >>>
> >>>Either NULL terminated or PAGE_SIZE/sizeof(pid) entries and not NULL
> >>>terminated feels weird. If I got that right.
> >>>
> >>>For me everything points towards going for text output.
> >>
> >>Yes, I know it might sound weird, but my reasoning was: either there ar=
e PAGE_SIZE/sizeof(pid) entries
> >>and the file isn't NULL terminated (which should be picked up by client=
s as being one page worth
> >>of data, the sysfs attribute maximum transfer unit), or else there aren=
't enough entries to fill
> >>a page and after the last one there's a NULL entry.
> >>
> >>
> >>>>>+
> >>>>>+       memcpy(buf, pid_buf, offset);
> >>>>>+
> >>>>>+       kvfree(pid_buf);
> >>>>>+
> >>>>>+       return offset;
> >>>>>+
> >>>>>+}
> >>>>>+static DEVICE_ATTR_RO(clients);
>
>
> /proc/<pid>/fdinfo/ is only readable by the owner. if we report what are
> the open fds (or even what are the pids with a drm fd), we are
> leaking that info. So we should probably make this
> DEVICE_ATTR_ADMIN_RO.

I think this is an argument for _only_ listing the PID and not full
paths.  I have a use-case where I'd prefer it not to be
DEVICE_ATTR_ADMIN_RO

That said, I think I do prefer txt rather than binary.  If nothing
else, it makes it easier to deal with for scripting, which is also
useful sometimes.

BR,
-R

> Lucas De Marchi
>
> >>>
> >>>Shouldn't BIN_ATTR_RO be used for binary files in sysfs?
> >>
> >>Like I said above, I sort of faked a binary attribute through the regul=
ar sysfs attr API,
> >>which is most likely a bad idea.
> >>
> >>>Regards,
> >>>
> >>>Tvrtko
> >>>
> >>>P.S. Or maybe it is time for drmfs? Where each client gets a directory=
 and
> >>>drivers can populate files. Such as per client logging streams and wha=
tnot.
> >>
> >>Yes, but maybe this is something we can discuss in depth in an RFC at a=
 later time?
> >
> >Yes of course, it is just a long standing idea for flexible per client
> >stuff.
> >
> >Regards,
> >
> >Tvrtko
> >
> >>
> >>>>>+
> >>>>>+static struct attribute *drm_device_attrs[] =3D {
> >>>>>+       &dev_attr_clients.attr,
> >>>>>+       NULL,
> >>>>>+};
> >>>>>+ATTRIBUTE_GROUPS(drm_device);
> >>>>>+
> >>>>>+struct class drm_class =3D {
> >>>>>+       .name           =3D "drm",
> >>>>>+       .dev_groups     =3D drm_device_groups,
> >>>>>+};
> >>>>>+
> >>>>>+static bool drm_class_initialised;
> >>>>>+
> >>>>>   /**
> >>>>>    * drm_sysfs_init - initialize sysfs helpers
> >>>>>    *
> >>>>>@@ -142,18 +196,19 @@ int drm_sysfs_init(void)
> >>>>>   {
> >>>>>          int err;
> >>>>>
> >>>>>-       drm_class =3D class_create("drm");
> >>>>>-       if (IS_ERR(drm_class))
> >>>>>-               return PTR_ERR(drm_class);
> >>>>>+       err =3D class_register(&drm_class);
> >>>>>+       if (err)
> >>>>>+               return err;
> >>>>>
> >>>>>-       err =3D class_create_file(drm_class, &class_attr_version.att=
r);
> >>>>>+       err =3D class_create_file(&drm_class, &class_attr_version.at=
tr);
> >>>>>          if (err) {
> >>>>>-               class_destroy(drm_class);
> >>>>>-               drm_class =3D NULL;
> >>>>>+               class_destroy(&drm_class);
> >>>>>                  return err;
> >>>>>          }
> >>>>>
> >>>>>-       drm_class->devnode =3D drm_devnode;
> >>>>>+       drm_class.devnode =3D drm_devnode;
> >>>>>+
> >>>>>+       drm_class_initialised =3D true;
> >>>>>
> >>>>>          drm_sysfs_acpi_register();
> >>>>>          return 0;
> >>>>>@@ -166,12 +221,12 @@ int drm_sysfs_init(void)
> >>>>>    */
> >>>>>   void drm_sysfs_destroy(void)
> >>>>>   {
> >>>>>-       if (IS_ERR_OR_NULL(drm_class))
> >>>>>+       if (!drm_class_initialised)
> >>>>>                  return;
> >>>>>          drm_sysfs_acpi_unregister();
> >>>>>-       class_remove_file(drm_class, &class_attr_version.attr);
> >>>>>-       class_destroy(drm_class);
> >>>>>-       drm_class =3D NULL;
> >>>>>+       class_remove_file(&drm_class, &class_attr_version.attr);
> >>>>>+       class_destroy(&drm_class);
> >>>>>+       drm_class_initialised =3D false;
> >>>>>   }
> >>>>>
> >>>>>   static void drm_sysfs_release(struct device *dev)
> >>>>>@@ -372,7 +427,7 @@ int drm_sysfs_connector_add(struct drm_connector=
 *connector)
> >>>>>                  return -ENOMEM;
> >>>>>
> >>>>>          device_initialize(kdev);
> >>>>>-       kdev->class =3D drm_class;
> >>>>>+       kdev->class =3D &drm_class;
> >>>>>          kdev->type =3D &drm_sysfs_device_connector;
> >>>>>          kdev->parent =3D dev->primary->kdev;
> >>>>>          kdev->groups =3D connector_dev_groups;
> >>>>>@@ -550,7 +605,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_=
minor *minor)
> >>>>>                          minor_str =3D "card%d";
> >>>>>
> >>>>>                  kdev->devt =3D MKDEV(DRM_MAJOR, minor->index);
> >>>>>-               kdev->class =3D drm_class;
> >>>>>+               kdev->class =3D &drm_class;
> >>>>>                  kdev->type =3D &drm_sysfs_device_minor;
> >>>>>          }
> >>>>>
> >>>>>@@ -579,10 +634,10 @@ struct device *drm_sysfs_minor_alloc(struct dr=
m_minor *minor)
> >>>>>    */
> >>>>>   int drm_class_device_register(struct device *dev)
> >>>>>   {
> >>>>>-       if (!drm_class || IS_ERR(drm_class))
> >>>>>+       if (!drm_class_initialised)
> >>>>>                  return -ENOENT;
> >>>>>
> >>>>>-       dev->class =3D drm_class;
> >>>>>+       dev->class =3D &drm_class;
> >>>>>          return device_register(dev);
> >>>>>   }
> >>>>>   EXPORT_SYMBOL_GPL(drm_class_device_register);
> >>>>>
> >>>>>base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
> >>>>>--
> >>>>>2.44.0
> >>>>>
> >>
> >>Adrian Larumbe

