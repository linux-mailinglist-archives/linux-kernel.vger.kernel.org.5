Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC74784DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjHWAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjHWAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:31:23 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90397CE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:31:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bdc27e00a1so467782a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692750681; x=1693355481;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5xB2Upx9ttp4MOF5t5mqqT8RJBeTmla5XMQEyZCcXjY=;
        b=q4/TrW/ufiBe1T0SiezdQOOACpVz8DRzM9xcRkteBISUrQqI/JhB6Ui8kqKI/uatwv
         38T41Vt/UxC63uEpSuFlyJtdt8BO3BeUNn1rRVQjKpBFW6A11t+wUnVXm2/y3ToiDvf9
         VrjQO7WbgddLdR9MR0fiu5tLKLM1yjOSKWoMAU8RngIuGkpag3jO/AemCs4aBBLqq+X9
         nE1uHw/SsZk2/0kQnOOkTpbMAzfrg5xLgwf+KqLdqXGjFvnFe9rF1ZjSzL+sA432ECcP
         rmYP+hlQtYOkb7JolaVO+CGNg6hK7mpajY5TJ2Hfn/KamnTitFuVykjyz3RJV3fcWimK
         EtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692750681; x=1693355481;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xB2Upx9ttp4MOF5t5mqqT8RJBeTmla5XMQEyZCcXjY=;
        b=Ypiai3w5uPF/sDu4HJUvVu5o7+KQXQ7MFMkisatY1ptwuapj3SVuP4dxl4uDsS+E1E
         xrVqNyJORmclYAqRIX6IiPPCTTkGH4C65fetwiqLBp9ZWPx9PRA7R9kqGr66WAyhY/+O
         BsYwJCp2cHM3jE0ZYBSBpvMYYPeIrpdQpoNtkkpFk6H0olVTNvVATtaJicZE5OFhx4VJ
         0hjWBxdjadu4KM4bPqyTlolEJ46NKQnmDiyPRYPdLoi6DEG0Xs41BAQ3d4kOUENrBSAG
         O1VsOHz6+VgGjrAXPQTPoxdNgq/+vLGM6eHC2aS/R1rLKzJqFfmdSuGGovr0rmQsJuTe
         KaqQ==
X-Gm-Message-State: AOJu0Yy5ict/sEQvLZBg/+XaEaDeRHTG0FhMu+p5PI++iNWQnbbTTAyu
        DgyhRjrdGIDmfFkAD74+7u6/OQWaeGWLauGCeLo=
X-Google-Smtp-Source: AGHT+IEmA8g777QIaK5pIET6e/aIDp2827DOvCJ77u415DaeaILmNmhF2ndaSbgJMex/2VlAEvfFL2dFM7mWDxuE5Rc=
X-Received: by 2002:a05:6870:d0d1:b0:1bf:9fa2:bf8e with SMTP id
 k17-20020a056870d0d100b001bf9fa2bf8emr13574273oaa.1.1692750680783; Tue, 22
 Aug 2023 17:31:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5797:0:b0:4f0:1250:dd51 with HTTP; Tue, 22 Aug 2023
 17:31:20 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 23 Aug 2023 02:31:20 +0200
Message-ID: <CAGudoHH-b5R+COHUtns92NTzSVeT1ECMHb22SEcH_108Pi0FTQ@mail.gmail.com>
Subject: idea for scalable and almost waste-free percpu counter alloc (was:
 Re: [PATCH 0/2] execve scalability issues, part 1)
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Mon, Aug 21, 2023 at 02:07:28PM -0700, Dennis Zhou wrote:
>> On Mon, Aug 21, 2023 at 10:28:27PM +0200, Mateusz Guzik wrote:
>> > With this out of the way I'll be looking at some form of caching to
>> > eliminate these allocs as a problem.
>> >
>>
>> I'm not against caching, this is just my first thought. Caching will
>> have an impact on the backing pages of percpu. All it takes is 1
>> allocation on a page for the current allocator to pin n pages of memory.
>> A few years ago percpu depopulation was implemented so that limits the
>> amount of resident backing pages.
>>
>
> I'm painfully aware.
>
>> Maybe the right thing to do is preallocate pools of common sized
>> allocations so that way they can be recycled such that we don't have to
>> think too hard about fragmentation that can occur if we populate these
>> pools over time?
>>
>
> This is what I was going to suggest :)
>
> FreeBSD has a per-cpu allocator which pretends to be the same as the
> slab allocator, except handing out per-cpu bufs. So far it has sizes 4,
> 8, 16, 32 and 64 and you can act as if you are mallocing in that size.
>
> Scales perfectly fine of course since it caches objs per-CPU, but there
> is some waste and I have 0 idea how it compares to what Linux is doing
> on that front.
>
> I stress though that even if you were to carve out certain sizes, a
> global lock to handle ops will still kill scalability.
>
> Perhaps granularity better than global, but less than per-CPU would be a
> sweet spot for scalabability vs memory waste.
>
> That said...
>
>> Also as you've pointed out, it wasn't just the percpu allocation being
>> the bottleneck, but percpu_counter's global lock too for hotplug
>> support. I'm hazarding a guess most use cases of percpu might have
>> additional locking requirements too such as percpu_counter.
>>
>
> True Fix(tm) is a longer story.
>

So I had a meh sleep and I think I figured it out. Key insight is that
with some hackery we can move counters *in active use* to different
pagesets. More, I found the crux of the hackery is already used by
percpu refcounting so I don't think it would be seen as too ugly
(keyword: RCU). :)

The word "allocate" is way overloaded for this discussion, so I'm
going to use different terms for each use case.

These would be:
backing percpu machinery -- it *assigns* memory for use by caches
caching layer -- it *hands out* memory to final consumers, memory is
*cached* if not handed out

Also the collection of per-cpu pages would be referred to as "pageset"
(already used above).

Say caches are per-cpu and are able to satisfy all requests as is.
This means there is no contention on the backing percpu store. Mass
import/export to/from caches can also handle the hotplug list --
everything cached or handed out can reside on it. Then handing
out/returning a counter does not have to synchronize anything with
other CPUs.

While this obviously scales, there is the problem of memory waste you mentioned.

For cached objects things are easy -- they can be unassigned *or*
moved elsewhere, for example trade 2 counters holding a pageset
hostage for 2 counters in a pageset which is already in heavy use.

Nothing new in the above and for the sake of argument let's say this
is not enough when it comes to fighting memory waste.

Say we got really unlucky and there is a bunch of processes where each
one happens to have counters in an otherwise empty pageset. So that's
cpucount * processes pages spent when they all perhaps could fit in
one * cpucount and that's not acceptable.

The idea boils down to temporarily disabling per-cpu operation,
waiting for everyone to observe the new state, changing the pointer to
percpu stuff and re-enabling. A simplified remark is that this can be
done with RCU, wrapping the regular consumers with rcu_read_lock and
invoking synchronize_rcu to wait for them (there is more to it though,
some fences may be needed).

To sum up, it is very much possible to avoid any memory waste *and*
have perfectly scalable percpu counter init/destroy, while adding next
to no overhead to consumers of said counters.

That said, I don't know if the complexity is worth it assuming the
"only use percpu counters if going multithreaded" idea gets
implemented.

-- 
Mateusz Guzik <mjguzik gmail.com>
