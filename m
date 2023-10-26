Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04577D853D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjJZOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjJZOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:30 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F935CA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698331882;
        bh=zCxTGeta7j9+1MvbeHs0ufQDzrEJIbaDrDa1lovi73Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N3P/HydjL1+T6To9o5YEwM0iMpG0Rm+7WPyrd2xKnKLLbuXBLpSPzECFGmtYy6VS4
         Nr7qxaf2Hyq8573FyuW4FXWFCUUnaKjvtt0DqJ4PSgsfSldgKjTHGhDgxnnIKKcSB+
         iSI2JZKAolprbzP7y+esbYx3ITCwrGpB/czXIdu0MXOaeQkRRwaybPvuDbcz0rq6/u
         M70IBI/CzkgOd0UoNpjXk4nAh5qy4b9s/P2EPlwglsAwtERm4Nokm8IYYR0AMCLPKi
         wuqPt8LfVF623INmssMMXgAYhYw7aYcn4+Zs3fDRCHnXAJlLfdv/we5cmIa51ULraD
         EHNE8vH2731Aw==
Received: from [172.16.0.85] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SGTJV2N6Vz1ZXJ;
        Thu, 26 Oct 2023 10:51:22 -0400 (EDT)
Message-ID: <b0654dab-eb43-444e-a820-db169812e1ba@efficios.com>
Date:   Thu, 26 Oct 2023 10:51:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, npiggin@gmail.com,
        shakeelb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
 <20231026091222-mutt-send-email-mst@kernel.org>
 <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-26 10:06, Mateusz Guzik wrote:
> On 10/26/23, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Oct 26, 2023 at 05:46:21PM +0530, Abhinav Singh wrote:
>>> This patch fixes the warning about directly dereferencing a pointer
>>> tagged with __rcu annotation.
>>>
>>> Dereferencing the pointers tagged with __rcu directly should
>>> always be avoided according to the docs. There is a rcu helper
>>> functions rcu_dereference(...) to use when dereferencing a __rcu
>>> pointer. This functions returns the non __rcu tagged pointer which
>>> can be dereferenced just like a normal pointers.
>>>
>>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>>
>> Well yes but these need to be called under rcu_read_lock.
>> Who does it here?
>> If no one then maybe you found an actual bug and we need to
>> fix it not paper over it.
>>
> 
> There is no bug here.
> 
> p is the newly created thread, ->real_cred was initialized just prior
> to this code and there is nobody to whack the creds from under it.
> 
> Second bit in the patch changes one real_parent deref, but leaves 2
> others just above it. Once more no bug since the entire thing happens
> under tasklist_lock, but the patch should either sort all these cases
> or none.

Drive-by comment: perhaps use rcu_dereference_protected() ?

Thanks,

Mathieu

> 
> I think it would help if the submitter had shown warnings they see.
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

