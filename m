Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693F97B6F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjJCRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjJCRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:15:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B81A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:15:53 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59f6441215dso14205937b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696353353; x=1696958153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwjXmyJg//4md64VO14v8NSw+0L9l5ReENJrqoBIryA=;
        b=OeZp6aNpNJW/Y4qHKxirz7yprJ3O18nFEdfu2QnxXlmwIpHmZVOB//5Yi0oZrM6ccQ
         pgCkINfvqQSsKZgsCAKG9NsK305NeH4Kls3srR1pqrhAzZog3hPycjV/2+VKJ1OzfIXM
         AdTJJVleG+u8n4y+hpAYEv4jV+8TOiizaJZODkjiUD5aHb3kV+a/YVbVM70Yqrtvu3Mk
         ySubD3MSU7X+f2RPVgNvfaekLsVoWuLqjWjAxn0ZkR5KUBYTxGteT4fxaG7gvj20tZgt
         XLw+vf3edGh3QNudI12A55USpDxeZHMwc6Ma6GLm1n23XXanRjw14skFZcYm1lAM6m1W
         M6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353353; x=1696958153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwjXmyJg//4md64VO14v8NSw+0L9l5ReENJrqoBIryA=;
        b=ofHZOFq6KbJenpEP+U8+8ccONAB7l1rJRdJdJzCsPPi7smAUJL7tXmz974sM/L/xog
         gG/u7BxS1gJH9ORbZiADzXJQECYVc7orm+r1IXT8Blm4jKAV3PBnIScTuqr00mXL2SHs
         E1HJod2DNNiqxIKvuOGQxJbxc+Dy3Ouhyd7/Li/y3LAocU2EacthNWC/64Zj41ixL+lq
         HV69voFqGrFy+jZni4gjjO+IBvzkCG21q5VzCKv/PXh3ZD5blcwbh9jNBRe5btrwOjWx
         jg+P5UxU+AZqgWUbeR4jAcKwdgzNMDipAb7gW414r0zzLnKsWr5IY0avuzLQE2hJ6/DQ
         JcNw==
X-Gm-Message-State: AOJu0YzRBedkMbyReCOiUtes+TJX9zw8SCn13m2vwW90ghm+Z7+BKj5+
        8STySV8ciWQidLWCkLLMg8I=
X-Google-Smtp-Source: AGHT+IHOjK56X6tL4f3m6KC5uFzsBWiBTe8Av+5Q0zR4i4RfJz4JRMYVJ5L1ZmqRc/cvApRy4U+ULg==
X-Received: by 2002:a0d:cace:0:b0:58c:4e63:109 with SMTP id m197-20020a0dcace000000b0058c4e630109mr296707ywd.0.1696353353020;
        Tue, 03 Oct 2023 10:15:53 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.gmail.com with ESMTPSA id r137-20020a0de88f000000b005a23a62a25csm515946ywe.9.2023.10.03.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:15:52 -0700 (PDT)
Date:   Tue, 3 Oct 2023 10:15:50 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 1/3] mm/rmap: move SetPageAnonExclusive() out of
 page_move_anon_rmap()
Message-ID: <ZRxMRjZqZ7Oj45aY@unknowna0e70b2ca394.attlocal.net>
References: <20231002142949.235104-1-david@redhat.com>
 <20231002142949.235104-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002142949.235104-2-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:29:47PM +0200, David Hildenbrand wrote:
> Let's move it into the caller: there is a difference between whether an
> anon folio can only be mapped by one process (e.g., into one VMA), and
> whether it is truly exclusive (e.g., no references -- including GUP --
> from other processes).
> 
> Further, for large folios the page might not actually be pointing at the
> head page of the folio, so it better be handled in the caller. This is a
> preparation for converting page_move_anon_rmap() to consume a folio.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
