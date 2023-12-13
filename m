Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE560812132
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442747AbjLMWHM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 17:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjLMWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:07:10 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6CF5;
        Wed, 13 Dec 2023 14:07:15 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ce831cbba6so4346445b3a.2;
        Wed, 13 Dec 2023 14:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505235; x=1703110035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF84qvQF+jKoq1M1NI49RnbH9CqQ4Hru8EABSTtyapU=;
        b=nbhSKYymGhY3JvL5kKAyYrILxLMp7tNndtTFSOdQO800+XhmBfqHfcZ/+nfhNXD5d3
         qBvNGMykcrpQKwciEh7G9bCSRtrOWcqkMmuU2NbwYg9WjUtu3FKNViAXhEALeZEaehpN
         adfJbI3lTQQtePdYsDbggr1PnF+CUfpBBIKNQwqKStf54bVNoeQiQWk57LbjYMQH+KnI
         juZv/jxWHgRIaFjuK8rHhY2JFzJkbNNblEa/Wipvu+CgBr5XoET7V1X/ikvSsWZVKpye
         KHI19+5+cLQDSv0fmwXRFgvz/hvES7POhi51nUnjIOMRM0WYqa/sr/xYVYdmopH7DjBM
         N/dg==
X-Gm-Message-State: AOJu0YwfhR4dMIq5S0JmjAOUC7MDeHV+unwfIT7ppNYQBavNlDtIMn6R
        frGpodRJ3dYhSmVMLwVKknxVrXcnFd2Za99dg5g=
X-Google-Smtp-Source: AGHT+IE4fpAh5MRfkBwR4G2EsuGiPpoQeclq+TFz1vKJ79Qrtc1dEmQiSBBHzIFIDWUev4rbxa1zoee6r87xm0H/Q7g=
X-Received: by 2002:a05:6a20:7a81:b0:187:b14f:a2a with SMTP id
 u1-20020a056a207a8100b00187b14f0a2amr4572950pzh.20.1702505234919; Wed, 13 Dec
 2023 14:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org> <CAP-5=fV5sA1ga5UfvHW_=Ep25b-TzsLJ8Atqk3KePKOx-fk9TQ@mail.gmail.com>
 <CAFjbc8Gt1GpLWjDf1jdhnb6fhVx246Tik+_TFXarGEqiZUY5BQ@mail.gmail.com>
In-Reply-To: <CAFjbc8Gt1GpLWjDf1jdhnb6fhVx246Tik+_TFXarGEqiZUY5BQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Dec 2023 14:07:03 -0800
Message-ID: <CAM9d7chSAJS+ro65eG9-A6G5xdgt0JTzJkYAnzqrW28EQ-zGug@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
To:     Pablo Galindo Salgado <pablogsal@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 4:54 PM Pablo Galindo Salgado
<pablogsal@gmail.com> wrote:
>
> > It'd be great if we could do similar for CPython.
>
> We (the CPython team) plan to release the perf jitdump support for
> Python 3.13 (around next October) so you will need to build from
> source or wait until is officially released for that test.

Okay, I hope we can have all the fixes asap and most distros ship
the latest version by then.

Thanks,
Namhyung
