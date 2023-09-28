Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7F7B186D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjI1Kml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjI1Kmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463B191
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695897712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rF94+lxnXcbWAAeiKQ8ZfUkLdacuHhBSdWopelKLUFM=;
        b=D+rD8LaQ1Rvnu3OtFsLfpMPrwmY88hyv4uAZ/9po3W0b/avrPRWLh/F00hg/RkppZjoyAe
        eHreEx/SKa8Q9ih7+HzdF8GM/BZOYMTaSyw9tSHl/oxYz1weUcyjz+lqFzBg/2w9glWKOd
        bza2S36MVgwIME2hfyWYbNRwAytGoxc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-0gvcyoVsPx--NddrKIMFZg-1; Thu, 28 Sep 2023 06:41:50 -0400
X-MC-Unique: 0gvcyoVsPx--NddrKIMFZg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4063fda7845so36451585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897710; x=1696502510;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rF94+lxnXcbWAAeiKQ8ZfUkLdacuHhBSdWopelKLUFM=;
        b=kPzIFroJYNPOV3OtU5K5wRaLpAzaLm2pK/Ase3fsAe7F85B/69X81vA7NDlUaai9Aq
         96Gw4gy7idQP6xO+F7zVH1ogT+gZyGHOg809ktvFywM3tEfITcNMX7fF0KPhcNHBFQaC
         nP4lq/NUQF75Cv5Z1Rj43FIEFkfh6+vcKj/sZQ3W/AK/OO6PmzIpbfcLT5aMixvAnEiS
         kKylRXH3/3yYaQ0VsJnHdVNRp6mfp0nyC+rotysV+cMHoNzDK+lEzcSgLkzEtFxNyzp9
         /3zOmxYiwEH66W+C6CKpkUfwJN1T3FkhwqapwABaz5Lc7P5SlDVgExusQOdjdj/wFTcn
         5RgA==
X-Gm-Message-State: AOJu0YxYwCHXVQj9sCFdVC2wrotpMv4a1XwAGBPpX3phj8h6kDEDMw6m
        npEbXjgKz+9FykkTNh0LUmRjaDG4ptuiNWCmfDXCDI7yqIKVOPd55SRBXRXEvUhZi8EYwrun86s
        h9StQ8s1i4pa0ST0xu5nU0Bbt
X-Received: by 2002:a05:600c:215:b0:405:1c19:b747 with SMTP id 21-20020a05600c021500b004051c19b747mr805044wmi.15.1695897709865;
        Thu, 28 Sep 2023 03:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gD9DALZSJ4/eLzmtzbsiPAZcQA5nxTmweX88cLLeoiwUrPazcr8qIKWXbPPfoL1FOYaQSA==
X-Received: by 2002:a05:600c:215:b0:405:1c19:b747 with SMTP id 21-20020a05600c021500b004051c19b747mr805036wmi.15.1695897709537;
        Thu, 28 Sep 2023 03:41:49 -0700 (PDT)
Received: from starship ([89.237.96.178])
        by smtp.gmail.com with ESMTPSA id c17-20020adfe751000000b00317909f9985sm18923856wrn.113.2023.09.28.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:41:49 -0700 (PDT)
Message-ID: <50069cc01dc978f33c9196f91cd238d3307d27fb.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] KVM: x86: add more information to kvm_exit
 tracepoint
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Date:   Thu, 28 Sep 2023 13:41:47 +0300
In-Reply-To: <3524fd5b-d846-ffae-0134-fef4447d8d72@redhat.com>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
         <20230924124410.897646-4-mlevitsk@redhat.com>
         <3524fd5b-d846-ffae-0134-fef4447d8d72@redhat.com>
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

On 2023-09-26 у 18:40 +0200, Paolo Bonzini wrote:
> On 9/24/23 14:44, Maxim Levitsky wrote:
> > +		__field(	bool,		guest_mode      )	     \
> > +		__field(	u64,		requests        )	     \
> > +		__field(	bool,		req_imm_exit	)	     \
> 
> I am not sure about adding guest_mode or req_imm_exit here, because they 
> should always match kvm_entry.
> 
> Paolo
> 

I'll drop both.

Best regards,
	Maxim levitsky



