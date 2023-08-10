Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4450577807E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjHJSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjHJSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:40:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF53C10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:39:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so18762501fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691692770; x=1692297570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4XjBV0qXXp37wiVyXtpMqkFIhm8hlMYH3y9Bd3d4SgY=;
        b=Z1LCczUUDmVellIoOclvETzn8hSQlCw0u6IpsabZn/OJoQCce0XQM0bkpY1Ew+egu4
         5ksdgfhc47fO9kQFamWJ8EoYwjz+6rKFAX28q/rX5CdY/LlcalXz1UPPZlAQh53aU/VU
         7FRPKJIAeegmtzGj5LqZX9llDB++MJmHiygdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692770; x=1692297570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XjBV0qXXp37wiVyXtpMqkFIhm8hlMYH3y9Bd3d4SgY=;
        b=FOV+i4ZA0YgQtd7MMNb3Z66B5ToHZvYT5RXKsIlnAJwSOKSC4OG9uE35pJPaBCc9Yz
         TBsP0QpH/5AJYkhKe7VPfo3dHMS+U1mUMlh6UJfs7t32Y127KaJINZmek8BjqIk2wLYe
         75i0xSMlwlpJsM6if2rf+YxS8wArHVp7mpahUe0HTUzKY0ZcNLYdluIemCm1GSeM2p6c
         Kb0Hh4UiehcN3QDob2+T9F5I3yEiYEMq0Un7JTeHqTdQRkeMCt2NpVUmNr5f4S0QbQ5h
         W+lWOiVr0j4YSGqePV2q56j0mXRWMeaabo/jtMG0kg8CPvoKeKhs0eUmpI2zQGEzZbaI
         ZDeA==
X-Gm-Message-State: AOJu0YyETkftlBPjI6cC6kyU4MyK4jEUql53hmbpuP8e1V3TNkAVBhWe
        cDV7SLxvpp/nA3XE/o0/jQsjEJ8lfZw5yvpZGVPTCAFs
X-Google-Smtp-Source: AGHT+IERkgxlNHovlif5YFHC1408on0bEZtuaqfuidLlM7Z4PrbWFo/NLbAbvioSkKG88Nt4G3yCIA==
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id z10-20020a2e884a000000b002b9ec57c331mr2794982ljj.6.1691692770471;
        Thu, 10 Aug 2023 11:39:30 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a6-20020a17090682c600b0098669cc16b2sm1275348ejy.83.2023.08.10.11.39.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:39:30 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5236a9788a7so1578156a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:39:30 -0700 (PDT)
X-Received: by 2002:a05:6402:31eb:b0:523:3609:d3ca with SMTP id
 dy11-20020a05640231eb00b005233609d3camr2930836edb.20.1691692769886; Thu, 10
 Aug 2023 11:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
 <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com> <CY4PR11MB2005976F49613E20BC072ECCF913A@CY4PR11MB2005.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB2005976F49613E20BC072ECCF913A@CY4PR11MB2005.namprd11.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 11:39:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whS19C=y32vNMRp7UfQMVw38HOfzhs9v5rjLayEFjMNPA@mail.gmail.com>
Message-ID: <CAHk-=whS19C=y32vNMRp7UfQMVw38HOfzhs9v5rjLayEFjMNPA@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix access_remote_vm() regression on tagged addresses
To:     "Schimpe, Christina" <christina.schimpe@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 05:42, Schimpe, Christina
<christina.schimpe@intel.com> wrote:
>
> We don't have any LAM support in GDB yet, we are just working on it.
> We currently rely on that feature, but could still change it. We don't
> necessarily require /proc/PID/mem to support tagged addresses.
>
> ARM's TBI support in GDB does not rely on /proc/PID/mem to support tagged
> addresses AFAIK.

Ahh. That would explain why nobody noticed.

I do wonder if perhaps /proc/<pid>/mem should just match the real
addresses (ie the ones you would see in /proc/<pid>/maps).

The main reason GUP does the untagging is that obviously people will
pass in their own virtual addresses when doing direct-IO etc.

So /proc/<pid>/mem is a bit different.

That said, untagging does make some things easier, so I think it's
probably the right thing to do.

             Linus
