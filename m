Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC88090A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443772AbjLGSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443500AbjLGSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:45:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA1D4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:45:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so1055a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701974714; x=1702579514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWB0WIEEa4Z0tavesIqmf2tsr9YlN6E60VVd41alXDc=;
        b=PzoAeIsAmdfghISxokqvgE86RpRMa6du4ujFdlJyC//7Avkyi0Bb4Femxyd5BOK/Go
         oXmRr7wK/QUnefkwd6JCSO1BVf1rUA175yqNq8oM9sG2Qupi7lsF2iOpyMzqzTk0fxGe
         ojlA9CSWucCACFjy3t+E5tmvKqdYWEykg2402p2xUqd5mSF2UsbYMb42YrmCCKU6TgFI
         MX8TfwZmcQdZ7imlVUW/LjozxeQq8H9dTQSsEC8pfwQmbrLJ7lKGMArYycmJWy8/DF8z
         /Q8oZL7SzyqGiGSYEtAfhmes/EPc8JMZ1fzme1CF7zY7m5rezMv87W7Yl52DlDAuabXF
         +XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974714; x=1702579514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWB0WIEEa4Z0tavesIqmf2tsr9YlN6E60VVd41alXDc=;
        b=Pg0f/4huQLwjHG6cMQWeXtKrAUitHEAyGyup4yvB37acgFQIzeBsePoT3KS4CP0eG/
         r/7Si2XgPNKO4msVQsxboAUxVf/xbmFAzoOTNTJ8p5ptuYAYBf1dEyBeKNNu+s0RklrG
         7KjthoHtnuNSBgwP1IgpUV9RkW866Gdk/mtOUhRBfXcE21nE+JARjotLUaclaOdVUHyl
         TvXjC3fGvnW/7qZVzUdBFy4x7wzd6+Smown1fHX2nZfIz4RreJuzHnc4iKufWepCW5Qu
         1bxpCGJPNM+KHPWPtxd/UT5JXRk4lEfRVJ/FeqKhVsv2c3IfdyLAbji2JH6ehm+XH/uU
         w8vw==
X-Gm-Message-State: AOJu0YwdBpK7bnQoXIPRUj4xpRzICNwcb4rffUotXLI70klEkRUVCOhN
        N9FPL0oofb+3k4FHSLlUsKITnyCA587niDMVZ8wuKQ==
X-Google-Smtp-Source: AGHT+IG3/oZML+t344yFzXZSbvBlxE3dHgyatuvIICstKemubny461JiiJqEooPSGNchRix6/Ykk12QMyc2QOc11Vrs=
X-Received: by 2002:a50:ccc6:0:b0:54a:ee8b:7a99 with SMTP id
 b6-20020a50ccc6000000b0054aee8b7a99mr2339edj.0.1701974713962; Thu, 07 Dec
 2023 10:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20231207081635.8427-1-yangyicong@huawei.com>
In-Reply-To: <20231207081635.8427-1-yangyicong@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Dec 2023 10:45:02 -0800
Message-ID: <CAP-5=fXRsxVUvOFp=9+nHZzsVbm0KxhSTL71=kvRpPZ14zTbQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Perf fix two memory leakage
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, hejunhao3@huawei.com,
        yangyicong@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:20=E2=80=AFAM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> ASan reports two memory leakage in the raw trace dump mode `perf report -=
D`.
> One is in the framework and can be reproduced when using hisi_ptt and
> arm_spe, which is fixed in Patch 1/2. Another is in the hisi_ptt parser
> and fixed in Patch 2/2.
>
> Yicong Yang (2):
>   perf header: Fix one memory leakage in
>     perf_event__fprintf_event_update()
>   perf hisi-ptt: Fix one memory leakage in
>     hisi_ptt_process_auxtrace_event()
>
>  tools/perf/util/header.c   | 5 +++--
>  tools/perf/util/hisi-ptt.c | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)

The series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.24.0
>
