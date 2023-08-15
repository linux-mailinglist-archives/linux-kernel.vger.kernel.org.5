Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6477D383
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjHOTo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbjHOTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:44:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDD10C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:44:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so2145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692128663; x=1692733463;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nxUR3sFcYnjoFTxoNsttWpRWyrvyRoinPGeHchrLRHY=;
        b=BYMJ8DSaKVAqTrDaY2VT7LqIqaqLYhxA7mPH+ucSeoG4M40jE2+mgmiyRy5Bcadwxh
         13/uORC/Cq2VC5Gp/cnp4iGu2+9CoZmoPfp7chv3MGkqkTzLyUIs9lZpk89GfegBcLq1
         3ILFfmr+vSekS48j1C0tfvIjThuz4tA0w/2cz8ThOpTy3ORfR0xNNzp2XxxEfV4YpxGm
         I7mnn3Fw2pHRLAXABn3kshHdAKvhU4OgN5mGbY9I/9NghJtkLgOA3nYljoHBCS27i+qX
         8VKpvqZ46hUXzXCN/+DhAba+0BlgJqgfaNdljLtYwh4HALPe2KuWuzYbydjFnc6j+tGx
         EqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128663; x=1692733463;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxUR3sFcYnjoFTxoNsttWpRWyrvyRoinPGeHchrLRHY=;
        b=eK7hn3r3OEQumzXrBA4YOM8IkYUadeQlB76rEsy9jim3k/muB0gQY2Vwu0Uz4O0QLH
         bdqPzIMetFJQ5JCBMz/Z7AU8r7llhQjXc9vLKTbEr8hri6UIKlSnl6QJAnPxPAF2/ry2
         iPBvc0hvfHJY5eMLfzJdBtDmysdeuFd2krkD/MF9Y0Jz/qdnzgSiIHWsECdIRthKh32h
         JMVYlI6wBco4h4j8MMnGD3pmcEKfgHKfA6COkNU2gMn7jDRAsRw9/TRXhoq/5F4rynDp
         OZ/VoAhYqMe4pq4O0waAgWpZ3eigeUlAfbTODFtR9l6ireSxmC8AXho+dqCKHUYsvGGG
         6FDA==
X-Gm-Message-State: AOJu0Yy/N6CEI8zx/0v5xg089K00a+rk5L+WWp+snJP34qmXu+qiw7WP
        BGUjF0kaeNGYph5z31XxDH9H0mnkyz0M8m27Hm1WSA==
X-Google-Smtp-Source: AGHT+IHK88BoURYieB1sfnjnsRaXzB6aiB/2b7ubSGAwNjvAZ85CNjaPzCQBhVhsfWDT1nTKTdbwkvEfzZvFedAYf1U=
X-Received: by 2002:a05:600c:46d1:b0:3f1:9a3d:4f7f with SMTP id
 q17-20020a05600c46d100b003f19a3d4f7fmr2589wmo.1.1692128662890; Tue, 15 Aug
 2023 12:44:22 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 15 Aug 2023 21:43:46 +0200
Message-ID: <CAG48ez1KYR9pY1s0=9QH_n5cY-_Zejajj2JEa-se=UZQbeN4hw@mail.gmail.com>
Subject: [mm] VMA merging behavior wrt anon_vma has been slightly broken since
 Linux 3.0 (in a non-dangerous way)
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shaohua Li <shaohua.li@intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think VMA merging was accidentally nerfed a bit by commit
965f55dea0e3 ("mmap: avoid merging cloned VMAs"), which landed in
Linux 3.0 - essentially, that commit makes it impossible to merge a
VMA with an anon_vma into an adjacent VMA that does not have an
anon_vma. (But the other direction works.)


is_mergeable_anon_vma() is defined as:

```
static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
                 struct anon_vma *anon_vma2, struct vm_area_struct *vma)
{
        /*
         * The list_is_singular() test is to avoid merging VMA cloned from
         * parents. This can improve scalability caused by anon_vma lock.
         */
        if ((!anon_vma1 || !anon_vma2) && (!vma ||
                list_is_singular(&vma->anon_vma_chain)))
                return true;
        return anon_vma1 == anon_vma2;
}
```

If this function is called with a non-NULL vma pointer (which is
almost always the case, except when checking for whether it's possible
to merge in both directions at the same time), and one of the two
anon_vmas is non-NULL, this returns
list_is_singular(&vma->anon_vma_chain). I believe that
list_is_singular() call is supposed to check whether the
anon_vma_chain contains *more than one* element, but it actually also
fails if the anon_vma_chain contains zero elements.

This means that the dup_anon_vma() calls in vma_merge() are
effectively all no-ops because they are never called with a target
that does not have an anon_vma and a source that has an anon_vma.

I think this is unintentional - though I guess this unintentional
refusal to merge VMAs this way also lowers the complexity of what can
happen in the VMA merging logic. So I think the right fix here is to
make this kind of merging possible again by changing
"list_is_singular(&vma->anon_vma_chain)" to
"list_empty(&vma->anon_vma_chain) ||
list_is_singular(&vma->anon_vma_chain)", but my security hat makes me
say that I'd also be happy if the unintentional breakage stayed this
way it is now.
