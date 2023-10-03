Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF787B5FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjJCELY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 00:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjJCELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:11:22 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189EA1;
        Mon,  2 Oct 2023 21:11:19 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2773f776f49so320094a91.1;
        Mon, 02 Oct 2023 21:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306279; x=1696911079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VlDmC8xOgvBLPT4tEbSJgPFVCcqc4cUC0AhxzjgTIU=;
        b=s92SFCyIdvMsMeTjNdxyKHvjvLayhphgdRXYuJUd191arPgJf2HZprjWQDOwyz6TXX
         SZObtebAojVy7fqTnfOLcqFQP02SwCnqLTl9lkYFtYpmPrpuEnz7jsWIVZmtRKi9jgVw
         zFdBLbdORQ2Xe2B7pVSwJxunzTCaHMX3XblcY41SXMmNJgbO/dcO/JduuBE6fjXJY+qa
         Sat8psDe+7Rc+JLJzwlzQ5MC9CJlmE+IY5QtYGRA5ivSHs90VtxkiOO4gRtWF8HmHkyC
         gmEdzAKgc+j8+wunCwt8xsnH21WsTGJL44I915PTaSizpNc19r2iYje76sByD3uzjugd
         A3Mg==
X-Gm-Message-State: AOJu0YyZQcvtLGOlxswXf96jKb56WEaxUOYdYQb5ScOplT2yzn0csa9R
        SGR162M0riYMOXvIU5K4pmQ0PMphHHcFDqoRn/c=
X-Google-Smtp-Source: AGHT+IHRNniFKHd7VTak37/zQsVx97Cnk28UTsicHJG0ZWBkWdY952Jo5BRh7i0OIVL4opUYt+dT7o14ZFCLcaRqHR4=
X-Received: by 2002:a17:90b:4a42:b0:277:3afc:f27 with SMTP id
 lb2-20020a17090b4a4200b002773afc0f27mr2479482pjb.1.1696306278695; Mon, 02 Oct
 2023 21:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230928072953.19369-1-adrian.hunter@intel.com> <CAM9d7cgihVvEtGN6LbSdtSnh6U9=dOttLAOs28SVzrB_sf3fnQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgihVvEtGN6LbSdtSnh6U9=dOttLAOs28SVzrB_sf3fnQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Oct 2023 21:11:06 -0700
Message-ID: <CAM9d7ciCfMM1fj6GVBdYrwHH9zj4e=E30WTSNhzYcxNNN=PxSg@mail.gmail.com>
Subject: Re: [PATCH] perf intel-pt: Fix async branch flags
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Sep 28, 2023 at 12:30 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Ensure PERF_IP_FLAG_ASYNC is set always for asynchronous branches (i.e.
> > interrupts etc).
> >
> > Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
