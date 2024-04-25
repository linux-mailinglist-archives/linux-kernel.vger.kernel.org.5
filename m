Return-Path: <linux-kernel+bounces-159073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950428B28F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66661C21E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D8152163;
	Thu, 25 Apr 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qufz6E7P"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9954F6A34F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072877; cv=none; b=N1sqWv6GAsg5c4xDAtZo8pYuqU6jTwoKCMS6sEyfUAUu3SV/AeytO7O/F5+Z3vyb6mSGFUia+QdAjf/k9XZkDYeQl32PA5o2ocrlRD7B2QU28CLhF4IgjPLql0pGV6Hp6hnaAG2U/3UbYuriW0xDIEeczhoSqa+IyoXcE3f9kAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072877; c=relaxed/simple;
	bh=tiKMrgnuGs5t+2Vzz7V4lhrYygWX5b/Q90bRNF9qjvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Feuq/T9A7/8Ictk/rVKSOViftyA/01HXuEOl9wk4xTQgjQIeIEALw/dmfY4t7ptIlUo4Y81PJtmkv9UDIUqL74kyz+ld2WpOkbDBGzeCIdiaQJow+Z76wfXgVPdM+hBBclL78HH7reJ3EE5obDpOIq1wAHOeXocCEWdyaN/Ieq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qufz6E7P; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso2171021e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714072874; x=1714677674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcVqUlOTaQsisuyRSLnOaMBAN8XZpzFOBfzLktmVTeo=;
        b=Qufz6E7PVoTDPYKwxqYK7oNoeCyToNlS1vV/Ksnfl9z+h9v5q/8wBMuIPRvZtVw6m/
         TvkfvJb/6499k2s9DvSfT43E1rlsWM5DVqiQEripchEtdIgMa8ViVvgPigNf3rRALlRW
         8DSCa7BqBngimBRvAPzseE11yb2ZEkUhj9v2/PepflH0ZpXIxm6bhrYcfiJnnkiPPt7Q
         p/JrUhX5YvO9PTAA8e6eE6pZEA1hTU+iIfYV7qUdTh5wy2CYiYdoZwEdHh9f4ZLPBokB
         p+t+rhvjFwtA6TKESHC0FiQ5xXgjZ/c1Fo6OwiZVRetixr7fUR06A2qtQfw4/MeCl8Tm
         Rf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714072874; x=1714677674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcVqUlOTaQsisuyRSLnOaMBAN8XZpzFOBfzLktmVTeo=;
        b=PyYMXyk2mkeWpDA+ZjG4tm8DQWeVKymv0wYfGdg47QNQh+GFSXiZOrCxCCbG530AaB
         AgeD8Xr7KtnqtIJwJyIUVhTeTQChaWXFlZh0HlNIHzMIJczg7P7oxwsB5I2lVHg52GXq
         G/A4JeY0GJHIf9qXN1CibAQFccAHp069bJrAtd5TDJxJpFEhSwp1JLBgcG1x2sr8dM0D
         /p5Mgb1TvHNwiwwUyUFCVSrBBwy+HqnIzNJDTNje4ZOMbAk9anaQrpbw0sRatDZV2RQh
         MWBEpKOoPhzQF7ZKx5ERpGrGwg/tAoYtqhgSjTyrKhmca9aLxBTKnZRpbWh/k++pFc3o
         R2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXDtXLdae5WDzfsibIHFzaWvx6iZjDk9eYFT+4XJ9gKAEzf+gOeiHpmW/HWAcF9HGFrPfZTAEzIFCXS++UNWOc9mWNMX2hQdIFEjQnR
X-Gm-Message-State: AOJu0Yxzs22zrNBqlL+TS0NcXqiSRlQiRx6+FzgQg68C0xafLh9ISg+w
	mPjoZxhztawPNZJKEWT8v0GGEX354wPdDBS2vXp7cn6Nagy5KigQCk7en2CTuPazNWNR6Eg1BMd
	MIBYmhPOOizF/7Bmz47m7XKMh+6qKY3V6PTqf
X-Google-Smtp-Source: AGHT+IEWs436UYchdWZ+ma907GdyhFrnVCv0SRj0APG4paAKxmMnUiA23HSnyvw74sshH+sXIgi78ki1SL5aQt2USFM=
X-Received: by 2002:a19:5508:0:b0:51a:dcf4:5b2a with SMTP id
 n8-20020a195508000000b0051adcf45b2amr214902lfe.56.1714072873437; Thu, 25 Apr
 2024 12:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com> <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
In-Reply-To: <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 25 Apr 2024 12:20:59 -0700
Message-ID: <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 1:17=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Wed, 2024-04-24 at 15:08 -0700, Mina Almasry wrote:
> >  If that doesn't work, I think I prefer
> > reverting a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
> > rather than merging this fix to make sure we removed the underlying
> > cause of the issue.
> This is the safest bet.
>
> So, to recap, I see 2 possibilities:
>
> 1) Revert a580ea994fd3 ("net: mirror skb frag ref/unref helpers"): safe, =
but it
> will probably have to come back in one way or another.
> 2) Drop the recycle checks from skb_frag_ref/unref: this enforces the rul=
e of
> always referencing/dereferencing pages based on their type (page_pool or
> normal).
>

If this works, I would be very happy. I personally think ref/unref
should be done based on the page type. For me the net stack using the
regular {get|put}_page on a pp page isn't great. It requires special
handling to make sure the ref + unref are in sync. Also if the last pp
ref is dropped while there are pending regular refs,
__page_pool_page_can_be_recycled() check will fail and the page will
not be recycled.

On the other hand, since 0a149ab78ee2 ("page_pool: transition to
reference count management after page draining") I'm not sure there is
any reason to continue to use get/put_page on pp-pages, we can use the
new pp-ref instead.

I don't see any regressions with this diff (needs cleanup), but your
test setup seems much much better than mine (I think this is the
second reffing issue you manage to repro):

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 4dcdbe9fbc5f..4c72227dce1b 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -31,7 +31,7 @@ static inline bool napi_pp_get_page(struct page *page)
 static inline void skb_page_ref(struct page *page, bool recycle)
 {
 #ifdef CONFIG_PAGE_POOL
-       if (recycle && napi_pp_get_page(page))
+       if (napi_pp_get_page(page))
                return;
 #endif
        get_page(page);
@@ -69,7 +69,7 @@ static inline void
 skb_page_unref(struct page *page, bool recycle)
 {
 #ifdef CONFIG_PAGE_POOL
-       if (recycle && napi_pp_put_page(page))
+       if (napi_pp_put_page(page))
                return;
 #endif
        put_page(page);


--=20
Thanks,
Mina

