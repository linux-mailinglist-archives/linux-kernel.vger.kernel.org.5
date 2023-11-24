Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C47F6E51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjKXIhT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 03:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:37:17 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F201D48
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:37:24 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so20431861fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815042; x=1701419842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCm2VbiM4tYPYLjATXAxUR88qLBixqCgfFCYij5grcs=;
        b=BrB3wlsApjQg3lCh8PsOKGOFDbOF5JQCBWuxCOmDchDq072u0vz5iwP1lAw2roSOar
         Z79Vf7MsInaTNjUOSF9h3lp9p30O/pLccEhYaACB1ojoGrn76Og0ZUgCzb2VeDW7X7mQ
         23LFrGQuI2jWAQkZO3pEHGqJEhXzyYW4/qFycJJ5UAGOpvaecJMpiJQUgYgrEQrcbMVD
         k0eqzowkyTdZz6gHOK49W83HIFDpFd8z9f+jrbkyOwH3NPFut/cxSqRoRgOgsKEqIBs6
         gPhSjUTAyo2xQjpQ4pzO1A9f7TjYmcsJx7L1JpPi3LkrjLLTtuC5lJeHv//KHZgSs7V7
         MdrQ==
X-Gm-Message-State: AOJu0YyYrqiGDN53bXBbjTDSZyP+FwxuqvjiA3YMQ8oQ521la0Rpe3mk
        Ot4kjaACeybZAQEjBY6qoi3a97McO9FfRzbgdA==
X-Google-Smtp-Source: AGHT+IGKU8lFeeHMHfbh7F6AFEH6mzb+Hw6QoVmQtGCt73sKKu32LO6wUxNnoGlM2inECRKS9nVBEKtu85tDrvZU3N0=
X-Received: by 2002:a05:6512:3484:b0:509:7141:fec with SMTP id
 v4-20020a056512348400b0050971410fecmr1182027lfr.48.1700815042245; Fri, 24 Nov
 2023 00:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
 <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
 <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com>
 <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com>
 <CAMgjq7DNVkyhwyXz9PRcp3XTBNvznZ97dOFFA_DGsJks12_pQw@mail.gmail.com>
 <CAF8kJuM05apUTd9Mpv6s4sZ6SfSAWD+hM_KLiDfatoXu5QwFbg@mail.gmail.com> <CAMgjq7Bax-EOiXXDRxpHFoyrQWRQdSWbZ0KN7-W8YsocV5C97w@mail.gmail.com>
In-Reply-To: <CAMgjq7Bax-EOiXXDRxpHFoyrQWRQdSWbZ0KN7-W8YsocV5C97w@mail.gmail.com>
From:   Christopher Li <chrisl@kernel.org>
Date:   Fri, 24 Nov 2023 00:37:10 -0800
Message-ID: <CANeU7QkiM9jhPnLg=hWjiZz35dE7mg0SvJPhesd9eJz+1S3gEg@mail.gmail.com>
Subject: Re: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing
 extra unlock check
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:15 AM Kairui Song <ryncsn@gmail.com> wrote:
>
>
> folio_put will discharge a page if it's charged, in original code the
> 2 folio_put call simply free the page since it's not charged. But in
> this patch, folio_put will cancel previous
> mem_cgroup_swapin_charge_folio call, so actually the 3
> mem_cgroup_swapin_charge_folio calls will only charge once. (2 calls
> was cancelled by folio_put).

You are saying the original code case folio_put() will be free without
uncharge. But with your patch folio_put() will free and cancel
mem_cgroup_swapin_charge_folio() charge. That is because the
folio->memcg_data was not set in the first case and folio->memcg_data
was set in the second case?

>
> I think this is making it confusing indeed and causing more trouble in
> error path (the uncharge could be more expensive than unlock check),
> will rework this part.

Agree. Thanks.

Chris
