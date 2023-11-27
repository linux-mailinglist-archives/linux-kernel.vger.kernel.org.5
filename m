Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE37F9EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjK0Lgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjK0Lgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:36:45 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B860C10A;
        Mon, 27 Nov 2023 03:36:48 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C3DFE12001E;
        Mon, 27 Nov 2023 14:36:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C3DFE12001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701085005;
        bh=QaLTeIQVEwYQhvGyG6jhlWGJJeRoWATq9TIXQyCWaCI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=TQydFY5Sw2HqL9MDgIEcgs2poKVNcq+vZCGvu4yX+xfyFiFz14r2BhCa7tyrw4TNJ
         UFWkk/4Ml6s4NoDiV/U3REUz3+HtRDuFnAFTu3UJMW+g4OHp/R7JFEfBLrCP7ZrPvJ
         451ahAt9uj6T+iMs/OEHpAKUkcyvkNaN0QZwOK8/Klx/2ZfhHF5ews+8D73Xwcps0c
         0oVscbkN7QnMB4Qe890uXCGIkYpoUEoSEhAMwvdGHnOOtFAxqpoIV/81QHmxEByxM0
         coPlhmiAgo0YDY79tX17ExZVo4RhoFpA8HuIYIaaoOfAjFEdqZijF5e6OOBo/RDbWq
         6nxcHTvtuulbw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 27 Nov 2023 14:36:44 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 14:36:44 +0300
Date:   Mon, 27 Nov 2023 14:36:44 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWRifQgRR0570oDY@tiehlicka>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181606 [Nov 27 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/27 09:57:00 #22553179
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:33:49AM +0100, Michal Hocko wrote:
> On Thu 23-11-23 22:39:37, Dmitry Rokosov wrote:
> > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > Currently, it is not possible to trace this point from non-direct
> > reclaim paths. However, direct reclaim has its own tracepoint, so there
> > is no issue there. In certain cases, when debugging memcg pressure,
> > developers may need to identify all potential requests for memcg
> > reclamation including kswapd(). The patchset introduces the tracepoints
> > mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> > 
> > Example of output in the kswapd context (non-direct reclaim):
> >     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
> >     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
> >     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
> >     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
> >     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
> >     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> 
> In the previous version I have asked why do we need this specific
> tracepoint when we already do have trace_mm_vmscan_lru_shrink_{in}active
> which already give you a very good insight. That includes the number of
> reclaimed pages but also more. I do see that we do not include memcg id
> of the reclaimed LRU, but that shouldn't be a big problem to add, no?

From my point of view, memcg reclaim includes two points: LRU shrink and
slab shrink, as mentioned in the vmscan.c file.


static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
...
		reclaimed = sc->nr_reclaimed;
		scanned = sc->nr_scanned;

		shrink_lruvec(lruvec, sc);

		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
			    sc->priority);
...

So, both of these operations are important for understanding whether
memcg reclaiming was successful or not, as well as its effectiveness. I
believe it would be beneficial to summarize them, which is why I have
created new tracepoints.

-- 
Thank you,
Dmitry
