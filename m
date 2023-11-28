Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4A7FC25F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbjK1RNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjK1RNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAE210EB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701191637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vm0O4QHg+NgUnD86syn9qOPr1P8d6e7mjB/3wAPf3vo=;
        b=JG0Zn4aBuxFq1uUDjYuPSrafcxfJRm4wKeipRGudSYbEtFbJv801lwNuv/o7/hqTBOI8Ww
        NND5dgq+Jbf4WdNpscj8SA+vv+nVnuMOS4Gjouv/7E3NAevDtC2qTOPEBsZdqivGxDCE42
        vrXRM5UUkS+d/dVQanKjX0ebTFIdJqE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-xA7U8tPxO_uCsCFdLPY08Q-1; Tue, 28 Nov 2023 12:13:56 -0500
X-MC-Unique: xA7U8tPxO_uCsCFdLPY08Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a1f38b735so9823546d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701191635; x=1701796435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm0O4QHg+NgUnD86syn9qOPr1P8d6e7mjB/3wAPf3vo=;
        b=h09tIaWOxciFxUBUR2HKqQxscboEXeQFe85FLK1wfL/A3JPJOCMhKV2TaOli1Nuaf5
         UrW9E2MTy6quypCUCShrD86vdQg+OORqGT1PZebl0jRBxYRh5A0QVAwi9o0UUsU+0upn
         5n9I2kS7pDmAnXJx0OPZ6XET+rh4/HRlQKHhbiupW35Az1ka19ygymga2LNtKczHoKI/
         Nxj716IlDb+n/5XV6i/7PGuC8GHU16GLirJMikXMk6dqHFoRtO8rq5lTCzHUnd2QnclF
         R9mzzdt8Ufn+/qoDqHC8ldVFhoZFtkrrD9eWEE5I1iuJXA9FFVOjP9GNp2H/G2Qk6jbY
         mPnw==
X-Gm-Message-State: AOJu0YxhYgF7o4a81BEscZpjzzj+UIdS2F0kRJV3S03dq9vv20dwx6PI
        DAxUgDdDdLCoEUdEPVsNnNXxQlEQw3CT2wLRzEuv56ntiNh6tYI126pfESWuoV7uLa6AYNipnoT
        yNn8TX8ntgcfTH1MCgHow2TsM3vDIJFso
X-Received: by 2002:ad4:4982:0:b0:67a:14fe:f3b0 with SMTP id u2-20020ad44982000000b0067a14fef3b0mr15322577qvx.0.1701191635461;
        Tue, 28 Nov 2023 09:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJRvkNDdU6zlDl3D0OUvysyyYQUO1Hv+GVAM1w4yF9cirbcHTWlpqNkLPcp5RbuilymG8ckQ==
X-Received: by 2002:ad4:4982:0:b0:67a:14fe:f3b0 with SMTP id u2-20020ad44982000000b0067a14fef3b0mr15322557qvx.0.1701191635195;
        Tue, 28 Nov 2023 09:13:55 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id w6-20020a0cfc46000000b0067a3f82c44fsm2265033qvp.138.2023.11.28.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:13:54 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:13:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/5] mm/rmap: introduce and use hugetlb_remove_rmap()
Message-ID: <ZWYf0ZNF9OJgt-mt@x1n>
References: <20231128145205.215026-1-david@redhat.com>
 <20231128145205.215026-3-david@redhat.com>
 <ZWYQeW1dqK6xM1T9@x1n>
 <f1b52042-646d-4679-b375-7550973701f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1b52042-646d-4679-b375-7550973701f5@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:39:35PM +0100, David Hildenbrand wrote:
> Quoting from the cover letter:
> 
> "We have hugetlb special-casing/checks in the callers in all cases either
> way already in place: it doesn't make too much sense to call generic-looking
> functions that end up doing hugetlb specific things from hugetlb
> special-cases."

I'll take this one as an example: I think one goal (of my understanding of
the mm community) is to make the generic looking functions keep being
generic, dropping any function named as "*hugetlb*" if possible one day
within that generic implementation.  I said that in my previous reply.

Having that "*hugetlb*" code already in the code base may or may not be a
good reason to further move it upward the stack.

Strong feelings?  No, I don't have.  I'm not knowledged enough to do so.

Thanks,

-- 
Peter Xu

