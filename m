Return-Path: <linux-kernel+bounces-41914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48683F98A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F11F213B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789C31A73;
	Sun, 28 Jan 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYd37yhl"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEC33CD3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471173; cv=none; b=oKRbK0qcMtD2VowNm/g9vgC+Lh7qCkpy/1H0XFJpm/V7Zxspl+/XDr1fHoc9ifwnddwRssxf9I25np6tEhC5lD8zk+U1j641k3LtfFjm0VS13AlMXckLBw4uv96aTzCJk9wuEQmRpw801J7sSAG0PCS4p2Q18grb4ASkxFOD6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471173; c=relaxed/simple;
	bh=wMBCuymaQLGVg6pkHDonjz4+0HoNQanG++ojQ1umdF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTEoMhx0jDy9o/ltd7Z4zGgAgKvqM7BOy3MtylgvBiDceRgoAOd8cRfuYrXQXwjGsZ0GR/UKBZP/mn70ic0c5A/B+rwftCeRvpcqhGbunsq3QtUxqTNbvQGOuQbZV9cX4z8gVOCDFavDaH6CEXo9uNcmWqfun5zzoksmhXUgj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYd37yhl; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36378ce9550so2018745ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706471170; x=1707075970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMBCuymaQLGVg6pkHDonjz4+0HoNQanG++ojQ1umdF4=;
        b=IYd37yhlfn/b85SEnkBFTZFzCEU6a1V385LDRBZbgQH9e+izBwmFw8EXGBQYcclbIU
         GjBKiuVCrYwU8GGWghbr0p22BLv78QGBnQ+WMCuM/vVyY3kvFs8HltRLHeGBixrCGCtJ
         tG2vHj0t41FfYwDd1bNMa/R+MTN6w1Q/RlzXMDh/NpmQ1dU1V7IBw7aA6or5TVHLsQ9q
         b4sjiJEQFfMlKzz5PoCHqbV/XFsONGrplNzR6OgmELZIp4BLL1NtnQyFfUoJiNz6JHKA
         dFhN9s0AspvLWOMF41oxKSZYJXBNvcqNSI6oAvXVytcchdKLJzlwejxPShBpN9QNGjFP
         EkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706471170; x=1707075970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMBCuymaQLGVg6pkHDonjz4+0HoNQanG++ojQ1umdF4=;
        b=t4mR77EtCukePZF7ydplq/aysnEqsv31xEr7KwRrYKKDTPMtK+yapJW4lmXFsjsGk1
         e67mXLsQZ5yrNNtcNZ+4u2CkLJKHLXn18IqWBbokFwnRVfUe45fQ32nhjgTEHRZeJrWn
         wEIFRpW4snEFujylgsbGrp/AKvHJKl6F8h07NMHxxcZszikGI/zbOnZX71CUPTBqcS7N
         nV5Rk7p9Gv+20vcv8CLVAZfO/dOWnQPPxMFyNmpygHbUPIUdUaBlLzQ3S/Wcv+QW9IrO
         gYERlV9t2hiP/w2Hg9nwwNgyMXXqxEjFwf8/0MtR/SWUNaUBc7JabkYEo9pPrY0SHEz1
         fpng==
X-Gm-Message-State: AOJu0YwH6eAEqgXofBQCd2q1Nj+IhgVQPXTn3FK2gj4r+R4b58bWWkIs
	e2lCRDubh7r/p7lEvc4vyn5d9zCfxsoewAppTxKxYMcDT1PJVJcO+RR9/Z7iAm3dW+J0Br1ghNb
	o8QNFdmA3+1x0pmZPM7AYupbwNHE=
X-Google-Smtp-Source: AGHT+IF/yb1xwlCBY63voHmWvi4riWQdt3Du+qgSUxHTk5rfmpuyqxSM77NrODH15q/kn4LGRy23X4e0seT2nKenxp0=
X-Received: by 2002:a05:6e02:20cb:b0:363:8030:e98a with SMTP id
 11-20020a056e0220cb00b003638030e98amr554771ilq.0.1706471170535; Sun, 28 Jan
 2024 11:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-3-b10479847099@bytedance.com> <20240128155219.GA174688@cmpxchg.org>
In-Reply-To: <20240128155219.GA174688@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 28 Jan 2024 11:45:59 -0800
Message-ID: <CAKEwX=N1q5PRqBR796VZB2NsyS5NCf+B3BwqQ9Om0mAo7T960g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/list_lru: remove list_lru_putback()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 7:52=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sun, Jan 28, 2024 at 01:28:51PM +0000, Chengming Zhou wrote:
> > Since the only user zswap_lru_putback() has gone, remove
> > list_lru_putback() too.
> >
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>

