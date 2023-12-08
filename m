Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C611480A3F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573746AbjLHMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:54:20 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209B171D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:54:24 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db4422fff15so2098342276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702040064; x=1702644864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByI2BmM76fDl6CBfV37McPabf7tQNlC2zWfp5P+Us7w=;
        b=c/VfjS1SUuwPa0ud1rF722pXq7krjTYGiyAE8nZHfGfjZDzA3ClrvBBuQ6yUccZEi6
         /bZoXwdzaqzTm+CoxnSe2Cabmorok2OW1nZ7TOZKAG1E/fUC+sfpYpw1eynWF5d3pJo8
         sC3wBfO2dKliegsZpEq/ZgpjepQHKUATQPJWV267UIYH+T6XWMO6DS7DtYpyXyPoCZkF
         mHTGgLAiLNnMGGejmdOT+zTHHjOoBf0u3kUbJ44QN1it0+cms9+IPimtcqpICtrTfzaC
         h5I9+liC5GdvGp2HvVPgmddd/Hn9iHVyQmSD3rQt4iw2tS2509s5Bqf7eXqb34M3k1GC
         h1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040064; x=1702644864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByI2BmM76fDl6CBfV37McPabf7tQNlC2zWfp5P+Us7w=;
        b=JrqdRZgBAJjptoXWrAyQa5bqFbwT4f4IO94+pFWS2CA55sl8xpOdAKy3uHO8Gnul9a
         KZcVy22GzKpd6yCAdMvyBb+RAnvHlPHpYUS0DDPI43cnL9e39IqjGvdQ3ihEQxNax7nf
         FiU5MXyJ9U1Wj/ZfQ5TzrVZx+2EyB6QjWtEVsXUIiovjpExUa753QDZ5wMRSR3whdB2z
         PCdLTr5sfG0Z0Cj36nbA/mHuEE3T/vJ88GR+MDdfNE07y9EOvwvQ4rEX6guwzPi1SzNm
         6hdy3/rDgXAykTT6Vz0RDA80AxjlFxBwmE1y2iwLwVgkUW48mHnYzE7xzxUGn2ud2/64
         lGkA==
X-Gm-Message-State: AOJu0YyXJFJIV8luqT2VWKwz3jTRDxVNoTQRnvt19CRx67exQESN/HFA
        fMyylQuyvhkYcEfZrDlfR1ETc/XNuk3Z2Gdf94HtEw==
X-Google-Smtp-Source: AGHT+IF5iZ4loNbrkDEVIKN0ZuOOKoVeFsgMMcs4UNMekY672SG41YIpWxGAUfSzwyEW89VxsHniMNAuYOLaquPgO8c=
X-Received: by 2002:a25:2395:0:b0:db7:dad0:76dd with SMTP id
 j143-20020a252395000000b00db7dad076ddmr3075741ybj.121.1702040063846; Fri, 08
 Dec 2023 04:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-18-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-18-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 13:53:41 +0100
Message-ID: <CAG_fn=Ug6MFyoj=J_yabfd-V+3vGYNS3-CS+fhW9Tsc847xMtw@mail.gmail.com>
Subject: Re: [PATCH v2 17/33] mm: kfence: Disable KMSAN when checking the canary
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
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

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> KMSAN warns about check_canary() accessing the canary.
>
> The reason is that, even though set_canary() is properly instrumented
> and sets shadow, slub explicitly poisons the canary's address range
> afterwards.
>
> Unpoisoning the canary is not the right thing to do: only
> check_canary() is supposed to ever touch it. Instead, disable KMSAN
> checks around canary read accesses.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
