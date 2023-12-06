Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F39806D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377978AbjLFLDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378064AbjLFLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729F2D63
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701860438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7/oZHACPeEsD+mXYOiqtdmGuUQoOrWauvnLhXLrRq8s=;
        b=PEE8dH+xb7msAX+mcpANgp/0SAH3vPMVP7PzZCj36ge8GCG3rMaIePDWPZObU2hPfarpKM
        UODwqxYdP3XTjUUvW+kMYGIXR7GcsVyMRCnBvT11O1StmzAoGUUccDpn7Zf3cmEcUPWwPR
        NUzDfVfWbsQc8QbnT2WOav4jWvceRvo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-KyLGvAs-PLqcDVG0tjPYzQ-1; Wed,
 06 Dec 2023 06:00:34 -0500
X-MC-Unique: KyLGvAs-PLqcDVG0tjPYzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 494E529ABA20;
        Wed,  6 Dec 2023 11:00:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4DAE40C6E2C;
        Wed,  6 Dec 2023 11:00:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     fstests@vger.kernel.org, samba-technical@lists.samba.org,
        linux-cifs@vger.kernel.org
cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Dave Chinner <david@fromorbit.com>,
        Filipe Manana <fdmanana@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Issues with FIEMAP, xfstests, Samba, ksmbd and CIFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <447323.1701860432.1@warthog.procyon.org.uk>
Date:   Wed, 06 Dec 2023 11:00:32 +0000
Message-ID: <447324.1701860432@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been debugging apparent cifs failures with xfstests, in particular
generic/009, and I'm finding that the tests are failing because FIEMAP is not
returning exactly the expected extent map.

The problem is that the FSCTL_QUERY_ALLOCATED_RANGES smb RPC op can only
return a list of ranges that are allocated and does not return any other
information about those allocations or the gaps between them - and thus FIEMAP
cannot express this information to the extent that the test expects.

Further, as Steve also observed, the expectation that the individual subtests
should return exactly those ranges is flawed.  The filesystem is at liberty to
split extents, round up extents, bridge extents and automatically punch out
blocks of zeros.  xfstests/common/punch allows for some of this, but I wonder
if it needs to be more fuzzy.

I wonder if the best xfstests can be expected to check is that the data we
have written is within the allocated regions.

Which brings me on to FALLOC_FL_ZERO_RANGE - is this guaranteed to result in
an allocated region (if successful)?  Samba is translating FSCTL_SET_ZERO_DATA
to FALLOC_FL_PUNCH_HOLE, as is ksmbd, and then there is no allocated range to
report back (Samba and ksmbd use SEEK_HOLE/SEEK_DATA rather than FIEMAP -
would a ZERO_RANGE even show up with that?).

Finally, should the Linux cifs filesystem translate gaps in the result of
FSCTL_QUERY_ALLOCATED_RANGES into 'unwritten' extents rather than leaving them
as gaps in the list (to be reported as holes by xfs_io)?  This smacks a bit of
adjusting things for the sake of making the testsuite work when the testsuite
isn't quite compatible with the thing being tested.

So:

 - Should Samba and ksmbd be using FALLOC_FL_ZERO_RANGE rather than
   PUNCH_HOLE?

 - Should Samba and ksmbd be using FIEMAP rather than SEEK_DATA/HOLE?

 - Should xfstests be less exacting in its FIEMAP analysis - or should this be
   skipped for cifs?  I don't want to skip generic/009 as it checks some
   corner cases that need testing, but it may not be possible to make the
   exact extent matching work.

Thanks,
David


