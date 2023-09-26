Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0842D7AF42C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjIZTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjIZTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:31:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2FCFC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:31:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c604a5a53eso67136065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695756671; x=1696361471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7dcEcPqYBrLr8YEQVG+yRj/mrY2mvRq3Ti0eeSXoSU=;
        b=z9eEnkFzVMOnIwlqStWsiOzUFgLVy0uQYAVeMgkjFPikVzlfQCFQc/w9Ey+NWoWCc8
         aZbYivo899dyXUSHrpJqeVWZM4GOS6bmiCGxNMzZQdASLatYfS/pmXLRCkkmyWl2u4Ni
         r4mtEa5iGI4BVWpX8cD5GEK/H0wVb/kHiiVAdw9wj8xrEDSN2ACT/+y4uHpr/Nge6fMk
         6OTWxD8xQJlXfsGRlF7kt246LU6FUuAxsStbistyvgyBg/XiE9iSzxpzPQjgZ5gmf3W7
         5dkLFBa1wQimc3VLVAVaWD8GqsBHhltobvKTLMdb2xbc8BiuiJxOa8PSB913VxGbhUCB
         0GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695756671; x=1696361471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7dcEcPqYBrLr8YEQVG+yRj/mrY2mvRq3Ti0eeSXoSU=;
        b=NqXIEJwY+hxGQvQ779a2+V+BfheAj+6zlqBdbWflilAKubxt6MRjna4fI4fTZ/Ji8b
         JTSLiX1qdNKfBvKEBUeClCS+HAfu9DD3whR9C9t3Iw97tq9Os0pZitfPUG92X5GBEhVu
         tWe4nueA62WTFrdb4BvhTNdvCRGUabzS1MNV/xLA+fgqtS37ES2qmH9yvrsisZ6Tixoe
         L6VyrZhXCMr5CCoNiMxFEakIZ4hq3du1wLkP08F2QkZw8LzflViy4sUQ3v8xmo8WCYkK
         HxBzfERXSLX3u+75+VQPkA2q+olO/GzNWci2Yw+j89TNwkZPaBLpkLQGVc/5BK/9Ti4N
         Mh6w==
X-Gm-Message-State: AOJu0YzTKI78LNnl5R632zG91U5UJ6t9fh7IdFCWL4KwjGh7S7Ka5GJ/
        G3e3NCzTDVqgzh1lvEhqF8bwGMr7C8Q=
X-Google-Smtp-Source: AGHT+IGEbT8t4CZ3N4cgy9pqGA5czbLjGs1Gz8Y71mba2TNs49IXxRyxbyoU5833gCs2OEfg4ZOI+H5vNzY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d481:b0:1c1:3ba1:b635 with SMTP id
 c1-20020a170902d48100b001c13ba1b635mr117047plg.4.1695756671094; Tue, 26 Sep
 2023 12:31:11 -0700 (PDT)
Date:   Tue, 26 Sep 2023 12:31:09 -0700
In-Reply-To: <8e57c347d6c461431e84ef4354dc076f363f3c01.1695751312.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <8e57c347d6c461431e84ef4354dc076f363f3c01.1695751312.git.isaku.yamahata@intel.com>
Message-ID: <ZRMxfTd65Ijn3RAj@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Refactor kvm_gmem into inode->i_private
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-coco@lists.linux.dev, Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Refactor guest_memfd to use inode->i_private to store info about kvm_gmem.

Why!?!?!?  Sadly, I don't have telepathic superpowers.  This changelog only
explains *what* the code is doing, what I need to know is *why* you want to make
this change.

The below kinda sorta suggests that this is to simplify the code, but it's not
at all obvious that that's the actual motivation, or the only motiviation.

> Currently it is stored in the following way.
> - flags in inode->i_private
> - struct kvm_gmem in file->private_data
> - struct kvm_gmem in linked linst in inode->i_mapping->private_list
>   And this list has single entry.
> 
> The relationship between struct file, struct inode and struct kvm_gmem is
> 1:1, not 1:many. 

No, it's not.  Or at least it won't be in the future.  As I explained before[1]:

 : The code is structured to allow for multiple gmem instances per inode.  This isn't
 : actually possible in the initial code base, but it's on the horizon[*].  I included
 : the list-based infrastructure in this initial series to ensure that guest_memfd
 : can actually support multiple files per inode, and to minimize the churn when the
 : "link" support comes along.

 : [*] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com

[1] https://lore.kernel.org/all/ZQsAiGuw%2F38jIOV7@google.com
