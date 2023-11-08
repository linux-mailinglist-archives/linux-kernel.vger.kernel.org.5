Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE187E6135
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKHXwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:52:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A674625BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:52:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc209561c3so60585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 15:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699487524; x=1700092324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9/j9I5xmRGr2xQ/85BVxrHK3DvRzWkvXiC6XBWsxsE=;
        b=tTzYqdwZMximB8t3UJu1rHO+i78BXw6YKWjK737WNix+66ViUDoon1g2ji3vcGgv7x
         snLozbkJ6K48D6ZHC6oIU8gkQd9bShXjkgdhEfHbBW+zpUqOq4SzaE4DbgWEvBrYBU9R
         yWEc36k1S4kax44WI9O/DbE3j/B6CoR7+ubmIOVNbvgFLG/XjPdiJcE3apjHNY027aZq
         QjBdvMv9n/edY+u2n9+FFf69TkB6jBYZVklMqTRH0ZZBOCXOuGOFXYPznGUeI3sGUQBX
         2yNKAd7eS8DJw4KrWAXxzSK+GM8Kx4TedKwH62C8s3DwJpoUKrZ6MqU240UizCPw092p
         7piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487524; x=1700092324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9/j9I5xmRGr2xQ/85BVxrHK3DvRzWkvXiC6XBWsxsE=;
        b=Bl43ci+k71e27N2/mjkbxYKbal49xQ6bQPaWb1+y+zAVA10Pi0I6BYkYcrf82N0v6u
         n8HzP8k7nNMmRxCoWsviyZ51SQG4NGcBXySvABdTnptUeZQ6BdGhTklKtfuZPG0Qg5ci
         syDDXJMNCvibTnpvAxt0ZLyK0tazW2f5IpHwaFEhmbfBbzui+Hinj9dP+9IrJqPMdq93
         o6QbChMwc9yJODX15A19TMAUrCQfrrgOUB3ZpjqeREqMYbi75MU2pxmhsMd38YcTZV85
         W3j/iUqwKfOPPLywAOxt6hF98qu51adJ3LSAADT8WhISzzYp0t51jHdwr9tiVia39A8t
         XCCg==
X-Gm-Message-State: AOJu0Yy4S61sEMf9dA63Uq89Svj6Evu4oDHShcsf3qnSVWSmLngRTBJ/
        llugzbK6VSZCbeS1GOwxWxJRBFOw0DHsHhz/kBVkqg==
X-Google-Smtp-Source: AGHT+IF2Rk1OnLoBlh4G5q0gviP55oQbuaIOMFh/BsYlOySzTGEITwUFg0K4+ckuaQiXzvwkDol0fP1lFjP26SgmBhA=
X-Received: by 2002:a17:902:758d:b0:1cc:2c43:9061 with SMTP id
 j13-20020a170902758d00b001cc2c439061mr95651pll.21.1699487523896; Wed, 08 Nov
 2023 15:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20231108164920.3401565-1-jackmanb@google.com>
In-Reply-To: <20231108164920.3401565-1-jackmanb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 8 Nov 2023 15:51:51 -0800
Message-ID: <CALvZod4Uj9rR3OL7CYfq5t8gsRLAa7b2wa3m26nyDhfvQaWQ+g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: Dedupe some memcg uncharging logic
To:     Brendan Jackman <jackmanb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 8:49=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> The duplication makes it seem like some work is required before
> uncharging in the !PageHWPoison case. But it isn't, so we can simplify
> the code a little.
>
> Note the PageMemcgKmem check is redundant, but I've left it in as it
> avoids an unnecessary function call.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Thanks for the patch. Actually the PageMemcgKmem/folio_memcg_kmem
check should be in memcg_kmem_uncharge_page() and not in
__memcg_kmem_uncharge_page(). Anyways, that is orthogonal to this
patch.

Acked-by: Shakeel Butt <shakeelb@google.com>
