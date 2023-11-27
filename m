Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCF7FA416
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjK0PHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjK0PHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:07:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28E111
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:07:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CFCC433C7;
        Mon, 27 Nov 2023 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701097674;
        bh=ZdIXB0ZgEROwUnVRRd+CBLfr1DhIzDP6zKsUGU3ilNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyrBq1wKWIspuT1T2STUO+qy0bcVBd9tMyqbNnPungwQQUlcBqVCARYpC/h9L3jGs
         JuD5XLvYnx8F6mUfYQ1lprQzo1LgvvtHRHKO8xHhH71eAfcM3hUu40p91Zi1Xw+yqa
         9fupgekRgdY4u2/h5hhaMbo13yIPZcXzbqgBfQdgWkGnlEQjncIU5mAL9EQvKSgEcW
         zTqnYMN1dbN0JeYPYGhjwBC3KkaAZrSI0/kNR6giAa9gevm8gk3p3b1+DbFqcmp5TB
         QQ5Iuc0IDCDEWET1rNKLrEj7sPYQTsIM2emEvaa+eYlg+9LVZzVkbtMxurW0kPRSFl
         2sgkhU2i6xnsg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6269540094; Mon, 27 Nov 2023 12:07:51 -0300 (-03)
Date:   Mon, 27 Nov 2023 12:07:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH linux-next] perf report: remove warning on missing raw
 data for s390
Message-ID: <ZWSwx5DQxNm8QnR1@kernel.org>
References: <20231122092703.3163191-1-tmricht@linux.ibm.com>
 <CAM9d7cjoniVhpb=xK8WSN1C80y4D25Tjedax9AmwPf1w2FsKrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjoniVhpb=xK8WSN1C80y4D25Tjedax9AmwPf1w2FsKrA@mail.gmail.com>
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

Em Wed, Nov 22, 2023 at 06:34:14PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> On Wed, Nov 22, 2023 at 1:27 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Command
> >  # ./perf report -i /tmp/111 -D > /dev/null
> > emits an error message when a sample for event CRYPTO_ALL in the
> > perf.data file does not contain any raw data. This is ok.
> > Do not trigger this warning when the sample in the perf.data files
> > does not contain any raw data at all.
> > Check for availability of raw data for all events and return if
> > none is available.
> >
> > Output before:
> >  # ./perf report -i /tmp/111 -D > /dev/null
> >  Invalid CRYPTO_ALL raw data encountered
> >  Invalid CRYPTO_ALL raw data encountered
> >  Invalid CRYPTO_ALL raw data encountered
> >  #
> >
> > Output after:
> >  # ./perf report -i /tmp/111 -D > /dev/null
> >  #
> >
> > Fixes: b539deafbadb ("perf report: Add s390 raw data interpretation for PAI counters")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

