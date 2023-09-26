Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35A67AF0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjIZQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjIZQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD0196
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Kd2LSMGaFyIyYUQYhYS2fW0pNR+YDpbhEtxru5Iz2s=;
        b=PPPexshFB6h0Z4V1gK3M4M0+pC4wq2iCLCeGwgw71/IPzLQzrll+0s/6W8yAJgrpMc/d9i
        O4rEMvNApm0s79Z2cDyvljCALOMhBRusCCr4sizy/zH25P3bjxNzVKzxQQPZyN06s1y+DY
        6B0MyQw9YKcvzlgd7TO9uM6+e+8lwEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-HR91xuAeOj2gUi4pjOBz0w-1; Tue, 26 Sep 2023 12:40:07 -0400
X-MC-Unique: HR91xuAeOj2gUi4pjOBz0w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40554735995so65272505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746406; x=1696351206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kd2LSMGaFyIyYUQYhYS2fW0pNR+YDpbhEtxru5Iz2s=;
        b=wuLce1HggfXHW1ryHXE0nf7xEZTSvzv5HvVtisvBhFK5bqk3qddT93gOL/w79CcHsL
         HVZhFbKahrbzR3qmWQNReQchEXBZ0ZARRfnfDIXLFQDK00n0u7zuge6vL3VK9drAhfHF
         tZyIhlPTalUaludYe0ec2sE3mOIKSwlU/Y7AMSc2ywe8rIRCZbDwBreL2MHM9FecG/tt
         eVvc5RHw/STjoyuPQzPA4mE0DIIEvlkAKCMj74LQydjGjKRcOQPeidJvHUOd1lcV4CVU
         HsUAAxvVCwLRTT8GUEHjtmihB8r6A2cR1bdB1VB+Kxg77M5ngHJvovcusmgNdQJa87Ud
         4L3Q==
X-Gm-Message-State: AOJu0YyCUvNFGJyNsResIBL2kUVWj8u5O/Zti1t1v7zdo5yrSkWkWnkV
        GW9HCv3a/OoTCLdR/VIk9QWZjqfdfryYAPsRfLFVNKBYppxMeN5dr8VnrV06pIli7OsotXrHs+D
        nT5Z2Rc3AiQTwzrCIMhUiI7up
X-Received: by 2002:a05:600c:216:b0:401:b2c7:34a8 with SMTP id 22-20020a05600c021600b00401b2c734a8mr8676659wmi.7.1695746406283;
        Tue, 26 Sep 2023 09:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhRVYxVcPQvs5mPR9xOjo4Wtr2On7+M2C4AejZs1aj6gskkn2/daaPqmz/7ZOdP8NT2H+dXA==
X-Received: by 2002:a05:600c:216:b0:401:b2c7:34a8 with SMTP id 22-20020a05600c021600b00401b2c734a8mr8676641wmi.7.1695746405923;
        Tue, 26 Sep 2023 09:40:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id s16-20020a7bc390000000b00401c595fcc7sm12722715wmj.11.2023.09.26.09.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 09:40:05 -0700 (PDT)
Message-ID: <3524fd5b-d846-ffae-0134-fef4447d8d72@redhat.com>
Date:   Tue, 26 Sep 2023 18:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] KVM: x86: add more information to kvm_exit
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
 <20230924124410.897646-4-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230924124410.897646-4-mlevitsk@redhat.com>
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
> +		__field(	bool,		guest_mode      )	     \
> +		__field(	u64,		requests        )	     \
> +		__field(	bool,		req_imm_exit	)	     \

I am not sure about adding guest_mode or req_imm_exit here, because they 
should always match kvm_entry.

Paolo

