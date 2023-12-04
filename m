Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F638803F26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjLDURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjLDUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:16:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E01D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:17:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54494C433C8;
        Mon,  4 Dec 2023 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701721025;
        bh=0UrX2iBVuIergkZq8gZnOx8mwnXEDjVYpx4+esY98GU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4O3MZ4z0dRtwiB0/ZvjjwMFvPnFXrN6dAEeKSDBJ3T0hTbOmn184Vs9B3YZNRCV1
         5RiEt6BWASfQvlyx0qJsX7J1SlR1EYqdpx7bKoVBB+pYzN491YUiBSSTs3shyCfDp4
         qfE2JzPjGUW4lzU/3gpLPhK8jLk8E+uIz0yqALstD6OwCgyAN5vpLSP0MXlP1trO4q
         vVklbt2/xkhTpJZiAGsMdPlmP96CgtRrJgW2nVPm79LxuxU0/734pnIWcPciyDR9Tj
         h0SCgDjyEaAC11WRizXjiQjQcq0XfVDAlOxhi0dkSgEFJPAj7fvG7ZfYye8lU5ghzq
         QRJTZz9Yi3I3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A0C9F40094; Mon,  4 Dec 2023 17:17:02 -0300 (-03)
Date:   Mon, 4 Dec 2023 17:17:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ammy Yi <ammy.yi@intel.com>
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
Message-ID: <ZW4zvk2ZUnLuFgFK@kernel.org>
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com>
 <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
 <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
 <f5112f5e-c77c-4a9a-ac3b-66772adba471@linux.intel.com>
 <CAP-5=fU6EXenN9uU1DZ3X=L+k6Y-4a-XESfY9gL9ZCowhSazWA@mail.gmail.com>
 <afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com>
 <CAP-5=fW=b7KmiJKgFOxWd4ayG9A+f4E6QuTKCV0bZmf=SWSQ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW=b7KmiJKgFOxWd4ayG9A+f4E6QuTKCV0bZmf=SWSQ4Q@mail.gmail.com>
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

Em Fri, Dec 01, 2023 at 06:08:13PM -0800, Ian Rogers escreveu:
> On Fri, Dec 1, 2023 at 1:43 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > On 2023-11-30 3:36 p.m., Ian Rogers wrote:
> > > On Wed, Nov 29, 2023 at 1:15 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > > Anyway, if you don't feel like the refactor we can move forward with
> > > this or a v2, let me know.

> > I think the refactor is doable. I will work on it next week.
> > But I think it should be on top of this fix.
> > If you are OK with the fix, I think it's better to have it merged first.
> > So everything would work properly. The validation work will not be blocked.
> > Then I can send a patch set to cleanup the perf mem events separately.
 
> Thanks Kan.
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

