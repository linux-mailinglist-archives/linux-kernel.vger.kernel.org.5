Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959F3793ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbjIFOaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIFOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:30:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF510F8;
        Wed,  6 Sep 2023 07:30:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC886C433C7;
        Wed,  6 Sep 2023 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694010633;
        bh=H4b49p0G1N+ERPiFWvG+J6lGuqxVEeIg8/rtSnFhxeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iN1dOangqLf1JXRqNgHyvVHqJRL0+HG5TSmQn4IPTG74f+nn6iSF52el4z5Ltpu3D
         USWhhFu746FOskth5cYghrx4bacdnEPSgoAGnxFsvy06OXNOmKuTLHK8K42NhtGnzc
         1rBy/zXRy/nWSg/8ElUk1ohRGzQJbf3QYae1l7PHM1IcYgkza+RxJO5eocu1ak+jjv
         FK91XWB3widwPXKnfljJnN4wljVOPnfHuy11Ron39To4Om+lJxSw4I67Q91QX+l4FX
         Vys1gwHGozCfxLSVLSbbhxcrAiEtRlVrW5FtNBqK/s4B+JBeYJAdziK0wqocAHTvhz
         j7jlxHB6nGpBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7306403F4; Wed,  6 Sep 2023 11:30:30 -0300 (-03)
Date:   Wed, 6 Sep 2023 11:30:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Fix aggr mode initialization
Message-ID: <ZPiNBk/m+vcsP+rz@kernel.org>
References: <20230906003912.3317462-1-irogers@google.com>
 <CAM9d7cgBZufrSWQhSeipV35_y3Kb1EWSoqtXMvLBnCFaoS9Atg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgBZufrSWQhSeipV35_y3Kb1EWSoqtXMvLBnCFaoS9Atg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 05, 2023 at 07:58:20PM -0700, Namhyung Kim escreveu:
> On Tue, Sep 5, 2023 at 5:39 PM Ian Rogers <irogers@google.com> wrote:
> > The issue was the use of testing a cpumap with NULL rather than using
> > empty, as a map containing the dummy value isn't NULL and the -1
> > results in an empty aggr map being allocated which legitimately
> > overflows when any member is accessed.
> 
> Right, evlist__create_maps() set it to non-NULL.
> 
> >
> > Fixes: 8a96f454f566 ("perf stat: Avoid SEGV if core.cpus isn't set")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Namhyung
