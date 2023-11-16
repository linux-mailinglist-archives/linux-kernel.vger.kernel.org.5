Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321697EDE41
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjKPKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjKPKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:14:19 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114FBD4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:14:12 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5b383b4184fso6849937b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700129651; x=1700734451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5z27wFZQcKESSrI85AK8SZJIpmMB6uhj5fEtkmaII8=;
        b=gjQ20O/oXiMttAWwKuYqRM8jsItpyrbgUftQOi5nWSPBZNynU2otEfAQ8TbFpi4nYv
         L2+mS6P5WPvxvBfcqlZXflak3skFOepr6piLa+3rwyHsi3Ndddhv/X+RasJn1W8E9YTn
         CcaQARRW3sYpKEJ8NwjYfrexPmk+IxEhSyt2Uj6v6k8oSC0xpt9FtPO4uhQfXnacz3Pw
         TtQevSy1Zitg1U2DBbPBp6TCzpgAnw2fSOk4OVZlBI0YbH9svNI3TddNsMuUF4zrzWrH
         lNvL1tVYYO4RoTabtVk3DbSNmT+xfAMzRWD5HqmCFqkYWjmWaJ2maieVCvzRMmsjjZKr
         grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129651; x=1700734451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5z27wFZQcKESSrI85AK8SZJIpmMB6uhj5fEtkmaII8=;
        b=g0uQSaKrssgHPPGfUObhyYD/xoeHqN4UlzxXQ394Mr0sCj8VibghJGVFq5OPM9cTU9
         039wmNR6v8KH0ebXRDGDhZuOZ6jGegVrKnBdRqZEtaOi4Pj2MVuu8GJVcMaKH4L/JZEc
         f4Snty1pEi+M5iYHgoePU0gzHaEGBHnvdQbXOutUtSFpTo5HYShhMzndbHW3bRmTSeTx
         wvnDgLVsxodctsDx3ifFuw3QroxPW/baCvupH6FFF74yx874VAh9SyaNvj2/QVkGuDn2
         JZZ8emnlvGWMcmjFHesI83LjTfNJshcMS2aCk5mrRDWm5gaY1w686RsuzLFYRLw1BoLU
         Vq8w==
X-Gm-Message-State: AOJu0YwdXiCcWAwMf8MT9fK+14pHqyBYcR19KrcWgISIOQ/nzOG1PVqi
        JcIjGmVcpah/bDGftuFgJGe1VXXkVZ7Vi5Rm088Z7w==
X-Google-Smtp-Source: AGHT+IF+jaGcS9pPp5H4LI7L0H2rgwwBBSMYs58tIpjDOVz6YSDhqCfvQL1gqRcOfGQbFFqR56bfm3c0DchFbitnYxg=
X-Received: by 2002:a81:47c3:0:b0:594:f864:8507 with SMTP id
 u186-20020a8147c3000000b00594f8648507mr15893002ywa.51.1700129651150; Thu, 16
 Nov 2023 02:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-7-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-7-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 11:13:30 +0100
Message-ID: <CAG_fn=Viz99-GHX0rnKWo7Wdhw+BLHqNXY_AV0-pT6d1OiGw3A@mail.gmail.com>
Subject: Re: [PATCH 06/32] kmsan: Fix kmsan_copy_to_user() on arches with
 overlapping address spaces
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Comparing pointers with TASK_SIZE does not make sense when kernel and
> userspace overlap. Assume that we are handling user memory access in
> this case.
>
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
