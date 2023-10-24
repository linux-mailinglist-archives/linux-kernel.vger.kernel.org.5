Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D177D562A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjJXPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjJXPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:25:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F34ECA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:22:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1EEC433AB;
        Tue, 24 Oct 2023 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160946;
        bh=yP/m5o/N2xjmFltBU342MA71mpnmokk3pCJv5uGnXGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBysLWeDFStlnjEQdvf9qACHZxYBYU3Xu/6xqUFCu6Ju1a3WZKBvjxtFbJsq5Vmgn
         xqDcyOxjS0loDAGl8TaGTgRizdvsc5P7ntlxJraiRoah1MqXWgjzH24sIt0hlSI3Uo
         fShS2I4QG2TU+qXEn5+bzlch00CmvKT/PgyHhE/fFE5eTi5uvfBOeXcB2gERwB2XNG
         jOvmAyzd37nYMoxQtyLt+7uH45luxJVr71LKB1F6GHlxPnn+cTZJIEOQHnnTIS9/DG
         q3o9ZAVyYumqwGkS4g4HDC/2DGjLSk12BJ47pcvpYzI+yJLVReLFrIK/Hrs0fXGZHv
         fzi+QtOt50LBw==
Date:   Tue, 24 Oct 2023 09:22:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <ZTfhLxXIMzdptS8E@kbusch-mbp>
References: <20231013163420.3097-1-dwagner@suse.de>
 <9c9ee261-6d44-4193-917d-a513865e7181@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9ee261-6d44-4193-917d-a513865e7181@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:21:45AM +0000, Chaitanya Kulkarni wrote:
> On 10/13/23 09:34, Daniel Wagner wrote:
> > The firmware version sysfs entry needs to be updated after a successfully
> > firmware activation.
> >
> > nvme-cli stopped issuing an Identify Controller command to list the
> > current firmware information and relies on sysfs showing the current
> > firmware version.
> >
> >
> 
> why did nvme-cli stopped using id-ctrl ?

We have exported attributes. We should be able to use them so that we're
not interrupting the device to provide info that the driver already
caches. The driver just needs to make sure the contents are reliable.
