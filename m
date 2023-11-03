Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B277E071E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjKCQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKCQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:59:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCA1BC;
        Fri,  3 Nov 2023 09:59:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3027215EF;
        Fri,  3 Nov 2023 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699030740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uksxNlyaCkPKE2rCxUqHpdRT6fah3eDwts+mbY5jJ80=;
        b=tFRHMHyImjbSl76qgnGYfaGAQjIf2+RKyoSrDKE6JYpTj3dCCULp5IbO+HPk9WXCt3fUCF
        Tma8lM/OV+12rR+rWRNAoHDmvTAo+dQyglzQIRQYyylAI0I5KBZMBZ+4gjZCW/UncW3qeC
        +/gos/UZoYDWbzoJMfms4apKWMlAb2g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBAFB13907;
        Fri,  3 Nov 2023 16:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W9LcKtQmRWVuVgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 03 Nov 2023 16:59:00 +0000
Date:   Fri, 3 Nov 2023 17:59:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <oe7s47mjbemtfsc3tbhweeiledh4srjntrsyohsvpy5m4jsgsb@xjl7u5a3p3z3>
References: <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
 <ZUKDz5NpMsoyzWtZ@memverge.com>
 <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
 <ZUMVI4YG7mB54u0D@memverge.com>
 <s72oio7nmez565i7h6fb4bdnhqkcablr34rz5gqteyrrf7yeux@lqrztvy35si5>
 <ZUPomvqNwZgDbo51@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUPomvqNwZgDbo51@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-11-23 14:21:14, Gregory Price wrote:
[...]
> Only thing I'm not sure of is what happens if mempolicy is allowed to
> select a node that doesn't exist.  I could hack up a contrived test, but
> i don't think the state is reachable at the moment.

There are two different kinds of doesn't exist. One is an offline node
and the other is one with a number higher than the config option allows.
Although we do have a concept of possible nodes N_POSSIBLE I do not
think we do enforce that in any user interface and we only reject nodes
outside of MAX_NODE.

The possible nodes concept is more about optimizing for real HW so that
we do not over shoot when the config allows a huge number of nodes while
only handful of them are actually used (which is the majority of cases).
-- 
Michal Hocko
SUSE Labs
