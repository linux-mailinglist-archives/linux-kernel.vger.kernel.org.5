Return-Path: <linux-kernel+bounces-65852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F748552D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B51F27F61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F413A272;
	Wed, 14 Feb 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLYzUw5G"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8116139575
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937147; cv=none; b=W7CyIsXwefmG+sjbX9wBoq6PE+XKC1ongnEFAnwLCuKM5305arWDHXPZ/mVXSIeEaKIZa9Df5MZXcFNHLSEc1R0dkL6XSbYJSfP84mYTZp4jlEM6U/RfL27eGV5KV6MW7gAnCwMTHLBsfqJ3jFoIzdX4QwDKyoeD5zzKVifw3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937147; c=relaxed/simple;
	bh=LVKSgLXhgHGnX3uNGwybMW+jYWMm2oZDEzcSI8Cl4Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jo9GyVGoC2WUzi89VxDg6OkGRd5KtHnI92QtNLvgggoH2Cp+Ub117j8k4UYTbxZjEjNik7WJQPMG/nLnA8wIXS32v9zMmSRdiHxwXQSURQ9Bl5vHLK4WGXZLTGIqZ1aliZxSZLv0j2P0GTkv1TctV8vIXr6kmgSv2lZcsxTiMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLYzUw5G; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso3505349276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707937144; x=1708541944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cy/7mXMaq79M/86eaI7actCw/L/OIE+F6++hCFelo0=;
        b=mLYzUw5Gz2l58L+kd9VKmv3SIlCGgLuzLaup1yAgKj6H5H7TCvVx4OBZOJCw56K/1o
         Qh0YELX5Js9V/DRrAIrn4Cl6Kd7UnUX43cxeXP56bDSKehlBZzkIlnrHlf2xxC6KYa50
         Im49lMVyAovRmxVqr3az0nUR98fKh7LrgoTdtBDFrhnCh6wq6Njua0LUAW9T4cfCMaYU
         0GYsy939cO+b/S+laitVD7mV8jKj9j+nyzDPb3qtzOrpfrsT5lpfqEXRNy2gBTtvFSX0
         JP+iEoCg4/ZTjAm9cY4Iz3UAd2PwZR4cnoJkgBb4FWcipAg7GtU27BOYYZLD8cAAZVEr
         vlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937144; x=1708541944;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8cy/7mXMaq79M/86eaI7actCw/L/OIE+F6++hCFelo0=;
        b=gBFzhlIRku+unc1YBQENk5vQuxNW/zz7piAIB2hVdQDeVnFcJxQXEFpAi54oHaqnMh
         EMYKvvGGhnmCkDfiVGMkbBhUFV1qGIJbIC+98trf5udp8W8N0o1wgGeZ7imTqcry9tpU
         KN4Ys4hfk6ABOpFTVc8NSSHbPPy+K8CKUDQWPFyVb1nuqttNcEGWbgKqSBpS4b5bmUrR
         eCxsJRIxCfdUkraacChCg56UQTuxyqyVEiv91soAjqOam2rkSO0S6y+DyjLmmezyrnU0
         Rqx8kn7a84eNS5FFYd37GCbbyqIQw+te4stou48iFKLtibW+0Iu+TGsvD/kyoE4wTNrg
         MNnA==
X-Forwarded-Encrypted: i=1; AJvYcCVaNE57dP+C8WjSQ/Gs0a7kwQQDeWOVoancjtosyhb7jOOMhiSq9JKZ1Clb5ZB2P8Ukw4T5w+Xik5tUfOsyrU4mHX8ByWOkmo+O+3Ax
X-Gm-Message-State: AOJu0YyilNPBn8MywV0oF5w4feY73aWGLqu7wiSi31rXa6aH89veGIRH
	ckjOX39b5SgC8wmNGymC6zqFKAXed7ezrW/Pn380hZ+/+9l/pCDzc+3CX1O7kjTsDGdAEkxK04Z
	ldyRliSHawq7DUl/9dQ==
X-Google-Smtp-Source: AGHT+IHSlBCRYHEyQoZ4CfxjV2Aj/enfQ4vJKY+6w4oEFPd9x/LV7DNhFahImFW0J8drZSJiyHAVJiJqQZIDQ2RK
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1885:b0:dcc:41ad:fb3b with
 SMTP id cj5-20020a056902188500b00dcc41adfb3bmr101625ybb.10.1707937144674;
 Wed, 14 Feb 2024 10:59:04 -0800 (PST)
Date: Wed, 14 Feb 2024 18:59:02 +0000
In-Reply-To: <3f7490bb-a36e-46aa-b070-7e6e92853073@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
 <20240209115950.3885183-2-chengming.zhou@linux.dev> <CAJD7tkZcL6=dYCHv4XvQhRXgszcevGmsZfeg12jXpzLyy4YH1g@mail.gmail.com>
 <3f7490bb-a36e-46aa-b070-7e6e92853073@linux.dev>
Message-ID: <Zc0Ndi58Y8r4_Voj@google.com>
Subject: Re: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate
 batch when !folio_test_lru()
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: willy@infradead.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 05:54:56PM +0800, Chengming Zhou wrote:
> On 2024/2/13 16:49, Yosry Ahmed wrote:
> > On Fri, Feb 9, 2024 at 4:00=E2=80=AFAM <chengming.zhou@linux.dev> wrote=
:
> >>
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> All LRU move interfaces have a problem that it has no effect if the
> >> folio is isolated from LRU (in cpu batch or isolated by shrinker).
> >> Since it can't move/change folio LRU status when it's isolated, mostly
> >> just clear the folio flag and do nothing in this case.
> >>
> >> In our case, a written back and reclaimable folio won't be rotated to
> >> the tail of inactive list, since it's still in cpu lru_add batch. It
> >> may cause the delayed reclaim of this folio and evict other folios.
> >>
> >> This patch changes to queue the reclaimable folio to cpu rotate batch
> >> even when !folio_test_lru(), hoping it will likely be handled after
> >> the lru_add batch which will put folio on the LRU list first, so
> >> will be rotated to the tail successfully when handle rotate batch.
> >=20
> > It seems to me that it is totally up to chance whether the lru_add
> > batch is handled first, especially that there may be problems if it
> > isn't.
>=20
> You're right, I just don't know better solution :)
>=20
> >=20
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  mm/swap.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/swap.c b/mm/swap.c
> >> index cd8f0150ba3a..d304731e47cf 100644
> >> --- a/mm/swap.c
> >> +++ b/mm/swap.c
> >> @@ -236,7 +236,8 @@ static void folio_batch_add_and_move(struct folio_=
batch *fbatch,
> >>
> >>  static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *fol=
io)
> >>  {
> >> -       if (!folio_test_unevictable(folio)) {
> >> +       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> >> +           !folio_test_unevictable(folio) && !folio_test_active(folio=
)) {
> >=20
> > What are these conditions based on? I assume we want to check if the
> > folio is locked because we no longer check that it is on the LRUs, so
> > we want to check that no one else is operating on it, but I am not
> > sure that's enough.
>=20
> These conditions are used for checking whether the folio should be reclai=
med/rotated
> at this point. Like we shouldn't reclaim it if it has been dirtied or act=
ived.

This should be explained somewhere, a comment or in the commit message.
=20
> lru_move_tail_fn() will only be called after we isolate this folio succes=
sfully
> in folio_batch_move_lru(), so if other path has isolated this folio (cpu =
batch
> or reclaim shrinker), this function will not be called.

Interesting, why are we checking if the folio is locked here then?

>=20
> >=20
> >>                 lruvec_del_folio(lruvec, folio);
> >>                 folio_clear_active(folio);
> >>                 lruvec_add_folio_tail(lruvec, folio);
> >> @@ -254,7 +255,7 @@ static void lru_move_tail_fn(struct lruvec *lruvec=
, struct folio *folio)
> >>  void folio_rotate_reclaimable(struct folio *folio)
> >>  {
> >>         if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> >> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> >> +           !folio_test_unevictable(folio) && !folio_test_active(folio=
)) {
> >=20
> > I am not sure it is safe to continue with a folio that is not on the
> > LRUs. It could be isolated for other purposes, and we end up adding it
> > to an LRU nonetheless. Also, folio_batch_move_lru() will do
>=20
> This shouldn't happen since lru_move_tail_fn() will only be called if
> folio_test_clear_lru() successfully in folio_batch_move_lru().

I see, so this is where we hope lru_add batch gets handled first. I need
to think about this some more, let's also see what others like Yu say.

Thanks!

