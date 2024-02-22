Return-Path: <linux-kernel+bounces-75902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1608A85F075
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF10283187
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51115B3;
	Thu, 22 Feb 2024 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq2V4Vqm"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BE4C7E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576548; cv=none; b=oJTQqZe6p27MHgzen4piFjUoINi+EOwzqmze63FpQt+B2RiNbTN1TevIMEHXHWke9TAJXDrWMsPjIhEB5giV8yD8+b9j0eIutSQjRacXA/aarfaHJvlryzhtiR3Jj8wybzrQEjDDE4hWJGkvkPmkPF5JQFy8PlO4iswn+NR5NRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576548; c=relaxed/simple;
	bh=R+LaV9IObqXEDslRt6huejtrzOUwqWZwLScJ3hFhjoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBG4pkkFRF1nXlbknuaxxTmwlcM5Zmq4z0I/jeIPfczclL3f4wQo36csHW4wal6Cu3YXBxVF/L2rGgNPYoeH/pDK0z+ScruyJkUba/1EMgy3mHsz+PU4+oHTwgo221b1ap8p4v6SUtpeIJt2p8oIGf3aaPgtnsM7iJA6Tg2KO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq2V4Vqm; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a0073ae310so1121628eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576544; x=1709181344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd5caO8ozl7kT0iui9IzlMI2kddZaEY7frmQ6rB1CWk=;
        b=gq2V4VqmZZCL3XUy1CYzfRluSbXeUOXkDVfuCU0rud8fRK+BS6sftmdo13cD00gprw
         +5g9Q9BWW6RL02vEWSHzShmE4WKdeOro593dU9nOS5y1jtganxI9M/XttZvr2ehg5Rl1
         jmHXAjdW5iAmUhtQW4L9gHEOhrYSqYDR59JIgR5r8RJ0nhFwjPSPDkP6PoxPZeSi5m5w
         k6hExnIsJDmzbn60uLFgmXNQ9tFuNknLsAGeuPMG6wu3im2HIWB4TZVU5FG8ycZUbP1H
         78FaRK3pcsMtwqOmYR/p1k7uXfCU2O7xs5Q10eH9hOsmgKwrymUaaySdNzRn9ob7QVcA
         9qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576544; x=1709181344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dd5caO8ozl7kT0iui9IzlMI2kddZaEY7frmQ6rB1CWk=;
        b=lInefsTaid/P06UGgr70AnVixq4tZH2nvb5o/+8g7C+ZGNU0dSGPYbDTW5tT5TrgCN
         m0xHL5JNsie9hC+zKKbTpB52cmpl9A+gA2eSeBuCadvy8Jowaw82gv6FsvqDZqK8aylw
         YugMZlyoinqHQuzbf/nKZQgjO/eWNQv/HgdqZZ2jTr9ql6ifZ9ViW7yf3AD4XkiUD3FT
         A7uIqnPudhbB7CZX3u8xl7aD5nWuh7T7U39nem5IY27Jzd1TBrEAGwV33OTsMLi7nXV2
         ew8yKps2WncRYnC5PFpT4k9CpZtPAs0tlcU2dIJetWVKFt8suOx0RxzCvmkYLCWRqey8
         t0qg==
X-Forwarded-Encrypted: i=1; AJvYcCXMK9oedffXWvhWbZ+A78Q4mWqNkGG2n1NGwQU4LEvEEm/pA6SR/G0+P7aK8/4AN1hZxTp2xy8lzxN+uTfVR+INT4vGSSpaNVwPa31h
X-Gm-Message-State: AOJu0Yw6SB9ZGour69KC6DJ1IJ5e6hlJEACXw+fCaxx2/if9k1D5Sq70
	J30jZslAiajdhucI2hr1NYhoWMuLk3JmUhuwOqSdFWUie6BHSGb7PtED2lh/hMbP7Z0pnnSOs8L
	zWfyiYcD5ZcAPZlFzPLXOUXavpbg=
X-Google-Smtp-Source: AGHT+IELOPzLAZtuM/6YlRq9uat+E4pWlf0jBLcTfsx73d5yOnxzzon+ziMTuPx5sKRX9OrmsCT+Ztozk2567eMxYzM=
X-Received: by 2002:a05:6358:18c:b0:17a:ec74:b574 with SMTP id
 d12-20020a056358018c00b0017aec74b574mr29323834rwa.10.1708576542881; Wed, 21
 Feb 2024 20:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221174333.700197-1-tj@kernel.org> <20240221174333.700197-2-tj@kernel.org>
In-Reply-To: <20240221174333.700197-2-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 22 Feb 2024 12:35:31 +0800
Message-ID: <CAJhGHyBgjMWtob2VRWhxCRyNuUVMzSEQufza5TRn7Cw-hBaQ3Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] workqueue: Preserve OFFQ bits in cancel[_sync] paths
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 22, 2024 at 1:43=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

>
>  /* Convenience constants - of type 'unsigned long', not 'enum'! */
>  #define WORK_OFFQ_CANCELING    (1ul << WORK_OFFQ_CANCELING_BIT)
> +#define WORK_OFFQ_FLAG_MASK    (((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WO=
RK_OFFQ_FLAG_SHIFT)

It can use GENMASK.

Thanks
Lai


>  #define WORK_OFFQ_POOL_NONE    ((1ul << WORK_OFFQ_POOL_BITS) - 1)
>  #define WORK_STRUCT_NO_POOL    (WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SH=
IFT)
>  #define WORK_STRUCT_PWQ_MASK   (~((1ul << WORK_STRUCT_PWQ_SHIFT) - 1))

