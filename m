Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ABC7FDE77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjK2ReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjK2ReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:34:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D675CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:34:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D526C433C7;
        Wed, 29 Nov 2023 17:34:23 +0000 (UTC)
Date:   Wed, 29 Nov 2023 12:34:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        akpm@linux-foundation.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, kernel@sberdevices.ru, rockosov@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231129123446.7d41c4e9@gandalf.local.home>
In-Reply-To: <ZWdwifakPuMZbFUV@tiehlicka>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
        <20231123193937.11628-3-ddrokosov@salutedevices.com>
        <ZWRifQgRR0570oDY@tiehlicka>
        <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
        <ZWSQji7UDSYa1m5M@tiehlicka>
        <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
        <ZWWzwhWnW1_iX0FP@tiehlicka>
        <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
        <ZWdhjYPjbsoUE_mI@tiehlicka>
        <20231129165752.7r4o3jylbxrj7inb@CAB-WSD-L081021>
        <ZWdwifakPuMZbFUV@tiehlicka>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 18:10:33 +0100
Michal Hocko <mhocko@suse.com> wrote:

> > > How? You are only reporting the number of reclaimed pages and no
> > > reclaimed pages could be not just because of low/min limits but
> > > generally because of other reasons. You would need to report also the
> > > number of scanned/isolated pages.
> > >    
> > 
> > From my perspective, if memory control group (memcg) protection
> > restrictions occur, we can identify them by the absence of the end()
> > pair of begin(). Other reasons will have both tracepoints raised.  
> 
> That is not really great way to detect that TBH. Trace events could be
> lost and then you simply do not know what has happened.

Note, you can detect dropped events. If there's a dropped event, you can
ignore the "missing end" from a beginning. You could also make synthetic
events that pair an end event with a beginning event (which uses the last
begin event found). Synthetic event creation is not affected by dropped
events.

There's a lot you can to get information with the prospect of dropped
events. I would not use that as rationale for not using events.

-- Steve
