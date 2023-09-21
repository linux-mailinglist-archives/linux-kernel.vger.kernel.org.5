Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF37AA3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjIUVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjIUVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:55:40 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B779008
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:53:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c577fea3dcso12002135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695333199; x=1695937999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKedUbEi3B4plTooYCB0IKgIV3PycN404RmnO3IuMFM=;
        b=FlFywrXNo8pt0M7BkGTPu/YBFaZ8cFrCflUdyIS2JhrANUQAlS+fVmKFc0oynyRuNu
         gik6QINZKtrEhc56ySwdyIrnhj5DQchxj01WAhtasJTBrOUd+N/RaE4ucbUDwEgLMJ0m
         64gZbhblWUB4KtbnrNOLsQZQ+6t3Op6YnfOMoNHV2b2iLCxNlaDlz9NPOcriowvduXgC
         J641nC9uCd0O1GdN/U7d1l2TpVR8m1uvuP155XW4/qUWaKNepoHZewQryUdCCSYj2BG2
         2Ixe2sE6APsJHiL1UXambg5driKpj5apowXUcy5q2owoNNvBLp5atZLuQILlINnOl26h
         EyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695333199; x=1695937999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKedUbEi3B4plTooYCB0IKgIV3PycN404RmnO3IuMFM=;
        b=iKn95RH1jStdG0ikCWIb6jTZ2qSoeksaJgLJdoyVsHFKkxhbVKjvmw+zEvSyIEp8d2
         619sUmGRIlrL1dJMBJ23oIfDPfUEKdsW+BzMPjSGus/xov8sZJW/4wxLbGlNkSveKWnA
         ioib+GLrtmn3vZkDXi/XG5JHOOqLSpdHLB4jTQsm/ubEOOu6+4p611Id8q4+lxOeJ8Gh
         L4IXSm4VNhO7/PUUjxIv8LME4e5mvnVUPs6vIA7XjbG0CtDxV5evDJnLdGoCM88+/16b
         8fskRX81mEgsF5lltFcXDh4R9sgJzWhusZjtPSH08d8eHeLY7qiVTe+OwKnU2FHbyS2b
         0CCg==
X-Gm-Message-State: AOJu0Yx5z75dmUAx7J3Eja3r4wRpoqA3bbMmSYwmusxCfXenkYdTfcvS
        p/37uP3XCSBPyyJfQVyL5vz2sAuXL/c=
X-Google-Smtp-Source: AGHT+IFzpB0LUmWG0P0jdo//QZ+1d5YUq5/bmYYJ0ADm2c6dVlI9n2014z9qeg4Uv/czKyKiUqWrALehVMY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:facd:b0:1c5:746f:efb3 with SMTP id
 ld13-20020a170902facd00b001c5746fefb3mr67381plb.9.1695333199087; Thu, 21 Sep
 2023 14:53:19 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:53:17 -0700
In-Reply-To: <363c4ac28af93aa96a52f897d2fe5c7ec013f746.1695327124.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <cover.1695327124.git.isaku.yamahata@intel.com> <363c4ac28af93aa96a52f897d2fe5c7ec013f746.1695327124.git.isaku.yamahata@intel.com>
Message-ID: <ZQy7TcPZvpQ7ns5n@google.com>
Subject: Re: [RFC PATCH v2 4/6] KVM: gmem: Add ioctl to inject memory failure
 on guest memfd
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Quentin Perret <qperret@google.com>, wei.w.wang@intel.com,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023, isaku.yamahata@intel.com wrote:
> +	if (!pfn_valid(pfn))
> +		return -ENXIO;
> +	return memory_failure(pfn, MF_SW_SIMULATED);

memory_failure is defined iff CONFIG_MEMORY_FAILURE=y.  All of this code would
need to be conditioned on that (in addition to the injection configs).

address_space_operations.error_remove_page() arguably should be conditioned on
that as well, but that's a much bigger change and not a problem that needs to be
solved anytime soon.
