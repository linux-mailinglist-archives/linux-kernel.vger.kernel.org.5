Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE10805C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442500AbjLEPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346918AbjLEPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16207D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:54:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA5EC433C7;
        Tue,  5 Dec 2023 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701791689;
        bh=o4aVIuxjrPEXq7MUNeoMQrjgq/QwX2+q3NVUago8P7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRgmc4XmccVhcTfMfbDmDehBpfSndSKD/y93zlELkc5mWZiKKovHFS3gWclmxXVIy
         hZEI2z6LQK8m+cCfbjUlGDqAa/y9XMPoyKOszXOZQbz12D+ubBvBzAYDhwZCdqk8ir
         jZmw7iPfYEayqp7ormZgukPAeck0Q0Mx8qnDPfDOu/B31JUC2HYxSIKujZkzwszZGu
         cwD62+lDx4Ccb4CQNig2XqPubnDuBMrTVt/Wg2RsUPW4ZohUJWMI+bvpGeTV6k0nyy
         LusVQ4WkTjrlV8H+o1KEPGx+ADPDOut+I09KhEOyeEokMw8RRFYciqvOvc9dv4ipn0
         TCg8Z1eAYbQUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CDEB40094; Tue,  5 Dec 2023 12:54:47 -0300 (-03)
Date:   Tue, 5 Dec 2023 12:54:47 -0300
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
Subject: Re: [PATCH v5 08/50] perf record: Be lazier in allocating lost
 samples buffer
Message-ID: <ZW9Hx2kCudM1Dc7z@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-9-irogers@google.com>
 <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com>
 <CAP-5=fXjReF38T_GKohtWd7_7fZjYVnKBj-Fwt+agi1vSWAEdQ@mail.gmail.com>
 <CAM9d7chU1Jyurb6bmZOSmeuFky9eN+2Ty7kMrQxyUXN=r0FKvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chU1Jyurb6bmZOSmeuFky9eN+2Ty7kMrQxyUXN=r0FKvg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 02, 2023 at 03:56:48PM -0800, Namhyung Kim escreveu:
> On Thu, Nov 30, 2023 at 10:29 AM Ian Rogers <irogers@google.com> wrote:
> > On Wed, Nov 29, 2023 at 6:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > To minimize the allocation size, this can be
> > > sizeof(*lost) + session->machines.host.id_hdr_size
> > > instead of PERF_SAMPLE_MAX_SIZE.
> >
> > Sounds good, should probably be a follow up. The current size is
> > PERF_SAMPLE_MAX_SIZE.
> 
> Yep, I'm ok with having it as a follow-up.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

