Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9CF7F2865
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjKUJKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A68E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700557840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8VqgPmAQ7EIQTV/xERi+bscdvu2asecBTlQhyi8tn8=;
        b=Me/MYWesMvAPQ4EXrw2ESgW6F8qtyQcH5dQGnOs9Zyobe2OwrgqJmSTVVkJAjb4W/a/QNn
        CO0eUUHPDwl7/UQOT2IfP+hnHfh5urCcUq2TVwrO9+Dh+IsN+qHORttsqK/a8dS6CIy60E
        XhxxXYxDuFpOctFBOUbwtjDyOBdwvd8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-CXoNiWknOUmDbWKqhEa7RQ-1; Tue, 21 Nov 2023 04:10:39 -0500
X-MC-Unique: CXoNiWknOUmDbWKqhEa7RQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a02d1c4adc9so8328566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700557838; x=1701162638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8VqgPmAQ7EIQTV/xERi+bscdvu2asecBTlQhyi8tn8=;
        b=WiFnatLrh+aK6gB+PLIKgBI8zwfnTFD5RJmWcABiCtt9boMcD/SWn59r6K3ibbGdvq
         0Z8wdbTFGuWJH1T7KHFKt0DdeFt0xpUfCq1QvfmmXo4pOtEeybEj/nH0yTtZKCMd46eH
         przSh9hkC3GKhXoOYvRq5q2rQJ6X89ekW00v1LjqZtiB8hHzZqfvjL9xYmwuuG+jO2At
         +JcpQfiOx8P2BwaaEl+M5IwvqLq/0z0KuXsMGhRdu6UaAdJqgJaToY0ernyClA1RfhWZ
         kT0W/yU924PQwd4GYOhbpYAB+uTUqBysBn8FV6vln3fCG27RKzop3kj/W2neUu2tkFQh
         Uqyg==
X-Gm-Message-State: AOJu0YxQWMzNzhjcQUjQq6Q3m/NqWoXEt7IrllWFDqNx6J2OVPr5S32Q
        JQtd0sH34O/AOWzEHDzWuL9PTvPtWM8YqjFQeRl822uKo9VREGL/60d94o55rYaslmko8zruK9K
        ++bQsMrGiHwYUj3V9Npr+UlTXDVTENt6JqJNdvBkH
X-Received: by 2002:a50:8d11:0:b0:548:4f16:ecfc with SMTP id s17-20020a508d11000000b005484f16ecfcmr1597922eds.0.1700557838113;
        Tue, 21 Nov 2023 01:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHVgvgj/1BJKpcUGeJXQN3MkvUneS3BEt5tns8r5WTn76N6o3GvUesVzThqilYiqkw7YjUG83i+KTKDSln3uA=
X-Received: by 2002:a50:8d11:0:b0:548:4f16:ecfc with SMTP id
 s17-20020a508d11000000b005484f16ecfcmr1597896eds.0.1700557837682; Tue, 21 Nov
 2023 01:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv> <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv> <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name> <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box> <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv> <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
In-Reply-To: <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
From:   Tao Liu <ltao@redhat.com>
Date:   Tue, 21 Nov 2023 17:10:01 +0800
Message-ID: <CAO7dBbWb2UWJRm1LLXOq7MM1K6BxDetL8tTmW93H589FGz8n9g@mail.gmail.com>
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Tue, Nov 21, 2023 at 4:43=E2=80=AFPM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Nov 21, 2023 at 02:41:08PM +0800, Baoquan He wrote:
> > > >
> > > > Still failed. And I found the normal reboot does't work either. I w=
ill
> > > > do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
> > > > config and rebuild, and update host kernel too.
> >
> > I did more tests, resuls are summarized as below:
> >
> > 1) kexec reboot works, but always fallback to 1 cpu even though multipl=
e
> > cpus are specified;
>
> That's expected. Until you have new BIOS. See below.
>
> > 2) kdump kernel need more crashkernel memory to boot up,
> >    crashkernel=3D512M works well in our case.
>
> I guess it is due to SWIOTLB memory which requres at least 64M.
>
> >  But it failed in vmcore
> >    saving process, either makedumpfile or cp can't access the 1st
> >    kernel's old memory;
>
> Will look into it.
>
> > 3) Normal reboot always failed;
>
> It is expected. TD vCPUs are not resettable. So we need to destroy TD and
> construct a new one to emulate "reboot".
>
> I guess we can try to add some glue on QEMU side to make reboot more
> seamless.
>
> > My colleague Tao helped to double check this, he got the same testing r=
esult.
> > Plesae
> > 1) what can we do to enable the multiple cpu support for kexec reboot?
>
> You would need a patched BIOS image. I've hacked one[1] for my testing.
> But it only works if kernel runs in 4-level paging mode (specify no5lvl i=
n
> kernel command line).
>
> BIOS folks work on proper patch, but it is not ready yet.
>
> [1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332
>
Thanks a lot for providing the BIOS patch. One more question, is the
patched BIOS image for the host physical machine or for the tdx guest
vm?

Thanks,
Tao Liu

> > 2) anything missing to allow makedumpfile/cp access 1st kernel's memory=
?
>
> It worked before for us, but I have not checked for a while.
>
> I expected you've dropped my "if (crash) return;" debug patch I asked you
> to tested before, right? If not, failure is expected.
>
> > 3) not sure if this is particular case on the system we tested on.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

