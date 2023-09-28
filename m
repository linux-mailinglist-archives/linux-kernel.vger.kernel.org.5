Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4027B1868
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjI1KmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjI1KmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9F8126
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695897674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIL/aLxSaBTwOd49hOiCBXEkh8RfyyP05npLoIlrk4w=;
        b=DGL89M9D0svPGugbmy6PnGmy8wNLG2/uXTb7jmkTN5+d5FTBG/yFP2rfQyo3Zgn4dix7Ub
        eJBocIe1Cvndnl/mJGEZK++pHt+wiBd3zLpzGbfwy5M8nMT09UHwu+p8v1qn2YbC0/S+wL
        rU18BEzCDIfAc7l0/b1DyMoyWJ/W8Gg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-6S6UGVnxMvi822o952ERFw-1; Thu, 28 Sep 2023 06:41:13 -0400
X-MC-Unique: 6S6UGVnxMvi822o952ERFw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-503177646d2so18697935e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897672; x=1696502472;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIL/aLxSaBTwOd49hOiCBXEkh8RfyyP05npLoIlrk4w=;
        b=Fh5e1DCeQ/FYTZpdl2cR2HyZSjYpmDaO6KlnLaQBLAgJYz/EmVjlHlHFtnE2KpOjFW
         hxkOnZgO6kDOfDoxZ9gWPYFQntJSwl5Fxsv0NNMvhtOU/wBQDLQKBYh8uP4MjBmyvoXW
         VMVZPjnSg+JWenVXSnZrTzKq8UrJW4ZAl6KWphk5JuOVeIhFbEDGAFexXBkfrTIW2HkH
         1S9IvAnHNoFawxaHaXjc5PJET3KLac/M63G2CpHWwDrRqbDYLuaU9c6hIgEetw+E4SLt
         1jy9Zz6WsPmZbLwRPa7x/37z2IsD3Quh657A3vqHgC+k71qUI4TvSa+cmRiXQ1PdyVpr
         vsPA==
X-Gm-Message-State: AOJu0YxZGBBJLmamzjZSGgzVeg1BdQHnt9a4AhdtVc2w+HyQnyS1vS1I
        X2QmG9kozwiEj8/+8kx4tGA1QVje6Kdkk6P+/EZrVtyICT2sIZyVxpgX3bwGs9qR9TUPQYNCYmj
        Mu2HZz+hjiifbgAuZjnHwhn6J
X-Received: by 2002:a19:7110:0:b0:502:9fce:b6da with SMTP id m16-20020a197110000000b005029fceb6damr693710lfc.21.1695897672218;
        Thu, 28 Sep 2023 03:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZnGFQao4JKubYwjZ1ImNhZcdEbjf0t/69AWlyueHN/65GfbbBPeP3rAa54U13dQaswEUQqg==
X-Received: by 2002:a19:7110:0:b0:502:9fce:b6da with SMTP id m16-20020a197110000000b005029fceb6damr693694lfc.21.1695897671830;
        Thu, 28 Sep 2023 03:41:11 -0700 (PDT)
Received: from starship ([89.237.96.178])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003fe2b081661sm22518733wmc.30.2023.09.28.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:41:11 -0700 (PDT)
Message-ID: <c6939a0d710438c4b3d3d98fb7b81030e9d01a0f.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] KVM: x86: refactor req_immediate_exit logic
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Date:   Thu, 28 Sep 2023 13:41:09 +0300
In-Reply-To: <93396a36-30fe-74d6-d812-a93dafa771cb@redhat.com>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
         <20230924124410.897646-2-mlevitsk@redhat.com>
         <93396a36-30fe-74d6-d812-a93dafa771cb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 9/24/23 14:44, Maxim Levitsky wrote:
> > +	if (vcpu->arch.req_immediate_exit)
> >   		kvm_make_request(KVM_REQ_EVENT, vcpu);
> > -		static_call(kvm_x86_request_immediate_exit)(vcpu);
> > -	}
> 
> Is it enough for your use case to add a new tracepoint here, instead of 
> adding req_immediate_exit to both entry and exit?


I prefer if possible to keep the req_immediate_exit field on entry only,
as it is pretty much an extension to the injected event data which I also
added to kvm_entry() tracepoint.

Best regards,
	Maxim Levitsky

> 
> Paolo
> 




