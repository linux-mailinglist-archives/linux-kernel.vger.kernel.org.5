Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0DF78F9BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjIAIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIAIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:15:19 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6048F;
        Fri,  1 Sep 2023 01:15:16 -0700 (PDT)
Received: from [78.30.34.192] (port=39840 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qbzJ5-00AEiB-H4; Fri, 01 Sep 2023 10:15:10 +0200
Date:   Fri, 1 Sep 2023 10:15:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     joao@overdrivepizza.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH 0/2] Prevent potential write out of bounds
Message-ID: <ZPGdihJLKXOj7rDI@calendula>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
 <20230831182800.25e5d4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831182800.25e5d4d9@kernel.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:28:00PM -0700, Jakub Kicinski wrote:
> On Thu, 31 Aug 2023 18:04:35 -0700 joao@overdrivepizza.com wrote:
> > The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
> > unsigned int num_actions (line 10) and later traverses the actions in
> > the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
> > 
> > Within the same file, the loop in the line 24 compares a signed int
> > (i) to an unsigned int (num_actions), and then uses i as an array
> > index. If an integer overflow happens, then the array within the loop
> > is wrongly indexed, causing a write out of bounds.
> > 
> > After checking with maintainers, it seems that the front-end caps the
> > maximum value of num_action, thus it is not possible to reach the given
> > write out of bounds, yet, still, to prevent disasters it is better to
> > fix the signedness here.
> 
> How did you find this? The commit messages should include info
> about how the issue was discovered.

This is net-next material IMO, none of the existing interfaces uses
such a large number of actions for this to be an issue.
