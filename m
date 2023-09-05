Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F5792B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbjIEQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353865AbjIEIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:24:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C670CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:24:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E26EF211CE;
        Tue,  5 Sep 2023 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693902262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhetfFhOHSS+038oUbTRXF+UPsEC1zWgHiLgMmQPm+8=;
        b=jzMKCa2yYWLNbfwAIS2rBWTr9eS6/cnY90D+QVv1bapYAGptYG6dFSlVkSCyqum2Fxg+9l
        RJGb6RUbz2TMrm+X6LJmqT7nLS0/hGP4TfVtuhisMO7X2LhUcyVU6hobe+bDbjlzFeTdmX
        bBLPIgQroN27pkm0RSTwgKr4Jy3Cx3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693902262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhetfFhOHSS+038oUbTRXF+UPsEC1zWgHiLgMmQPm+8=;
        b=3T3MucQ0R/XLFrtX5Zkf4gscLBBxnJdjJqws7kMT00NNJjtBo+zucaz+kvAY0am9tDVcJQ
        2Jt2C9QLBnlpJlCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D52EC13499;
        Tue,  5 Sep 2023 08:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RkkENLbl9mSoDAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 05 Sep 2023 08:24:22 +0000
Date:   Tue, 5 Sep 2023 10:24:51 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Message-ID: <77nt3zr7rap6w7bpvm6vfdqqf4xc46afq4tzlifsn3zlry5wvh@t2e6orslw6on>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-2-dwagner@suse.de>
 <20230905064846.GA19701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905064846.GA19701@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:48:46AM +0200, Christoph Hellwig wrote:
> > +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
> >  {
> > -	return req->sq->ctrl;
> > +	if (!req->sq || !req->sq->ctrl)
> > +		return 0;
> > +	return req->sq->ctrl->cntlid;
> 
> Can you add a comment here why we have this check?

/*
 * The queue and controller pointer are not valid until an
 * association has been established.
 */

?
