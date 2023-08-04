Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE65770B37
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjHDVsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjHDVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDCBF0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691185633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiScYNNF3/5tyRgaI7Wx7hPnkZAj0r8d0q062ZADxes=;
        b=da0RcL+LOEI9NOGSDuLzgdtNyRL9esABRUEhRQWuWuuZQ2a1Dgq88LRx5LEiEN2oDFFAqC
        knF+AkiQkC7F3jOtboV9iqUZcH5047fNh5J1bE+3A5DRymDJHJgUyWesebJ6dsjOZgE+NP
        WmfvvePm3pc/vz5XnRLrejM5sxO2UxQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-_Jw055fyOjynagqq_n7STg-1; Fri, 04 Aug 2023 17:47:11 -0400
X-MC-Unique: _Jw055fyOjynagqq_n7STg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9dc1bfdd2so30141821fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691185629; x=1691790429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiScYNNF3/5tyRgaI7Wx7hPnkZAj0r8d0q062ZADxes=;
        b=cGLx6JG18sORbjNlBGUVBYzkYQr4Je40HAVLxrii9do/k9AKaVhZpyq58ovA2TB7iM
         Qmdf13NrGBchzWod+M/8/cM14eNyHPxt+xsKJ1MWMwHpf3/swIMK+K9U+bdJrbOeWRTe
         IwMekyy9WUyH43+OMBiJ2iSzZ5sHExjCxRaZ7D3S4pim5/ENWRuxLcAJycUcXmM+SwnH
         PRHHh7OO9egXw/Nt06k/FCPNw2+tDQO1FHHjn4J1I8O6Kk60RB4TkkZsygo2XHZy9TDD
         IzWRHop9Bol80HhsHgLkZ+VmSr63IKZdRimObyBr9LHz3t07eDRhgmbbxiKIBwndDokz
         9oAA==
X-Gm-Message-State: AOJu0YzfMmGbF4ufzB6xfiqJ9pQ7qeFoob00C9r55kbtWDuSpvFxAec2
        AwyBTPNNP/6gK3a7t5b4vXpmBrGOGJSH78wp07gc75xSVHg4n2uF7uqRxuMjq2CUM2TTwhhzHJq
        +eoH0ivR5Um+xcQ8FM0YtQLy6
X-Received: by 2002:a2e:8097:0:b0:2b6:df71:cff1 with SMTP id i23-20020a2e8097000000b002b6df71cff1mr2280550ljg.52.1691185629602;
        Fri, 04 Aug 2023 14:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExe5iiZfhIyXQdWvWaXrTzadO33FxB5aH81HqxqGBkNcUN8aPdMF9xEDQqQjhI1d+42Kq3fw==
X-Received: by 2002:a2e:8097:0:b0:2b6:df71:cff1 with SMTP id i23-20020a2e8097000000b002b6df71cff1mr2280541ljg.52.1691185629115;
        Fri, 04 Aug 2023 14:47:09 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id d24-20020a170906c21800b00989828a42e8sm1834839ejz.154.2023.08.04.14.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:47:08 -0700 (PDT)
Message-ID: <6d0b0da3-5df2-46f4-d6ba-75ae6a187483@redhat.com>
Date:   Fri, 4 Aug 2023 23:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/19] KVM:x86: Report KVM supported CET MSRs as
 to-be-saved
Content-Language: en-US
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        peterz@infradead.org, john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com, chao.gao@intel.com,
        binbin.wu@linux.intel.com
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-9-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230803042732.88515-9-weijiang.yang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 06:27, Yang Weijiang wrote:
> Add all CET MSRs including the synthesized GUEST_SSP to report list.
> PL{0,1,2}_SSP are independent to host XSAVE management with later
> patches. MSR_IA32_U_CET and MSR_IA32_PL3_SSP are XSAVE-managed on
> host side. MSR_IA32_S_CET/MSR_IA32_INT_SSP_TAB/MSR_KVM_GUEST_SSP
> are not XSAVE-managed.

MSR_KVM_GUEST_SSP -> MSR_KVM_SSP

Also please add a comment,

/*
  * SSP can only be read via RDSSP; writing even requires
  * destructive and potentially faulting operations such as
  * SAVEPREVSSP/RSTORSSP or SETSSBSY/CLRSSBSY.  Let the host
  * use a pseudo-MSR that is just a wrapper for the GUEST_SSP
  * field of the VMCS.
  */

Paolo

