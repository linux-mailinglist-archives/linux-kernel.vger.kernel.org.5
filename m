Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6967FEFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjK3NDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjK3NC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:02:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774BC10D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:03:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B48C433C8;
        Thu, 30 Nov 2023 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701349386;
        bh=1FPM5w/i6S0Q04oL+gVfGh38uu2R4D28EHz8Ggy4Wl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubtcrQo6k8dELTQ98qmB2vQggVeYtiqRc8OHhoKKnywxytrmhiiGqlEaNHfEOIcge
         eqKJLK8JJPoImMIlBld0IrJHTntVoljaMo+aHHU7ve6xc7ib3Mdsu+5v5PfS2tofDn
         WdBwpCrSPIs5w2B5mxQv9RClpsdsOXTH4HGP3z4vwb3+sDjYRTq7W7qydlAeIj1as6
         TbWP7JTiYtB0ppgb8cyI9X+XoiQCJ/hpd91hC1x7JnmL32QftHJF0OO8spMu/F+OZk
         B71IUsQ3iXVrBTfXM4VMhowNhTAHb+t7dH60N7a0Pn4RLq37WX+9JtQa9ZPgTQWjPf
         ciqgw/z/yXlsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB17E40094; Thu, 30 Nov 2023 10:03:03 -0300 (-03)
Date:   Thu, 30 Nov 2023 10:03:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
Message-ID: <ZWiIB0AURxL7qb5e@kernel.org>
References: <20230602194513.1589179-1-namhyung@kernel.org>
 <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
 <ZV9lfJyyC7xawHBC@kernel.org>
 <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com>
 <ZWSombzfCkxHc7lC@kernel.org>
 <fc2390cf-bdf9-590e-d078-4bb616d5feb6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2390cf-bdf9-590e-d078-4bb616d5feb6@amd.com>
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

Em Thu, Nov 30, 2023 at 11:58:15AM +0530, Ravi Bangoria escreveu:
> On 27-Nov-23 8:02 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 24, 2023 at 09:30:37AM +0530, Ravi Bangoria escreveu:
> >> On 23-Nov-23 8:15 PM, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
> >>>> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
> >>>>> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
> >>>>> events with brstack.

> >>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

> >>> It seems this patch was not merged, can you please check?

> >> Right. And it does not apply cleanly on peterz/queue.git/perf/core, since
> >> surrounding code has changed.

> > Can you please refresh it if PeterZ has nothing against?

> Posted v2: https://lore.kernel.org/r/20231130062246.290-1-ravi.bangoria@amd.com 

Peter, can you please consider this one?

Thanks a lot!

- Arnaldo
