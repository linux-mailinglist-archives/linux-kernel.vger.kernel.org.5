Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C87B8075
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjJDNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F421A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696425264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKB87bTajQH/5HfXBd7T/7DKZGQoywxxIms8WQ1l3Bc=;
        b=Gk2TpchBvbG7Ok8DRKAogY/mgsbwkh4M9SIDJos4H7vlhRCLY206SDZ7K49ZweTUycH5Mp
        2fXshYD64k0JqeBPrRmIqSFrhul+Mobeag3THWofroqz/BzSeoMNIbtJ7045uIPw2Tx/vK
        Rgz+qnxR9ZRZHKBG7QaIP+3DzHMfkNI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-mz8YbnRuPyOK0Tr-WDtI0g-1; Wed, 04 Oct 2023 09:14:06 -0400
X-MC-Unique: mz8YbnRuPyOK0Tr-WDtI0g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae0bf9c0a9so177698466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425245; x=1697030045;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKB87bTajQH/5HfXBd7T/7DKZGQoywxxIms8WQ1l3Bc=;
        b=JVoa0fWVnL8Sx2tjCqmVejaKPwzSLQAF0hzFYnia+I5RMobnenlWR8OQngtpwAz0dO
         7kAzprca37WWkhfTqQr2cWruoHqPh5nX6w5aq3tq1Ny9IIpNGJ5kVsosy1NfPGsSJkfh
         ilbI52LPtJNNy8aNC7FYCTDxhXyrGFT/6+m8poCK8FPxxO+uB+DM43e4nPZ6U/Jxxbt4
         Y0Z2TuuZybTWE0aOwvTv9MHW27PHJml7s1faHKuEx4Xo18KFiFvVzZELkiAO8vxkoGnH
         V0H5Y77ZGVR2G+E8WUEvsSCMIThzOynTqtx+O7rJYJ+UvB64xgTdhzzM6qMTHGptfF8U
         vR8Q==
X-Gm-Message-State: AOJu0YzwUcA2MmiQYiuo/1LzTimT2uELMv9etDsqJxk6DTFCVlFapPLV
        2+G09RnwDIc6Rtekbb7DM35NnM9iAM8srsFiud8o94I/Qv+FS98Ccaxk+7hi0xizFzOUkb68hiJ
        oRAkpJfpRaAXcDQ/o5fWDCp6d
X-Received: by 2002:a17:907:2cf1:b0:9ae:513d:de22 with SMTP id hz17-20020a1709072cf100b009ae513dde22mr1648385ejc.56.1696425245064;
        Wed, 04 Oct 2023 06:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC30AVKWCM9IrhyyL18ynsqE9iCne0MTdbHhx8Q+RGfk5sKrumzX45E7UuQGRJoR3t6l1Fjw==
X-Received: by 2002:a17:907:2cf1:b0:9ae:513d:de22 with SMTP id hz17-20020a1709072cf100b009ae513dde22mr1648367ejc.56.1696425244676;
        Wed, 04 Oct 2023 06:14:04 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906048300b009b2ca104988sm2824343eja.98.2023.10.04.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:14:04 -0700 (PDT)
Message-ID: <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 04 Oct 2023 16:14:01 +0300
In-Reply-To: <ZRsYNnYEEaY1gMo5@google.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
         <ZRsYNnYEEaY1gMo5@google.com>
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

У пн, 2023-10-02 у 12:21 -0700, Sean Christopherson пише:
> On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > Hi!
> > 
> > This patch allows AVIC's ICR emulation to be optional and thus allows
> > to workaround AVIC's errata #1235 by disabling this portion of the feature.
> > 
> > This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> > review feedback.
> 
> Please respond to my idea[*] instead of sending more patches. 

Hi,

For the v2 of the patch I was already on the fence if to do it this way or to refactor
the code, and back when I posted it, I decided still to avoid the refactoring.

However, your idea of rewriting this patch, while it does change less lines of code,
is even less obvious and consequently required you to write even longer comment to 
justify it which is not a good sign.

In particular I don't want someone to find out later, and in the hard way that sometimes
real physid table is accessed, and sometimes a fake copy of it is.

So I decided to fix the root cause by not reading the physid table back,
which made the code cleaner, and even with the workaround the code 
IMHO is still simpler than it was before.

About the added 'vcpu->loaded' variable, I added it also because it is something that is 
long overdue to be added, I remember that in IPIv code there was also a need for this, 
and probalby more places in KVM can be refactored to take advantage of it,
instead of various hacks.

I did adopt your idea of using 'enable_ipiv', although I am still not 100% sure that this
is more readable than 'avic_zen2_workaround'.

Best regards,
	Maxim Levitsky

>  I'm not opposed to
> a different approach, but we need to have an actual discussion around the pros and
> cons, and hopefully come to an agreement.  This cover letter doesn't even acknowledge
> that there is an alternative proposal, let alone justify why the vcpu->loaded
> approach was taken.
> 
> [*] https://lore.kernel.org/all/ZRYxPNeq1rnp-M0f@google.com
> 


