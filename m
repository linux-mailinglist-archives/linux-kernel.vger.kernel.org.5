Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F68801440
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjLAUXX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 15:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLAUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:23:21 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B027103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:23:28 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28655c04da3so978618a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462207; x=1702067007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6uSDoNQeYcE0d3VamMdZZXW8gFGXoitBoE7ho02KuE=;
        b=jOiq6yd+NpgxYq3rm4k4TGPKf+8ht2xLb4cNZVtGsh2Rfh608aQnVk4zhVmnZcyjsJ
         EbL39RS1PmVSVVRzl9/oHweaxy8rIEqR/IkVIKAfFhhwRab+fwnGHy2O5l/XPLrZrg1x
         4znGb1g+yzyvCaJMXFgn8eAQ02CfKNoEpG/CEfkaOQVoKLWNMd3qUXHkLsdi6fD1eq1K
         kbj4b/bRlll46MpMZKhFiIFMFwd48YUlgNxHrhlwO8b64vI2kBYIOR3b0zelGEsI4I9D
         +qKcSbHh9W4/QlRIjNYnBakdNfNG3nctbztjDYvyBnfTdsVHg/t/xDSutNHWO8MQe+zU
         bVAA==
X-Gm-Message-State: AOJu0Yx/JBTq2HPPIzdYelIe2Cniq8rMtdvGrh/VYQwbjxIPlICaBk9I
        PgISgU5+e6eeP0cT9elbRpNXwFH+MlWaGmQZR2A=
X-Google-Smtp-Source: AGHT+IElxmUYJWDP0N0x4mjkJdPj7Cphje6oPkxkNXasQkSuVWoCdEedb7NIn6VkqjU3pWEasACeUrfITYeZdZKHTTA=
X-Received: by 2002:a17:90a:ce92:b0:285:7e62:2822 with SMTP id
 g18-20020a17090ace9200b002857e622822mr214159pju.16.1701462207563; Fri, 01 Dec
 2023 12:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20230602194513.1589179-1-namhyung@kernel.org> <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
 <ZV9lfJyyC7xawHBC@kernel.org> <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com>
 <ZWSombzfCkxHc7lC@kernel.org> <fc2390cf-bdf9-590e-d078-4bb616d5feb6@amd.com> <ZWiIB0AURxL7qb5e@kernel.org>
In-Reply-To: <ZWiIB0AURxL7qb5e@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 1 Dec 2023 12:23:16 -0800
Message-ID: <CAM9d7chHWovp7W+e6KBaeZh3pBZTuHBe0hRH=6WW9-XBp0SQaw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>
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

On Thu, Nov 30, 2023 at 5:03 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 30, 2023 at 11:58:15AM +0530, Ravi Bangoria escreveu:
> > On 27-Nov-23 8:02 PM, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Nov 24, 2023 at 09:30:37AM +0530, Ravi Bangoria escreveu:
> > >> On 23-Nov-23 8:15 PM, Arnaldo Carvalho de Melo wrote:
> > >>> Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
> > >>>> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
> > >>>>> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
> > >>>>> events with brstack.
>
> > >>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>
> > >>> It seems this patch was not merged, can you please check?
>
> > >> Right. And it does not apply cleanly on peterz/queue.git/perf/core, since
> > >> surrounding code has changed.
>
> > > Can you please refresh it if PeterZ has nothing against?
>
> > Posted v2: https://lore.kernel.org/r/20231130062246.290-1-ravi.bangoria@amd.com
>
> Peter, can you please consider this one?

The v2 is already in the tip tree.  Thanks Ravi for doing this!
Namhyung
