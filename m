Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02E7FF93C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjK3SWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:22:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA51D6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701368579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wI81TszQ+HavXeXDYPqPnC9zC5eJQkah0vJVVXbWL9Q=;
        b=bn+g4EAx7hmH3RceJnv2Xbdaa6z6UVKwodSxCG09Xxie6ukP4dNLX0CkvAxgvkmH+llC8I
        DohLtueI8YRscEN7UKPDBFtorxOfBqC5b/kUjozDYOismAHdvXynNFkfIoKhqpCHKRWV4U
        hk7imtBTd8AIHOY7RLFd/cP+gH0Y+N8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-qoBo23_oN2SYZDkGdXi8GA-1; Thu, 30 Nov 2023 13:22:58 -0500
X-MC-Unique: qoBo23_oN2SYZDkGdXi8GA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c9b97a391bso14824441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368576; x=1701973376;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wI81TszQ+HavXeXDYPqPnC9zC5eJQkah0vJVVXbWL9Q=;
        b=eM5lVLZcgF0w0TCCW4TyuvXev0xRHGQWZM+i6oh5Pb6ePUTo2h8E9YLqXPj55raUc9
         BZXWTo1JR64gwJj/xv50ZjIs36842gSmICv+8swlM3uipf3+l2E97KV13Qpma63+z3ld
         IWD6VhbVBtjlwJQRix5rbQu+jmzN4eKxOb3HykoFOA2HIjeh7rCspi1MTMkhREIeqqG1
         0oRBqLFwjOJ1dpz2Yu+AAtZRcJhvj36CEijZt+qKlWwgAnc8odBzYdRmKlt4BAz1JXTy
         eu2Rgg/hV30jLGDWnK7MVYtP8iKWuemAzDquokAVbYSpDzpR2tj86r5X6ZUwdAJoFryO
         +3dA==
X-Gm-Message-State: AOJu0YzKxzb1CIBVDv5+THssrWPT80f0S9O+VRbUW4KAkbg8VwbDJ5oL
        yrU9+y2r0IJCG71Rug8XJLXV8gYcEQn9znLTWNCbYsJUuPNYh2M5gq18N299Cd4dmZ6BFllWnXa
        oz4mSC9UHiHuZ+Y9G5y+01KJpQHoxy3Xw
X-Received: by 2002:adf:fc4a:0:b0:333:145b:dbe4 with SMTP id e10-20020adffc4a000000b00333145bdbe4mr5824wrs.42.1701364094859;
        Thu, 30 Nov 2023 09:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt5VLzdRHMWwfoz78n79Jjv1J/ksnTUOcY2uHEfV5/oooNR24dio4f81xNIhQQUnzfLiBQEg==
X-Received: by 2002:a2e:9784:0:b0:2c9:c192:43a9 with SMTP id y4-20020a2e9784000000b002c9c19243a9mr3511lji.28.1701362235390;
        Thu, 30 Nov 2023 08:37:15 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b4c26d2dasm2536292wmq.32.2023.11.30.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:37:14 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: arch/x86/kvm/vmx/hyperv.h:79:30: sparse: sparse: cast truncates
 bits from constant value (1b009b becomes 9b)
In-Reply-To: <202311302231.sinLrAig-lkp@intel.com>
References: <202311302231.sinLrAig-lkp@intel.com>
Date:   Thu, 30 Nov 2023 17:37:13 +0100
Message-ID: <87v89jmc3q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
> commit: a789aeba419647c44d7e7320de20fea037c211d0 KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"
> date:   1 year ago
> config: x86_64-randconfig-123-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302231.sinLrAig-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302231.sinLrAig-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311302231.sinLrAig-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    arch/x86/kvm/vmx/hyperv.h:79:30: sparse: sparse: cast truncates bits from constant value (a000a becomes a)

This is what ROL16() macro does but the thing is: we actually want to
truncate bits by doing an explicit (u16) cast. We can probably replace
this with '& 0xffff':

#define ROL16(val, n) ((((u16)(val) << (n)) | ((u16)(val) >> (16 - (n)))) & 0xffff)

but honestly I don't see much point...

-- 
Vitaly

