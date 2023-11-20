Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F847F1E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjKTUnR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 15:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjKTUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:43:15 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D2E3;
        Mon, 20 Nov 2023 12:43:12 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2839b418f7fso2076048a91.2;
        Mon, 20 Nov 2023 12:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512991; x=1701117791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uEWKcf0Qu+JBFnsj4DeP5h18wjA4sNIxAJuwdb8sxU=;
        b=hKwgQgnBzTZLF4RlW/aeaGNubHJTv+IgO+8jkMihNlQbqXgOc3Oh+LkyqDspkbCF48
         HirD1OmCLY4bfxnMXmoGdsJxdEINbsTr0byj+I2AzmZ58JLHjA+HZeNKTBVVa4atRFyd
         2kfi/BmS5xjYe+VmQ/RtI5sUF5Ng9ghKJA6SFqeCz37t8EJ6rwpNNICrobxa0qBsUmKq
         26k8yrUb04UHl/xcxwCVHrJ53H5V8Q8Z8NAH3i6LsmhPsGLwcmI6hI5iAed8QEe5B5G+
         qiYqhTzh6opezbQbHDX0vRrpsLrG72xnfix4D4iuZXDqXrPU3HWoW9uViQh4GfuoRi/7
         O9rg==
X-Gm-Message-State: AOJu0YyQ9GApiYr1CPYdwsB31aUifcx80iXOPrwgHvmGJwhX2gJ4Np0n
        fLpqrtR6v2kYTsFM2CgDijkD4tvkjaEhcrYiwcc=
X-Google-Smtp-Source: AGHT+IG/d7JgW8EAdqGPjQumtNuDPJUeNf5SpANhbNyrZWBbVaf/AsuklIdvm5uo7lAZd0Z3QCaEp67JShW5j0p1u5U=
X-Received: by 2002:a17:90a:f018:b0:27f:fc2f:4831 with SMTP id
 bt24-20020a17090af01800b0027ffc2f4831mr7539084pjb.13.1700512991415; Mon, 20
 Nov 2023 12:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20231110000012.3538610-1-namhyung@kernel.org> <20231110000012.3538610-13-namhyung@kernel.org>
 <CA+JHD90fkWNrQWO5DrHeV8mCmFyKKqJ8fV=KwztRi7TSw+8yDg@mail.gmail.com>
In-Reply-To: <CA+JHD90fkWNrQWO5DrHeV8mCmFyKKqJ8fV=KwztRi7TSw+8yDg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 20 Nov 2023 12:43:00 -0800
Message-ID: <CAM9d7chUNfAnLB-Hwry8M1d1Nb+YH3jf3ySmTZJoC0NYeqDAdA@mail.gmail.com>
Subject: Re: [PATCH 12/52] perf annotate-data: Add find_data_type()
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
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

Hi Arnaldo,

On Sat, Nov 11, 2023 at 10:55 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Thu, Nov 9, 2023, 9:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>>
>> +static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
>> +{
>> +       Dwarf_Off off, next_off;
>> +       size_t header_size;
>> +
>> +       if (dwarf_addrdie(di->dbg, pc, cu_die) != NULL)
>> +               return cu_die;
>
> Isn't the return type a bool?
>
> Shouldn't be 'return true;'?
>
> Ends up like that as cu_die isn't NULL, but looks confusing.

Ok, will change.

>
>> +
>> +       /*
>> +        * There are some kernels don't have full aranges and contain only a few
>> +        * aranges entries.  Fallback to iterate all CU entries in .debug_info
>> +        * in case it's missing.
>> +        */
>> +       off = 0;
>> +       while (dwarf_nextcu(di->dbg, off, &next_off, &header_size,
>> +                           NULL, NULL, NULL) == 0) {
>> +               if (dwarf_offdie(di->dbg, off + header_size, cu_die) &&
>> +                   dwarf_haspc(cu_die, pc))
>> +                       return true;
>> +
>> +               off = next_off;
>> +       }
>> +       return false;
>> +}
>> +
>>
>> +struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
>> +                                          int reg, int offset)
>> +{
>> +       struct annotated_data_type *result = NULL;
>> +       struct dso *dso = ms->map->dso;
>> +       struct debuginfo *di;
>> +       Dwarf_Die type_die;
>> +       struct strbuf sb;
>> +       u64 pc;
>> +
>> +       di = debuginfo__new(dso->long_name);
>> +       if (di == NULL) {
>> +               pr_debug("cannot get the debug info\n");
>
>
> Shouldn't inform the dso->long_name and function name to ease debugging?

Sounds good, I'll update it in the v3.

Thanks,
Namhyung
