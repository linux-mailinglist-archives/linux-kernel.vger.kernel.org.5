Return-Path: <linux-kernel+bounces-125531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779A8927DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D821F22225
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280D13E410;
	Fri, 29 Mar 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7slhIF2"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544F64B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755390; cv=none; b=B2xBJXyAF+xCt+7PkGMm+3ww9E4DVix9mHcowghTX0V/nXMhpISRxayOFPGVgpnUrpHLbXMlK7k6kdGyGEGV8ulPsOxkFYFRUYb9sXDCqDPQOyRRrEcQvDfCudZghpB/0wU2d0CM0LTGX1jGjMRl7WAq6bZNw1s6hTinT2XkJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755390; c=relaxed/simple;
	bh=z3ws0GiqfaPCvaP9VcCCnewH75CZLc5KkLizkP97z2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJW4Rb3Kbor/4HdKy2y3CqP7fqL3NBUHIiSEb5AQEvNG2+c4duGj1J1doGsmAgsBSZct0OoikS1/9a9ZmjOAy99KmuDwgGEHYl8OXEeG8tmgpYPJE3qRcNSJAMs0Zz9OMGUazuN4yhqLI6sqtvq7EZ+iKMZab1yttjOrLtYPfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7slhIF2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1992031276.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711755387; x=1712360187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3ws0GiqfaPCvaP9VcCCnewH75CZLc5KkLizkP97z2M=;
        b=e7slhIF2Poej7FfS4d6SxKo+L8d3oJBxPdhX/JSz81GDut3kwXj8ACCLiiU1snlDk+
         mslJZOzdPbvcwkTPviA7hUHB/tPhiQ1Xlf1BP9A7EK8vlm3xa5NBOAUzcUfSr5GFGjcL
         5jV6jjvh4gWx+3TE0XLgMULCBfbEh4vJjesOqo2L2oN+zAnkKrE3uPynyFYqUBxhUTLr
         iKYDdgJ7bq39AeO36XKMM7zvRBuHjCgJXrJEkAyXffqAhqwPDi4M/da7tDaLaMjQL0vj
         kqyd+ABm5eV19N57a6hx5IgymvNtGECZ/kzCfl5iNon11htgh1MwsDVMRDFRiOrJIqJc
         +7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711755387; x=1712360187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3ws0GiqfaPCvaP9VcCCnewH75CZLc5KkLizkP97z2M=;
        b=ZJDVVOGY0v6/R+sQ5xazvtAaIdsOGahBXqCEdiv9TKOt3yDmD0tCFsbxi3q7Ox9+Mi
         MVNVaDL45rdyUftIFjF986SpTNtwewO3aGSWXRyuSCrOBajDyOEqdPeZy3QLOcO5sXE+
         qIRsN+t9mbYVIbToYDS2oJdUbowWNK/dUsWkKRlTn/I/mROl0lo4OVf/BtbK+OzobArk
         kUbZxxS//o0ZFAZ0gbI2XqR4odElbSM9+GY1BVYkfdav/4hpayDpPrPKKxqDvt92vgAW
         Oa3QgL/rE05zAKlhYJ4jYoQzzjK5s5z0rsWNAHErRXJdUFlLwrHc6lRkRdkaJp7GfW5q
         2kKw==
X-Forwarded-Encrypted: i=1; AJvYcCX1oRf6X+rz1adxHz/Rx5Aw6VZxnP/06arJ0MykOVicHcPu6cQlr2EM3K2goE2NGfJ4SGo1eu6VqahnnqM3fvfPs0CNdWQbCE/SL5E7
X-Gm-Message-State: AOJu0YwPZlEPSsE9CXIzpl9b0zwG9B6PIh58vE5bAysjrQAF7lq2FD4L
	82NEkfW6+1XpfXQFdOgwLIulSaGJClWhP+3YlGnFh+Rqcey4JQBxgdLAIaokvgTNrUWyykDCGTR
	fnvbUMrwEWRISboXoKrappA0eVbcsWCtBP/h7
X-Google-Smtp-Source: AGHT+IGJk7NU8MrL8Rai4C8fdDlc24klJyWnbefpAnU4Fv6NNUTsRsocqC1LxHZ94PST37mhkloThVc9PuLt5FEG9B4=
X-Received: by 2002:a25:f912:0:b0:dc7:494e:ff33 with SMTP id
 q18-20020a25f912000000b00dc7494eff33mr2512234ybe.7.1711755387188; Fri, 29 Mar
 2024 16:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327022903.776-1-justinjiang@vivo.com>
In-Reply-To: <20240327022903.776-1-justinjiang@vivo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 29 Mar 2024 16:36:15 -0700
Message-ID: <CABdmKX1swVO1=6cs+CW_g2g4g7woB5-Ks1gBzCA+iLcvpLmkvQ@mail.gmail.com>
Subject: Re: [PATCH] dmabuf: fix dmabuf file poll uaf issue
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:29=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com>=
 wrote:
>
> The issue is a UAF issue of dmabuf file fd. Throght debugging, we found
> that the dmabuf file fd is added to the epoll event listener list, and
> when it is released, it is not removed from the epoll list, which leads
> to the UAF(Use-After-Free) issue.
>
> The UAF issue can be solved by checking dmabuf file->f_count value and
> skipping the poll operation for the closed dmabuf file in the
> dma_buf_poll(). We have tested this solved patch multiple times and
> have not reproduced the uaf issue.
>

Hi Zhiguo,

What is the most recent kernel version you've seen the bug on?

You are closing the dmabuf fd from another thread while it is still
part of the epoll interest list?

Thanks,
T.J.

