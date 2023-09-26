Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD97AF0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjIZQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjIZQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885FE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTQuhz6i8pETFCJEBQwLAAEUzmgG6c+WGKgQCxT5cqM=;
        b=eFiPdBpE9q+RyXI7EdgB+0PjB0IQL/2eh3+8mbUAqiAiI9hV1MP/SWyfOUaHmIfx7CUsyv
        I1CxACeIoM7aOn0TDaFpH5LxZInu2D4t356vN66WNv3Lm89jbquz4ShNC6IDagKiI4+T0w
        6tpWm8pd7ooFTYWGkngl1yGtMSuadt0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-CGVq1eA4PxKppnKn6bz_FA-1; Tue, 26 Sep 2023 12:39:04 -0400
X-MC-Unique: CGVq1eA4PxKppnKn6bz_FA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3200597bfc5so7023195f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746342; x=1696351142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTQuhz6i8pETFCJEBQwLAAEUzmgG6c+WGKgQCxT5cqM=;
        b=VAzkEOHEDAdpvfKzjLQEfVJFuguZ+mgyuzSYquNByMvwuOnYQFQlAELKS77GTQUxHJ
         2Y6wBpsXvIZ0yfiPhjk4NAl8xunMfsiDTldhDW0hgvVqkR+luoo5eaC++kN2fWt/ZcGA
         ezeI2VZUtAnn00ziABwPvuYu5UBNDfAiM47L/0/arVXyHy/4sHKhtm89tcfcieTj9x+C
         KKYSR41VBdX8Xe4WARQDloOHLzRZl7MPxq/scwhnBeiBQfUNDoMiFmF0Yjwv81mZm085
         F3g97QwriStIsFtpFDts5aTj/BAAnB06756nbwHA1A8+C3Jpkz/jNu0RPLWQ+031aRxf
         Tzhg==
X-Gm-Message-State: AOJu0YzgF9ysBFq7z3CnxCEHJ6DGDIM6nHxi3Tjxyt1iYq4f8BXxhayl
        MhYtKbdLyK15IKROr1PEDnzunzXjR0b2w9loTdTRdXNDaar9Az1paEF/QdR7nlpg6zXEhMBePdN
        R8oETvKerOKmxYersDHJiE8oX
X-Received: by 2002:a5d:4571:0:b0:320:28e:b638 with SMTP id a17-20020a5d4571000000b00320028eb638mr9555565wrc.36.1695746342455;
        Tue, 26 Sep 2023 09:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy0LhaIhMp+x6DrglQYfNQsGu8JLiXNZjRQ5NtgOwYtPJlfphvtDjLSoegu8pEbBK1x4jBBA==
X-Received: by 2002:a5d:4571:0:b0:320:28e:b638 with SMTP id a17-20020a5d4571000000b00320028eb638mr9555542wrc.36.1695746342137;
        Tue, 26 Sep 2023 09:39:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id u21-20020adfa195000000b00323293bd023sm6072760wru.6.2023.09.26.09.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 09:39:01 -0700 (PDT)
Message-ID: <27053c89-e11c-e16d-ef88-89b3cd99c487@redhat.com>
Date:   Tue, 26 Sep 2023 18:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] KVM: x86: add more information to the kvm_entry
 tracepoint
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
 <20230924124410.897646-3-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230924124410.897646-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 14:44, Maxim Levitsky wrote:
> +		__field(	u32,		inj_info	)
> +		__field(	u32,		inj_info_err	)
> +		__field(	bool,		guest_mode	)
> +		__field(	bool,		req_imm_exit	)
> +		),

As anticipated in patch 1 I'm not so sure about adding req_imm_exit here 
but also (especially) in kvm_exit.  I do believe it should be traced, 
I'm not sure it's needed in kvm_entry+kvm_exit as opposed to just a 
separate tracepoint.

Paolo

