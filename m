Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E979E761
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjIML6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbjIML6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:58:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283891996
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:58:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC877218E3;
        Wed, 13 Sep 2023 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694606320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw7VrG1wDiIT9Y0JnImTHxBRJ2Bt8wke3di/er57Oyk=;
        b=rrRJ5Wwycc/qfyFFS7rpx6l8AM9MmEFFLEKwB1N11nCDaUYb6PQGnFw+5qp7I6dpFJ+qJp
        12SpqKJB2OZh2jHu1ZzQWM4VtBIvFx4UveWSMNfVARmP2jRhM6oynspuOipGTs+EmWfPfL
        E2qdJnCKU08HxZgWeiGuPfetumgeEfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694606320;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw7VrG1wDiIT9Y0JnImTHxBRJ2Bt8wke3di/er57Oyk=;
        b=QC90yT4DjDa3rPfezZsWpPsgjo2Azp8/Vdk/viCDvJRM5xa3G2QFpd92QizVz58tNHJ6gB
        BzuzlKaSgg7FuYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D225F13582;
        Wed, 13 Sep 2023 11:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ABUYM/CjAWVpFgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 13 Sep 2023 11:58:40 +0000
Date:   Wed, 13 Sep 2023 13:59:18 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <nnvprosph2h6ydtl2fcsseppgyrlju2bnc76lxmgcd6cbk62fo@vmdgzstnn2pz>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
 <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
 <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
 <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
 <20230913113519.GA1565@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913113519.GA1565@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:35:19PM +0200, Christoph Hellwig wrote:
> So that's interesting.  But what I'm mostly worried about is how the
> nvmet kernel code allows a request without ->port to progress to the
> actual command handler.

nvmet_fc_handle_fcp_rqst()

	if (tgtport->pe)
		fod->req.port = tgtport->pe->port;

Not sure why this is there. Will test what happens when we just return
an error when we don't have pe set.

> We should never allow a command to get that
> far if ->port is NULL, and should not allow to clear ->port while
> commands are still handled.

Okay, makes sense. I'll test this when I have access to my rig again tomorrow.
