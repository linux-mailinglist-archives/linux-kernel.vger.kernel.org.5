Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D788792663
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbjIEQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353893AbjIEIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:33:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF53CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:33:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30B4E68AA6; Tue,  5 Sep 2023 10:33:09 +0200 (CEST)
Date:   Tue, 5 Sep 2023 10:33:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Message-ID: <20230905083308.GA20920@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-2-dwagner@suse.de> <20230905064846.GA19701@lst.de> <77nt3zr7rap6w7bpvm6vfdqqf4xc46afq4tzlifsn3zlry5wvh@t2e6orslw6on>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77nt3zr7rap6w7bpvm6vfdqqf4xc46afq4tzlifsn3zlry5wvh@t2e6orslw6on>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:24:51AM +0200, Daniel Wagner wrote:
> On Tue, Sep 05, 2023 at 08:48:46AM +0200, Christoph Hellwig wrote:
> > > +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
> > >  {
> > > -	return req->sq->ctrl;
> > > +	if (!req->sq || !req->sq->ctrl)
> > > +		return 0;
> > > +	return req->sq->ctrl->cntlid;
> > 
> > Can you add a comment here why we have this check?
> 
> /*
>  * The queue and controller pointer are not valid until an
>  * association has been established.
>  */

sounds good.
