Return-Path: <linux-kernel+bounces-160832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE18D8B4362
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C511C21FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3EE2C84F;
	Sat, 27 Apr 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idQK0hLN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F72CA5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714179123; cv=none; b=Di06hU2fiFE5Ki/NV8EdtDG0AvcslwW5dIJMh8y2op2QtnMrJzcRN4iPhZbxZ67YG8n+G2XCa/3KVSyWk4yiB5HBL1Vo5KtZaf+Hx61VjYpRKnvEmdeBglS6HBNyR9bsMhFuHMWZ7yd725QDP655jiXBidv2aFUS21zdXVSfeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714179123; c=relaxed/simple;
	bh=fUScy4CDQzemTknfjsfZBWJBSrUtTixdIVJuNp4SGp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QskQefjcqmamEZdKedlBUWNMMFZct7tYTxoF3VwNtpRjPEUtzFuUnzvzyiBuxRkFwiWOu6sBTXCxs+/UL8GsIZxMCRVHYPL5rWs6QkcE85I4LGMzc8GFFiW2aN8cLeCynniYxGgYVm9iWaW6ct0MLqJCzq6DLlZc4fJrzeIhDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idQK0hLN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51addddbd4so321982466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714179120; x=1714783920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUScy4CDQzemTknfjsfZBWJBSrUtTixdIVJuNp4SGp8=;
        b=idQK0hLNdTDQb9ei/A3bZSwSfB09zG/8Kup2ObMSMnYvl9MF2jcgiF5KmUoMSIVqVN
         tZC6CHE61iBaG91QvparGrb1z0PdVFkWVjt8+4DKb2s4yEZXItIjwJomYv+rVDHfevKo
         QbaXYuC9UnsE1A4t8TBnGYq1DKWz/qZsJ8YarC4aIr1IAxFk8g9quHvSxTeNQ24Nx4hF
         WSFuE4BW53pMqyGXiY/qfzh1ceettJEct8CPlIlGwWmFd8PnATVdzs6NcDqaINnTkXXV
         +7S8fZSVJ66ohUcuPSvlAGDOtRU1coyiC0S8vUMPH865GV+qS1lOsBB5o8v07ws7wxE7
         YrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714179120; x=1714783920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUScy4CDQzemTknfjsfZBWJBSrUtTixdIVJuNp4SGp8=;
        b=dxdwWhaJoLB++oQpokAykrxD2jHqxdzjdg0CTYIqtK0mM/46Z8iIuOiFH9Pg2EevVH
         Yi7BGtAX4AUHOrsiXQqzNbJr6r3z6YjtJVIa0Jki8KtTXawhH64UhAKorTyOGJGCJwec
         TPG3ObrFBtunSzh8Nx1GDC4+0WDYfJAJQSedvpR+xLQ/ZuZ72k1WBxOERS1DflwQD9ak
         RH8FU4nZ/H2QfTzjYLDhAW0F93anYS50z8q4dzFKyLSbtqbwcE6D3cGuXO7nRZHWZX/1
         ykkfADtcP8xeNc44F5LXvlsGgJI+N9Z3dogzCffcb685PqS14sDcmcfNG0zO+lOknrW2
         /XxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAdQIxigN9RFGwqzoTBHAx/8eUkNjHH3LUuo34v+soTOTpzhGbygKqzl3p//Mwk42Jaz+cIKf8nckb02aJmfMaY+PFmi4uKexvRSTI
X-Gm-Message-State: AOJu0YxsCmdbwdQELOf3OhhtolFxpY2Y1tkinKXwCEXA3AQTGRsiaNnl
	KLITnYxpV3JOMQIs8pKKv6mVsMtvYY26xsxrClBhBvW14RwAff5wWWBtf6Q4NndyCFb7OIJ5Whm
	XOG40GTDYGotjJ/Sa+L8mRP3O8vDECv6qD4H7
X-Google-Smtp-Source: AGHT+IENM3+vqJZUAP4pwreGwwcuKC80xieBst0NU2JKw0jAEPkLUSJvuN/h5ayrVasiJ/V8gG8GgXK7KZtoX8i9M/s=
X-Received: by 2002:a17:906:6a8d:b0:a58:308:274c with SMTP id
 p13-20020a1709066a8d00b00a580308274cmr2911288ejr.21.1714179119602; Fri, 26
 Apr 2024 17:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev> <20240427003733.3898961-4-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-4-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Apr 2024 17:51:23 -0700
Message-ID: <CAJD7tkY2EwtOHh3w=e0+OC3gOPb9xCC7C36BhM0RHYPv184U+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> At the moment, the amount of memory allocated for stats related structs
> in the mem_cgroup corresponds to the size of enum node_stat_item.
> However not all fields in enum node_stat_item has corresponding memcg
> stats. So, let's use indirection mechanism similar to the one used for
> memcg vmstats management.

Just curious, does the indirection table cause any noticeable
performance impact? My guess is no, but the update paths are usually
very performance sensitive.

I guess lkp will shout at us if there are any noticeable regressions.

