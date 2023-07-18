Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572F757201
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGRCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGRCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:50:29 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F82E6C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:50:28 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DFE69C01B; Tue, 18 Jul 2023 04:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1689648626; bh=wJz99+njLvG/FzGn7fEs+yqA3KyAmCqTev3CP76dB6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feHVcwBFEQSWByWmwub9QVWLKu74iTPwORh5V65W+TxOWTqez2yiy3m/7DGWGsTIy
         wWTetBfROg7SqjfbuV1KdAQAFmYi3B4YdFfAGrOEjxj/O5N3ixwBa3Zj6NIfAW7kq+
         FKlP1rI8Y+WmDt4jSMHPIXwAamPnVXA45q26BTbD7vXAA73hK99sfbJy1bU1ALeT00
         5vnSvR1UylC++Qg022eAvv+oq94ToMzRwodJz9gzgpBmeW5scaQZm3EMYMwXHZrEEh
         LwzbycyVGH+KX95fHS0uubioPp8PPH3lP8p91zZsv5hvmKDN24E/A4gHq8q90eOTUZ
         QL7eG5o2cGadg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 31F16C01A;
        Tue, 18 Jul 2023 04:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1689648625; bh=wJz99+njLvG/FzGn7fEs+yqA3KyAmCqTev3CP76dB6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0k1QVCyqWppSXRu9b0CgGfUuScnAXyJ0K7Oxt93Xz7fQUi0U0P/9rQGJmmJcjByOA
         tWoDLJC9Xo+c2LL+CrP2ZbnDAFA6XYSegv4TNwieA8k6snaiyNQ7OsnWkJjBgCrv20
         RGxH1Sm8yI/4+dgDfRT8aTQCWFLJUeOi8DN68y8DJlUekxPV214+4xjSGgwKGkfqVd
         MJlR9KmYnQRoZOC3QdJdeYKHsLS6junNuHRhlwrxgmu1G04XF/951OEwfAIdPwOPW2
         iDwFesWkIgqgTLv/duKZEkg19ktJU3fDWRYwicZasUq+uIOfY8cXvXu5QfhtYVW9B3
         Qt9OJb0C358ng==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id cd499b91;
        Tue, 18 Jul 2023 02:50:20 +0000 (UTC)
Date:   Tue, 18 Jul 2023 11:50:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 3/3] fs/9p: fix type mismatch in file cache mode helper
Message-ID: <ZLX93Z81efpEWjaa@codewreck.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote on Mon, Jul 17, 2023 at 04:29:02PM +0000:
> There were two flags which had incorrect type in the
> paramaters of the file cache mode helper function.

Checked the parameters passed (v9ses->cache, file->f_flags and a flags
parent function parameters) were all correctly unsigned:

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 297c2c377e3dd..29281b7c38870 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>   * NOTE: these are set after open so only reflect 9p client not
>   * underlying file system on server.
>   */
> -static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
> -	int s_cache, unsigned int f_flags)
> +static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
> +	unsigned int s_cache, unsigned int f_flags)
>  {
>  	if (fid->qid.type != P9_QTFILE)
>  		return;
> 

-- 
Dominique Martinet | Asmadeus
