Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEAF8042B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjLDXlD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 18:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjLDXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:41:00 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4AFF;
        Mon,  4 Dec 2023 15:41:07 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce49d9d874so1675623b3a.2;
        Mon, 04 Dec 2023 15:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733266; x=1702338066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfCfiXm3/Ll9RNAoG2ZfPYsvYBN/K9DzLGEchqmmWgQ=;
        b=BTxUO5NEgX0zAp6anU/HspFvnmPPZ7F2x6eDhMROxg3aEgtiNTjuo/nS98KwdIfSll
         hggf2T+5eFYO881nDzS/XsaH/uIOuqtatoEXCXZ5YvpU2vC7tS0h/qAZFEal6Tc+qLtm
         5UgyQjetxL1+6l0xnXQfAmucNuAE6aOh+1nTECNDd5gQONA14MrAMuKQx1hZ0N8x/lve
         aHUeIohc3IysiVfbUWbA/qVCaIPHwzHeEkWz+aFE9D/tOEfUrsOeFPZI7fJEraFsujXZ
         kjxIKMCjO05AwDgicaa3WBVg1XEN2RUKKm/0eNcdzySt2CqmU2xQ/NfLgzGclfwwD6CL
         aQ3w==
X-Gm-Message-State: AOJu0YyJMx8tfGz1gitUOzqcv7Kd2NuO0CIRQ4AO1EA4O9jJKQPa1VUl
        tOzSZfZyHF3TfgP2gOSCxeaBNgM7b4ipKf6bnPk=
X-Google-Smtp-Source: AGHT+IHowDJWLRJJ9Oic8ewLV/VvozPVgxLbW0FyweAuE4eUcJYcPDO7LHoRQbV17sr9di9l/AEvwEfIQsTiX3zwflE=
X-Received: by 2002:a05:6a20:42a1:b0:18f:1d8b:fadc with SMTP id
 o33-20020a056a2042a100b0018f1d8bfadcmr5555994pzj.19.1701733266511; Mon, 04
 Dec 2023 15:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-14-irogers@google.com>
In-Reply-To: <20231127220902.1315692-14-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 15:40:55 -0800
Message-ID: <CAM9d7chEb_ij73ZhBr9EpT7HE34Hy0aqTOmSWp_-xTwc2=0Zjg@mail.gmail.com>
Subject: Re: [PATCH v5 13/50] perf maps: Move symbol maps functions to maps.c
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> Move the find and certain other symbol maps__* functions to maps.c for
> better abstraction.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
