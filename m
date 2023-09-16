Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87197A31B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjIPRnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjIPRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:43:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA63E6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 10:43:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502fd1e1dd8so1441219e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694886217; x=1695491017; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIVt11VXEPQxcMmnR7p7Lc2b9PwXHp0ElLuvknOACcw=;
        b=tx+AR9bugQ7/8ibQ1T3Q2gpzgJVRPn5xndR5vysxxvH/aD1MHIFKJu72aHmYzSruMq
         dSQMBMabnwoJwxjhVgfknKNOeQOpEpxP/WFDG7pM7DLV1PZQz5kNpW0eJDvjzaHkaKsR
         MvRIRbAkMi+LxrDhBz97Mwp7UBbQDiN4oxJrDj4s9YZwMrMM2m6dcsJlkB+QbfDEN98n
         LhTYcHTrSLeoLN7gNY019DtaKhdnnhBNkVDqe3oFi5g5XM34RGcPKJ1Lw40VN7sWlkLN
         PjsO+Q2YvuCduuZtFQiJIMzimR9Y6xVMTIB328Za/q24+mMYRabrHFb4Q2pMyskttpGp
         CZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694886217; x=1695491017;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIVt11VXEPQxcMmnR7p7Lc2b9PwXHp0ElLuvknOACcw=;
        b=ZcDl9B6Qf8NfnTxwiOk/ZHRqvLUIsyaL3tTL5MLYr0GjNSGxK4+rtVWUbHfFFpZuiZ
         gefstB22mBZWq7m1KYHjJZF2tOfwakpjIaiJHGmatqdggRinMQwiREmBJhLh+NZxpdlQ
         ranF0unXcu7SaFuM/UP03Awtj+8xRuWTPfQ3jvXZiocBKj4kUN7w/Y0NicAM1+p59DbM
         J02rtfNWbZ2DXLNJJfY38GKYoMdRVMaERJ5XYylVCiq3T+MaviP3ymoR4vPjhBYdwiTE
         kBeg/TneotIMTxeZ2YroUZE2x/3d+PrKzXLCpndy38zrA2PIj5lTGmvx7qEsptX3Tk55
         h67g==
X-Gm-Message-State: AOJu0YxA8YMMMwipP7uTJkWYclK8MfMrQt2yBNBRBlE2NGmuuyVvxsYG
        SHWWG4RI/LjMTBEOPxJmIZ97hg==
X-Google-Smtp-Source: AGHT+IEHywx+IdLPBKdiSYcGSmJF+BwP9LP1gn12kM7MQoC51Mwh5zkrKUcRErYNvh+ZG67AtLACOQ==
X-Received: by 2002:ac2:5976:0:b0:4fb:911b:4e19 with SMTP id h22-20020ac25976000000b004fb911b4e19mr4035596lfp.35.1694886217563;
        Sat, 16 Sep 2023 10:43:37 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id w10-20020ac254aa000000b004fdc0f2caafsm1103942lfk.48.2023.09.16.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:43:36 -0700 (PDT)
Date:   Sat, 16 Sep 2023 19:43:35 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>, arnd@arndb.de,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2 12/19] lib/stackdepot: use list_head for stack record
 links
Message-ID: <20230916174334.GA1030024@mutt>
References: <cover.1694625260.git.andreyknvl@google.com>
 <d94caa60d28349ca5a3c709fdb67545d9374e0dc.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d94caa60d28349ca5a3c709fdb67545d9374e0dc.1694625260.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 19:14, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Switch stack_record to use list_head for links in the hash table
> and in the freelist.
> 
> This will allow removing entries from the hash table buckets.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 

Building on an arm64 kernel from linux-next tag next-20230915, and boot
that in QEMU. I see the following kernel panic.

[   67.398850][    T1] Unable to handle kernel read from unreadable memory at virtual address 0000000000000010
[   67.407996][    T1] Mem abort info:
[   67.411023][    T1]   ESR = 0x0000000096000004
[   67.414757][    T1]   EC = 0x25: DABT (current EL), IL = 32 bits
[   67.419945][    T1]   SET = 0, FnV = 0
[   67.423172][    T1]   EA = 0, S1PTW = 0
[   67.426669][    T1]   FSC = 0x04: level 0 translation fault
[   67.431357][    T1] Data abort info:
[   67.434593][    T1]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   67.439801][    T1]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   67.444948][    T1]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   67.449910][    T1] [0000000000000010] user address but active_mm is swapper
[   67.456236][    T1] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   67.462181][    T1] Modules linked in:
[   67.465435][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.6.0-rc1-next-20230915 #2 e95cf19845fbc1e6a5f0694214d59e527e463469
[   67.477126][    T1] Hardware name: linux,dummy-virt (DT)
[   67.481994][    T1] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   67.488454][    T1] pc : stack_depot_save_flags+0x2a8/0x780
[   67.493348][    T1] lr : stack_depot_save_flags+0x2a8/0x780
[   67.498339][    T1] sp : ffff80008000b870
[   67.501670][    T1] x29: ffff80008000b870 x28: 00000000650dddc5 x27: 0000000000000000
[   67.508658][    T1] x26: ffff80008470a000 x25: ffff80008000b9e8 x24: 0000000000000001
[   67.515564][    T1] x23: 000000000000000e x22: ffff80008000b988 x21: 0000000000000001
[   67.522430][    T1] x20: ffff00007b40d070 x19: 000000006ee80007 x18: ffff80008000d080
[   67.529365][    T1] x17: 0000000000000000 x16: 0000000000000000 x15: 2030303178302f30
[   67.536101][    T1] x14: 0000000000000000 x13: 205d315420202020 x12: 0000000000000000
[   67.542985][    T1] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   67.549863][    T1] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[   67.556764][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   67.563687][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[   67.570500][    T1] Call trace:
[   67.573275][    T1]  stack_depot_save_flags+0x2a8/0x780
[   67.577794][    T1]  stack_depot_save+0x4c/0xc0
[   67.582062][    T1]  ref_tracker_alloc+0x354/0x480
[   67.586273][    T1]  sk_alloc+0x280/0x5f8
[   67.590064][    T1]  __netlink_create+0x84/0x200
[   67.594009][    T1]  __netlink_kernel_create+0x11c/0x500
[   67.598816][    T1]  rtnetlink_net_init+0xc4/0x180
[   67.603052][    T1]  ops_init+0x100/0x2c0
[   67.606827][    T1]  register_pernet_operations+0x228/0x480
[   67.611568][    T1]  register_pernet_subsys+0x5c/0xc0
[   67.616282][    T1]  rtnetlink_init+0x60/0xb00
[   67.620086][    T1]  netlink_proto_init+0x374/0x400
[   67.624465][    T1]  do_one_initcall+0x2c8/0x840
[   67.628518][    T1]  do_initcalls+0x21c/0x340
[   67.632527][    T1]  kernel_init_freeable+0x3b0/0x480
[   67.636905][    T1]  kernel_init+0x58/0x380
[   67.640768][    T1]  ret_from_fork+0x10/0x40
[   67.644606][    T1] Code: eb1b029f 540008c0 91004360 97caa437 (b9401360) 
[   67.650293][    T1] ---[ end trace 0000000000000000 ]---
[   67.654948][    T1] Kernel panic - not syncing: Oops: Fatal exception
[   67.660229][    T1] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

The full log can be found [1] and the .config file [2]. I bisected down
to this commit, see the bisect log [3].

When reverted these two commits I managed to build and the kernel
booted.

47590ecf1166 ("lib/stackdepot: use list_head for stack record links")
8729f3c26fc2 ("lib/stackdepot: allow users to evict stack traces")


Cheers,
Anders
[1] http://ix.io/4GyE
[2] https://people.linaro.org/~anders.roxell/next-20230915.config
[3] http://ix.io/4GyG
