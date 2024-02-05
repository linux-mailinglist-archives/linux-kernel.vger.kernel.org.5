Return-Path: <linux-kernel+bounces-51970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09B849221
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999AC1C21A65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88BC3D72;
	Mon,  5 Feb 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Tee4bMKJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E67F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707095302; cv=none; b=f7qWEr42CttKVh+df303qPnWB6AZ+7JkesEYrkSWvFh707RPBS9HAla3CO0BU/jlDWerVcQJmgNq/YBxB7cocAbWu8zGwt/AOow3W08aJL6+oAtBlcnZj9wKAbhUl4OT2P8pUQ8IUgl3P7fjPq0tMbDUS7yo8c18rAfOKgMxWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707095302; c=relaxed/simple;
	bh=v4LFyJ1t1UIFUEEvXX1msKSzIfXiNFqjufeQP0rdzQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmRE6JWdp9z7d1O8Sfnr0ff5cSPRRwhOiVse3D0lvM3TIXiqqelmXM5Z0xVNAiDxx+hUL5aK2wlbUAXd6+Jhn9kDToCXxAdO5kSX7rTlyry4EXTyYEA0R0Sx/3vAr2CIPVT0YirzjA9Ywo26ZYRcLM05KwlSFIaop8Mfg9TOcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Tee4bMKJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0600551e8so45735531fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707095297; x=1707700097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdbAwEJl1rtLFB4DCgkdORCmvUIdyteBLrK16DC7n5s=;
        b=Tee4bMKJEWUzygKRKjNEQ2gQc8zsC7JWogr6a6HGkEdtjbBRoTQ1FFSU9aVmkkBHjq
         NmCYMhouwWJj+oro2m2vAHc36+BKLmfwm7xM6jZWAprnefUmP/FpYC5Tpz1n8WFPrIUy
         OySgp8c/BUne5I91L60KPJRrCdLMuJwoaVsLf1amkbGKoAjo+HlhcSB8+cAw8N/M011d
         EQEVCVXSrPNBcHhwb5COtA2qvOCph7wncfRu4smry6PGjiuJ0ZWpY2NAOb6p4GtOb1JX
         96dDZBPVC2tGKkHYf6hPJYfFIv0zCp6TQsQtNoyPQ4Nw4l7ZT2+es7SBnuWZapF8AaXo
         A/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707095297; x=1707700097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdbAwEJl1rtLFB4DCgkdORCmvUIdyteBLrK16DC7n5s=;
        b=GEvNUe+Juvdz9S60E2XujV/glNFv5ASHa4wAJzowrG9HYg/jzPTb2jn6i9ylu6oy25
         5qJvhxasZPEziKfJ0fvzynKNXgWbq703kUKkl3+d5DLGyChwKuEaUGsUJ+Wxjh5Udk8w
         aneR5T1ZBHitoHHaTWNqGObgq5gPJJ7BjDFEMioFF+ANLrxFTWhIAbm+ijPdUrZ5ZGLD
         g4OE+IKCnyhqDldFFszFG33TzzEA07cqbadKkTWjrCVAMykz+/Af7Ae5XZjopE8t9fpC
         +8lbO2Sx7bJUPT5Lr3eWSOg8T3uRb8cxrsUs4Jm1AWwYpWOvzDMcHWom3LcxalVzRuSz
         i8QQ==
X-Gm-Message-State: AOJu0YzJbLMn1v/TOKwB+RCCN5h/sLNnjnR314VPgTVR3ACQZY+mV0xB
	vyzeuvHnuH1SrEaSgKhlqr1bZJCZnoQZecg1KL/3BHpGh396P+O7oodE3/B+Y2csG1lUj74tFes
	FRN0mNnXm4i21JY4fUlScS1P7LV58OR+ncq8qLQQKi4XZTai69eY=
X-Google-Smtp-Source: AGHT+IFIxDhTYZTdpOKgpyaPb/SxbPhb9q7aB7kBJBo5DGQLfQdn1ujQgPcy3Jiw+c0s+wmjSHKsUyNvg+zivQr9Nec=
X-Received: by 2002:a2e:bb81:0:b0:2d0:a4fb:ca92 with SMTP id
 y1-20020a2ebb81000000b002d0a4fbca92mr1585980lje.7.1707095297408; Sun, 04 Feb
 2024 17:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204125404.2112384-1-hezhongkun.hzk@bytedance.com> <Zb_bhO8Z_d7VUCdJ@casper.infradead.org>
In-Reply-To: <Zb_bhO8Z_d7VUCdJ@casper.infradead.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Mon, 5 Feb 2024 09:08:05 +0800
Message-ID: <CACSyD1MEM+KnNMimmbdSFXOsok9S=vN=DxzS9x90_6+pt5qjFA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/z3fold: remove unneeded spinlock
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:46=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sun, Feb 04, 2024 at 08:54:04PM +0800, Zhongkun He wrote:
> > There is no need to use spinlock in this section, so
> > remove it.
>
> I don't know this code at all, but the idiom is (relatively) common.
> It waits until anybody _currently_ holding the lock has released it.
>
> That would, eg, make it safe to free the 'pool' memory.
>
> > -     spin_lock(&pool->lock);
> > -     spin_unlock(&pool->lock);
>

no,  please see the commit 'e774a7bc7f0adb'.

        spin_lock(&pool->lock);
-       if (!list_empty(&page->lru))
-               list_del_init(&page->lru);
        spin_unlock(&pool->lock);

The original purpose of this lock was to protect  page->lru,
which was removed now, so the spinlock is unnecessary.

Thanks for your time.

