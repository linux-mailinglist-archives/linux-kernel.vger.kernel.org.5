Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A67D5F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjJYAet convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 20:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJYAer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:34:47 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35AA10DC;
        Tue, 24 Oct 2023 17:34:45 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-564b6276941so4012769a12.3;
        Tue, 24 Oct 2023 17:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698194085; x=1698798885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPJ3ikDFUsXo043wQDFUZjWLaI/XIii/rtjaUwo0cPo=;
        b=p/u7wmkDNA7Ec9ZRxJS5yPdSjg836B66gl60BnIZzCIl2Km3Ckf7nP0/el83PDxUXm
         /h3m+wedIwUp5OAx2elHEhsDLXDTlh5RCaYthfsUt8MkQpu4EDIAA5QFiyQK6s9FYNn8
         idkQD2x2fJ28oDeq/iHfuVr2KBp7nMpT1qkr1MzA5l9YTeIN5PMpOjCfAQrv10IX0ver
         iqAGS5xWF45drIMiIFeqxVk/KlgSKXuGI0l0CaNIrRYYlnXbXNeoEnNpjR9dbYzcg/UT
         MnKKppWTKp1vtRxqQOZkkhQkdaHW4syohCC10bkcoOTbM3XRoYOE3LVoDsK1rCMCrB4E
         Ppuw==
X-Gm-Message-State: AOJu0YwNEyjkhXQxdK5u4+vFJdzOte4zSPH7nlAKTirVm4I3dyEGZ24m
        0mawQfWewXYQb4mPOQTJoVdu6gWfh/W8tKpIS08=
X-Google-Smtp-Source: AGHT+IHuCWQmOV9T92y6SKKVVwNZ03oYE1gpCz7tq6+YH0oXEFwazTvYlG8PSf0eqOaJsq1BsYXFVbR/UuAo0ZLHPSs=
X-Received: by 2002:a17:90a:1602:b0:27d:4dae:3c62 with SMTP id
 n2-20020a17090a160200b0027d4dae3c62mr13428350pja.27.1698194084918; Tue, 24
 Oct 2023 17:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231025102647.321c6629@canb.auug.org.au>
In-Reply-To: <20231025102647.321c6629@canb.auug.org.au>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Oct 2023 17:34:33 -0700
Message-ID: <CAM9d7cjNAiE6bdSoQKsAqQcHBm1APz6C+-vQwu4BTB5R83dEgg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Hello,

On Tue, Oct 24, 2023 at 4:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
>
> perf/util/pmu-flex.c:1812:1: error: unterminated comment
>  1812 | /** Setup the input buffer state to scan a string. The next call to yylex() will
>       | ^
> perf/util/pmu-flex.c:550:24: error: 'yy_fatal_error' used but never defined [-Werror]
>   550 | static void yynoreturn yy_fatal_error ( const char* msg , yyscan_t yyscanner );
>       |                        ^~~~~~~~~~~~~~
>
> I don't know what caused this, but the above file looks fine and redoing
> the build works, so it may be some timing problem when doing an
> incremental build?

Yeah, I think I saw this error before.  Looks like a timing issue
but I believe something is wrong with it.  I'll take a look.

Thanks,
Namhyung
