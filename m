Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77FB78F828
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjIAFrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjIAFrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:47:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813EAE50;
        Thu, 31 Aug 2023 22:46:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id C8080E0003;
        Fri,  1 Sep 2023 05:46:49 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 31 Aug 2023 22:46:49 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH 0/2] Prevent potential write out of bounds
In-Reply-To: <20230831182800.25e5d4d9@kernel.org>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
 <20230831182800.25e5d4d9@kernel.org>
Message-ID: <00d4a104c17d92562f03042c31ea664b@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: joao@overdrivepizza.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-31 18:28, Jakub Kicinski wrote:
> On Thu, 31 Aug 2023 18:04:35 -0700 joao@overdrivepizza.com wrote:
>> The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
>> unsigned int num_actions (line 10) and later traverses the actions in
>> the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
>> 
>> Within the same file, the loop in the line 24 compares a signed int
>> (i) to an unsigned int (num_actions), and then uses i as an array
>> index. If an integer overflow happens, then the array within the loop
>> is wrongly indexed, causing a write out of bounds.
>> 
>> After checking with maintainers, it seems that the front-end caps the
>> maximum value of num_action, thus it is not possible to reach the 
>> given
>> write out of bounds, yet, still, to prevent disasters it is better to
>> fix the signedness here.
> 
> How did you find this? The commit messages should include info
> about how the issue was discovered.

Sure, I'll wait a bit longer for more suggestions and add the info in a 
next patch version.

Meanwhile, fwiiw, I stumbled on the bug when I was reading Nick 
Gregory's write-up on CVE-2022-25636 [1], which happens nearby but is 
not exactly this issue.

Tks,
Joao

[1] - https://nickgregory.me/post/2022/03/12/cve-2022-25636/
