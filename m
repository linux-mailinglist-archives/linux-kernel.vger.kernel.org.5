Return-Path: <linux-kernel+bounces-103746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1387C3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD5CB23131
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA776034;
	Thu, 14 Mar 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRnS3UAz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EF74E21
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446480; cv=none; b=pJV1UY+OEBtnmRAfQP+mEVtPADNmYELzNlXHE9Nb33yaRvdKnVFV71boMmaSn1VEDFgB7RtWsmtQHkSmvcTpEneD4o3F0w4MJmc+/KB3s4cdjPROMLQZBLjzpiu8GNBIO5hnw+dgEzaZLwZwrvng2lwKswwtDc2kbb30S5d/86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446480; c=relaxed/simple;
	bh=WzR9A6+jj11uhMDYOlAcj90m7WoEANKKgh8cf4FoQ+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFFoJn9lmMCgpQ2YktWls86ZHTu6oM9WS9gmhmJ7zmGNtGCXRXRdgqNLQDnuTpQmoTg4Sl1XXLoyBVjWuAw6Iv8DdGf9aKOFANhgE+HW6x/1dhw6BTXIUl51FBjUcjSHLF1fyi6l3IC0OlW9mEgv5ikuojs1X9ZEj7mPmcUx5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRnS3UAz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso1042382a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710446479; x=1711051279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6pCffNMKzoDGTKw4n/6Ob9IQM84n1hQBuu01Y8Xtu8=;
        b=kRnS3UAzYvTCDTuL+ZsA6ZKqmr6IUmn0Tj9tBmvXZjJ3f5Z4jxZs2CDxp3NH1w+c9d
         Zb/Amox4Ha5XID6baLZGDveztJCA4Kp1OIek5hosVsxpcV8zf0Jd/QTU0fpY3WnUYURY
         yS7oAd1pOxiKJt6ll6KnWQKNztLItGpKq0EamoXK58C6+Jm7k/h4nyAwf2qQWNrjV+u0
         qgsX1WWEO6gLEIHoGBrS4nd617UXjy0mMkAlDVqwDbfAz7TIKvQgZtl0PyjyWpOoH4YT
         6QN4iQBN+0GuK/kxRm2HRWbYFWnVNn2K8oKBeAPARfeHuRftNySbJyFigp3Y2vRrnvMS
         JjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710446479; x=1711051279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6pCffNMKzoDGTKw4n/6Ob9IQM84n1hQBuu01Y8Xtu8=;
        b=HqdFDhnipeS1y8Lu/iKgj93nKGqT/NVxQmAJ0Je35DVEgqSXS7+elmLAhTN3lem3Zi
         mG8MPauadxXW+r+CafKgse/YSTu/t2Y1V3AatYBbrTgfzJ7pGTf/Wu2S88nfMFW6B+ub
         fGjn1BLz0iaBLnKOgRQqEpAEejwAwTtqqwlRArXBacvnzqnj+ftV2PiUs/0XgkwPfOwR
         /Mxem5XIZRNtetbuvM72r37dcz6Yc58YS5iOPrIxZZFSpWpbAsgtF5TF600LL3A/iWVE
         ctw+TiLAkqB/Rmiiqn3t1qSgj5VMvlT0UU/FOrTXBU0NZH+Lhd6MD4if47HHYqMy+1R0
         Cp7A==
X-Forwarded-Encrypted: i=1; AJvYcCXijzRcqVnCuYfbWOyeOGfgqk1TEacXNNja3OaHs2jJTpo3I+QGZ0iGtaDxcjyF85Fr2HnDTqaf9gUiKzkE3bufJlp+X1argxol2NgW
X-Gm-Message-State: AOJu0Yy2wCq8O5uxcsmxWADJMtL8FEpPo/+jdyFpUZwFPlTUqlBl82Ic
	Q5YSccioBUWD16RQXDzy3M+1/5jty0kw4K5bJzCkJ+2nXHKE9jmq2x4SybBfkfvL2g==
X-Google-Smtp-Source: AGHT+IFKfU2NA2q8Rlp50xG0jix20Rw9KJIZR9SH6PcuXiddyRxwquv/7vX3A/fr9QnaaO/eg3bUAzQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:fd43:0:b0:5dc:aa2a:7766 with SMTP id
 m3-20020a63fd43000000b005dcaa2a7766mr8215pgj.2.1710446478832; Thu, 14 Mar
 2024 13:01:18 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:01:17 -0700
In-Reply-To: <20240314122533.419754-1-liucong2@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314122533.419754-1-liucong2@kylinos.cn>
Message-ID: <ZfNXjd1ML2WJwOKX@google.com>
Subject: Re: [PATCH] tools/Makefile: Remove cgroup target
From: Stanislav Fomichev <sdf@google.com>
To: Cong Liu <liucong2@kylinos.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Rokosov <ddrokosov@salutedevices.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/14, Cong Liu wrote:
> The tools/cgroup directory no longer contains a Makefile.  This patch
> updates the top-level tools/Makefile to remove references to building
> and installing cgroup components. This change reflects the current
> structure of the tools directory and fixes the build failure when
> building tools in the top-level directory.
> 
> Fixes: 60433a9d038d ("samples: introduce new samples subdir for cgroup")

nit: is it worth it to have a fixes tag here? Doesn't looks like it's
a backport candidate..

