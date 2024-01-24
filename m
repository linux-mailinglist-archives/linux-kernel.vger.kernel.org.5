Return-Path: <linux-kernel+bounces-36441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9283A0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A063C1C2175B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A00C2D2;
	Wed, 24 Jan 2024 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K36wELUG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E2E541
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071989; cv=none; b=Qj7P1ShQIUymE6Gh7Cwbnwqgwv0IFMJAgNimw7IHiHQNwxzP4dt5L6tVERtaHlFrr4p3bP6fvK4bupnsPDxumNYQDrAFXEVUlNHSD8yCdUEvXpJMzHRQj2o/L4PeM9weGwej2QV4bpIh5g5ZCMzQMMY4npDkeJySNq2JgntiMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071989; c=relaxed/simple;
	bh=jbbOrSG210rOp8pDrzickj6q2E2LjgjMyvfy8tdCtvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDxxDwd1kODKCfBmUAYLA3UDzarI0EOuS4o1mzkHhk2x3F3Y3cBHxf5ffIIyWCalSru7NHUaA0NVVRqkKmRHMcy56XBmHExv/sY5lPoGeQyHEUErVJKdzCSdCO+hfcT9d8SKjChXqgSENlKPoH3gkkhbmLpqqmSiEW3WUlhADPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K36wELUG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so10709279a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706071986; x=1706676786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbbOrSG210rOp8pDrzickj6q2E2LjgjMyvfy8tdCtvI=;
        b=K36wELUGOWvuGNQuP5K8IKcDColB+U0jWN/IDyUJbLi07ARVzgmyi6fVhvxj1S6//b
         yiHnUoOs95E8eIFSHnY6dYKjEjK0r+mmc5ULhPzV3UcZcQJuqOinlwUT7vYGkWYiXgWk
         A3NndeFerWB8hy77eQusaKfIbKFFHQRRiefSBYZ4OOTXH+Nf2DT+DO8AcU3Hs9mxOmr/
         DSEgbX3Ew1eelqMqsgJwytZtZspLl1/oxXmeVI0Wjj/EMa0oCuvKNqYohLS11usiksPH
         hFz21ERKNuaZIFA/w3/X8S0idI/J2XKlLy9szBtNE2yAp3Vf0Gy4LLYigE+z+p8mXy2n
         oiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071986; x=1706676786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbbOrSG210rOp8pDrzickj6q2E2LjgjMyvfy8tdCtvI=;
        b=wcvd8T9DAjrRFt5ssrz/ZpJk5xUF7JpbQsWoNgDixs7khBdq7ZIF0BiiIdD9WP1BFJ
         GT9rY6sXYCA5Vs6depfMlPGmYErexgI+nUsauvmMYDOPrq0VEtS4TCHiljEql1fC9mPs
         P9j7Mfo7rG6/l8CCK35pQL3WHsHRKcjwjbwGBsHDaKcebrp4gtaY4LzwNlR+wNaVC+xb
         FECrh7xM9EFC7igzYuPzW3wqHOfnd1iMJOVyjdDzPcKuOjWk6hvZg0OFPfCuREwqOQI8
         KGXE3k+sZAq2d/mtzDa4ExHC8ESiAXhmM4scI1kmdbuQ1ER881svSLqWlijdCAO2maDz
         Y2Rg==
X-Gm-Message-State: AOJu0YwmMSiJms19MMgNJJm1GZN+0IQdygl9O7kbJae/ttfJsexj7tIo
	5lHSIcRrT9lghoGV/3mwTJOGdmoBah/bQDvRuWemyYamqR4AjQxbPKJgL9bbbaazE92d1yn63/i
	C/8OKzMcX/mrmWrplfvQ8yrZ1rzs6DGEw7OrY
X-Google-Smtp-Source: AGHT+IEsQe1YFNd8pR55+rNboWKDDEVrJaaGfXSbJE8aX1qVrBqLFI0F4Pj4taUHbIwaD2FS2o1UjbCmRXziX+zwKIs=
X-Received: by 2002:a17:907:77d0:b0:a28:a7cf:b014 with SMTP id
 kz16-20020a17090777d000b00a28a7cfb014mr673835ejc.2.1706071986187; Tue, 23 Jan
 2024 20:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124045113.415378-1-yosryahmed@google.com> <20240124045113.415378-3-yosryahmed@google.com>
In-Reply-To: <20240124045113.415378-3-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 20:52:30 -0800
Message-ID: <CAJD7tkbCyW7rOHH+32vY962QKDQj89xF4knUuqCx6PkeYHeDoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: remove unnecessary trees cleanups in zswap_swapoff()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:51=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> called for all swap entries before zswap_swapoff() is called. This means
> that all zswap entries should already be removed from the tree. Simplify
> zswap_swapoff() by removing the trees cleanup code, and leave an
> assertion in its place.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Johannes, Nhat, I didn't carry the Acks forward after the rebase as
the code changed significantly.

