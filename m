Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7EA807131
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378636AbjLFNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjLFNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:51:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4675122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253ABC433C8;
        Wed,  6 Dec 2023 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870686;
        bh=GLeeHfOeGoG5/MxNRdUC4rUQIwViNOc7KTKzMVOdT6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKqfpPY9RMsiEns7RW18gyj3JUAdojEJ+cZ0KB6WLtPxgAwGAIv3gnwrQ4mQDiayh
         CfWj4Z5RCjAFC5z9MMy6hr0tz8p6CRFOngZAYbLQxShpFlJC0ME3X9R4ShDNUKpUC6
         2vghHGsRRYkQhoA7Cyj0pzfxF7/vXHpG30dfC0IehWvx685kxHdoY9dO7QjPIUULz9
         UYFbF4IOXWmOey0+6/K9+6k7ufufE2J/nsbufkQTPOXkR7sc/vRxmA8zLInfkXNIfz
         Of0FxTDhF9xGQNQziU8JI9MNnIo+diLY8hzQRBXawY8uzwYds+egIFu3yiJ8005wgn
         at0I2nOlcPXKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 43A78403EF; Wed,  6 Dec 2023 10:51:24 -0300 (-03)
Date:   Wed, 6 Dec 2023 10:51:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v5 14/50] perf thread: Add missing RC_CHK_EQUAL
Message-ID: <ZXB8XDM8YkLNGYoD@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-15-irogers@google.com>
 <CAM9d7cjbZgKHJ472Gwz=6C-htWDiPQGWbq7how0zcUuwYxxQmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjbZgKHJ472Gwz=6C-htWDiPQGWbq7how0zcUuwYxxQmQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 04, 2023 at 03:41:42PM -0800, Namhyung Kim escreveu:
> On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Comparing pointers without RC_CHK_ACCESS means the indirect object
> > will be compared rather than the underlying maps when REFCNT_CHECKING
> > is enabled. Fix by adding missing RC_CHK_EQUAL.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

