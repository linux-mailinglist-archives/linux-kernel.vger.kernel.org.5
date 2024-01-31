Return-Path: <linux-kernel+bounces-47221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A7844AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BA228FF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEE39AFA;
	Wed, 31 Jan 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Sk58nSeF"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD839AE6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738443; cv=none; b=fns72emgP62LH4lnytf9dBsvXH4sU4uTRcigJ/zWsHZHg8CVBQy7EMS3ZPjXrlNlE+zVTZEjqTE660xUxQc5Z54Bk9wBhAKnWWELuC1NoECniye6WTFjXaX6VChsBdvPk/9fruXM+yR8v0DBQm09O1W0K1KgEwpi3+U1csNWEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738443; c=relaxed/simple;
	bh=MAx2AM1ui04J6QtPnwU/a2AiNiYAg3CwRR9lCwmLQr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzY4XyDnA95cSZceSp9PRgnHg4OFf1SAl3e9PLtDJBwccKwjEZCGjwO911VHzH1Pg2M47oOm0h6NrUwjo3J9yoCZZeCDsoerr06jH1snw1poqutZV+KXMnZRhVf0YTqMvcS3n/oz3cPc/iO64QRBjx+hutTpuoEPe5K+Gk2R/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Sk58nSeF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d043160cd1so3926771fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706738438; x=1707343238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAx2AM1ui04J6QtPnwU/a2AiNiYAg3CwRR9lCwmLQr8=;
        b=Sk58nSeFoIZ1TCxIJ1biAxCUI/xTFOm7Yz1hUogcBzWFbMZy4sI4TqIhGRkDzzLpqw
         2s6qvZH3s/8P3r2HXffx/9fN2a6k3J3KxrI2SuHdhq+8BwNYfdsXEZd3o7jeUpluskrk
         Y9vLCJAO0puMzftKobdMgiILHTd8u/iPOqTdFm683tx+FwDup03q4VAExkha66G2qwnt
         PAWjKxup2JdegfheK3OedZw2fvT4dEhjqXBRMGZTL3lGKsrwM3laLbjTnTHOt1q7WyUM
         KivR19aQyQKLZ9pah8dct/w3wyCjQNfUU13O5SeObjCrfvsbM946uNxQ9u2jEolWpmYb
         qHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738438; x=1707343238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAx2AM1ui04J6QtPnwU/a2AiNiYAg3CwRR9lCwmLQr8=;
        b=OgzbEj4OuGfs8NKy8a26t8s5tzxKj4ccceLRyZ5dMpsBlQQyT3yzbmyDxDRnJBItQ0
         pQGjHXiehMpJmAV0Vr0239QX8IwlJkxcM+OWQzVeJr8w7TLpbb6OqWYskKwA4l4Oq8mI
         /A3L9jilKiPrKx7rXWIo6/n3xpxyvBy3IdF5mOeulrosuzrzyTOxNG3ijJ29jAorrQGF
         d9co01dK9peld04P5kusMBOPOps7FdTqeNIdPsLqz23AJAeL6z4HC3R5YWLfVOs0svYh
         aykBlabe3jTD4Qx60Pb+UbfOyYFEa0+uzcRJc7SzFNuoc7H33Dm2mZH+JokWVaqSutkL
         6vEg==
X-Gm-Message-State: AOJu0YyiviY7NHhNDiU4E2pfL2pabr2Mehwy+upLDONyWT6YqgMtBXOS
	GclM1xGZlwPjtdCKj7D8y+HUiVh2GvTzFU357P0nqOqm2xOCR3BB0AhWmk+qJgiDCISLNzKkrXL
	V9g5rSdo95YVwvwL3leD2dqrG47k4UchCM+K2kOl+qAadf+rx
X-Google-Smtp-Source: AGHT+IEzf92DpVDPx1aZr0SaJKqyjhXJ1ItLJLPkjWmQ8MBpb4F7RDiorzXx1a8ajHes70qTufhI7MH9FGG+8eRTBVQ=
X-Received: by 2002:a2e:a499:0:b0:2ce:708:ae85 with SMTP id
 h25-20020a2ea499000000b002ce0708ae85mr1957030lji.47.1706738438608; Wed, 31
 Jan 2024 14:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145008.1345531-1-max.kellermann@ionos.com> <28b1d750-fa74-4279-b292-e36cea995e80@infradead.org>
In-Reply-To: <28b1d750-fa74-4279-b292-e36cea995e80@infradead.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 31 Jan 2024 23:00:27 +0100
Message-ID: <CAKPOu+8QQnMaZG33wyR1EzoifHD5kjSmjf2FQ9Y9gGdYN9dgJw@mail.gmail.com>
Subject: Re: [PATCH 00/28] Fast kernel headers: reduce header dependencies
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:44=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> How were these (a) missing and (b) unnecessary includes
> found or determined?
> Did you use some tool for that? If so, which one?

No tool, just stgit to edit the patches (in arbitrary order). I
reduced header dependencies, but got lots of build errors because
symbols were missing in different sources, which were previously
fulfilled by indirect includes that were now removed. I fixed all
those build errors by adding missing includes to those headers, moving
those changes to the first patch.

I found the unnecessary includes manually along the way by using "git
grep" to find all include directives for a certain header; I checked
the source for the reason why this header was included, and whether
the include could be replaced with "X_types.h" instead. Sometimes, I
found that not even "X_types.h" was necessary, but no include at all,
so I removed the include completely and had those changes in the
second patch.

The first two patches grew along the way. It was refreshed over and
over (with stgit), while I was editing the other patches.

I know there's the "iwyu" tool, and it may be helpful eventually, but
there's so much low-hanging fruit in the kernel, iwyu is not useful
yet I think.

Max

