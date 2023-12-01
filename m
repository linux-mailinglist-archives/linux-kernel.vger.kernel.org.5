Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38A800F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjLAPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjLAPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC910EA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701445884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7QbH72MaN7zgPPC836wmmvKLt2x8/XmeGRsr2itGo8=;
        b=KInKMHyZfzCsfMjH40zUL857foxNMbO343os6pAGCM4u476wpiEjEaoOPfSb0tPTNPFv/I
        4J5Ghge2FZMJqmYR2ad6+CvxhLJQaQyAeXwrcgkLbtU3/Pu2N3cRusTDAUrWraHfKJgNsZ
        LJWnarE4YU/ZcriPO+AbNZmrDBpBJWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-fGVmDC1vNfGhqLF9iG1lZQ-1; Fri, 01 Dec 2023 10:51:20 -0500
X-MC-Unique: fGVmDC1vNfGhqLF9iG1lZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D5F3831524;
        Fri,  1 Dec 2023 15:51:17 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4787492BEF;
        Fri,  1 Dec 2023 15:51:15 +0000 (UTC)
Date:   Fri, 1 Dec 2023 16:51:13 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231201165113.43211a48@rotkaeppchen>
In-Reply-To: <ZWnJyArAmFo_uYPA@tiehlicka>
References: <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
        <ZWWuBSiZZdF2W12j@tiehlicka>
        <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
        <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
        <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
        <ZWhg_b3O6piZtkQ-@tiehlicka>
        <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
        <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
        <ZWiQ-II9CvGv8EWK@tiehlicka>
        <20231201123353.2b3db7fa@rotkaeppchen>
        <ZWnJyArAmFo_uYPA@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 12:55:52 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
> [...]
> > And yes, those are all what-if concerns but unfortunately that is all
> > we have right now.  
> 
> Should theoretical concerns without an actual evidence (e.g. multiple
> drivers known to be broken) become a roadblock for this otherwise useful
> feature? 

Those concerns aren't just theoretical. They are experiences we have
from a related feature that suffers exactly the same problem regularly
which wouldn't exist if everybody would simply work "properly".

And yes, even purely theoretical concerns can become a roadblock for a
feature when the cost of those theoretical concerns exceed the benefit
of the feature. The thing is that bugs will be reported against kexec.
So _we_ need to figure out which of the shitty drivers caused the
problem. That puts additional burden on _us_. What we are trying to
evaluate at the moment is if the benefit outweighs the extra burden
with the information we have at the moment.

> > Only alternative would be to run extended tests in
> > the field. Which means this user facing change needs to be included.
> > Which also means that we are stuck with it as once a user facing change
> > is in it's extremely hard to get rid of it again...  
> 
> I am not really sure I follow you here. Are you suggesting once
> crashkernel=cma is added it would become a user api and therefore
> impossible to get rid of?

Yes, sort of. I wouldn't rank a command line parameter as user api. So
we still can get rid of it. But there will be long discussions I'd like
to avoid if possible.

Thanks
Philipp

