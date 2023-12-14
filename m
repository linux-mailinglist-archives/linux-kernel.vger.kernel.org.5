Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4D8131FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444227AbjLNNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjLNNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19918CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702561585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMlqSzMLtoLhUA6/pSOLSiY6ne++uxerHVPAdydtEYo=;
        b=fiMUfyUKsp+4F4PwDfNafkGuWkOhKDQgsDaxSWV1T4pwNaEh80ZKoYOr1t5Lm3+aw/qMR2
        PUGDmH4jxQ4taFMlgw0YIliQAFl3visG0B52dv6fkRmiLYHqzvAoUbSMyat/gKaI/dZLEj
        n4BMrK5EjsktaGE4rq7TDZL1ndheCs8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-Yr6iln9QPreJK0NkIMKRvw-1; Thu,
 14 Dec 2023 08:46:21 -0500
X-MC-Unique: Yr6iln9QPreJK0NkIMKRvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 514D328040B2;
        Thu, 14 Dec 2023 13:46:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 006DAC15968;
        Thu, 14 Dec 2023 13:46:08 +0000 (UTC)
Date:   Thu, 14 Dec 2023 21:46:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, jaswin@linux.ibm.com,
        bvanassche@acm.org, Himanshu Madhani <himanshu.madhani@oracle.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <ZXsHHA/GeO8PUeaA@fedora>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-2-john.g.garry@oracle.com>
 <ZXkIEnQld577uHqu@fedora>
 <36ee54b4-b8d5-4b3c-81a0-cc824b6ef68e@oracle.com>
 <ZXmjdnIqGHILTfQN@fedora>
 <yq1cyv9flkw.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1cyv9flkw.fsf@ca-mkp.ca.oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, Dec 13, 2023 at 11:38:10PM -0500, Martin K. Petersen wrote:
> 
> Ming,

On Thu, Dec 14, 2023 at 12:35 PM Martin K. Petersen <martin.petersen@oracle.com> wrote:
>
>
> Hi Ming!
>
> >> +    lim->atomic_write_unit_min_sectors = 0;
> >> +    lim->atomic_write_unit_max_sectors = 0;
> >> +    lim->atomic_write_max_sectors = 0;
> >> +    lim->atomic_write_boundary_sectors = 0;
> >
> > Can we move the four into single structure and setup them in single
> > API? Then cross-validation can be done in this API.
>
> Why would we put them in a separate struct? We don't do that for any of
> the other queue_limits.

All the four limits are for same purpose of supporting atomic-write, and
there can many benefits to define single API to setup atomic parameters:

1) common logic can be put into single place, such as running
cross-validation among them and setting up default value, and it is impossible
to do that by the way in this patch

2) all limits are supposed to setup once by driver in same place, so
doing them in single API actually simplifies driver and block layer, and
API itself becomes less fragile

3) it is easier for trace or troubleshoot

> 
> > Relying on driver to provide sound value is absolutely bad design from
> > API viewpoint.
> 
> All the other queue_limits are validated by the LLDs. It's challenging
> to lift that validation to the block layer since the values reported are
> heavily protocol-dependent and

After atomic limits are put into block layer, it becomes not driver
specific any more, scsi and nvme are going to support it first, sooner
or later, other drivers(dm & md, loop or ublk, ...) may try to support it.

Also in theory, they are not protocol-dependent, usually physical block size is
the minimized atomic-write unit, now John's patches are trying to support
bigger atomic-write unit as scsi/nvme's protocol supports it, and the concept
is actually common in disk. Similar in implementation level too, such as,
for NAND flash based storage, I guess atomic-write should be supported by atomic
update of FTL's LBA/PBA mapping.

> thus information is lost if we do it somewhere else.

Block layer is only focusing on common logic, such as the four limits
added in request queue, which are consumed by block layer and related with
other generic limits(physical block size, max IO size), and it won't be
same with driver's internal validation.


Thanks,
Ming

