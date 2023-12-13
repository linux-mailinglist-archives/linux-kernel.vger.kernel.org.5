Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01126811893
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjLMQD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjLMQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:03:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C7BD;
        Wed, 13 Dec 2023 08:04:02 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BDB9E68B05; Wed, 13 Dec 2023 17:03:57 +0100 (CET)
Date:   Wed, 13 Dec 2023 17:03:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com,
        jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Message-ID: <20231213160357.GA9804@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212110844.19698-5-john.g.garry@oracle.com> <20231213-gurte-beeren-e71ff21c3c03@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-gurte-beeren-e71ff21c3c03@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 02:02:31PM +0100, Christian Brauner wrote:
> >  typedef unsigned int __bitwise gfp_t;
> >  typedef unsigned int __bitwise slab_flags_t;
> > -typedef unsigned int __bitwise fmode_t;
> > +typedef unsigned long __bitwise fmode_t;
> 
> As Jan said, that's likely a bad idea. There's a bunch of places that
> assume fmode_t is 32bit. So not really a change we want to make if we
> can avoid it.

Oh well, let me dust of my series to move the fairly static flags out
of it.  But even without that do we even need to increase it?  There's
still quite a lot of space after FMODE_EXEC for example.
