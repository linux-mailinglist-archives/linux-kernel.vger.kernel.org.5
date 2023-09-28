Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448FE7B186B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjI1KmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjI1KmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6CE180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695897695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujY5ssiz00Acvp8rMGRHNHWIqC+q9jsSl4olj7QYH/0=;
        b=MS7LW40eDbavR3Rr73V3cpwxwql2M3D8lPKBHbbadtBHMGdnBbGQGTQDOYMGHBmSFJ+KJw
        gqZWOB0vJTlMUrsNRm4MZDr488iNcE+N6YynxB5i5dhry+VqlzoUCi7sCUYPgm5sKyxgZD
        UChZ2y4+WR6jS/UQijS3Ze6TNsZLbZw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-JkfmU_BPPOWPqsroaQfsCw-1; Thu, 28 Sep 2023 06:41:34 -0400
X-MC-Unique: JkfmU_BPPOWPqsroaQfsCw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3232c3df248so6157310f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897693; x=1696502493;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujY5ssiz00Acvp8rMGRHNHWIqC+q9jsSl4olj7QYH/0=;
        b=CdpKlv/qGI8bc0J2J3WiG502NaX8xuiOX+DvgHfGDtqclXSLgFOmo9a4+VDa5utkZl
         rdUZwWS6eAr78HtVPs6qVzQZ9mcZzWHa1aBiR/FwDtBG8drNjdPZWWxBzHs6/SB8ATt9
         jFxrGdUeBskwa8enWt2ucHfP0CPTUSct+we9MR/tKzGCupf6xjtRFv3OPjvR7jnJKtAa
         EjZgWRXUCA7zwxoiLgHWfb44fQ/dkpsWne/yIvON5FFsmH0MEi5e40LHyAI09LAKAgUb
         NjrTfs6S88DU5LF3xSVjLnXN1pjnWSSCvx/NJ5FAl4e/bCVcR9X5FlOk1+obX4Aa6ppZ
         FN6w==
X-Gm-Message-State: AOJu0YyheuegFKcGftcpB9fwAdm5vnoMOssdM3NPHTNGxWVmXScjcg7d
        oYoBh9xNns64xbfaoMXJrSTriAE7f93bWgSWijz8o6LDf6xskfGZgF74t/MHBjzzbdmQ5Qmx5fK
        +3ggiahBnuA/S08L6Nqm9zpYq
X-Received: by 2002:adf:d4c2:0:b0:31f:fafe:a741 with SMTP id w2-20020adfd4c2000000b0031ffafea741mr805288wrk.67.1695897693342;
        Thu, 28 Sep 2023 03:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8wQqJcLWfnLgcx3NFwWByEI5vHLz4X4Dd/wyS5mYLcYBquvQCsnqouz8WVv4GxVhZ3/cOTg==
X-Received: by 2002:adf:d4c2:0:b0:31f:fafe:a741 with SMTP id w2-20020adfd4c2000000b0031ffafea741mr805266wrk.67.1695897692989;
        Thu, 28 Sep 2023 03:41:32 -0700 (PDT)
Received: from starship ([89.237.96.178])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d4a8b000000b0031fc4c31d77sm19261478wrq.88.2023.09.28.03.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:41:32 -0700 (PDT)
Message-ID: <43a47609b43641bd74f96d86783f984295e3d87d.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] KVM: x86: add more information to the kvm_entry
 tracepoint
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Date:   Thu, 28 Sep 2023 13:41:30 +0300
In-Reply-To: <27053c89-e11c-e16d-ef88-89b3cd99c487@redhat.com>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
         <20230924124410.897646-3-mlevitsk@redhat.com>
         <27053c89-e11c-e16d-ef88-89b3cd99c487@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У вт, 2023-09-26 у 18:39 +0200, Paolo Bonzini пише:
> On 9/24/23 14:44, Maxim Levitsky wrote:
> > +		__field(	u32,		inj_info	)
> > +		__field(	u32,		inj_info_err	)
> > +		__field(	bool,		guest_mode	)
> > +		__field(	bool,		req_imm_exit	)
> > +		),
> 
> As anticipated in patch 1 I'm not so sure about adding req_imm_exit here 
> but also (especially) in kvm_exit.  I do believe it should be traced, 
> I'm not sure it's needed in kvm_entry+kvm_exit as opposed to just a 
> separate tracepoint.


I will drop guest_mode.

Best regards,
	Maxim Levitsky


> 
> Paolo
> 




