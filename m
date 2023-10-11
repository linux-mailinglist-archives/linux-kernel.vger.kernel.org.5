Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205D7C6147
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjJKXzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjJKXzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:55:49 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7F94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:55:47 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-419768e69dfso133501cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697068547; x=1697673347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mbs/rfu0P0DJS7f90s401MVmrsSuyrp2SnKszuWDoU=;
        b=PL22iz/hgQmiJQRE07LVdaND3QTu7Ssj+sQxcKG5TDw0cQjTwLgARsr4H8ransSV5X
         rjI7djIJn25O9xdgRqk6YK4hH9wEDUxl/fmcpkV2OG+nC8YQ5NvtuD/xoJQY3rMtL4AO
         1/Jhu0n4a+SX+xkryXYhUgKAPhldEUpXCVnXjJCAFIGi1pI7yY+51LFehdVXO891bL7e
         /+bkdrWkuoimhk/N8gk3uA7Dwe580ExQ4arH6MDgPcQJrhcjPxcjo5gQruUbVa4ejH/3
         koB0HiSDWLl3aJhEs+m75n1XxYRw+ltOfIZ/GPvTSTaXcnFDhiOPZrwe3A2Nsjh9sBAA
         dmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697068547; x=1697673347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mbs/rfu0P0DJS7f90s401MVmrsSuyrp2SnKszuWDoU=;
        b=GkwxV7HrQq5WKWcNLsBSXNi54x/UASIWnQr+fEBwRGuZ8MdGQE+gKC4Od9RN1moJnd
         EEIzcSR8+A/wvsgX2MP8FL7IBQhZ+kT65c9LvKLsNX/qjIyx4MSzWpiEOBVFNXF/KGxY
         kvs2zVDT4K2Dz30nZ9mvYUCSByBJfEFAjCvU7ohHzvobZzpgogtwN+2WfxdGhMVF4fSP
         tL4x+ITZLt2A9fmvTzudr9qUqvJRU7nv78mM1Ln3c29DdTu/tY6wgFsc7poFe6K3MtG/
         9RpFAwZWzwZslbdlrHhDcUK73/Y5zgikEjMuuEbEu40B/i9pTpFYRuARAF4fk7+p4NZt
         pivQ==
X-Gm-Message-State: AOJu0YzsQSoZbM2HB42yahyA75A8s6TG8E6/z1f/1iTlnVsWTAGgWfPg
        sP6wucKuWhznbfClftnN6QCN6O0TcNTO5uQq+MIMUg==
X-Google-Smtp-Source: AGHT+IEUqRV1/mWmdzT8yvWLJ6VHbYGMxbAptLRMnxQuymaF7xRsHd00kBKxdxzWYh6t5fe/VTmZrP+ZpHFdtKupxOM=
X-Received: by 2002:ac8:5b03:0:b0:417:9144:9567 with SMTP id
 m3-20020ac85b03000000b0041791449567mr514405qtw.0.1697068546906; Wed, 11 Oct
 2023 16:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231011071925.761590-1-ankitja@vmware.com> <20231011105329.GA17066@noisy.programming.kicks-ass.net>
 <20231011114642.GA36521@noisy.programming.kicks-ass.net> <20231011135238.GG6337@noisy.programming.kicks-ass.net>
In-Reply-To: <20231011135238.GG6337@noisy.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 11 Oct 2023 16:55:35 -0700
Message-ID: <CABk29NvHx2saNLdYmQgt31R8W28p7=GUtXiiupgE5czXRBAx5g@mail.gmail.com>
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankit Jain <ankitja@vmware.com>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        qyousef@layalina.io, pjt@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        namit@vmware.com, amakhalov@vmware.com, srinidhir@vmware.com,
        vsirnapalli@vmware.com, vbrahmajosyula@vmware.com,
        akaher@vmware.com, srivatsa@csail.mit.edu
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

Hey Peter,

> +static struct cpumask *root_domain_allowed(struct cpumask *newmask,
> +                                          struct cpumask *scratch,
> +                                          struct cpumask *valid)
> +{
> +       struct root_domain *rd;
> +       struct cpumask *mask;
> +       struct rq *rq;
> +
> +       int first = cpumask_first_and(newmask, valid);
> +       if (first >= nr_cpu_ids)
> +               return NULL;

This picks the first arbitrarily, but isn't it possible for the mask
to span both isolated and non-isolated cpus? In which case, the rest
of this just boils down to chance (ie. whatever the span happens to be
for the first cpu here)?
