Return-Path: <linux-kernel+bounces-120020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D688D05D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64B31C36A59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941AC13D89D;
	Tue, 26 Mar 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4bqrpzQ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBF3C26
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490241; cv=none; b=bVyl96p5Qlx0ShKwnnynG95zOk7WL4lRY12YdfbVmGuYANwa6Ug7i+EFvhdfJlA+Glx5yFjiMAlDTTeDc5nA+J8mbw75U4jgciTA6T1ctDDK0wxvBh0iiOcv/5rG5wl/esutniXJCb+ZDOvYOvvrW6NLo+g6dU7WExcyu51WiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490241; c=relaxed/simple;
	bh=jXtqhW7TrzvsAEXyOy5z64mjAY/B+CgwYFFgZL+QG1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhzZX3Alw501ZkE/pm9LC/SzmCw9lytZnclCBfvnKMddiiXK///uN2rrfcUewTexmRMHThUU2AICCNj3JhktD8XCuHqj5nAAztvDybQ6tHiN9RnQEvRpgPKZcbbvUtiVpggGYFphDYzut7IpfcF0c86ibSe9KCX6pq4uHuQY/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4bqrpzQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430dbcfc2afso42498051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711490239; x=1712095039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXtqhW7TrzvsAEXyOy5z64mjAY/B+CgwYFFgZL+QG1k=;
        b=D4bqrpzQ5ByrQ87dzbj5SElg2kvmbbHilikNdH4ECg//WKsfFtpcXRMHJEOanE0qnd
         JdJpZ2Y9D2SX8rSNRedz+iOo+Uw1K3Ltwid4oNFGWKGiCBIbvAuU5A77gV1y3FGI8L8R
         GqHNOa0faW2OONMTQOgPfRKRmxTFjI8zFlVSlIWEUuToUC4PBC14UW5kobDLrHBnandb
         haWQNmAHcdatAE+ph2V62m5Kgl0w1CstwmCjdAu02nHjFEiyCCVdaEloEZzleXv52MCI
         US6gc14Lvy/D6Qkwzeuvb4NShOxX7yuI9aN4iahhFieSTz5G1AUjWuQsOwY8Bwbl+h0M
         EPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490239; x=1712095039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXtqhW7TrzvsAEXyOy5z64mjAY/B+CgwYFFgZL+QG1k=;
        b=BBEurBRlSA6GgR7ggkplQb9POPNlJOm4HM52iVMHGOCMyr4niCitAsiixu6Cf79N6G
         dyob7579oyy9U6uB9OZ6iohX4glxNz8xDYvN6jVil/1f/xuSx/AuO8iHf7+M801V2Y87
         m9acCNoRd95JprnV4naJFqLctgGcNR4JymBdWP18WF7A0RL0KKVqEjFRRWPV9ShV9YZw
         Dbcluakq+gEJ/VV5rXBPupdXknF0QjnlBfselErApTY1CH98Rabb0rwfBkDYu7TkgJK9
         GQQ48KgywTqDHYaqmuQqDuVCVG9Xp3KOkCdzcFxgDaiSPv4Tvu7xZadLipidOVyv5ZHL
         t5bg==
X-Forwarded-Encrypted: i=1; AJvYcCUW3Xu/GFV9ah0LapoO49wy7JGieoft31dBLS4c0TRx10QrKewJJKqkY+lFB1tyPvRvCirZaD80o02x/dqVcVs3jGbo2i9MSz/zuXgL
X-Gm-Message-State: AOJu0YzQYNThkkwuJR1AHFbr7e923ACRVV77xowXwbr66rWlNGtQ11n0
	xtpxN3mFnoRLaNYkoNkXDa87mtDJeAULNAqf9ywkRmKB1p6fPrFFIXLcyov7ezn4vCIHcbWV0FB
	AGTqKSz1h7lmWBcpfCKS+eOJThyI2iHJeMMA=
X-Google-Smtp-Source: AGHT+IEwiQs8QUTSm0qtv3eRNdV07njB0FxU7nx1qsSrehCl42nzo+21HWXDQRIfFt2zmjQDPEa3/s/mlqYLF3/K9YY=
X-Received: by 2002:a05:6214:e65:b0:696:76bc:357f with SMTP id
 jz5-20020a0562140e6500b0069676bc357fmr1124376qvb.6.1711490239244; Tue, 26 Mar
 2024 14:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com> <20240325235018.2028408-5-yosryahmed@google.com>
In-Reply-To: <20240325235018.2028408-5-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Mar 2024 14:57:08 -0700
Message-ID: <CAKEwX=OD9_MHPLDgOC3yM86nY4BCNNuav2m=QfoJ7GNADw8GDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] mm: zswap: move more same-filled pages checks
 outside of zswap_store()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:50=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Currently, zswap_store() check zswap_same_filled_pages_enabled, kmaps
> the folio, then calls zswap_is_page_same_filled() to check the folio
> contents. Move this logic into zswap_is_page_same_filled() as well (and
> rename it to use 'folio' while we are at it).
>
> This makes zswap_store() cleaner, and makes following changes to that
> logic contained within the helper.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

