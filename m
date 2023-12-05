Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7F804323
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjLEAKb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 19:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjLEAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:10:29 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AFFF0;
        Mon,  4 Dec 2023 16:10:35 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2916208a12.1;
        Mon, 04 Dec 2023 16:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735035; x=1702339835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNrtMZXRyIGyhkjT4JI1KSJerGhWTgoNl7m2Gv0tWQ8=;
        b=d95sEYLXlzwo5ZENkQxq/8Q5V6ecULN8XUf8zbv9VBWwIgpSg0rH77Q2SM9eCAA6Ws
         fAUorDaYeJeMWDrpcbEDra928bX8YDQhODcNE+A0o3s06FQzZhtfQIvoidnqGN6Fszkk
         XDEVErqNWw95pIlnEfq/3W3C3m32po/hV/jV9gB1D3sKAZKaOfFsWDt/6jBOW33bUbeI
         molWnZT29nOLv4i/EYz7WQ+5yAfBGgZQzFkCwq3YbizXEaYeywKwLczB925bnAxPfG98
         hJ+uzguBNBIE54Ddi57yXxQQrMF3lK37K/37TSEveNHPycDx8u8pG8igR1GkMzq4gwwm
         GmIQ==
X-Gm-Message-State: AOJu0YweMnoMJ0IQHu1inSJU6OxbS+Ea3PmYbpSrqHqU0CVWA6M9XWI8
        fRWBxcD2iksmZX/KllDD+yVhn6IRM+2Gt3TQBFVyP2QKqNs=
X-Google-Smtp-Source: AGHT+IHpJOO1gjA+QD4Y2Vv8sBMHvrZDvCNXRG2CGvSQAxz+GqJV4mQxzYN3cA8/d3COk14Ub3zwaYtqJBJGsTAuVqQ=
X-Received: by 2002:a17:90a:8005:b0:286:6cc1:3f1f with SMTP id
 b5-20020a17090a800500b002866cc13f1fmr476637pjn.86.1701735035239; Mon, 04 Dec
 2023 16:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-37-namhyung@kernel.org>
 <852644CC-CF12-475A-A7D2-84EFDCE9D248@linux.vnet.ibm.com>
In-Reply-To: <852644CC-CF12-475A-A7D2-84EFDCE9D248@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 16:10:24 -0800
Message-ID: <CAM9d7cgdUfdMnhmMpqnkpJyV5hJE9dgGuwPetSNM0KfDuYfs6A@mail.gmail.com>
Subject: Re: [PATCH 36/48] perf annotate-data: Introduce struct data_loc_info
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Dec 3, 2023 at 8:22 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
> Hi Namhyung,
>
> I have a thought there. For the type and typeoff sort keys to work, we depend on Dwarf support in perf, right ?
> If the perf is built without dwarf support ( either due to older elfutils or missing libdw.h ) , find_data_type will return NULL and we will get “unknown” for Data Type and Data Type Offset in the result.

Yes, right.

>
> Can we add a pr_debug line in find_data_type (which is in else part for HAVE_DWARF_SUPPORT) so that user can understand if “unknown” is due to missing devel during the build ? Or may be restrict -s type,typeoff if dwarf support is missing ?

I think it's better to add a warning if DWARF is not supported.
Thanks for your review!

Namhyung
