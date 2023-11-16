Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F87EDDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjKPJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjKPJp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:45:26 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855A1B1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:45:23 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-672096e0e89so3066606d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127922; x=1700732722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuV5LSK+LTxWeRbqVFyqwK6y6J/MVZo38WZUFkMurd4=;
        b=ie7q4YNNpOmZWVVFQ4eh3GLCWwkUKfB8/4+ZVt+6UczviZrpiElYcAc86/h4dmzgl4
         4fFjDwB4iNAmEW8MfPJHlX5V7kQWQyPLS+pmd0vYSkXUIrTtxaVIOUO/oEPQbYTx31va
         8qTqcXetDJNg/rWBsjGku2+rW8cbZCeaLdxMwySx58y5k80Nbltu7jcClKt/qmUfensN
         L5XWH4KTJ9pJ4KjnHL1nkgjOQlh635gi6neceX/GNyaYCA2Lz32NjDGZYR0KVYmbR/pZ
         tx+fkh4enMIRp2lfoHjOYlKaEHOH3DuoW4B70kuqMNroWZUJnEdDd95UBp4xmR7trMsZ
         wcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127922; x=1700732722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuV5LSK+LTxWeRbqVFyqwK6y6J/MVZo38WZUFkMurd4=;
        b=AjaBo+ja9+9NOGxShmK7lHAgzD/t0AFZeV7mKDaMteNI7kh7PtkkX8OYN2uAMm25aa
         9GOaU9AaDcs35dvWGZOo9dzOoyuW/e+/S4YNCupr9aEvtgNJYta1eqYtrGXGDZ18P0gm
         naqtyHJNEMrUQ04+BLurpkAZjhwYFPwIV+1aA6wLms4zgSCffAVWjfvyUPafkbv61HVS
         7jjSfJM9vsS4vP2mDv3V23ospsF4ksR9uX1QkpNekxtMp3TBcLwaliWW+dr58J/X3A4A
         JauptEQ/W6lAlKi4k4L/ylyosfP+ZMDX7ZBPpz4RDIXYP+5t7zECwBgDP4zXWtLemoEi
         NWUQ==
X-Gm-Message-State: AOJu0YyR1DLz/d1SndoRghZicdgLdzmFv1Kmm9DBNMgCAtYfcHqM/aeL
        GZkkqF8URelb9GVD2doYSfMRBgopRCawFheG9L+iHA==
X-Google-Smtp-Source: AGHT+IEZe2pBqGaIQDwerQVIP7hrHF/NMnZNmo8au4Dfrdlz3uGifZ2pJ0NnPGfwguQfG35pdHrd/w8j19ygDJMsLmM=
X-Received: by 2002:ad4:4d11:0:b0:672:ab2:d9d9 with SMTP id
 l17-20020ad44d11000000b006720ab2d9d9mr8242754qvl.29.1700127922512; Thu, 16
 Nov 2023 01:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-9-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-9-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:44:46 +0100
Message-ID: <CAG_fn=U8r0cZ2ZG5dr-Um9Un=S_go7-PixFXJ-PkXCMyL7VY5g@mail.gmail.com>
Subject: Re: [PATCH 08/32] kmsan: Remove an x86-specific #include from kmsan.h
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
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

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Replace the x86-specific asm/pgtable_64_types.h #include with the
> linux/pgtable.h one, which all architectures have.
>
> Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see the comment below)

>
> -#include <asm/pgtable_64_types.h>
> +#include <linux/pgtable.h>

For the sake of consistency with other KMSAN code, please keep the
headers sorted alphabetically.
