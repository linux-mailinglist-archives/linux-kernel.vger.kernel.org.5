Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5A810786
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378184AbjLMBUh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 20:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378146AbjLMBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:20:35 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CACE109;
        Tue, 12 Dec 2023 17:20:30 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9e2a014e8so4383934b6e.2;
        Tue, 12 Dec 2023 17:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430429; x=1703035229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDV23UfQcsiX7X38F3L5/gMcpwEJh9Y0+V7g6hM71gc=;
        b=KLW+zhVLY4+XptpS1QhwOpzlNjHSZj2vNTOr+PIgNgPi3iZb5UI2k9KQNxm54c+H2u
         vF6G2UpfGlekBBBzdS2bKMu68dSgkpH9/0Vvij4X3Tz8XpdUegNekFFUPt8tdVhK9iDI
         MLoXoOVBOUrmrTlME9S0CY0KlltysEliQPUvwGi/lVXUylVVtF0LPbxKAvk+bUVmFBNE
         9ZorXGIHsLwKBPvxqUSzYUzWKtt5vgJLDKVJjczxsCMcw0C4dDfSni/Rbh4l00OgxC9e
         YGonWLN8RI2JRy5NayWLXHiA9FcQIoN/PdYYDxVfEsHhc8Im8QcKwqJ/1972Mqs5f4N9
         oELg==
X-Gm-Message-State: AOJu0YzBLWJIHfaZ01JuYQdPoC/XDhToLuE2LdbrVxbEqaqwqaA+Qtg7
        P8p7BwwLjP/FcbMU6hoM8rL1gyD4XWIa0jvpF24=
X-Google-Smtp-Source: AGHT+IEmB8ZiGiwrSCCoseXLOaGUQiS/8jpIC2lF/0Ti3OWOHpRo3txtpbpT5bK0l0OFcTPwC+dDxsWivJf3tyH+0s8=
X-Received: by 2002:a05:6808:2186:b0:3b8:b063:6ba7 with SMTP id
 be6-20020a056808218600b003b8b0636ba7mr10146976oib.86.1702430429500; Tue, 12
 Dec 2023 17:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20231207081635.8427-1-yangyicong@huawei.com> <20231207081635.8427-3-yangyicong@huawei.com>
In-Reply-To: <20231207081635.8427-3-yangyicong@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Dec 2023 17:20:18 -0800
Message-ID: <CAM9d7cjmgFEXsHOfkryZRdypEdxb48JCrH-T70KYwsDXsZvWFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf hisi-ptt: Fix one memory leakage in hisi_ptt_process_auxtrace_event()
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, hejunhao3@huawei.com,
        yangyicong@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:20 AM Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> ASan complains a memory leakage in hisi_ptt_process_auxtrace_event()
> that the data buffer is not freed. Since currently we only support
> the raw dump trace mode, the data buffer is used only within this
> function. So fix this by freeing the data buffer before going out.
>
> Fixes: 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing HiSilicon PCIe Trace packet")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Namhyung Kim <Namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/hisi-ptt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 43bd1ca62d58..52d0ce302ca0 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -123,6 +123,7 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
>         if (dump_trace)
>                 hisi_ptt_dump_event(ptt, data, size);
>
> +       free(data);
>         return 0;
>  }
>
> --
> 2.24.0
>
>
