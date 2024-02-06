Return-Path: <linux-kernel+bounces-54364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF384AE3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB31C221D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF4482D6B;
	Tue,  6 Feb 2024 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVjv8kvK"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7367F470
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199099; cv=none; b=b1QnKNCupVWC5c7DP9nN7khQ+yjgMY2VYfykdojlQ7LBUL4L7hywsa9+ophcOz5CXPF399dSYOoRkR9ZUg/GEjLG64YHmSvJwo/7cRnX1wruEZvPzoR+n+P7kiX8sUmQZSmrrs/Aaf3eLDww8JLBBlZFvIqacfTAl2DaXah67es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199099; c=relaxed/simple;
	bh=J6+zoDYSJ2B/VtzzhTVn2Pjk1oze/PF/fF9MkfoDNL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzupra1AdsWko4zrK1ZALgmMJLmRf858PJMzpSRBmkby+PGeXFcygPLkqul5Dm/Z05VBE9cNCuZ8Ie8H+uyMlhH01KYUU6tc+TUmUovUNtyJTXeNpuKxCpnCR3jRYz6J5xqf4awqdvB05TIbcfxtaTbqgu1diw/0o3rm04CA7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVjv8kvK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56061ad3d3dso442075a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707199096; x=1707803896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37SRj3V5WCLVhgLQFuxLAmj/CKN5zZ9vlMu2l5q/YAA=;
        b=EVjv8kvKkJRpiGD4ruM/1SQ3sLMlzv6bSdwbd+k65PiufpMkOavI9le4iXecd/Ro6V
         Ludct3uaA1uFQ+ZpQugAys7EnSBYa8STm003kvcTgZ1ioWCRHqTgAS2kkhl1jHUiPPTa
         hDY5yD5m/goRhz4FEL64uQoi2yIqGRvSyitpQ9JxnUYwf0hPZbEYtKCLShcNzTiub7p8
         ES/rT4TcTzgxBwJF2nkKWGetAEcrRZTfXOfndM02ot7RUhF6TGhT+2FicE/uQOw0z6bL
         wn+IWZgw9INi8PtobtnF2Bs7CSFlZJfq8h8j13hIyQl1lu6cjRy22BaDEqufXTH4qEsU
         P4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707199096; x=1707803896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37SRj3V5WCLVhgLQFuxLAmj/CKN5zZ9vlMu2l5q/YAA=;
        b=dtzo5tGrJD0/BvcgSF/cer1umlwm0VchPsbKYuPhi367q1MgHIt4Gft07H3zQtWl9H
         ijHgebieJmijXsUuZYc/QodxrBJe06P6QtEeZUuY2S3EOxsnnyu+rPFcKD1uSiGR9CwU
         iEU9rfAHS8LlsL9/NVRpTkhvDNBcZ64FS9i//UL8SL2XB8e1bJpnGrXeRvdplg0F9+FN
         M9JZgto1K8vSJMWBHqS+QtTyyLMjBxaTKah2pRIBOYnnwEYeRgUJRAj/adCFwykNefzM
         XD2caJptUC0xWJl2gxobCrpNyVhj1NdJkGzkkuKe0HxmGWfjXsCObQmILEuTVF/NtvU/
         7/ew==
X-Gm-Message-State: AOJu0YykX0Tse15EzLFCvVAnV43ClT6bWwvuFqSKBZ8If1zAt0a9cJdT
	42HHNYwKxFA7o1G5jcnLVgx2l7ER8wYQ1JulpF3eAis3fiZ9zB7PUCu+s0pISkkVvjtA06jKsKk
	Pi3RpN287wORquDuybG3OeNHUvDqfjR02wLs=
X-Google-Smtp-Source: AGHT+IGDo18AFJzHyBqAN82N1ANueKAASCsDKhpE72pjl7nhu5Q+7HX+a1/HlotJGde4S/sbGdFvgvLqzYWzDU6ufak=
X-Received: by 2002:a50:d59d:0:b0:55f:c4e9:60df with SMTP id
 v29-20020a50d59d000000b0055fc4e960dfmr7804341edi.20.1707199095565; Mon, 05
 Feb 2024 21:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com> <ZcGkZslfFLP8wqUr@google.com>
In-Reply-To: <ZcGkZslfFLP8wqUr@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 6 Feb 2024 13:58:04 +0800
Message-ID: <CAHJ8P3KVJvNfPhUa07j87irmbjgV8nsuCby2oASTM=QHboWc2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] f2fs: fix panic issue in small capacity device
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:15=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 01/29, Zhiguo Niu wrote:
> > A panic issue happened in a reboot test in small capacity device
> > as following:
> > 1.The device size is 64MB, and main area has 24 segments, and
> > CONFIG_F2FS_CHECK_FS is not enabled.
> > 2.There is no any free segments left shown in free_segmap_info,
> > then another write request cause get_new_segment get a out-of-bound
> > segment with segno 24.
> > 3.panic happen in update_sit_entry because access invalid bitmap
> > pointer.
>
> The goal here is to stop f2fs when it hits no space to write anymore?
Do not let the system crash now , and add some sanity check to avoid
accessing  illegal memory
> And, we need f2fs_stop_checkpoint() at the end?
I think it need indeed.
thanks!
>
> >
> > More detail shown in following three patches.
> > The three patches are splited here because the modifications are
> > relatively independent and more readable.
> >
> > Zhiguo Niu (3):
> >   f2fs: correct counting methods of free_segments in __set_inuse
> >   f2fs: fix panic issue in update_sit_entry
> >   f2fs: enhance judgment conditions of GET_SEGNO
> >
> >  fs/f2fs/file.c    | 7 ++++++-
> >  fs/f2fs/segment.c | 9 ++++++---
> >  fs/f2fs/segment.h | 7 ++++---
> >  3 files changed, 16 insertions(+), 7 deletions(-)
> >
> > --
> > 1.9.1

