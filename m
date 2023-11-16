Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228807EE837
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKPUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:19:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D829126
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:19:19 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e62ab773f1so180064866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700165958; x=1700770758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OgdBdxfhNkPsuCj3CVQO+gy86aXcSm+tfVyfjz90gM=;
        b=X4fc+4lGrv+8VqLjAKVWjzkLP4rMdoPCnIJ/Sy4lQONkcfRMYeNy8cu7lKocJHchcI
         O4Q75ChBATgCpDz1LbDD3kYdtAnLhAMnOyYikdJphalGZZiGjIhuHcQfvJywqXarwOKp
         AO8yIe2Ltv9iMDZGkLy4ktiNwnJgBtZNyHIONfpxpEki45UGskR6oyz40Pb2W/ijMJKk
         iVYGzZgA0qgn4iJuSdpJ6150XXc4axSd3fmwMJ8y3+4cGc/p8XmsCRdvyoo5JFcWzF4y
         ZeihuxCMyc1nVt0JF6+3yI7HJfC3QuD8HsEQXR+d22MBwqel8lO7aRltqyIXLlSCsrxg
         QNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165958; x=1700770758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OgdBdxfhNkPsuCj3CVQO+gy86aXcSm+tfVyfjz90gM=;
        b=xKYRtQ/rOSe2nmisMby4VgpXnnQ33oIN34qw/0qhvqSM5JT62f/iHKrX5w+n9cCURv
         m2fObckiPjGkwwiKoCozKk2ha1OXgnkN+u10IE2MJSm3Uiky+xGpvWQ5aL3EMid7tXOR
         +fGrdBj1xzcZi3lmC5vvxvWiNarlqVLLwaUNt9KQOvUs9daCFkvvEe81iePDGvxcH6AJ
         T+4Imf+NHGp+sEJxz0zJurQQlEIAkZQxXlPvCxEU/NwQRvM+OPJHA3TvzYuKKfAYpYSH
         StnBXNYT3yoNfq0gM2ikyTfJ1iIsOVI7enLAJ/d6CfkDSXnpS7kmcA5tngZ+HB/vJ+NH
         4LSA==
X-Gm-Message-State: AOJu0Yz20SwUeTp/XM+qkDW4uwgyFN/1GH1sf22RmAaSpHglTbCipjiH
        KjbNeAWHKrWLJFUSdwV8XZ5AegMXIv4AFKuqMVVvsg==
X-Google-Smtp-Source: AGHT+IHg3EGd0I62ta7o+TPCWWwtNPcxX75RJDJGXptVhnsHRxShshMV7iQIK1LHDeOA/VBB9f3MP/0YjZjxs13sMoY=
X-Received: by 2002:a17:906:404:b0:9e6:4156:af4f with SMTP id
 d4-20020a170906040400b009e64156af4fmr13053218eja.55.1700165957515; Thu, 16
 Nov 2023 12:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com> <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
In-Reply-To: <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 16 Nov 2023 12:18:38 -0800
Message-ID: <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Chris Li <chrisl@kernel.org>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:12=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> Hi Yosry,
>
> On Tue, Nov 14, 2023 at 9:16=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > > 1)The swap entry has been freed, but cached in swap_slots_cache,
> > > no swap cache and swapcount=3D0.
> > > 2)When the option zswap_exclusive_loads_enabled disabled and
> > > zswap_load completed(page in swap_cache and swapcount =3D 0).
> >
> > For case (1), I think a cleaner solution would be to move the
> > zswap_invalidate() call from swap_range_free() (which is called after
> > the cached slots are freed) to __swap_entry_free_locked() if the usage
> > goes to 0. I actually think conceptually this makes not just for
> > zswap_invalidate(), but also for the arch call, memcg uncharging, etc.
> > Slots caching is a swapfile optimization that should be internal to
> > swapfile code. Once a swap entry is freed (i.e. swap count is 0 AND
>
> Do you mean moving all swap slots free to bypass the swap slot cache, eve=
n it
> is not from zswap? That might have unwanted side effects. The swap
> slot cache is not just for swap files on disk. The batching has the
> effect that on average lower cost of freeing per entry.

Not bypassing the swap slot cache, just make the callbacks to
invalidate the zswap entry, do memg uncharging, etc when the slot is
no longer used and is entering the swap slot cache (i.e. when
free_swap_slot() is called), instead of when draining the swap slot
cache (i.e. when swap_range_free() is called). For all parts of MM
outside of swap, the swap entry is freed when free_swap_slot() is
called. We don't free it immediately because of caching, but this
should be transparent to other parts of MM (e.g. zswap, memcg, etc).

>
> > not in the swap cache), all the hooks should be called (memcg, zswap,
> > arch, ..) as the swap entry is effectively freed. The fact that
> > swapfile code internally batches and caches slots should be
> > transparent to other parts of MM. I am not sure if the calls can just
> > be moved or if there are underlying assumptions in the implementation
> > that would be broken, but it feels like the right thing to do.
>
> There is also the behavior that if the page gets swapped in but hasn't
> changed,  when swap out again, it is possible to avoid writing the
> page again to the disk. For disk there is no overhead keeping the old
> date on the disk not to touch it. For zpool it might have memory
> overhead holding the compressed pool. The trade off might be
> different.
>
> Chris
