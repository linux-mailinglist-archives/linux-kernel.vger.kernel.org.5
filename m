Return-Path: <linux-kernel+bounces-68971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6E8582D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A981C21522
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E030130AC8;
	Fri, 16 Feb 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhlxl4hD"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62912FB31
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101725; cv=none; b=JrGRSPv/Mpo3/oBJfQQYYx6Hj8KRPYJ1hHY12pvKYKaRYJAaYmKdWwW1rtF5/jTN4M/x4FA3iDZAKMRZ7SLixrzj/saiE1N9XaqzGhVAgdraS7IXJxQEqVAf5gjuI+SBH0KfxAblXpJ1S4XYHfmNO16GGhb1SoQVeWcmJB3zMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101725; c=relaxed/simple;
	bh=a90W6kAzjb9x+SuSU919u0b9IIwywBYyqIR4eLcOobU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqqiLpsYc/3pL7IWs5ZkvxmHNlrk+1NbKPcA49Jx2szKJh4rjUWAdkK08Z27O3NMyQwYtoNfnP5LUjs/xaqmz8R5ADru44O/85vy0rrx+0yh9Wy3eczVWt/vqP7tTYzHpUDL/qHrlxirG6qwqawo+nHzK5zgLqYCEo5z3KzmV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhlxl4hD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-299354e5f01so566017a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101723; x=1708706523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EMPafwLeq7MLqsVb1yw1pk0iPW8a/wDMfuJKhuYK68=;
        b=Rhlxl4hD7VOVhs1sFq9A2ESD2mXamRetJvaMDSzPQ7mS+LuJn8mxGpGIvwDiRgRNEk
         XEsZBvF3k/u++XGiSdpI/9VNbWBOxzoTmnQAovn3WuVQ+I9QZQdWOIJZa0MkLtA1iVwi
         TU0FYA/ypHK5O0wKzBUF/GiViDen9HFWgnqaJnZIAYrKDEFFcQAGIc54jjA/tXcwqPwK
         pvgHRDTScwzOquwKBletKifuJDQ3x1TATl3s0xr3h7nrPp3MaD6tfJTay/NrB48GCxW+
         4/g2Lfwkx9YmTIfcLSf4yX00uFFyfcupX2J+WP16NXn20SszDNCk76TQTvhhpVB1bR8d
         aUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101723; x=1708706523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EMPafwLeq7MLqsVb1yw1pk0iPW8a/wDMfuJKhuYK68=;
        b=Zwr7bBSfrlFW2Wksm6aDzc0JzjiK3om9/Oi2VTv1vZ5wGyzcTkwMvPE8NcE2CbH9Cl
         TyjKTZnJVRcXmiecX2UCSwAMrt3G7wVw57a8kwFKxiFEdKb5Wkb+VISJ/IHm531kAd9Q
         EHEy/89YyLqJK39n09XGvZZO4oCpNSA/OshEzLvZHpHtV4Pq1Syuf2iLqDb3+ddJCa6+
         Abc+2qN28j6FFnQBayxlbGPNavTg0LkFClC9tUkDPUPuofUxdXCzgPGo6+VXFV82tprS
         CU2EyWHy6SIK2VxPyNHo9fgR5hU0HUu3fGuvG5I5s76956Q9XAz2FZ0ps8U/Wcfq+VF9
         XXpg==
X-Forwarded-Encrypted: i=1; AJvYcCVpekgv8Xs/AxZTwOoAj5teR+IMpw/+rb5F4lDXdM5bjOSk+003HEXv80MdeVDre0ndpLUbHu/6J+7QmzfqDtb73cB+weFG2PFTVX/i
X-Gm-Message-State: AOJu0YxXZfTAfbVEVGkc0zrmU3W18TQ3yR4YUp1ZbsFSbj57MYv/jpt4
	n2HUH0CE64n90rX2My+BQMam+tIUGkqnbznj0BOewhomNMzEC1/Q+BZsLwm1wE8bwZkvXQStWr3
	QDNDYSlMBA645zZROxvhamElAzLk=
X-Google-Smtp-Source: AGHT+IGRPzDc3QxFYqOR5Y9w47n2OGHklvOvGfX/0AMDI+/gqNwj6exnZjySb5lMxEb9AfRp3gBQ0K/wYsfTsTxAMIQ=
X-Received: by 2002:a17:90a:8b88:b0:296:edc5:fa44 with SMTP id
 z8-20020a17090a8b8800b00296edc5fa44mr11859447pjn.21.1708101723342; Fri, 16
 Feb 2024 08:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213005050.4442-1-W_Armin@gmx.de>
In-Reply-To: <20240213005050.4442-1-W_Armin@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Feb 2024 11:41:50 -0500
Message-ID: <CADnq5_OYE8g77YOQvN=TKQJtT_JvCDCbWxejW05VsgyqTSHetA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leak in dm_sw_fini()
To: Armin Wolf <W_Armin@gmx.de>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Feb 12, 2024 at 8:08=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> After destroying dmub_srv, the memory associated with it is
> not freed, causing a memory leak:
>
> unreferenced object 0xffff896302b45800 (size 1024):
>   comm "(udev-worker)", pid 222, jiffies 4294894636
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 6265fd77):
>     [<ffffffff993495ed>] kmalloc_trace+0x29d/0x340
>     [<ffffffffc0ea4a94>] dm_dmub_sw_init+0xb4/0x450 [amdgpu]
>     [<ffffffffc0ea4e55>] dm_sw_init+0x15/0x2b0 [amdgpu]
>     [<ffffffffc0ba8557>] amdgpu_device_init+0x1417/0x24e0 [amdgpu]
>     [<ffffffffc0bab285>] amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
>     [<ffffffffc0ba09c7>] amdgpu_pci_probe+0x187/0x4e0 [amdgpu]
>     [<ffffffff9968fd1e>] local_pci_probe+0x3e/0x90
>     [<ffffffff996918a3>] pci_device_probe+0xc3/0x230
>     [<ffffffff99805872>] really_probe+0xe2/0x480
>     [<ffffffff99805c98>] __driver_probe_device+0x78/0x160
>     [<ffffffff99805daf>] driver_probe_device+0x1f/0x90
>     [<ffffffff9980601e>] __driver_attach+0xce/0x1c0
>     [<ffffffff99803170>] bus_for_each_dev+0x70/0xc0
>     [<ffffffff99804822>] bus_add_driver+0x112/0x210
>     [<ffffffff99807245>] driver_register+0x55/0x100
>     [<ffffffff990012d1>] do_one_initcall+0x41/0x300
>
> Fix this by freeing dmub_srv after destroying it.
>
> Fixes: 743b9786b14a ("drm/amd/display: Hook up the DMUB service in DM")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 59d2eee72a32..9cbfc8d39dee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2287,6 +2287,7 @@ static int dm_sw_fini(void *handle)
>
>         if (adev->dm.dmub_srv) {
>                 dmub_srv_destroy(adev->dm.dmub_srv);
> +               kfree(adev->dm.dmub_srv);
>                 adev->dm.dmub_srv =3D NULL;
>         }
>
> --
> 2.39.2
>

