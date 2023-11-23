Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847E7F59BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbjKWIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:03:32 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40921B3;
        Thu, 23 Nov 2023 00:03:36 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 967F710004A;
        Thu, 23 Nov 2023 11:03:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 967F710004A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700726615;
        bh=lKtCLctmBBF1Tsb0SyxySTIx7meumO6usFrm+TS9QSU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=D4HCV6dFilbsWayXzzkcs2T3NjL+YalHW9kY4+EXk8KX8O8DVINwNEMKhE1m/Jt98
         DFKEZnQ4TuySorJZWAqyH1hva8f0bl7O9vE7Qobb20zuD5INDosOQ8b6FUcIm1TJVa
         rqCJkqK806c8WyR57ONIIyCGuDreWGDfE5pNIja7xaaOCJh4ILZThAhJZS3Pil9V4Z
         AA6YMS1B0yvlB78T7At+bPtUp3CwF5FV/0XNuk7eSKgGdrRrhhbRHFOYVRN/rpkXQg
         JUngGqB34jZ319nISBEcC0l987OrKgiz/G5uG8DyLXmESFsMBxH6r5fiH4briEGsjR
         s/jlm5GYwRLoA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 23 Nov 2023 11:03:34 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 11:03:34 +0300
Date:   Thu, 23 Nov 2023 11:03:34 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg
 tracepoints
Message-ID: <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-2-ddrokosov@salutedevices.com>
 <20231123072126.jpukmc6rqmzckdw2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231123072126.jpukmc6rqmzckdw2@google.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181550 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 06:37:00 #22507858
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shakeel,

Thank you for quick review!
Please find my thoughts below.

On Thu, Nov 23, 2023 at 07:21:26AM +0000, Shakeel Butt wrote:
> On Wed, Nov 22, 2023 at 01:01:55PM +0300, Dmitry Rokosov wrote:
> > Sometimes it is necessary to understand in which memcg tracepoint event
> > occurred. The function cgroup_name() is a useful tool for this purpose.
> > To integrate cgroup_name() into the existing memcg tracepoints, this
> > patch introduces a new tracepoint template for the begin() and end()
> > events, utilizing static __array() to store the cgroup name.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  include/trace/events/vmscan.h | 77 +++++++++++++++++++++++++++++------
> >  mm/vmscan.c                   | 10 ++---
> >  2 files changed, 70 insertions(+), 17 deletions(-)
> > 
> > diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> > index d2123dd960d5..9b49cd120ae9 100644
> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -141,19 +141,47 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_b
> >  );
> >  
> >  #ifdef CONFIG_MEMCG
> > -DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
> >  
> > -	TP_PROTO(int order, gfp_t gfp_flags),
> > +DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_begin_template,
> >  
> > -	TP_ARGS(order, gfp_flags)
> > +	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
> > +
> > +	TP_ARGS(order, gfp_flags, memcg),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, order)
> > +		__field(unsigned long, gfp_flags)
> > +		__array(char, name, NAME_MAX + 1)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->order = order;
> > +		__entry->gfp_flags = (__force unsigned long)gfp_flags;
> > +		cgroup_name(memcg->css.cgroup,
> > +			__entry->name,
> > +			sizeof(__entry->name));
> 
> Any reason not to use cgroup_ino? cgroup_name may conflict and be
> ambiguous.

I actually didn't consider it, as the cgroup name serves as a clear tag
for filtering the appropriate cgroup in the entire trace file. However,
you are correct that there might be conflicts with cgroup names.
Therefore, it might be better to display both tags: ino and name. What
do you think on this?

-- 
Thank you,
Dmitry
