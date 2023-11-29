Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BF7FE064
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjK2Tlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjK2Tls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:41:48 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048B1A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:41:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfaf05db73so25625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701286914; x=1701891714; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=De6xxx8/OcpsczWD4sU3Fi2NLfEqw+uaoC66p0XYL50=;
        b=xe871kn/kql9g0eB+/tbYfBa8AtgkBvN/sNptiLAz5Jt6pwzjlEvIekeVSbrZn8KxG
         xLSiITHPD8FqKPgNshg1Aegf5sU2cst5PttbPn7WXwGdCpRlF5lNyUaZ2T1TppISmMDw
         d1rCbmBn+EuHGJZ0pBWtcMyRL1PvFq4IV25ZTVN0PieppT67T4DICZAMfBgvcZuAo/4w
         4BPt5cSPyKiJephG/BuqCflmE7Rf7ERiGc/4D1+CHMbjv8h875wwtukEh2NV70nS9r9/
         jeM6/dR4hBPpvgsfUCQh1mMEBrCrwXHPgaLYY7AFOJ7uRBHA8D7IYbVk306srvNIb3gK
         6qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701286914; x=1701891714;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De6xxx8/OcpsczWD4sU3Fi2NLfEqw+uaoC66p0XYL50=;
        b=kHGChU67mgKxsVSH8vp71JaPoy7AzfRBXOo4TaJiXRtdpwtHLrZGNCxgLwSGgT8lqE
         VnZ2EGkB8IswHUPOhClHDwzhV7IPVuTGDBOF2XmUeS+3KH59WnrsoTZMwDEyMRcsf/zF
         xh60lRSMlsjwTCmmpAK+wyLzSw2mTMIgnbl3XuL6Su3Rkmnkqei55q0ViB7Ot/ho8EnZ
         FpzWt7m6EDelbxTCqeFb1nXqPhk7rsQyJS2gaF88I6rf341VJBOwXRaqg0LuRzELdmGO
         rVt/kU4XXf5CBltoy13xDzUweC3njJgFVPpjrRx1WWHe394xnwoj3xo5mOy8iC/t16GP
         wRcw==
X-Gm-Message-State: AOJu0YysR3pXtKE7kl+3+0SMk+i0KQKZbz+/WQKDFjKoJLHeqohlfzCQ
        gRyrnv3aC3zGfqVNe5X/UWwK7g==
X-Google-Smtp-Source: AGHT+IE/rLfR934Pc/7oeHzX02TL1UhWj/9mOZYOmi6cOCUWiWcKKKIu0Qv2b8dkem4+uVwTQVDufQ==
X-Received: by 2002:a17:903:32c1:b0:1cf:d2c5:af12 with SMTP id i1-20020a17090332c100b001cfd2c5af12mr24857plr.12.1701286914105;
        Wed, 29 Nov 2023 11:41:54 -0800 (PST)
Received: from [2620:0:1008:15:9ddf:fd79:28e8:6290] ([2620:0:1008:15:9ddf:fd79:28e8:6290])
        by smtp.gmail.com with ESMTPSA id w8-20020aa78588000000b006c4d47a7668sm11081724pfn.127.2023.11.29.11.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:41:53 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:41:52 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
cc:     David Hildenbrand <david@redhat.com>, Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
In-Reply-To: <db1b593a-41d9-444a-b3f4-f6bffe98634b@bytedance.com>
Message-ID: <965d3ea8-4dd9-8f66-7ac0-0d6aa7fcadc7@google.com>
References: <20231123133036.68540-1-gang.li@linux.dev> <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com> <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com> <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com> <783f8bac-55b8-5b95-eb6a-11a583675000@google.com>
 <db1b593a-41d9-444a-b3f4-f6bffe98634b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Gang Li wrote:

> > 
> > > And there, the 65.2s won't be noise because that 12TB system is up by a
> > > snap
> > > of a finger? :)
> > > 
> > 
> > In this single boot test, total boot time was 373.78s, so 1GB hugetlb
> > allocation is 17.4% of that.
> 
> Thank you for sharing these data. Currently, I don't have access to a machine
> of such large capacity, so the benefits in my tests are not as pronounced.
> 
> I believe testing on a system of this scale would yield significant benefits.
> 
> > 
> > Would love to see what the numbers would look like if 1GB pages were
> > supported.
> > 
> 
> Support for 1GB hugetlb is not yet perfect, so it wasn't included in v1. But
> I'm happy to refine and introduce 1GB hugetlb support in future versions.
> 

That would be very appreciated, thank you!  I'm happy to test and collect 
data for any proposed patch series on 12TB systems booted with a lot of 
1GB hugetlb pages on the kernel command line.
