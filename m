Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B57FC17C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbjK1QTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjK1QTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:19:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326FD66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:19:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CD0C433C7;
        Tue, 28 Nov 2023 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701188346;
        bh=0Ag4qaJaVJYeZsmD/Ziq5NjmMiyUyZLsJEveoMz3LW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAYeXIcJISUhsgXkvRPJciIHAtJiy3JURj2WtelWdRE52/+33R7yA289mOzSTFPpQ
         rwvSp+PNfOUOBQH1Ul7Wq1jJD8+OUCi5IgdB99002hA2VEMI461EJ2V1gIkysFpu7N
         RN3Cf+ilnB3KDSbC3/FaJDuxPCLYlXHUqx26VNbazKoqVS66CESKEjBCMq9aE6UcyS
         jnrgswmoFSERvHBfI0edS+Js8eB/OusESfzc2lAjul9+/Vs2DD0TrnfSTAUaVMWRlr
         mKuXnagpjChGo5xeaRCgDhalBQ+0P1TRId5VxBUD9yZLQTTYvJfZ8lRIYJIrVLVAzO
         wQFQHbq2qH0ng==
Date:   Tue, 28 Nov 2023 08:19:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 1/2] xfs: ensure tmp_logflags is initialized in
 xfs_bmap_del_extent_real
Message-ID: <20231128161905.GT2766956@frogsfrogsfrogs>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-2-zhangjiachen.jaycee@bytedance.com>
 <ZWWii6HhlfkWXSq8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWWii6HhlfkWXSq8@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:19:23AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 28, 2023 at 01:32:01PM +0800, Jiachen Zhang wrote:
> > In the case of returning -ENOSPC, ensure tmp_logflags is initialized by 0.
> > Otherwise the caller __xfs_bunmapi will set uninitialized illegal
> > tmp_logflags value into xfs log, which might cause unpredictable error
> > in the log recovery procedure.
> 
> This looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But I wonder if removing the local flags variable and always directly
> assigning to *logflagsp might be more robust in the long run.

Yes, I think it's better to eliminate opportunities for subtle logic
bombs by not open-coding variable aliasing.  Perhaps this function
should set *logflagsp = 0 at the start of the function so that we don't
have to deal with uninitialized outparams, especially since the caller
uses it even on an error return.

--D
