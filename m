Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7467F29EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKUKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjKUKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63572A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700561726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eaq+2OyV91s1t6M0bC5vk0Dtry8ozGJ14NR0RM+C2uI=;
        b=isfJkb/MWVDZtRnnyI7CHOAfG9CIoPIgQ0D9QmnnC///KXg4SfTQ+zuq4i6AeLx5vhemQP
        BLjEDgs9ZkqqLCRhXW7kSWROY63JoHUakmenCEo/B9vUMRHQB/tAjoHkCTHb7SLpncEQa2
        zVJN0oXmZWPiFNOE3bKBNrVhIHB5ZQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-O-CmAiTLNsq8Y_QdiHiwyg-1; Tue, 21 Nov 2023 05:15:18 -0500
X-MC-Unique: O-CmAiTLNsq8Y_QdiHiwyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC45884B105;
        Tue, 21 Nov 2023 10:15:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16281492BFA;
        Tue, 21 Nov 2023 10:15:16 +0000 (UTC)
Date:   Tue, 21 Nov 2023 18:15:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ltao@redhat.com,
        Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <ZVyDMTrbPwe/0yRd@MiWiFi-R3L-srv>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On 11/21/23 at 11:43am, Kirill A. Shutemov wrote:
> On Tue, Nov 21, 2023 at 02:41:08PM +0800, Baoquan He wrote:
> > > > 
> > > > Still failed. And I found the normal reboot does't work either. I will
> > > > do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
> > > > config and rebuild, and update host kernel too.
> > 
> > I did more tests, resuls are summarized as below: 
> > 
> > 1) kexec reboot works, but always fallback to 1 cpu even though multiple
> > cpus are specified;
> 
> That's expected. Until you have new BIOS. See below.
> 
> > 2) kdump kernel need more crashkernel memory to boot up,
> >    crashkernel=512M works well in our case.
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
> > My colleague Tao helped to double check this, he got the same testing result.
> > Plesae 
> > 1) what can we do to enable the multiple cpu support for kexec reboot?
> 
> You would need a patched BIOS image. I've hacked one[1] for my testing.
> But it only works if kernel runs in 4-level paging mode (specify no5lvl in
> kernel command line).
> 
> BIOS folks work on proper patch, but it is not ready yet.
> 
> [1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332

Thanks a lot for explanations. Let's wait for it.

> 
> > 2) anything missing to allow makedumpfile/cp access 1st kernel's memory?
> 
> It worked before for us, but I have not checked for a while.
> 
> I expected you've dropped my "if (crash) return;" debug patch I asked you
> to tested before, right? If not, failure is expected.

Ah, my bad. I didn't actually.

Just now I rebuilt kernel and retested, vmcore saving works. Just when
it finished kdump work and tried to reboot, the rebooting failed because
cpus are not resettable like kexec reboot does. Not sure if this is seen
in your test.
> 
> > 3) not sure if this is particular case on the system we tested on.
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

