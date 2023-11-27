Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08EA7FA339
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjK0OnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjK0OnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:43:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC1135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:43:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C3C433C9;
        Mon, 27 Nov 2023 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701096186;
        bh=Mpooaxd6qlzBPGhMTWc6TBoY3fAhwP8179zOVmhHZc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0VNXQBwfae+zomFI11MW8jQNo54Ite29pj5VueZhibOsECkW6sXOwK6tXfRNQP39
         +IANnpFjvNm7rfjHrm5isjxt0alRAe6nU/iHbwgglaLhKcvRfsc0+SG/ZiQlfwrC4k
         uFJ93bmvs3WS7htUoE6m0HcGEJ++rLv62oBk9t5FENgZX4ynbmk2ALPVALcsQzL4KY
         IydyWZQQ0ULedy1YINLzCUgNShE96xrcq7pjdmJFBqGtqCOEk134V4yq3V7rIFZ4HR
         XWN03DeJB7jFFCfE/lXbBs13/O9H67frXJCL6GhMO1QQnFIFKPYhp3xupFRFTwEIyP
         4ZZYC5W77KIcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8094940094; Mon, 27 Nov 2023 11:43:03 -0300 (-03)
Date:   Mon, 27 Nov 2023 11:43:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/2] perf lock info: Enforce exactly one of --map and
 --thread
Message-ID: <ZWSq96mWUpLuGh0L@kernel.org>
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-3-nick.forrington@arm.com>
 <ZUEfXU34ZijKe8aA@kernel.org>
 <3ae2cf90-b0a1-5f54-56aa-ed4a04dca8b0@arm.com>
 <CAM9d7cjQs0BrFAMa4=PGxxPBoGOAVzermH=0HrA1rhegmAA8zg@mail.gmail.com>
 <ZUvvXhkY+NcSxaJU@kernel.org>
 <df428c93-e3b8-c60c-001f-2228845983cf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df428c93-e3b8-c60c-001f-2228845983cf@arm.com>
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

Em Mon, Nov 13, 2023 at 11:50:16AM +0000, Nick Forrington escreveu:
> On 08/11/2023 20:28, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 01, 2023 at 11:00:42PM -0700, Namhyung Kim escreveu:
> > > On Wed, Nov 1, 2023 at 7:35 AM Nick Forrington <nick.forrington@arm.com> wrote:
> > > > On 31/10/2023 15:38, Arnaldo Carvalho de Melo wrote:
> > > > > Em Tue, Oct 31, 2023 at 12:05:25PM +0000, Nick Forrington escreveu:
> > > > > > Improve error reporting for command line arguments.
> > > > > > Display error/usage if neither --map or --thread are specified (rather
> > > > > > than a non user-friendly error "Unknown type of information").
> > > > > > Display error/usage if both --map and --thread are specified (rather
> > > > > > than ignoring "--map" and displaying only thread information).
> > > > > Shouldn't one of them be the default so that we type less for the most
> > > > > common usage?
> > > > There isn't an obvious choice (to me) for which would be the default.
> > > > Both options display completely different data/outputs, so I think it
> > > > makes sense to be explicit about which data is requested.
> > > Maybe we can default to display both. :)
> > Yeah, that would be a better approach, I think.
 
> I'll submit an updated series for this, with the next update to patch 1/2
 
Thanks, tried using b4 but it din't find a v2, will wait then.

- Arnaldo
