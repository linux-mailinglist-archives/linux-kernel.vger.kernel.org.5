Return-Path: <linux-kernel+bounces-133053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3B899E1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A73282B66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8416D4C6;
	Fri,  5 Apr 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVlSCTSQ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BE1649DF;
	Fri,  5 Apr 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322829; cv=none; b=VVHp2Uph3PIooyAbVMBSOnsHFZBAbrMg9UAcv830sx2Gy4IcStA4rbmQIUCSkgM/Wenh8E48vbDxHZTyHyDoRzdy+2Y+p3joM6sp8QaPmHqZRDFkU/F1L4EsSEuoRLa/YtRdhdwdCWieyBfPn8H6kkGzg93C2+UB5XghnS1+adE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322829; c=relaxed/simple;
	bh=kuMV/3T6ZFOYdnbds+4lzaSfsPnTVAQKG+lKGoR4FbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T49Ho9CyCxb47jkypRRkwMdyZNuLFPvQ6gS7TfOQpmAueVwQjC5srAW9ZeXz07lAB4QVIhIQ4/cQxrNagCsuPtakMY0VbSRwqxIXMQaWrPBBX33TGSUrdut8gIMEQ8FrIEO8c3ANleCy45dr0Zcs4oMtChXGb2nItGsrU4cCUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVlSCTSQ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc5fdb0148so91027839f.3;
        Fri, 05 Apr 2024 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712322828; x=1712927628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+eOwWNjATfYk+c/TB3aDWZzFnSusbmwrVL3HM1jFH4=;
        b=EVlSCTSQKG9QmTsjxYJDcjVkkBLATS1toUs2ASfMe10LaBo+hM7C4jiymxzYbfAbmn
         mF9X0PtV3CZ3B3Gv1YzN+QzOD/iumiyuiZ5e6y13Xb4WxdHcBlZ/Q2d97+56NLr9l/M+
         VdFBdlfR78+Ft70sBWPPsk0tIJUXsVM9TZHl3bfgWklmRokLYq90Ei8HnDAgsVOF5A1e
         qssrck6KDSDOoKoekVmVotWkUge6C/oFQfqzEdrdJyX/ft7Ue04ZYWLSdh/+PHfnDEpK
         0XDvtdwMdi18d0cX+r19Sc4/V2+PjJe7Vd1xeSe79LsUVzbqulROa7wv483Cd2JRh65b
         I4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712322828; x=1712927628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+eOwWNjATfYk+c/TB3aDWZzFnSusbmwrVL3HM1jFH4=;
        b=DjBXXhxzvSMclkCzvocsN9j2nVIPmFE2eJ64Z7TfNaQrq05IEqaFEdtC/VkNcRft3r
         MKA6XZjNaomPXdJAgMe7ByX4cQ//Ye1APQYzgmPCgtSFy1jNCjFQyZIHXN3wuSv5uPFZ
         SSOkVXPUQoJw3FeP5Us0SwMOMH6kX0Crqmys4xY49820QbER2ylyGZxPvLJlAQJ6KCzB
         fNAm5gbr1PrGhjyrhKH3jC7rxorFsxtlq5BNWQ0eoe3mE3o9lwac6RhhlTQKOmUd2ion
         Sph1CBYLJW4TOEMc0F9RE4aptYvDv8qEuhIHz7M8IFLHOW/Pv8pmoeaH9U0x/1bPTOxP
         U5SA==
X-Forwarded-Encrypted: i=1; AJvYcCWoeGbX9LtGm5G0YuPuISbQQNiZZOCPVOSHOkL4AGwkZ5JKi4vLduKbRMPBWuEkvcChPDTt/FA3F5m8ZFFLFUl75HNXT0znK2Brn46DzCMYIsG1IAUGaPJ91TjwiQfHX9r65HE3
X-Gm-Message-State: AOJu0YwtMcYv8nrPMjN/H+NVk6UKh2+QQZ1uVM7fJMZV1DbCH9Zybfyo
	O8Z1xmbvHt99yhOBU4QKyWDy3XG1yNWiFIE91bx3YaT+ay/pU3uPtE9JPhiqWs6r8m/K6rYkMrJ
	EXZq/AhJMzUKKNLWHucRWcyHtdcGQBl+ugM8=
X-Google-Smtp-Source: AGHT+IHaX2dQh+kALgdWIspduT6ugovJPa5Sn4HGaoAs9RZ6fW+NT+v+SSYkpoJ5EWsoUTSjQy/1Vw5BjcFJ1irMF5s=
X-Received: by 2002:a05:6602:2486:b0:7d5:bfc5:2a4f with SMTP id
 g6-20020a056602248600b007d5bfc52a4fmr1235931ioe.3.1712322827628; Fri, 05 Apr
 2024 06:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322162135.3984233-1-steve.wahl@hpe.com> <ZgABC1oQ9YJW6Bw3@gmail.com>
 <20240325020334.GA10309@hpe.com> <ZgFY24QT7470ZGnV@gmail.com>
In-Reply-To: <ZgFY24QT7470ZGnV@gmail.com>
From: Eric Hagberg <ehagberg@gmail.com>
Date: Fri, 5 Apr 2024 09:13:36 -0400
Message-ID: <CAJbxNHeqY3QevjH3=BuD=DhB0YK6ZvPDbOn_m-LOYAfY81MqhA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
To: Ingo Molnar <mingo@kernel.org>
Cc: Russ Anderson <rja@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, 
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, Dimitri Sivanich <sivanich@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:58=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
> Anyway, I've reverted this in tip:x86/urgent:
>
>   c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB p=
age should be mapped."

I see that this hasn't been reverted in the longterm branches it made
it into already (6.1.x and 6.6.x, for example) - is it expected to be
reverted there as well? I'd think it should be, until this is all
sorted out.

