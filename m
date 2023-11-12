Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1E7E9262
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjKLTzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjKLTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:55:45 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D81136
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1699818937;
        bh=oUH5yB59vNk6vH5kP/XzAUvhUo0WGNNoDlHhwTnLRmM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TsJTrrY/IoeQkMjYQ2d/iUOXhjVAxnV/lby2W6X7YxP0q4DAvIGD3xN/6L17UhN8A
         6rFsdBreQOnM/E1i3IIy5t9sBDyZnEvfG4vsLcjokDZ3tTu58tFk18Raa7SAWLw5/A
         skwh1S89OIqUxnEMSwFssjVJMLrUT1S2XXUtYH35KvyCOqQWUfRBSWvWfLMXLGTKxa
         IojeyOyNsXIYTPXOxLMeKZrZF0S/SLUrk4qxXyNzCwNvj1b0oi2VwkLHLFldxVUlYF
         Cxf6N67l1nuO4jynLoVca6Iux41gKG6fk1H0UhIpxgEgSPrMVgpnduCBD0WBw7B81G
         2lZ+yUaggauwQ==
Received: from [172.24.0.4] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4ST3Fh3Chtz1cV8;
        Sun, 12 Nov 2023 14:55:36 -0500 (EST)
Message-ID: <dbe62cc9-8354-463f-b398-8e80ca17e556@efficios.com>
Date:   Sun, 12 Nov 2023 14:56:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Fixing directly deferencing a __rcu pointer warning
Content-Language: en-US
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com, mjguzik@gmail.com,
        npiggin@gmail.com, peterz@infradead.org,
        paulmck <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <202311031320.c3ebc782-oliver.sang@intel.com>
 <20231112193055.2072382-1-singhabhinav9051571833@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231112193055.2072382-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-12 14:30, Abhinav Singh wrote:
> This patch fixes the sparse warning with this message
> "dereference of noderef expression" , in this context
> it means about directly dereferencing a pointer tagged
> with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> function rcu_dereference(...) to use when dereferencing a __rcu
> pointer inside rcu read side critical sections. This function
> returns the non __rcu tagged pointer which can be dereferenced
> just like a normal pointer.
> 
> I tested with `lockdep` enabled, with these config options
> `CONFIG_PROVE_RCU` and `CONFIG_PROVE_LOCKING` enabled and it
> booted just fine. To confirm if lockdep was really enabled
> I found these paths inside the qemu virtual envirnoment.

I did not see actions taken nor answer on those comments:

https://lore.kernel.org/all/CAGudoHEfjSAim6Hh-qYPY+qi8nbLx7J3YdpGgFwSvD7xbeYR3w@mail.gmail.com/

Basically, the missing annotation here can be either:

- A missing rcu_dereference, if the intent is to use the pointer while protecting
   with with a read-side critical section,
- A missing rcu_dereference_protected(), if the use of the pointer is protected by
   a lock.

I don't really care if rcu_dereference happens to work in testing or not. _If_ the
intended design is that this rcu pointer is protected by a lock, or being used before
becoming published elsewhere, then using rcu_dereference to silence the warning is
wrong. (note: I did not do a review of the affected code, but I would expect the
commit message to take care of going through this level of detail)

And the fact that this aspect of the feedback has been hidden under the rug worries
me.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

