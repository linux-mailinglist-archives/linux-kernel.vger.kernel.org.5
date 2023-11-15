Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F57ECA22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjKOR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKOR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:59:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7F196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:59:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9866BC433C9;
        Wed, 15 Nov 2023 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700071194;
        bh=qJI2z0ReFfzq8M+WOh0oHBJMpUIn9L9pdYg857SZGY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEH30KYa+z8fuMcvGKVHOCb7nabg24cQjk9qizAUfFn8JMrOivyxgEOjSjqBYdTf5
         JJUsreegDd1Htec7k05AJdDtwfb/nE5J3JEHpbTssIzVc3JUD2qTo6QBNdCBl83Pnm
         KgZvpUmAYAWQmidHvRcnZuelai5qFb4VaZcVy7rUrJ9VjuVkT2BFCa3TUB1wfexc21
         IBVKD0oVd5xEv19U3t19K1sca8fP68nu68rIWMgQ9nzS7Sj9jYhh2tSExJgaKQmPeL
         +G8yaWI7KpUg5cfI6CHOsay7LbN3lnt4nNFLG9eJHDigAi5bL4QyWy0KNePc+ICuC7
         XryTMJKex4jbg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C2F940094; Wed, 15 Nov 2023 12:59:53 -0500 (EST)
Date:   Wed, 15 Nov 2023 12:59:53 -0500
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v3] perf report: Add s390 raw data interpretation for PAI
 counters
Message-ID: <ZVUHGRgTBXyUjezY@kernel.org>
References: <20231110110908.2312308-1-tmricht@linux.ibm.com>
 <ZU4d0G23WOKwpIwb@kernel.org>
 <ZU9vUEzF4opW5Gb/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU9vUEzF4opW5Gb/@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 11, 2023 at 09:10:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 10, 2023 at 09:10:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 10, 2023 at 12:09:08PM +0100, Thomas Richter escreveu:
> > > +/*
> > > + * Check for consistency of PAI_CRYPTO/PAI_NNPA raw data.
> > > + */
> > > +struct pai_data {		/* Event number and value */
> > > +	u16 event_nr;
> > > +	u64 event_val;
> > > +} __packed;
 
> We'll have to disable this warning:
> 
>   19    10.55 debian:experimental-x-mips    : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
>     util/s390-sample-raw.c:222:13: error: packed attribute causes inefficient alignment for 'event_nr' [-Werror=attributes]
>       222 |         u16 event_nr;
>           |             ^~~~~~~~
>     cc1: all warnings being treated as errors
 
> I'll do it while waiting for flights later today.

this got it cured, pushing out.

- Arnaldo

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index d4dc84aa889a04cf..29a744eeb71eb2bd 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -215,6 +215,9 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
 	}
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"
 /*
  * Check for consistency of PAI_CRYPTO/PAI_NNPA raw data.
  */
@@ -223,6 +226,8 @@ struct pai_data {		/* Event number and value */
 	u64 event_val;
 } __packed;
 
+#pragma GCC diagnostic pop
+
 /*
  * Test for valid raw data. At least one PAI event should be in the raw
  * data section.
