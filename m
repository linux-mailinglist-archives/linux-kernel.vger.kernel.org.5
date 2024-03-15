Return-Path: <linux-kernel+bounces-104821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3E87D42B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234F21F21AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2283B79E;
	Fri, 15 Mar 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PpNcbE1A"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032A50A72
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528878; cv=none; b=pPa3HYVYna7/4gzsg0CMc06pGqCgHiMw9Ke+Ry9k/W67sUe/TXMDkU21KS/EMgUjO0TlUQpSG25sd2ZUa5e99vjmuVDvuBCfjiBwLorVnTjmMDfVB7uAS6MtNG9iUbi1iU0MitDbVH3Kl/Lgp8RNKpM8to4/lsNkWT2bmvJ//Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528878; c=relaxed/simple;
	bh=KW4wakcjnuKbRSjOEgZl4lW2AZACO4wTscoGG/mpnXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egWkzcoTi4YVlwC1n9h+TtG+nEXxAaih1jNYTox2XlCox9G0Opkcgv5hYwf/3Vc/WTn2AXrgNqd/L1uakdnVX2AuzEKNA0gzkdC9nJdDkO+U4TvQHUhSsgLZgG9RaoXuplh0Q0hAPDdFC06qOWzBKMoJgsB/PgHrAUx4qOyNLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PpNcbE1A; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45f257b81fso325068466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710528874; x=1711133674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ATHLM2mB7/uarmSrYlojtclecckho1jASanaFaAquaQ=;
        b=PpNcbE1Aiyl69XPMUeKYYt+aAhNfFEuc2cThdqgIWeCmxN+rFfWfKu+Ia+/hwzdyy1
         bNeAi+PsGnQexLigqE/43febV7WAA0l2PiW/juzBlJCMhCgUeDxNmNCv6DT+kqhEHSI8
         Bpl0WTHuL9Tg9NJfrYFrHZsUDk7UmrR9xpB7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528874; x=1711133674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATHLM2mB7/uarmSrYlojtclecckho1jASanaFaAquaQ=;
        b=siGfIrCo1GeVph6+gj3OdJ7/guM66J1npUcewpdiHhYvoZNevfes0XqlCrNlR5q/U/
         +ZotoQYY1OZsZ16AnTjqmGMjhwXVET9wzxEsvKcQW79kMhX6XOWBrkF0IJ42U6i235qR
         NiV6nLLRaU+d1HAs7TRL7os7BDuDw/ZOWS1DSYW/mP/f3H7cPPwnHsga5lFYIHW4RlbV
         7BYP0KC7ty4UXezWWJLCoFRkZABjIOJp5jarKMTWWTuFQPTt8+7aAdgSkUfqK21RaC/2
         7a/QaBL5VfIodzEtv7HivW0bSQnKaS5NmeoU6NcdJ0i3xZ3+1x+Mkibhp+Gk0TeBbJsi
         k/sg==
X-Forwarded-Encrypted: i=1; AJvYcCUXVo2wrGIaEtXC60k9y6zpKsd3Jx13VOd2WgkguJZyNIrfn+N08FPzLRMDHy8/x2jfaPt4gsz+NRB3RSNJNbkzqAc+m6cow303hogQ
X-Gm-Message-State: AOJu0YzKD1/RdC2+ttL0YCFKK+7zYxLy/8quZlI7oLYw+/M1MqOAlsdX
	XDhF2iq6Fk8JWO4RFucFhjPXoV8wbLI4ofULZAYT7uhq4h4O/rQ39pGX2PCAeD1NJRu6Z9qp4yD
	A+Raf0Q==
X-Google-Smtp-Source: AGHT+IHVMjP20/jzusE7XhXDzdgnZkN9kSAfbKsLmcsEyALUZJVe/+mGfShv5rqegiGr/Hx5fiUZjg==
X-Received: by 2002:a17:906:a413:b0:a45:5831:4f00 with SMTP id l19-20020a170906a41300b00a4558314f00mr4325474ejz.75.1710528874034;
        Fri, 15 Mar 2024 11:54:34 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a4661caeed7sm1943343eji.48.2024.03.15.11.54.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:54:33 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45f257b81fso325065766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:54:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGHFPv0u6R1nfqwjlPxKs5ts2ybVzY6nGCzuAP/eoy1sdFS/P9qIDrf8VqM2HMKk1eL0/m/QuRR5JdUu9FCsoMRwId9+FGgNx9sDLU
X-Received: by 2002:a17:907:9709:b0:a46:7bd3:c7b2 with SMTP id
 jg9-20020a170907970900b00a467bd3c7b2mr3449508ejc.5.1710528872728; Fri, 15 Mar
 2024 11:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314194324.2487618-1-sboyd@kernel.org>
In-Reply-To: <20240314194324.2487618-1-sboyd@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 11:54:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyY_-NnDZ+GhZjJaLqORcuwp_Jj=D-Zjsk-cwZp7YTcA@mail.gmail.com>
Message-ID: <CAHk-=whyY_-NnDZ+GhZjJaLqORcuwp_Jj=D-Zjsk-cwZp7YTcA@mail.gmail.com>
Subject: Re: [GIT PULL] clk changes for the merge window
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 12:43, Stephen Boyd <sboyd@kernel.org> wrote:
>
> I'm hoping that we can make that into a genpd that drivers attach
> instead, but this API should help drivers simplify in the meantime.

. and I'm hoping that name dies in the code too, not just in the
directory structure.

'genpd' really makes absolutely zero sense as a name to anybody
outside of that legacy clique.

               Linus

