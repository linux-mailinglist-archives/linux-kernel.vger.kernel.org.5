Return-Path: <linux-kernel+bounces-50621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFE847BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECEA286E21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35C8175F;
	Fri,  2 Feb 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+2bvFHM"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3A8173E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910180; cv=none; b=UMfqEu8518J2P1DCH7W7ddkEupJTWHJpCDxm0Q7dHMEMEIHAY/x1S1bNnOIqt1GnsRFB3t0ebbkcELn9X4g7olLCkDNd4tE1SW5OyJsA5RH63SEk9I0wIYKJ77MtfLvATJDCxcyD9B6ndMaFntQkAkOUX0R/2844hpWAU79eGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910180; c=relaxed/simple;
	bh=JMTAKCnlm+qRofrbzQT0twQWPmdB7rbVAIRwYv4C2eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfb6XSGvy1Uf0wISC1uH2s53AGDjh6xpRqpJChFJoF1TkZGrSoARyjW8H0vIOzNELV+E6sfj8dIq9LeC+jIJ5DcvJnsEP1RiUYXZmIQ3JSmev+EJ9PDjqN2Md+pM5/1L2XQck2zRDoNvIxt3pz3GsrSVji3UA26wtzjw0qCoGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+2bvFHM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604255f581cso15923357b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706910178; x=1707514978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMTAKCnlm+qRofrbzQT0twQWPmdB7rbVAIRwYv4C2eY=;
        b=b+2bvFHMt/shTzmoWL5DDZZanZduRvwtWMeUbrg14JSv2o7g1pnYM/zyRPFdH4qh3D
         HiUgbmp9tKe76sIoeliVx0cT69mQufXj7x4YxQaFUI2BFtzjQ6eXRaNsheSgxgN6n2rT
         VXLZX1KMWi9Lf0lQgHfxgg2p7pyIS1DUIw9yq0/SWbpibBx+PtLG1J2V0/xNaCz7JoXj
         3QDoos5dwjaz1f0YE5obz3nOji7n44OFf7yNeOawOPLQdsgR7PufauTBjYU7r03UCb4I
         Y0mcstiM0mAf4an21kVUtTTcQT2VpeqyGA0txzucY74JjbMPZB0q41tFanQisdRsr+2I
         sFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706910178; x=1707514978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMTAKCnlm+qRofrbzQT0twQWPmdB7rbVAIRwYv4C2eY=;
        b=l5mPQNNyCmrcFcbaFDdOr3B7za8bXHfgPoZaVYZB7c8FkMKemkVcO/bTA+WciBn1Hx
         5tVp5L1aXSruf/mVWiHG2Z/vM4PwI8NteuKkeM7F0+6Frypl3Vh3i9DPn4zXyoNcG9Li
         QjJE3Smnt+RZIxUz072sSsEUCTAV9OHXglNB+x8JWj9e3PcnQyY2dMZPoIaDmRvoCXvu
         cMmuzwD3ZT6sCMI/3LPXLoiVsRJYVZ6wZtup0fbfMvtRxIRHB8Xx7XxtjL0rnwuguVfj
         Q6XESq2Z2btSvV8VIaEGaZzFnUUXAf8TFi48xnySVjzcykOl5DOxdG3wlttIcHjNsHCL
         kXfg==
X-Gm-Message-State: AOJu0YzghbgrwIf0TC7FSZPGSWH67pvA0xmuamRuKg3kB0Cr0PGpBqGw
	Lo6W/dp0kKNG6tI79+iNruv09KVRrIny1NpF2HMI5ydfk8+punraGCYTkXFCPq1iIZl1H+Cc+QT
	ul5o3/X4AqGZwnoYZAVPtKqFA9elNfTXS3DdD
X-Google-Smtp-Source: AGHT+IHCXjtFXHPMmcjKAuZloPxLqvRZDzLRsio77BcVGOg3RTtHzUSiPVrgFhG7UEsNkzW/caKJn5/hzaqDvapj1VY=
X-Received: by 2002:a0d:d495:0:b0:5eb:3851:2bba with SMTP id
 w143-20020a0dd495000000b005eb38512bbamr9522889ywd.41.1706910178189; Fri, 02
 Feb 2024 13:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201153428.GA307226@cmpxchg.org> <20240202050247.45167-1-yangyifei03@kuaishou.com>
 <vofidz4pzybyxoozjrmuqhycm2aji6inp6lkgd3fakyv5jqsjr@pleoj7ljsxhi>
 <CABdmKX2KsxVExVWzysc_fQagGkYWhqRF00KxNxjpVWovHHip+Q@mail.gmail.com> <bycpbzvo2fpd2qrrl7ipnzrsyun7hg5tjlqouafuosxxlxfml5@vpbl6kl74hx5>
In-Reply-To: <bycpbzvo2fpd2qrrl7ipnzrsyun7hg5tjlqouafuosxxlxfml5@vpbl6kl74hx5>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 2 Feb 2024 13:42:46 -0800
Message-ID: <CABdmKX3Be=AHSvHOa7NQVapb5pdL9pk-oW_yyxG3NuC4D9aCAQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Efly Young <yangyifei03@kuaishou.com>, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	android-mm@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeelb@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:46=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Fri, Feb 02, 2024 at 10:22:34AM -0800, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > So all of these should be more or less equivalent:
> > delta <=3D SWAP_CLUSTER_MAX ? delta : (delta + 3*SWAP_CLUSTER_MAX) / 4
> > max((nr_to_reclaim - nr_reclaimed) / 4, (nr_to_reclaim - nr_reclaimed) =
% 4)
> > (nr_to_reclaim - nr_reclaimed) / 4 + 4
> > (nr_to_reclaim - nr_reclaimed) / 4
> >
> > I was just trying to avoid putting in a 0 for the request size with the=
 mod.
>
> The third variant would be simpler then. Modulo looks weird.
>
> Oh, and I just realized that try_to_free_mem_cgroup_pages() does
> max(nr_pages, SWAP_CLUSTER_MAX). Then I'd vote for the fourth variant +
> possible comment about harmless 0.
> (I'm sorry if this was discussed before.)
>
> Michal

Ok great, let's do that. Thanks for your input.

