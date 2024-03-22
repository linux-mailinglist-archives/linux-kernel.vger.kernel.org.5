Return-Path: <linux-kernel+bounces-111974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055AD887385
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD98A1F223B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1D76C64;
	Fri, 22 Mar 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya+9/IfF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E287691E;
	Fri, 22 Mar 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134033; cv=none; b=FXuKImpxtznIRAj0nnTaTvbu27g2qjBpyFXhVynOszOtFXxyRRQsPiyyDuTt7vBtF5tnLF9KId0rjl07QutTNotVcQ9dMXrzO0gZY9PELadZoNbTFkB61f3Y4qhUOITJP3qrv9ryeB9Arq46dghuJEgrKufxGdYYF3zhe4ios9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134033; c=relaxed/simple;
	bh=rbqZXtWUsXkXU7uKgL2eJ1fLAfu1qEVONTKncRNgFZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TicHjd6SmNo4h2u9TAB8zuZ/oHhARDqBi5xBVF60+KPfQMHv1BRryVoMnlu2c+8LnU9Km3ARzWOhwin9booI3LuqFBGNcKrMuL17Te8jWBBlWYVPuy4fOuqtyKPdATpEJNGKXUEfiyB6RPWEVFOQqBhWk1i+Ang04Fx5wFOv1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya+9/IfF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1728990b3a.2;
        Fri, 22 Mar 2024 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711134015; x=1711738815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rbqZXtWUsXkXU7uKgL2eJ1fLAfu1qEVONTKncRNgFZU=;
        b=Ya+9/IfFPGVr3Uk6qIVf86skp48eVrcZp3OnY+P+YtRcTkZbq/0n59u7HfgDbC0wUh
         G1ErmMbIKV6iGYiNagGDbo5lUDSGuxpp9C22+N9xNpPwD7Y8wJbQah7f7erJlQyx8Qhy
         Dbhv9YIkcSP/lz5nexuyTRo4NVgLYAfwXDHK2R3jxxYkfhM1Qr6VxxZJnP0OalA6QCXM
         bhjyjNAHTsYzzg0Z+ttLMgIIvYkexOr6AdjhQG9lTxGvg7tezaC/8Kr/U8H7a2vVovs2
         S8jz0F2JOXIx77FrwA4PcL1KB3weGKAIYWHIbqBTIwKAsJinp2VS9X3ReK18ZrjrYEpp
         rkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134015; x=1711738815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbqZXtWUsXkXU7uKgL2eJ1fLAfu1qEVONTKncRNgFZU=;
        b=KM8gArMuH2cPtcIHKe7FRmocWMRNLA2+QKWj6aukdYX8S2hpmnzWxu7h7WlwacgjtH
         ysgzVmKO934/nW/yxaMBTWCP5vanEB0NnsNHnlYrckYQDSng3fut2FBrfXI0ESmtUILp
         BAWwETkriV2YAeUCEBnk2UKD3NnOxKIQly0DNPveFxQaiQXrGdyZQRMrb4uszBjHxTS+
         3XcVPluZj8iT3Gi3KUdR1J14FU0zQaxRSJUDga5OFY4ZAuxVAh8MR/D+FLtker7PkKYt
         lBBNTQTcU+UABVpgRdSkJlQdqZH99OQE3rqGB32rW70heZEqKMpXXZREGlLHpfAZfEZz
         sEwg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOdr7xOYAWYIWf/pAeLG5f56PbUswP6aEAew5lfNlWUnTHfQ9AY9RSuhpQ/pDiLRe3hrsUCUQwt1miKOF62r9jH6eygHa9CHZntJb4CjXdcZCRFDSV8ISuNcAEZxdg42pcikU4GQA
X-Gm-Message-State: AOJu0Yy7DoomLUiVizRa6ziUffTj7d3BFZe7p6AbGE3yfKbwEIWGYy/C
	ncb4a3K5L1+1uLjK+Px+CGSC8NQqgM50PxfBoeRDSiREvGNb2hkX
X-Google-Smtp-Source: AGHT+IEBGM7i1E1TidmfQx+2yGHWF02f7RsNVHEYExqXeZ/JPZ+xWiuTct6cwktvs6pJTLdsmyz9lA==
X-Received: by 2002:a05:6a00:3d06:b0:6e6:b155:b9a3 with SMTP id lo6-20020a056a003d0600b006e6b155b9a3mr703841pfb.11.1711134013371;
        Fri, 22 Mar 2024 12:00:13 -0700 (PDT)
Received: from [192.168.0.21] ([119.82.120.209])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b006e6bcbea9e0sm96558pfm.88.2024.03.22.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:00:13 -0700 (PDT)
Message-ID: <0d10046d0868878cfc1f3de90ebd5e5bc1a74a6f.camel@gmail.com>
Subject: Re: [PATCH] Fix duplicate C declaration warnings
From: Amogh <amogh.linux.kernel.dev@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, javier.carrasco.cruz@gmail.com, 
	skhan@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 23 Mar 2024 00:30:07 +0530
In-Reply-To: <871q83mw96.fsf@intel.com>
References: <20240321115738.51188-1-amogh.linux.kernel.dev@gmail.com>
	 <871q83mw96.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-21 at 17:37 +0200, Jani Nikula wrote:
> Please paste the warnings here.
>=20
> BR,
> Jani.
>=20

Here are the warnings I got:

/home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
kms:360: ./drivers/gpu/drm/drm_fourcc.c:344: WARNING: Duplicate C
declaration, also defined at gpu/drm-kms:39.
Declaration is '.. c:function:: const struct drm_format_info *
drm_format_info (u32 format)'.
/home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
kms:461: ./drivers/gpu/drm/drm_modeset_lock.c:392: WARNING: Duplicate C
declaration, also defined at gpu/drm-kms:49.
Declaration is '.. c:function:: int drm_modeset_lock (struct
drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.

With Regards,
Amogh

