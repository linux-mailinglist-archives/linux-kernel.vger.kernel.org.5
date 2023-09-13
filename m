Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29A79E6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjIMLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbjIMLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:35:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA51BC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:35:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E551D68AA6; Wed, 13 Sep 2023 13:35:19 +0200 (CEST)
Date:   Wed, 13 Sep 2023 13:35:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, g@flourine.lan,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <20230913113519.GA1565@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-5-dwagner@suse.de> <20230905065032.GC19701@lst.de> <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to> <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw> <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe> <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that's interesting.  But what I'm mostly worried about is how the
nvmet kernel code allows a request without ->port to progress to the
actual command handler.  We should never allow a command to get that
far if ->port is NULL, and should not allow to clear ->port while
commands are still handled.

