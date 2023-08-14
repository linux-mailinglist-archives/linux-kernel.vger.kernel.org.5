Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223D77BE80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjHNQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjHNQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:56:52 -0400
Received: from out-124.mta0.migadu.com (out-124.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28C173F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:56:32 -0700 (PDT)
Message-ID: <f10dd9ba-de75-c2b1-a7e9-fd71bdc2f0fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692032144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klWKyCaQaMM6/yKLS6/tQBPou6nr0c7eYZv3+B1cSxE=;
        b=QWjiaGMuRoRj8P+8ts/4jZ9thYR/uD1ou/hGBlCgB1NyCSBREk89vBed9eHJqH2jkZoooH
        pZgqC6laGqD/DXD62HtBL35b51aU+uj4qlPKuvVkfqAJb2ZiQb3ETw2owrm4w/DwKb/jEc
        M/fT/Kfx/Pmz1b4j/ONvury1SIEUUow=
Date:   Mon, 14 Aug 2023 09:55:37 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, clm@meta.com,
        thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com> <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
 <20230811201914.GD542801@maniforge>
 <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
 <20230811233616.GE542801@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230811233616.GE542801@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 4:36 PM, David Vernet wrote:
> I see, thanks for explaining. This is why sched_ext doesn't really work
> with the BPF_F_LINK version of map update. We can't guarantee that a map
> can be updated if we can't succeed in ->reg(), because we can also race
> with e.g. sysrq unloading the scheduler between ->validate() and
> ->reg(). In a sense, it feels like ->reg() in "updateable" struct_ops
> implementations should be void, whereas in other struct_ops
> implementations like scx() it has to be int *. If validate() is meant to
> prevent the scenario you outlined, can you help me understand why we
> still check the return value of ->reg() in bpf_struct_ops_link_create()?
> Or at the very least it seems like we should WARN_ON()?

->regs() can fail if another struct_ops under the same name has already been 
loaded to the subsystem. If another subsystem needs another return value to 
support .update, I believe it can be done if that is blocking scx to support 
"updateable" link.

>> If it needs to validate struct_ops as a while,

There was a typo: as a /whole/.

>>
>> 1. it must be implemented in .validate instead of .reg. Otherwise, it may
>> end up having an unusable map.
> 
> Some clarity on this point (why we check ->reg() on the ->validate()
> path) would help me write this comment more clearly.


hmm... where does it check ->reg() on the ->validate() now?

I was meaning the struct_ops supported subsystem should validate the struct_ops 
map in '.validate' instead of in the '.reg'.

or I misunderstood the question?

> 
>> 2. if the validation is implemented in '.reg' only, the map update behavior
>> will be different between BPF_F_LINK map and the non BPF_F_LINK map.
> 
> Ack, this is good to document regardless.
> 
> I'll send a v3 on Monday with these comments added both to the code, and
> to the commit summary.
> 
> Thanks,
> David

