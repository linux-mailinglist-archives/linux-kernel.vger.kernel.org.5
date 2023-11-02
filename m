Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5587DF9E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377178AbjKBS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKBS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4313D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698949570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7VlI3P4zkoGBoInIQmHlfw4FeMBcLOAHJ8eeKcs2mc=;
        b=JmKlPZ42Mxkh+yFQVUJy8rBI8ZjlCYrvsbH2X95ueHarnsZhdLgZFOZLe4YEEzvOLUSXJH
        hoQd34BVzSMb1ZTxDnHd5JbVk1NoUbuhq+05AGB4A3zKveYZz50wCP8XbOUYj+Jo2ITLAV
        JiEO86znkd39+xxBQ6XZ6WqSHIxj/hs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Cr9_3ngUMGmf7wOkoQCgWQ-1; Thu, 02 Nov 2023 14:26:09 -0400
X-MC-Unique: Cr9_3ngUMGmf7wOkoQCgWQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5090f6a04e1so1370032e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949567; x=1699554367;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7VlI3P4zkoGBoInIQmHlfw4FeMBcLOAHJ8eeKcs2mc=;
        b=Wyfl456o/zdigk1nQQ698IaZF7K1H1Wu/YqS6c0fXB2ZzUXbsT3q/ffwOzzt1rKE2d
         1d7yFhFGwr5290R3++Zv3L03Q5x4jEOHfjCz6V1qYGZVPeRIXAsIrHpmZDiDrbHTPEuQ
         INER+olWMsK72/iqB+DB84lcodJcRFrn6xnV/GJ9HEeQpDzJaHwmmZ8bfQOCXcsMDh2s
         88jPw0JjuQ+LwAoCxm5US+ORRcd3JjT6ucidXejvVh5ciZ3d6Z2/GOAd1d0G46gVEb/Y
         PIgYtZP5rw97sXwq2DIbXCNvQlLMi9TF4PR7YggVTvyRAFYPMHzRrz+sspcSlCz9/C5T
         QU9g==
X-Gm-Message-State: AOJu0Yw/u0Bu8PuU4AkDmG7AYHsUSkzkARoeN66NPrXpAr/EsrGilGK6
        rBMjJlBmR8OFTXvf3gKwWb2F3a8xOqUgqfmpkrT9N6toqrhZlUb8RsRYEy9E/73eDfBEAbUXiso
        CTeLlrHSBzWdSPfIIMrpnGRLJ
X-Received: by 2002:ac2:44c4:0:b0:509:dd0:9414 with SMTP id d4-20020ac244c4000000b005090dd09414mr10956144lfm.24.1698949567682;
        Thu, 02 Nov 2023 11:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwdj92bVhqKRjZlj65hl0Att8XKDMIM0oIyfctzH6r2VQilezMgCK2YEafflmanu3ckbNE7A==
X-Received: by 2002:ac2:44c4:0:b0:509:dd0:9414 with SMTP id d4-20020ac244c4000000b005090dd09414mr10956121lfm.24.1698949567349;
        Thu, 02 Nov 2023 11:26:07 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040775501256sm298171wms.16.2023.11.02.11.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:26:07 -0700 (PDT)
Message-ID: <1e9921f687abe09d8797e6fb83760acf970f344e.camel@redhat.com>
Subject: Re: [PATCH v6 10/25] KVM: x86: Add kvm_msr_{read,write}() helpers
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 02 Nov 2023 20:26:05 +0200
In-Reply-To: <ZUKnyfbRqTFhMABI@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-11-weijiang.yang@intel.com>
         <92faa0085d1450537a111ed7d90faa8074201bed.camel@redhat.com>
         <ZUKnyfbRqTFhMABI@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 12:32 -0700, Sean Christopherson wrote:
> On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > Wrap __kvm_{get,set}_msr() into two new helpers for KVM usage and use the
> > > helpers to replace existing usage of the raw functions.
> > > kvm_msr_{read,write}() are KVM-internal helpers, i.e. used when KVM needs
> > > to get/set a MSR value for emulating CPU behavior.
> > 
> > I am not sure if I like this patch or not. On one hand the code is cleaner
> > this way, but on the other hand now it is easier to call kvm_msr_write() on
> > behalf of the guest.
> > 
> > For example we also have the 'kvm_set_msr()' which does actually set the msr
> > on behalf of the guest.
> > 
> > How about we call the new function kvm_msr_set_host() and rename
> > kvm_set_msr() to kvm_msr_set_guest(), together with good comments explaning
> > what they do?
> 
> LOL, just call me Nostradamus[*] ;-)
> 
>  : > SSP save/load should go to enter_smm_save_state_64() and rsm_load_state_64(),
>  : > where other fields of SMRAM are handled.
>  : 
>  : +1.  The right way to get/set MSRs like this is to use __kvm_get_msr() and pass
>  : %true for @host_initiated.  Though I would add a prep patch to provide wrappers
>  : for __kvm_get_msr() and __kvm_set_msr().  Naming will be hard, but I think we
>                                              ^^^^^^^^^^^^^^^^^^^
>  : can use kvm_{read,write}_msr() to go along with the KVM-initiated register
>  : accessors/mutators, e.g. kvm_register_read(), kvm_pdptr_write(), etc.
> 
> [*] https://lore.kernel.org/all/ZM0YZgFsYWuBFOze@google.com
> 
> > Also functions like kvm_set_msr_ignored_check(), kvm_set_msr_with_filter() and such,
> > IMHO have names that are not very user friendly.
> 
> I don't like the host/guest split because KVM always operates on guest values,
> e.g. kvm_msr_set_host() in particular could get confusing.
That makes sense.

> 
> IMO kvm_get_msr() and kvm_set_msr(), and to some extent the helpers you note below,
> are the real problem.
> 
> What if we rename kvm_{g,s}et_msr() to kvm_emulate_msr_{read,write}() to make it
> more obvious that those are the "guest" helpers?  And do that as a prep patch in
> this series (there aren't _that_ many users).
Makes sense.

> 
> I'm also in favor of renaming the "inner" helpers, but I think we should tackle
> those separately.separately

OK.

> 

Best regards,
	Maxim Levitsky

