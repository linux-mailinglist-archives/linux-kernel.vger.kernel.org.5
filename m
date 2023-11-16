Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34B7EDDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjKPJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjKPJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:42:17 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B9019E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:42:14 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db057de2b77so507528276.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127733; x=1700732533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbQBUq6zMPZ7ORs1zmLeLhmCeGDS7R7Qw733eYdaWDY=;
        b=Gx5PhsvmMsmSQy3ihT4tpPP7j6KuTZToX9EDbr4inLdKRMGz52HovUOZHRAPOP1YHi
         2ipifisV8I057MGg0156wIzWDSOMSKyNWlVNIy7H5l0WV+YA1gWwNjgJRm4lzJ0g/Zig
         e3Fq1d9RuFDN/NI5SHzRvYiyRzXfaf2MtyDOuSTIERdpWy4ZH7es6Rdn2nMqM8DDSDOS
         jm6U3umaLZ8fmfQOyK/Tb5+5tyN4NSc8miBvTTart/pYg2AeDL/o7YwlQxkxXlKEYHjf
         N2ZLOYF+gK0GMQ7IxMY6QqKEfFos2iFwPNb2o2x3+nYh7CNO9V+whWwNf+mIC34AvU2d
         rHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127733; x=1700732533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbQBUq6zMPZ7ORs1zmLeLhmCeGDS7R7Qw733eYdaWDY=;
        b=IJIO/PQ4xOOFFpUhkHEzJKRC+/jLPrMCM9FLcGtM7dtC2PlVly/kXnEITti+GiZngL
         8JffVPaOweAqDe3A72uF36prLqOoy+3J9+Qs2ekNchywOxNmME/2IDYMbHz+rTEc4T6t
         tmcUGZWfHlqwj9NU191N2y7ATgPKsZ6yKd/rUOYqY3GkScNGc8d4wYfONZsd0+rC+Pif
         JDh5kYcimIWO5M0hLFq+4M0cC3Ud6IQesnhwSYniKMwtBuhFS9YC3Ilb7jPr1rqhx0MZ
         wBYW0xBMz+f5JmwORwzAX+65cd3GajOslgSzoahE68fb2X8Zh6Il/OX3GtXwDABKmUur
         RpkA==
X-Gm-Message-State: AOJu0Yxxy0e55O0dqn7WBrD2eR19hdEDXuj238M91aZNhjIdcrlsx+KL
        UUVMiyvSK8Ymq2K9qjapldFBdAJeeZuauMV3k8rejg==
X-Google-Smtp-Source: AGHT+IFonAyLHLBLw3FFUBVfouzs0zLwD6TTo4Qrxnr7Ueo57CVLxGNAvxlYkAgnfWpgWjxTtGnDhXKHUgixd6B4yVA=
X-Received: by 2002:a25:c70e:0:b0:da0:411b:ef19 with SMTP id
 w14-20020a25c70e000000b00da0411bef19mr14634881ybe.1.1700127733310; Thu, 16
 Nov 2023 01:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-4-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-4-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:41:33 +0100
Message-ID: <CAG_fn=Vw-kR4QM8jwJYQjv8ma+mh8uyGyP2SP7PhoMvn7UqYwQ@mail.gmail.com>
Subject: Re: [PATCH 03/32] kmsan: Disable KMSAN when DEFERRED_STRUCT_PAGE_INIT
 is enabled
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
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> KMSAN relies on memblock returning all available pages to it
> (see kmsan_memblock_free_pages()). It partitions these pages into 3
> categories: pages available to the buddy allocator, shadow pages and
> origin pages. This partitioning is static.
>
> If new pages appear after kmsan_init_runtime(), it is considered
> an error. DEFERRED_STRUCT_PAGE_INIT causes this, so mark it as
> incompatible with KMSAN.

In the future we could probably collect the deferred pages as well,
but it's okay to disable KMSAN for now.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
