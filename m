Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726217FB3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjK1ITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbjK1ITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:19:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E018D;
        Tue, 28 Nov 2023 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6P7w5SEBilFSlHhNw2KzHq6PLTIxmHl6RL+UUL/42O4=; b=QSsHW+cmFxrltLh/f9Lb0TdNQW
        XB3OQhlSlav/WP4TYeNIpcrr31tzYQwifoM59bijQl+S3EIRO4exXXa81GwpjXIQZ9m3PV9UBZ50F
        +3goC+gwiuixCxTD6YW8VOJtjLCRxfJG1KZO6k9FFyAd0FkS84JYPcwSiCrMfQ+zz3uyFWWXvDaYG
        toChNVC0eN9plO/QuqPh/DCV9fs8CYsNs6xpVQbH4LmChjO76dK/ZbHFZOxXusVG+kLlyo9WJ/Ylp
        S1kHVMBjGOkrUtZxPD7OJVSh5XKKYhYcIxlUBQqMfC2geJtiN8sM+CjS2dvhR9kfOH1k8iSh8ER7P
        Ga4zG69w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r7tJT-004W5m-1Z;
        Tue, 28 Nov 2023 08:19:23 +0000
Date:   Tue, 28 Nov 2023 00:19:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 1/2] xfs: ensure tmp_logflags is initialized in
 xfs_bmap_del_extent_real
Message-ID: <ZWWii6HhlfkWXSq8@infradead.org>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-2-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128053202.29007-2-zhangjiachen.jaycee@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:32:01PM +0800, Jiachen Zhang wrote:
> In the case of returning -ENOSPC, ensure tmp_logflags is initialized by 0.
> Otherwise the caller __xfs_bunmapi will set uninitialized illegal
> tmp_logflags value into xfs log, which might cause unpredictable error
> in the log recovery procedure.

This looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I wonder if removing the local flags variable and always directly
assigning to *logflagsp might be more robust in the long run.
