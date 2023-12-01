Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ADE8009F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378568AbjLALd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30E0FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701430442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYm7DltZI4+AHPUZ5dfoYGeOZ9qcY4lfHZBKyjjZBuk=;
        b=SRX5i8wQOZdKo4jzIi+geUungBoxar+Og8BkhHlK2Q/0IeI9Xdy5GQzWTX42tik6dsDQrj
        h/5A6NAE/kCucB/gqF+Lgmti9O5IVlBDLX4cIZQ7qxv1TRQYR7YB9LB47D8Cvt9G6ADpQe
        lHj6A7kBIoKtVOER/l0BF0PO5pafBFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-FiU4OtBFP0mrsBgN-gL4uw-1; Fri, 01 Dec 2023 06:33:58 -0500
X-MC-Unique: FiU4OtBFP0mrsBgN-gL4uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72547101A529;
        Fri,  1 Dec 2023 11:33:58 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 111391121307;
        Fri,  1 Dec 2023 11:33:56 +0000 (UTC)
Date:   Fri, 1 Dec 2023 12:33:53 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231201123353.2b3db7fa@rotkaeppchen>
In-Reply-To: <ZWiQ-II9CvGv8EWK@tiehlicka>
References: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
        <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
        <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
        <ZWWuBSiZZdF2W12j@tiehlicka>
        <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
        <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
        <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
        <ZWhg_b3O6piZtkQ-@tiehlicka>
        <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
        <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
        <ZWiQ-II9CvGv8EWK@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, 30 Nov 2023 14:41:12 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Thu 30-11-23 20:31:44, Baoquan He wrote:
> [...]
> > > > which doesn't use the proper pinning API (which would migrate away from
> > > > the CMA) then what is the worst case? We will get crash kernel corrupted
> > > > potentially and fail to take a proper kernel crash, right? Is this
> > > > worrisome? Yes. Is it a real roadblock? I do not think so. The problem  
> > 
> > We may fail to take a proper kernel crash, why isn't it a roadblock?  
> 
> It would be if the threat was practical. So far I only see very
> theoretical what-if concerns. And I do not mean to downplay those at
> all. As already explained proper CMA users shouldn't ever leak out any
> writes across kernel reboot.

You are right, "proper" CMA users don't do that. But "proper" drivers
also provide a working shutdown() method. Experience shows that there
are enough shitty drivers out there without working shutdown(). So I
think it is naive to assume you are only dealing with "proper" CMA
users.

For me the question is, what is less painful? Hunting down shitty
(potentially out of tree) drivers that cause a memory corruption? Or ...

> > We
> > have stable way with a little more memory, why would we take risk to
> > take another way, just for saving memory? Usually only high end server
> > needs the big memory for crashkernel and the big end server usually have
> > huge system ram. The big memory will be a very small percentage relative
> > to huge system RAM.  
> 
> Jiri will likely talk more specific about that but our experience tells
> that proper crashkernel memory scaling has turned out a real
> maintainability problem because existing setups tend to break with major
> kernel version upgrades or non trivial changes.

... frequently test if the crashkernel memory is still appropriate? The
big advantage of the latter I see is that an OOM situation has very
easy to detect and debug. A memory corruption isn't. Especially when
it was triggered by an other kernel.

And yes, those are all what-if concerns but unfortunately that is all
we have right now. Only alternative would be to run extended tests in
the field. Which means this user facing change needs to be included.
Which also means that we are stuck with it as once a user facing change
is in it's extremely hard to get rid of it again...

Thanks
Philipp

> > > > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > > > is the said theoretical driver that needs fixing anyway.  
> > 
> > Now, what we want to make clear is if it's a theoretical possibility, or
> > very likely happen. We have met several on-flight DMA stomping into
> > kexec kernel's initrd in the past two years because device driver didn't
> > provide shutdown() methor properly. For kdump, once it happen, the pain
> > is we don't know how to debug. For kexec reboot, customer allows to
> > login their system to reproduce and figure out the stomping. For kdump,
> > the system corruption rarely happend, and the stomping could rarely
> > happen too.  
> 
> yes, this is understood.
>  
> > The code change looks simple and the benefit is very attractive. I
> > surely like it if finally people confirm there's no risk. As I said, we
> > can't afford to take the risk if it possibly happen. But I don't object
> > if other people would rather take risk, we can let it land in kernel.  
> 
> I think it is fair to be cautious and I wouldn't impose the new method
> as a default. Only time can tell how safe this really is. It is hard to
> protect agains theoretical issues though. Bugs should be fixed.
> I believe this option would allow to configure kdump much easier and
> less fragile.
>  
> > My personal opinion, thanks for sharing your thought.  
> 
> Thanks for sharing.
> 

