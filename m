Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE58098E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572968AbjLHB4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjLHBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F691FE9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702000546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0GlGocyqXMQn1E1f/sgzjFoxtiNjbFqYR2QABsm1pU=;
        b=BXKE7llGMAv4Q5oam3wF0zMKioelKCv6rAS1t4TY20dWayz1uG/meDnB5wFEPVgsLX3SFK
        kUw9JF456WASnJ/kL/nIWDno3W1ntEnAoKzYOQ9557UJ17PrljS/zQQZVhSy3OcbtN7k4A
        Ji8BK/82Zueg5vW8wrsg8QiYeOVQ2iM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-TebjmZGVN6ifQgtcoa-I8A-1; Thu,
 07 Dec 2023 20:55:43 -0500
X-MC-Unique: TebjmZGVN6ifQgtcoa-I8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C63D53806068;
        Fri,  8 Dec 2023 01:55:42 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 173841C060AF;
        Fri,  8 Dec 2023 01:55:41 +0000 (UTC)
Date:   Fri, 8 Dec 2023 09:55:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXJ3m4fPZXJnj29z@MiWiFi-R3L-srv>
References: <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
 <20231207121314.50b8e4c4@rotkaeppchen>
 <ZXGyANwELvFKpysH@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXGyANwELvFKpysH@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On 12/07/23 at 12:52pm, Michal Hocko wrote:
> On Thu 07-12-23 12:13:14, Philipp Rudo wrote:
> > On Thu, 7 Dec 2023 09:55:20 +0100
> > Michal Hocko <mhocko@suse.com> wrote:
> > 
> > > On Thu 07-12-23 12:23:13, Baoquan He wrote:
> > > [...]
> > > > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > > > it will be a venture.  
> > > 
> > > We can't guarantee this of course but AFAIK the DMA shouldn't take
> > > minutes, right? While not perfect, waiting for some time before jumping
> > > into the crash kernel should be acceptable from user POV and it should
> > > work around most of those potential lingering programmed DMA transfers.
> > 
> > I don't think that simply waiting is acceptable. For one it doesn't
> > guarantee that there is no corruption (please also see below) but only
> > reduces its probability. Furthermore, how long would you wait?
> 
> I would like to talk to storage experts to have some ballpark idea about
> worst case scenario but waiting for 1 minutes shouldn't terribly
> influence downtime and remember this is an opt-in feature. If that
> doesn't fit your use case, do not use it.
> 
> > Thing is that users don't only want to reduce the memory usage but also
> > the downtime of kdump. In the end I'm afraid that "simply waiting" will
> > make things unnecessarily more complex without really solving any issue.
> 
> I am not sure I see the added complexity. Something as simple as
> __crash_kexec:
> 	if (crashk_cma_cnt) 
> 		mdelay(TIMEOUT)
> 
> should do the trick.

I would say please don't do this. kdump jumping is a very quick
behavirou after corruption, usually in several seconds. I can't see any
meaningful stuff with the delay of one minute or several minutes. Most
importantly, the 1st kernel is in corruption which is a very
unpredictable state.
... 
> > Finally, let me question whether the whole approach actually solves
> > anything. For me the difficulty in determining the correct crashkernel
> > memory is only a symptom. The real problem is that most developers
> > don't expect their code to run outside their typical environment.
> > Especially not in an memory constraint environment like kdump. But that
> > problem won't be solved by throwing more memory at it as this
> > additional memory will eventually run out as well. In the end we are
> > back at the point where we are today but with more memory.
> 
> I disagree with you here. While the kernel is really willing to cache
> objects into memory I do not think that any particular subsystem is
> super eager to waste memory.
> 
> The thing we should keep in mind is that the memory sitting aside is not
> used in majority of time. Crashes (luckily/hopefully) do not happen very
> often. And I can really see why people are reluctant to waste it. Every
> MB of memory has an operational price tag on it. And let's just be
> really honest, a simple reboot without a crash dump is very likely
> a cheaper option than wasting a productive memory as long as the issue
> happens very seldom.

All the time, I have never heard people don't want to "waste" the
memory. E.g, for more than 90% of system on x86, 256M is enough. The
rare exceptions will be noted once recognized and documented in product
release.

And ,cma is not silver bullet, see this oom issue caused by i40e and its
fix , your crashkernel=1G,cma won't help either.

[v1,0/3] Reducing memory usage of i40e for kdump
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210304025543.334912-1-coxu@redhat.com/

======Abstrcted from above cover letter==========================
After reducing the allocation of tx/rx/arg/asq ring buffers to the
minimum, the memory consumption is significantly reduced,
    - x86_64: 85.1MB to 1.2MB 
    - POWER9: 15368.5MB to 20.8MB
==================================================================

And say more about it. This is not the first time of attempt to make use
of ,cma area for crashkernel=. In redhat, at least 5 people have tried
to add this, finally we gave up after long discussion and investigation.
This year, one kernel developer in our team raised this again with a
very long mail after his own analysis, we told him the discussion and
trying we have done in the past.

