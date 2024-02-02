Return-Path: <linux-kernel+bounces-49738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8654846EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540AA1F286D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C813D515;
	Fri,  2 Feb 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQKo6UUV"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7B13D4F8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872726; cv=none; b=gF8zNT2AzF2Eozj1zUXwgfVvnoX4DkP658ZwbqYmbIs8QLrlfGNPrbcPStc56MC0ChwRI+ttO24mT2At/eZS4xAaIUnkT6Iv41hE3gliuoa/YOyS3gOfCjWqVsubw024B+68pDxNY/p2/aodtJ5aOH95yXPN9JqgpZvrLzWpaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872726; c=relaxed/simple;
	bh=rzVH+2O/yXCF23MPinpXV17zNzphyyEZe/7tL4XX3X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGXmoz+uicO6WzOMdge9MEUGC7DHjcLzizb+qLto1EDsfWKaTHBrpcd+KV7hbXHwBxAWOJtaOz6pquw1UcB/SxyXOkF1uE4uQl9Qdp7VzuhSbawwsJhAq9WmXKfMrBTCUmLApmZIEWehqjDTjlkcJgaXKF4ZyfEvDH/vReM1s2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQKo6UUV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so1898644276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706872724; x=1707477524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzVH+2O/yXCF23MPinpXV17zNzphyyEZe/7tL4XX3X4=;
        b=ZQKo6UUVXK8kI0VibuTzmn9hW3fsSDTrG+gN8mdF5hfZ0p+3ua7lKUifGzx981/KSz
         c6ps3p6ktb/tRCLXF4bmu0VVyWxh4FwHWbJS8D8oL66RmVmMtVKbM6KkDwDoHH+x82jD
         2kqFy15PI2kqltvKSe72fqxl0ELKLEvS6cAnvExASKtLFiqI3HMmAZfh1gLTIxV2cP4u
         iNHh9loI0CboiEk2Iiqan4HcPnljBDRTOrpxwFGvulWhSWkv0bO68FwksgsBci8MLiPF
         Dy4Js6OscE2jKvnEA02X0kwtvFqCRQ8r2TFxG+JHbOiPSN/S+8IKWdjz1JieHlAnQwdE
         QCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706872724; x=1707477524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzVH+2O/yXCF23MPinpXV17zNzphyyEZe/7tL4XX3X4=;
        b=ajFfQ+AmE8IYCtG2O5jNelTtOvEvkiNNnmeo0a4RLxhlTOIJx9+5v3zeuEi47n7UbP
         KSJpyVPmS5hDoIZz8mY0EWVF2OcQ0E3q7vCK05ooHvhsX5dgIpkcK2Z0Aub9shMbbQk3
         9TnjSW3gqqshei9H46XyklepeuH0ll1YLXKP7FGAgIXTS7wxhXZi9o3hJgn8VMWWbeXg
         t1P3oLOUgrMFCBuOenzwe/HledGrIt/pDSeejxkO2xHwnO2RM+LQhtCuNzz7EcKFMbRM
         VK/d3H19ibhT1db3H63372eqg1sHEJPJFMHXWJxD8e8f6UELip4/k6E8kb/QcSNR5Hd6
         jwWw==
X-Gm-Message-State: AOJu0YzZZyZuaRY5bLOG6HzfkgZUMUrk1P8rcPdvhxsKm7jNXy6mZYMu
	ZXlk4qqpRCmmze7+Be6eViZUmo5P00eer5ichS+UDoTmw+JfzPywvzZUZH6vtPUKZcLKR/I7BSD
	rbOuw4l1CLneEeSLEBc4KAEsP/IA=
X-Google-Smtp-Source: AGHT+IEsj0cjiaNuNnw4dFqioHzPuHEuUlcbg/MpTMg1paPWYBzrxOVoAylzR+eBC3pzZMECv0Dm23dSJNjpdkKfhvw=
X-Received: by 2002:a25:aacb:0:b0:dc2:4e83:e6be with SMTP id
 t69-20020a25aacb000000b00dc24e83e6bemr7841907ybi.46.1706872724255; Fri, 02
 Feb 2024 03:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
In-Reply-To: <Zby-sHLDlmTRaUcd@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Feb 2024 19:18:31 +0800
Message-ID: <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:06=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 01-02-24 20:52:26, Lance Yang wrote:
> > The collapsing behavior of khugepaged with pages
> > marked using MADV_FREE might cause confusion
> > among users.
> >
> > For instance, allocate a 2MB chunk using mmap and
> > later release it by MADV_FREE. Khugepaged will not
> > collapse this chunk. From the user's perspective,
> > it treats lazyfree pages as pte_none. However,
> > for some pages marked as lazyfree with MADV_FREE,
> > khugepaged might collapse this chunk and copy
> > these pages to a new huge page. This inconsistency
> > in behavior could be confusing for users.
>
> Is that any more confusing than collapsing pte_none
> pages?
>
> TBH I do not really see why this is a problem. MADV_FREE
> are correctly recognized same as pte_none so the user
> defined trashold applies.

Sorry, I might not have expressed it clearly.
MADV_FREE is correctly recognized, just like
pte_none. This is also reasonable and not an issue.

IMO, since it's treated the same as pte_none,
perhaps lazyfree pages shouldn't be copied to
the new huge page.

Thanks,
Lance
> --
> Michal Hocko
> SUSE Labs

