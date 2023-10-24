Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCBA7D5B44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjJXTND convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjJXTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:13:02 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057410C3;
        Tue, 24 Oct 2023 12:13:00 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6b709048d8eso3825026b3a.2;
        Tue, 24 Oct 2023 12:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698174780; x=1698779580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huRoCbol9sNMgaeeR3QA3ScQBG85LW2f8G//agffXVw=;
        b=wfyiIq0otJgEpPdmEAKRyZEhVEU0Clm0+I2HJGzbT0mSDJbc/hHx15VibuP6EgF+B0
         fWfz56Oe2t+F6/yeEkIla2K2B/Hc6ru1/s4/aNJYuTIEfkWvbhdqzPppU8LvnoQtp9vo
         IU49nLSF3/qI9V6k3VfrcSLvtDSXvOR3x1veOkffLVV+fAKQcUsmTN5iftt49YLUSLja
         oRTvr8aI2ofHUBwzD4YB6AhhBcfLzxnW2TmYUV7rzldLtXpwTbMNnLKTLoLSL/iIzUCN
         WS7vo4lFkRN6YjDohSATaZJfougGOy3Reo+U5fFa8c6o8ZxsL6hjXQGTEX8UHsYeStPE
         B9Nw==
X-Gm-Message-State: AOJu0YwcVkt82/DDE3yCgbnxeknzaPiDAMYxRPesDPEZMvnixQSpgXJU
        rQiQx64+72/Tm2K3LCud5lPnlLjC6XAjza2m2do=
X-Google-Smtp-Source: AGHT+IElqV2VvOOlwXcCKYbePTwIdFTsHFEljmIA2WcXU6fpC5iokmsfsZ1W/m28EC0JKtUESSAvPDgR0h1ZnWaZ9DA=
X-Received: by 2002:a17:90a:183:b0:27f:bd9e:5a15 with SMTP id
 3-20020a17090a018300b0027fbd9e5a15mr4754395pjc.28.1698174779944; Tue, 24 Oct
 2023 12:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-23-namhyung@kernel.org>
 <ZTatKUD6nS7OlvuC@kernel.org> <ZTawKZK/ImWsPkUI@kernel.org>
In-Reply-To: <ZTawKZK/ImWsPkUI@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Oct 2023 12:12:47 -0700
Message-ID: <CAM9d7ch5CCv+RjLzZp51DrLaONS9vbyUTOg-dJZ_c-deTH3Fzg@mail.gmail.com>
Subject: Re: [PATCH 22/48] perf annotate: Add --type-stat option for debugging
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
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

On Mon, Oct 23, 2023 at 10:41 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 23, 2023 at 02:28:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > When building with NO_DWARF=1 or in systems lacking the used DWARF
> > libraries. I noticed with some of the build containers, will updated
> > those to have the required libraries so that this feature gets compile
> > tested there.
>
> The problem was that I build with/without NO_LIBELF=1, and with it set
> NO_DWARF=1 is enabled and thus breaks the build.

Ok, I'll take care of NO_DWARF build in v2.

Thanks,
Namhyung
