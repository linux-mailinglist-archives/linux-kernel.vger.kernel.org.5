Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382E278F6AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbjIAB2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjIAB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94538E67;
        Thu, 31 Aug 2023 18:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E56561BA0;
        Fri,  1 Sep 2023 01:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0925BC433C7;
        Fri,  1 Sep 2023 01:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693531681;
        bh=wfKITlhsoQmivTcQnEhF6jPQbiuN6NmrSQ2Hh7h3Qw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gfZJ0y0KEMzMGUTLDIoB3W5mwXa9hIZHdwdg9OdFt+sno/Yf5W6BE/UnOr6hvslR0
         Scu3llwRnQLLdEqu9EQSURsHaKa0kk3eoAA8cCF252uYas/CNVvE3nPLbPSA+TA6SN
         9QCZpLzPmDKNVEgcgf+k2Us6hoJg7j/vSM9VzE5hPbWVxraMkLJ+1XlJmfJpee06P8
         4vuhTF5bDQxalTeH1qg5NMCQQRD+QRbk8/uRVqpEK2BtduMRxigZUg2kaLL2e02BBS
         84oPqXL0ZgDEEROP0xkruzCsXu0WScYKukNsTsB2+Z50ALNN/MgqQxrm4RjuNQ3aR5
         iNq011wzXBEHA==
Date:   Thu, 31 Aug 2023 18:28:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     joao@overdrivepizza.com
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH 0/2] Prevent potential write out of bounds
Message-ID: <20230831182800.25e5d4d9@kernel.org>
In-Reply-To: <20230901010437.126631-1-joao@overdrivepizza.com>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 18:04:35 -0700 joao@overdrivepizza.com wrote:
> The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
> unsigned int num_actions (line 10) and later traverses the actions in
> the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
> 
> Within the same file, the loop in the line 24 compares a signed int
> (i) to an unsigned int (num_actions), and then uses i as an array
> index. If an integer overflow happens, then the array within the loop
> is wrongly indexed, causing a write out of bounds.
> 
> After checking with maintainers, it seems that the front-end caps the
> maximum value of num_action, thus it is not possible to reach the given
> write out of bounds, yet, still, to prevent disasters it is better to
> fix the signedness here.

How did you find this? The commit messages should include info
about how the issue was discovered.
-- 
pw-bot: cr
