Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4B8091E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjLGTua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:50:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF38A5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:50:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205FFC433C7;
        Thu,  7 Dec 2023 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701978634;
        bh=uolfMoZiIRSE/4h+zQ+qJh3J/h+CcPF6Bi68mWyjVuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hw4AUm3eUGiUHDMPy4OR0enT9w8/FGehvahDwUMqHTW0frjTo3grUXPZ9joA6xby3
         G/RJsqWb3nxyR1Tp3nBXHGOCrDvDPx92BYBRBGBAJOXIOoaHws87u/0rpJ9Y5X2gDI
         yB3P8n3F+D9R1iXspXHX6JqjOcTgt3DjK7bIBotQMrILBDhMkS+MbkNLjaEb5KJ5Mf
         P4lkADP/qH/B+/7rvUOenEDV4+MuzMqrgBv+PxMD8nPclklMvivqb1snTymO6wqLZH
         5zBJ79msLN5FwG/scROF1W2BiU5IZZ/pyK9ia0vhnKkcXL1D5xIEGSH/I/p8zBDnp/
         e3kEQWTtB5mSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EED24403EF; Thu,  7 Dec 2023 16:50:30 -0300 (-03)
Date:   Thu, 7 Dec 2023 16:50:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
Message-ID: <ZXIiBp-rvdvSI-ZY@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
 <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
 <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
 <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
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

Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> On Mon, Dec 4, 2023 at 2:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, Nov 30, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > > Sgtm. My point wasn't to criticize, I think this is a good change, I
> > > was just trying to imagine doing things in a way that could overall
> > > reduce complexity

> > Yep, thanks for your review.  Can I get your ACKs? :)

> For the series:
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

