Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B879B1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbjIKVTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244398AbjIKUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:21:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B37E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:21:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F20C433C7;
        Mon, 11 Sep 2023 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694463685;
        bh=ifurHTfD/rz+WeSAjb0JVVNYuU1Cfmlv0GKMYTTrDJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbqPLTZ9LeNmAlmVzcYu36tyFIABx8PJv7gicVSRS0UoDC+4rWJItiASAHjYRxQYX
         mts0sxkgjGe7LbjxTyoB/Ejo+jjSBEpX5l+Y0hmVtWScremxmJFgSKGRwo9+lbjQqo
         lwOiXmCKHpugXKdCtMHrn1MlMmSRxcoJiZqFUy04p9xj/Bl8aVlZoJxbCxqbtUCnIr
         baWvj2BMlP+tF5HCsVdDiVcbmQEOWi7Lbhf5uI5Wgm5w+jKEyVgwiqoy3nL1J5tWZ0
         HbnO4rCvELbOjwidiFN9Iclxu+j/J8UjhB2Xxf7T3x0ykErySXK2zd3f4esbJXbTOp
         eNG3PfWvWF4fQ==
Date:   Mon, 11 Sep 2023 13:21:23 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Ameer Hamza <ahamza@ixsystems.com>, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, edmund.nadolski@ixsystems.com
Subject: Re: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Message-ID: <ZP92wmbIHpzZKEyZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230910212641.338438-1-ahamza@ixsystems.com>
 <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
 <2f1414ab-9152-17ab-d2c6-96f4f5de7d45@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1414ab-9152-17ab-d2c6-96f4f5de7d45@ixsystems.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:29:34PM -0400, Alexander Motin wrote:
> On 11.09.2023 14:40, Keith Busch wrote:
> > On Mon, Sep 11, 2023 at 02:26:41AM +0500, Ameer Hamza wrote:
> > > The 'id ctrl csi' command was introduced in version 2.0, as specified
> > > in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
> > > command on previous NVMe versions returns an "Invalid Field" error,
> > > and the error entry is saved in the log page. Although, Commit
> > > c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
> > > the error occurrences, but the error persisted during the initial
> > > module load. This patch ensures the command isn't executed on versions
> > > older than 2.0, and it also eliminates the skip implementation because
> > > NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.
> > 
> > NVMe TP's are allowed to be implemented by versions lower than the
> > release that first included it. I recall the first nvme controller I'd
> > seen that implemented this identification reported itself as 1.4.
> 
> Then there must be a way to detect it.  How otherwise it is not a standard
> violation to send arbitrary effectively vendor-specific commands to a drive?

For identification structures, you detect support for these by seeing if
the device responds with success or not.

Not sure what you mean by "standard violation". The standard defines
ways for the controller to respond when it receives an unrecognized
command.
