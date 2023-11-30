Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17B7FE748
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjK3Cmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjK3Cmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD01FEF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701312141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlnSo+MSVJ02cRZKA4QKHS15/hcZAeTG8jw5g53iRBQ=;
        b=eI1j77Y5sjEtITGstFSkNxSa/AiGbCAocyrOIrYPNaR1gRZ2g5/LXflNwaToicxW9Sbgwy
        EGTX/TCFwhCIMHLEwruiJnbeGyuhpm8cCEWgcyWGmSZrUN6/YrYSSSXMMfv+CbW4wfX2bh
        VoWTpOyx4gPWw7JJD/3rsVHn6WmbDOo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-57Xl6FtdMtiy8EYMFLhbpQ-1; Wed,
 29 Nov 2023 21:42:17 -0500
X-MC-Unique: 57Xl6FtdMtiy8EYMFLhbpQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A8722815E20;
        Thu, 30 Nov 2023 02:42:17 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A36F8492BFE;
        Thu, 30 Nov 2023 02:42:16 +0000 (UTC)
Date:   Thu, 30 Nov 2023 10:42:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWf2hdX9L8SZhvzB@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
 <ZWcDiHNCJDNfCbaq@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcDiHNCJDNfCbaq@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On 11/29/23 at 10:25am, Michal Hocko wrote:
> On Wed 29-11-23 15:57:59, Baoquan He wrote:
> [...]
> > Hmm, Redhat could go in a different way. We have been trying to:
> > 1) customize initrd for kdump kernel specifically, e.g exclude unneeded
> > devices's driver to save memory;
> > 2) monitor device and kenrel memory usage if they begin to consume much
> > more memory than before. We have CI testing cases to watch this. We ever
> > found one NIC even eat up GB level memory, then this need be
> > investigated and fixed.
> 
> How do you simulate all different HW configuration setups that are using
> out there in the wild?

We don't simulate.

We do this with best effort with existing systems in our LAB. And
meantime partner company will test and report any OOM if they encounter.

