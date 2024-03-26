Return-Path: <linux-kernel+bounces-119944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AB88CF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C2C1F359C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54413D605;
	Tue, 26 Mar 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EDF0sf5Y"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8E13D510
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485605; cv=none; b=bJZ86uq1AYJKnNHos9CBtSD9VBhgCzsULStfKwyEMxzK3f2L9YBBGrM5m90f6rfFr8rMc4p9JcS93lTHCuzou26Scg5Sh8sHW+bZu3fGiA3n38kLDFXThydqndmbutMJZciXwKWsmC+VkjwvKmbmjcxuKvNIrNwLyBAydT4oqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485605; c=relaxed/simple;
	bh=WruQOz9RaEv3HVSegh36YJN7OSGfDHYA1SUjz10NO3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNxaI2709RyiKeDai6McewZ8pE0Wr/m05ToT824CiaErNPuMJiTnIfh6ILmK2JGjaD9/uJ0zxGXtAsjO3/PS3tKfj1z3c7n6W6C1B2yaWBffTZbCre3QQzTH7kd7RplNVP+GcGXaBLLcyz9ADPKqjdSESMkHXrPPJv4MQJSW7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EDF0sf5Y; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61149e50602so1970877b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711485602; x=1712090402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfA6Bw+OqHDFIH02i3SdSOQOzi8KrIdytQiZZA87Vsk=;
        b=EDF0sf5YQ0IellJZEMR50G7XA1/CyYTEIdVXam2F7o4cdYEV8eIsSeV/J6As+iBxvh
         2yQa0UF/6oxk1g3Zpv/4F4nqu0j+iLG7H06h5kkA26vtF3QW8QiMIIpb+Oq9jX9ltiah
         K8aRRMYtKumV/UgWqBzNFJR8WguMxzqSuFtNHU1I0dX9jKIyjAMYh1WM0r0nPfybnfFe
         mHcs85loQkHFlzAO1fkjgBkSF5d5cHJ4NqmR9zIuyDuh+eEoImAexZfICL5hjnf47Nv+
         oBpOxqTblKi+wSj5FrnG2xEUnQPYKJVV9nOYcRPKPOnggolhiqdZ8NU0MCLGg7Sof/au
         jpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485602; x=1712090402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfA6Bw+OqHDFIH02i3SdSOQOzi8KrIdytQiZZA87Vsk=;
        b=WYg/dC0U3nkFYjLz7Z9t8lXFAwGMVT+4DQapztiiSssgw/uapHd73AXxbsGxsb4XPM
         CFINA2ORa72+RmHKqPx6rYmw2Wr2cNaudxralQSITQ1DJIKOjCaKaBL3ZO6obKbRHs8d
         KPBUR7ZstV6IyLMEUnwBko54YzCslOepE6V4fO7wtXktFRj/UFVAWSEyGpcQ+MmWmIz2
         pKHyqKVAUfNSTwPdu5o/Q13Ug4UbXIWBB7sxFDgw8YYvtuDemFZvvr/YOyEhQ2UJfXC0
         VEtFuOo0Y49ZGzcv/2gH8T736+ih/GZY89PeBy/Waz0uH4sDcN0Hk4S11InXCrgOoNiD
         XfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK2e2a0YH8sGHwWizWRtjuctOh5CZfzHEJRa2z87o8za6FTEYIM5NXUW8Ch+qefauWsPPxDJvEBi/J7dWTdfl3JsMLWh76oeftyg0N
X-Gm-Message-State: AOJu0YzC4IOgp65yyNHVPWIz2J3gdsD4y7C2I4xZgi8PIrrzrrdeHTUD
	/s3pz93nKW2ccSR2/LNWuxyXsSRg9bC4yMkTFadK+BS9nyPR9jRC7YDzbB4J/pRUFH7rOyb2uk+
	PLGheTQhAwT5MCCXbtID4XnIb8HceWQGTPgsD
X-Google-Smtp-Source: AGHT+IGojsm7tQ5IjgAZja3ZCicVNmkHB0OiNPAhpMRvWu2bsnClyYgJZH/nGSm005+lB31cavBaGPAdYzYaSe2kNak=
X-Received: by 2002:a0d:eb45:0:b0:611:71b0:4ee2 with SMTP id
 u66-20020a0deb45000000b0061171b04ee2mr1807908ywe.23.1711485602560; Tue, 26
 Mar 2024 13:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315173105.636749-1-cgzones@googlemail.com> <20240315173105.636749-2-cgzones@googlemail.com>
In-Reply-To: <20240315173105.636749-2-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 16:39:51 -0400
Message-ID: <CAHC9VhS-nTktDCbdrb2Zos_GtbN1C87VijJUqB88sZWpn+6m=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: avoid identifier using reserved name
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Avoid using an identifier starting with double underscores, which
> signals a reserved identifier.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thank you for the patch, but this was addressed by the patch below
which was posted on February 23rd.

https://lore.kernel.org/selinux/20240223212640.305789-2-paul@paul-moore.com

--=20
paul-moore.com

