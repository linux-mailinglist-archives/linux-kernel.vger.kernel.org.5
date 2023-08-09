Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374D8775350
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHIG4b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjHIG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:56:29 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162F1FD4;
        Tue,  8 Aug 2023 23:56:29 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so5515386276.0;
        Tue, 08 Aug 2023 23:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691564188; x=1692168988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c2ojFzdHZ+liacKOpIuuI9b60nNWMmDP0BaH1HEZBI=;
        b=DnQTZR37/3m+L3SwSibUcDnpVdTBElkzZpATAdYl211W0IOTILw9hlXr5qcHi041N2
         RIryC/cp/3V7xBj+ApkgTLQY664RlETPLSefcNr7akBRyO36oKPOCF5ZvhRP+ZKhe3DM
         OiB1deguQ72pNNY9ffIOqDGbjDwqeBRcaaWqkocxQL8BLmJve1hBso7MV8SVc9EGm5Mb
         Ur/K13XXa0M3L0Mbw0VN0wDYb2GhnEnFo86qw2cr/HiL8DJDJovw9qgWnknoiyzLxgVL
         L6qnVKbQTh7TEHAxvEN57yBtdyhFrvC2H4+03qyNheFIp8VbxPdShtPz0/wWenMHStR9
         M4kg==
X-Gm-Message-State: AOJu0Yy16oTxlpMZ7eZaUNlPnS8jlywYDldT5SGam+wBj2iVtr+JiSsp
        S2No8IEBlcz5P1y4xDHWTFnavsHA2mOokY4XPvE=
X-Google-Smtp-Source: AGHT+IGdOZaA22wipBCNYsAFwmB08/wQlkuzZlmn/whmGXM8cJnVESICn4GS3578VkWMZZdkEquBdZxVr5R9z+p+raQ=
X-Received: by 2002:a05:6902:102c:b0:d07:fd29:d752 with SMTP id
 x12-20020a056902102c00b00d07fd29d752mr2106251ybt.6.1691564188235; Tue, 08 Aug
 2023 23:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230728022447.1323563-1-namhyung@kernel.org> <ZMPMHNjX2IxsLbAe@kernel.org>
In-Reply-To: <ZMPMHNjX2IxsLbAe@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Aug 2023 15:56:17 +0900
Message-ID: <CAM9d7cgqJatFn0tQVOxoQymFUruSzniPi5Okb1sotb6VLt+X_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf build: Update build rule for generated files
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jul 28, 2023 at 11:09 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jul 27, 2023 at 07:24:46PM -0700, Namhyung Kim escreveu:
> > The bison and flex generate C files from the source (.y and .l)
> > files.  When O= option is used, they are saved in a separate directory
> > but the default build rule assumes the .C files are in the source
> > directory.  So it might read invalid file if there are generated files
> > from an old version.  The same is true for the pmu-events files.
> >
> > For example, the following command would cause a build failure:
> >
> >   $ git checkout v6.3
> >   $ make -C tools/perf  # build in the same directory
> >
> >   $ git checkout v6.5-rc2
> >   $ mkdir build  # create a build directory
> >   $ make -C tools/perf O=build  # build in a different directory but it
> >                                 # refers files in the source directory
> >
> > Let's update the build rule to specify those cases explicitly to depend
> > on the files in the output directory.
> >
> > Note that it's not a complete fix and it needs the next patch for the
> > include path too.
>
> Applied, testing it on the container builds.

I don't see these commits in the perf-tools{,-next} yet.

Thanks,
Namhyung
