Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9177BD57
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHNPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHNPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:44:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EF10F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:44:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so116905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692027856; x=1692632656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqfNmX4k95GxAmCJ+7I1b46X41dBF6Sr+i7+9zDFrXM=;
        b=pAeaso56JB/q4jzngfUnbBBsmUzEcCZ4dbJuhld2JnVkiK/dpefrb73LpfIyVTqjtx
         mChrXwznEGDplqMc8LHg+9RsjG5HxAGfqYQAAd5UKZStPPjIkn6kbFA0XWrERHll4KSj
         HKrGAZhVWe97Lrf8mO2CSNh81zXw58aFisflq0drdTVexFHPzp+et0eShKnt0VC9ekuZ
         hoRHymurYXS85W7n0OCrA6e2qKoUxMP4FCdZCU6bPSkIeEsSxHrElLpblvfelBzTPrIl
         FzRMNZM4afyRCHXtn0z35q//cwn9dCe8Nn7JGW0BVOScKCDqmZEa44aZjObRizj693dI
         KYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027856; x=1692632656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqfNmX4k95GxAmCJ+7I1b46X41dBF6Sr+i7+9zDFrXM=;
        b=YLcESxUlOPxnlLcwgby5g2Lxp2bUuC6KtAz3JD3Hi8jtxnZQeKPiJGgXNX2ksjVe4s
         HPQK3nRYthKg7Vlf/LzxjxOU2LK6geEiF4zDSSG1IhUkg4L36op6V52QxLa5km7hBn23
         kjl0nANUymxLwJAh3xtSzIQNadaZ5L0mzhcMwlNPrtJ4tyJKN7lEoiyfqfjHdZGt0EgM
         kZUFNDCU+6VgZ6WycxV4gRBljCLu7v17WHdpIhTRrC1vV0Nb9/Ns857c+c5Z3mES6Eq/
         R2I//8E5vclbkYSnnmOtsdH9GDqP0smhERuk/dgvjGE+C8aFbLOXYtuRUj43sudhkhP/
         p8BA==
X-Gm-Message-State: AOJu0Yy7cElEWwLdDGjo5bg+f+TL8F0ynFfvfSN3i6GRiFe+bPpY8HQ7
        yHbcEwCZdEugA7Id2kl9OIueRU0SCBrK+lhlBwUEDco3VZ7Srujimo94ZA==
X-Google-Smtp-Source: AGHT+IGQAH2acO3XfxZHfpRS1AbLTd6zLXkVBvHEQQAcvSF3rJpF1yfDyPDig8gWSpDIjwriF7rpPwsVRRgxnf1mrIY=
X-Received: by 2002:a05:600c:500f:b0:3f7:e4d8:2569 with SMTP id
 n15-20020a05600c500f00b003f7e4d82569mr274345wmr.5.1692027855860; Mon, 14 Aug
 2023 08:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com> <20230724183157.3939892-16-Liam.Howlett@oracle.com>
In-Reply-To: <20230724183157.3939892-16-Liam.Howlett@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Aug 2023 17:43:39 +0200
Message-ID: <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] mm/mmap: Change vma iteration order in do_vmi_align_munmap()
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@akpm

On Mon, Jul 24, 2023 at 8:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> Since prev will be set later in the function, it is better to reverse
> the splitting direction of the start VMA (modify the new_below argument
> to __split_vma).

It might be a good idea to reorder "mm: always lock new vma before
inserting into vma tree" before this patch.

If you apply this patch without "mm: always lock new vma before
inserting into vma tree", I think move_vma(), when called with a start
address in the middle of a VMA, will behave like this:

 - vma_start_write() [lock the VMA to be moved]
 - move_page_tables() [moves page table entries]
 - do_vmi_munmap()
   - do_vmi_align_munmap()
     - __split_vma()
       - creates a new VMA **covering the moved range** that is **not locke=
d**
       - stores the new VMA in the VMA tree **without locking it** [1]
     - new VMA is locked and removed again [2]
[...]

So after the page tables in the region have already been moved, I
believe there will be a brief window (between [1] and [2]) where page
faults in the region can happen again, which could probably cause new
page tables and PTEs to be created in the region again in that window.
(This can't happen in Linus' current tree because the new VMA created
by __split_vma() only covers the range that is not being moved.)

Though I guess that's not going to lead to anything bad, since
do_vmi_munmap() anyway cleans up PTEs and page tables in the region?
So maybe it's not that important.
