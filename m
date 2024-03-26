Return-Path: <linux-kernel+bounces-119645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6E88CB81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA41C2B758
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423146F07B;
	Tue, 26 Mar 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8k8uz2T"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691B84D34
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476305; cv=none; b=rm4geP30nkXKPwBlfrPFoPgKKd0CtrvKgD/MCsL465cOr5cp+tmG00Ujrc0tFj/PBnASVwyygz96egnHTWBy7jAhDoG3m0ay6dijhnMgRzYyBFmcjNiijYDfeM78KBMVHk2RW5YaiKtendB7UYDrNIqIqGMQWl95L7OfTg6kbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476305; c=relaxed/simple;
	bh=1HtAEn3GUDU1rNP6LZWmBuVwhufr+rjFcdlx8t9YYvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RpKaelVFOXlJPvwBULwSBzr4/l90GV33dHRsMqzdFd33ew8jC4T4aUho5L64ch73YAstUFjs05vKDxIB+8T0F7KOkkQmwwByd2jPBBImX9MHh3XZR7ipL4//jSsapVU//k3HxXUPlpSjEvhJGr8O/+CgZL5mesuNJa51Jr+cjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8k8uz2T; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso1437949a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476303; x=1712081103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=InAZ9/C9EDyJhkW+bEV5eavwbh4jrGbQhGajHqMOaXs=;
        b=T8k8uz2T2njzNwO9uuJCZUPbgR7UFW3VEzMiwRNl2nNnkzK0CQ0ib/Ud1d8W/cZ7zR
         gs/sTUjSgsy+g9XB4s3HmW8K2Z4QH674pe38Y9CdG6pxuzLH60WLj2VLrdQvh5R9nK07
         /TF0KH0xwUpPyLq8WJbFiuKVsH9uwJO8/hywywXg6O5vOjbVAvxYEAnanO899MyHqdoQ
         PY3wMbQkBRl1gRtwlQcRV822sE+pi9QwTeRAvUWRIbtTYkfvLgOowj6kxQd0W/YpziZS
         nKNAjMIhDWSu+Hr4SVNSGMF61ufFq7KGK9RBnHoWjajT0jqvruf8XqYrxvaxcTqVENfD
         fv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476303; x=1712081103;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InAZ9/C9EDyJhkW+bEV5eavwbh4jrGbQhGajHqMOaXs=;
        b=pWXkrvEv7H8s6aGXqyITehsameVNCy6Ejt1sAOSxNzspON3iQW56pq+1PmjZugKsy7
         I+OMQ36d5GCraGFf/aw12+xpvFJ2tH+AdjTla91CQk1toai3Os/A81A/jqK6izJO2Lbi
         VsG0uhVnL/vQPTkrM4yHX1R3ZJ5FzQNUSJHEAYGranX+oUtXvXdT5aAoJt9JXAg2J6K3
         bu9Jl9WdtwzgGXpdpkYlUe2jlQnNFlGdJnPPOOFiEuQIplLgeaF8WkGuAcrT20sD+ZAO
         73kgq72eviF2F6V0Sno1PdqUQC4uR5mcmsprngh7D5t3x2VpSayPd4EyBKUMpnWSnwgQ
         QT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXn6/1VmaaTzDrsqxY85zMiiDg4Zq0FSwt2K57L/m9QLrLWxT4WUS+knFz3bEDwRLkUihnSS1RSejYPgrzWq1d9ZdDI5MV8Faq/O+Lv
X-Gm-Message-State: AOJu0YypFzQOebOc/9YC3VS8FsANXlRvTIaKetu+vZIG//37fcdSGMtc
	slTZZ4FS+TecPaIfEHoyN7ueR8ObzuRPp5H4XFXuXjxFrQ5KgmbhosJ8DI1CLaQuKRaHkbTogWw
	wT1Wx3AmQh3BdmkszAqDL8R10OkE=
X-Google-Smtp-Source: AGHT+IEBhA+WnnRTf8AR2UyUOmIouX8FcColXZqyCdRGDNFO76HxCoWYBYVkcsPJZ6LizCzy9BOlPUU/AKNzLxSVaQ8=
X-Received: by 2002:a17:90b:380c:b0:29f:e443:204f with SMTP id
 mq12-20020a17090b380c00b0029fe443204fmr8861033pjb.18.1711476303337; Tue, 26
 Mar 2024 11:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 19:04:34 +0100
Message-ID: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
Subject: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set but
 not used
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

In today's next, I got:

    drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
but not used [-Werror,-Wunused-but-set-variable]

`count` seems to be there since commit f64122c1f6ad ("drm: add new QXL
driver. (v1.4)").

Untested diff below -- if you want a formal patch, please let me know.

Cheers,
Miguel

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 281edab518cd..d6ea01f3797b 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -421,7 +421,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 {
        uint32_t handle;
        int idr_ret;
-       int count = 0;
 again:
        idr_preload(GFP_ATOMIC);
        spin_lock(&qdev->surf_id_idr_lock);
@@ -433,7 +432,6 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
        handle = idr_ret;

        if (handle >= qdev->rom->n_surfaces) {
-               count++;
                spin_lock(&qdev->surf_id_idr_lock);
                idr_remove(&qdev->surf_id_idr, handle);
                spin_unlock(&qdev->surf_id_idr_lock);

