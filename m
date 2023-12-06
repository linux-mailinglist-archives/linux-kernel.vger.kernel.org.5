Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58C806D69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378019AbjLFLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377909AbjLFLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115DD41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701860893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hu1oMLC/dT4Tav3HkAUGVB3bgKWopFUqSwZfN78dtKE=;
        b=GlxHaNYwE0rZVinOq0tI177unDvs8zkpdeWqoK7EEEgGj5+NpCX2830bQv/InTsCP8XmLz
        7uB7zVuVsxGt5teKigVkbfNrJTJ7XOcQRL1lVgadGwlT0gPqk1SZT7hjgImUYeSvSuIm6b
        8svm4Y1W1hTW/hnUsQkWdq699yFq8Ao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-U9vYq7uOPp-pKHmUesEtRw-1; Wed, 06 Dec 2023 06:08:10 -0500
X-MC-Unique: U9vYq7uOPp-pKHmUesEtRw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4F80185A780;
        Wed,  6 Dec 2023 11:08:09 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A415492BC6;
        Wed,  6 Dec 2023 11:08:08 +0000 (UTC)
Date:   Wed, 6 Dec 2023 12:08:05 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231206120805.4fdcb8ab@rotkaeppchen>
In-Reply-To: <ZWoQ1k2AikSiMjys@tiehlicka>
References: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Fri, 1 Dec 2023 17:59:02 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Fri 01-12-23 16:51:13, Philipp Rudo wrote:
> > On Fri, 1 Dec 2023 12:55:52 +0100
> > Michal Hocko <mhocko@suse.com> wrote:
> >   
> > > On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
> > > [...]  
> > > > And yes, those are all what-if concerns but unfortunately that is all
> > > > we have right now.    
> > > 
> > > Should theoretical concerns without an actual evidence (e.g. multiple
> > > drivers known to be broken) become a roadblock for this otherwise useful
> > > feature?   
> > 
> > Those concerns aren't just theoretical. They are experiences we have
> > from a related feature that suffers exactly the same problem regularly
> > which wouldn't exist if everybody would simply work "properly".  
> 
> What is the related feature?

kexec

> > And yes, even purely theoretical concerns can become a roadblock for a
> > feature when the cost of those theoretical concerns exceed the benefit
> > of the feature. The thing is that bugs will be reported against kexec.
> > So _we_ need to figure out which of the shitty drivers caused the
> > problem. That puts additional burden on _us_. What we are trying to
> > evaluate at the moment is if the benefit outweighs the extra burden
> > with the information we have at the moment.  
> 
> I do understand your concerns! But I am pretty sure you do realize that
> it is really hard to argue theoreticals.  Let me restate what I consider
> facts. Hopefully we can agree on these points
> 	- the CMA region can be used by user space memory which is a
> 	  great advantage because the memory is not wasted and our
> 	  experience has shown that users do care about this a lot. We
> 	  _know_ that pressure on making those reservations smaller
> 	  results in a less reliable crashdump and more resources spent
> 	  on tuning and testing (especially after major upgrades).  A
> 	  larger reservation which is not completely wasted for the
> 	  normal runtime is addressing that concern.
> 	- There is no other known mechanism to achieve the reusability
> 	  of the crash kernel memory to stop the wastage without much
> 	  more intrusive code/api impact (e.g. a separate zone or
> 	  dedicated interface to prevent any hazardous usage like RDMA).
> 	- implementation wise the patch has a very small footprint. It
> 	  is using an existing infrastructure (CMA) and it adds a
> 	  minimal hooking into crashkernel configuration.
> 	- The only identified risk so far is RDMA acting on this memory
> 	  without using proper pinning interface. If it helps to have a
> 	  statement from RDMA maintainers/developers then we can pull
> 	  them in for a further discussion of course.
> 	- The feature requires an explicit opt-in so this doesn't bring
> 	  any new risk to existing crash kernel users until they decide
> 	  to use it. AFAIU there is no way to tell that the crash kernel
> 	  memory used to be CMA based in the primary kernel. If you
> 	  believe that having that information available for
> 	  debugability would help then I believe this shouldn't be hard
> 	  to add.  I think it would even make sense to mark this feature
> 	  experimental to make it clear to users that this needs some
> 	  time before it can be marked production ready.
> 
> I hope I haven't really missed anything important. The final

If I understand Documentation/core-api/pin_user_pages.rst correctly you
missed case 1 Direct IO. In that case "short term" DMA is allowed for
pages without FOLL_LONGTERM. Meaning that there is a way you can
corrupt the CMA and with that the crash kernel after the production
kernel has panicked.

With that I don't see a chance this series can be included unless
someone can explain me that that the documentation is wrong or I
understood it wrong.

Having that said
NAcked-by: Philipp Rudo <prudo@redhat.com>

> cost/benefit judgment is up to you, maintainers, of course but I would
> like to remind that we are dealing with a _real_ problem that many
> production systems are struggling with and that we don't really have any
> other solution available.

