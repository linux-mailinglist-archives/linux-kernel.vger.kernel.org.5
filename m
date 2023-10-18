Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18817CE742
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjJRS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:56:25 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF778123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:56:23 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7ac4c3666so88149437b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697655383; x=1698260183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8u57CE8Kdi0g3jbFeaVMUNjtuMyTsXSOw82lfN+HY7s=;
        b=apfYQDO5wmiW21pRZhB2L1vOJ9K1ywL1K6UWrUJF/fNyLCBNKN1yR5zWDJTR009T5d
         N8k3xtIPzv/Mt3xpbL75R/eMqJsArfcSs4M7Yhzb1TJh9etxKWCyzkPsqhfkyIMntmnl
         k1WdQqR6EaEv7+W+gzlCmfidSA+7w4Pjym41VfRnmDlWFYKOMLL0Ip0YM65SEFQg0vrT
         AO7MZG1CNL5Kd0luhKmoV6PpQWfNdWuEVWLpo0505rxGPdqVy8vqLDnPQu7JYkO58haN
         OFpZ/TOR76guYxBhBzS1hZtvEaftPJ8agInMuX0hAZwENTZW8ID/BT96YyOsmBzbsySj
         OBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655383; x=1698260183;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8u57CE8Kdi0g3jbFeaVMUNjtuMyTsXSOw82lfN+HY7s=;
        b=LvbBRBAziHq0X1EB5CmWDD7dbPqED5pO99RBW8Pc5PbMIFoeCELt52ARYMxB9RuBs0
         Dd+gR3z6OY/vjKco4KTlDUEJlYvqOJ/66DECpRziPcvFY0yUUpOPQSbX6QwF8S8i/htn
         ZC2ERYyOpKjv3iCgTW4kofNnHQCcZK0M88LBrELl6hJk4dJBhQzDc909SKaf4ugvLZ8J
         UB1qzp8MnZb6R6CJu4tja1oVdMY/WbzQK1jxLCdk6KT37gZlgflvCe1QqWAbcyJ8n/gZ
         h/CiNQo+KhDoeGiLKqc3xqt1wVIuWkwuA0RMu3G2bjGBy2pzZbCLRwVCV9CRKu7sZCDm
         A12A==
X-Gm-Message-State: AOJu0Ywc72R8hVDRzpSxT2jXbABxZLzdVZ5GIKVEDy3357LPKaeD9YZE
        Q7kEpB4LpSp+B6MN5iK0m6NsTvOeWm9Jkq+jRqrODg==
X-Google-Smtp-Source: AGHT+IEVthnA6CU9mpkTsCHlLVMIzAPKmS4ZaPXH4ULIXiZ+5TAJwScCOKMTezMaxNwS+k8Jz117dmhU1EvVRABxWDU=
X-Received: by 2002:a25:b7cf:0:b0:d9a:d895:2ede with SMTP id
 u15-20020a25b7cf000000b00d9ad8952edemr238953ybj.16.1697655382857; Wed, 18 Oct
 2023 11:56:22 -0700 (PDT)
MIME-Version: 1.0
From:   Jianxiong Gao <jxgao@google.com>
Date:   Wed, 18 Oct 2023 11:56:10 -0700
Message-ID: <CAMGD6P3szwE-ji3sJsow5PPuazqQjQhgN4ZKFmUmZJ0Gfz=ByA@mail.gmail.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
To:     michael.roth@amd.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, dave.hansen@intel.com,
        david@redhat.com, dfaggioli@suse.com, jroedel@suse.de,
        kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        mgorman@techsingularity.net, mingo@redhat.com,
        nik.borisov@suse.com, pbonzini@redhat.com, peterx@redhat.com,
        peterz@infradead.org, philip.cox@canonical.com,
        David Rientjes <rientjes@google.com>, rppt@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Sean Christopherson <seanjc@google.com>, stable@kernel.org,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        tim.gardner@canonical.com, vbabka@suse.cz, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch helps us gain more stability in our testing.
We are not able to reproduce the soft lockup issue in over 20 runs
with 176 vcpus so far.

Thanks!
-- 
Jianxiong Gao
