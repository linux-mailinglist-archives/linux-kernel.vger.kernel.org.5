Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716407558E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGQAft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGQAfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:35:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA4ED9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:35:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403b622101bso304521cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689554146; x=1692146146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceHFS68Z8eoyXByi3OzEKWi0O43JJE6aFLe5wsYlfoM=;
        b=yEIJY3DVqOHs8s97//ML3Qw6AqdTsgExYIRXtv1XIb17Yn6cicVenDWfR03w+17dHn
         f/1ydEyAuCFpnbjVQkE9KlEBLoEDSMXQZUE/ENQUIAkdNESA/SlmP6fL1KISFgiY5WjU
         FblGDVq13GLmkgIT/YBYqvTg0J8BGwYwb/4QDri1ntfBKsrwl8ctZKYaYFZhzbck5OvD
         HhDvoJjtxNF1mlmiwSburiaQZkSW87J4C/GytZK3FbfGd9bChxO2xOY5YmuA9yPpg6L4
         /cpiqYIi6yfA1MiSz7SP6DSxyC6gIm6rWRnP0IRCA41q1vFC7s4KkQ4yNaKn9pWNj5p1
         nUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689554146; x=1692146146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceHFS68Z8eoyXByi3OzEKWi0O43JJE6aFLe5wsYlfoM=;
        b=DadGQcxeGg94xDRDfBsMhjLnwOR5Vv+3ZLFNUecoOtS9PkZAR4ACzZRCqGgmdSmPFp
         Ucu0v9h5DTdr7Rquz7S7IZSIsBE/vhc7eXINc7g3plI43sZgSHbcodwf+34OLP85xLGH
         ARb+qd/l493wN5MbF8yd4I29qXB44FwRyyy1Zm/JfilzHgeV82+4kiq0FKbI9Y+FqRV+
         9uoc5bO7ibjMKlQ8vg0GFXrF31wG6KAc7PieMiiqWysP1dDK4MfccAqMgNj5o4nKm3bf
         gTjVVMSivpaYjki7iI/wuZDh7jhqukLqTuVH4h/pAJ6/Ve8q9HNbdsedWSzkiOX9OcuP
         paFg==
X-Gm-Message-State: ABy/qLaxePCfjVH5C8Gu3CbjUCaLVzAJPPzIqRQLWg6X5OKgZgtfgQZj
        g1B/p3+GKL/fsP3JTWdBbQngaPWEeC4z8FoCaszWiQ==
X-Google-Smtp-Source: APBJJlGENDq5+47+ugTUyKQNYlOuSLR/z8TxIj3Eua5o56NWZayheDv1PmFMI7BkYtmNiEMw6YAN8mme0nSaOw5Rkss=
X-Received: by 2002:ac8:7f11:0:b0:3f6:97b4:1a4d with SMTP id
 f17-20020ac87f11000000b003f697b41a4dmr1205909qtk.23.1689554145721; Sun, 16
 Jul 2023 17:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com> <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
In-Reply-To: <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 16 Jul 2023 18:35:09 -0600
Message-ID: <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> > There is a problem here that I didn't have the time to elaborate: we
> > can't mlock() a folio that is within the range but not fully mapped
> > because this folio can be on the deferred split queue. When the split
> > happens, those unmapped folios (not mapped by this vma but are mapped
> > into other vmas) will be stranded on the unevictable lru.
>
> This should be fine unless I missed something. During large folio split,
> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will be
> munlocked in unmap_folio(). So the head/tail pages will be evictable alwa=
ys.

It's close but not entirely accurate: munlock can fail on isolated folios.
