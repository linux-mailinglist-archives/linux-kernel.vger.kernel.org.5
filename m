Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884F078182F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjHSICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjHSICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:02:12 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB673C35
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:02:07 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 3C75D2017B.A853B
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 3C75D2017B;
        Sat, 19 Aug 2023 10:02:04 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692432124;
        bh=iPHEGUtZhzhEMVVK9XDgSi7+6mF3itLhrrfps3wMzQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LXDrH31RF/N4H2cWclsOgqtUbjGZ6Lopq9TS0Dv2v1rjM2GpuvSfSpn1sOs0IUvcl
         GRZFttESY6v8sXDz3Ao7gnTPcnUtPL9KXZmiiaeh3smo+FjY0FY4lWjtlDNx+6IXSz
         xU0VZzdyr0EIv2lrnKBbVEhfDTjftWzEiRgyA5fo=
Received: from [10.41.63.38] (unknown [77.241.232.4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id BEC7AD4E6A738;
        Sat, 19 Aug 2023 10:02:03 +0200 (CEST)
Message-ID: <71214e64-0546-0767-3543-963329dab9a3@cs.kuleuven.be>
Date:   Fri, 18 Aug 2023 15:33:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
 <20230812155448.8865-2-jo.vanbulck@cs.kuleuven.be>
 <841e08d9-ce97-e57a-3fc4-0fb87322903a@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <841e08d9-ce97-e57a-3fc4-0fb87322903a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 14:12, Sohil Mehta wrote:
> On 8/12/2023 8:54 AM, Jo Van Bulck wrote:
>>   arch/x86/mm/pti.c | 55 ++++++++++++++++++++++++-----------------------
>>   1 file changed, 28 insertions(+), 27 deletions(-)
>>
> 
> This version is very similar to the original patch and much simpler.
> Sorry about the unnecessary churn.
> 
> Apart from the minor nits below,
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

No problem, thanks for the help!

> 
>> +	if (cpu_mitigations_off())
>>   		pti_mode = PTI_FORCE_OFF;
>> +	if (pti_mode == PTI_FORCE_OFF) {
>>   		pti_print_if_insecure("disabled on command line.");
>>   		return;
>>   	}
> 
> A new line here would be useful.

Added in next revision.

> Was there an issue with the flow you had in the original patch? It was
> avoiding the goto label and flow was a bit more linear.

No, the original flow also works and I agree that an explicit PTI_AUTO 
check may indeed be preferable. Reverting this in the next patch iteration.

Best,
Jo
