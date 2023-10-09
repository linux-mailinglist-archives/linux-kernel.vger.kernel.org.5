Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB87BDE3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376734AbjJINR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376966AbjJINRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:17:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67688F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:17:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25774C433C7;
        Mon,  9 Oct 2023 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696857443;
        bh=fb9+S+IdbqXmmVRZq9TTSPJ4lFpZS+G3qg2LrBeKI90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUk7j7g8cl6hCmae1KMe30hi13L17mfcIS9n6OseiyZ7CxMUtL+E645vsFKUsr8Be
         cLyzMwOsvtEIHwZkfLsK2ADlxSNMF8dI0Yi/90po45aTe3Qi1762zcaVmZzLPdg+Cj
         IBEQ9zNXeCIQCXJco201EXDXx+L/Y26We6Ch0JYlKfitDaHKZu/RQ/C3AL9XqVr2+8
         C6RHCjqVCxyLoDfAP3ZqsjtBXvGgCxLKP0VU0jaT3SgJRDWZ1ppdUJwx+uNrl4dcO2
         UJJV5ncECfeKdvVF7PxsJP4gYiefZ3x40jPvDjGWrNJ3u0Jd4WH8/fCwC/eE+xjqiq
         PJbnfcKFMKgFQ==
Date:   Mon, 9 Oct 2023 15:17:18 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] staging: qlge: Replace strncpy with strscpy
Message-ID: <ZSP9XspeNznHzlA6@kernel.org>
References: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:12:24PM +0100, Ricardo Lopes wrote:
> Reported by checkpatch:
> 
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy
> 
> Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>
> ---
> v2: Redo changelog text

Kees,

could you find a moment to look over this one?

> 
>  drivers/staging/qlge/qlge_dbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> index c7e865f51..5f08a8492 100644
> --- a/drivers/staging/qlge/qlge_dbg.c
> +++ b/drivers/staging/qlge/qlge_dbg.c
> @@ -696,7 +696,7 @@ static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *s
>  	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
>  	seg_hdr->seg_num = seg_number;
>  	seg_hdr->seg_size = seg_size;
> -	strncpy(seg_hdr->description, desc, (sizeof(seg_hdr->description)) - 1);
> +	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
>  }
>  
>  /*
> @@ -737,7 +737,7 @@ int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_core
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_mpi_coredump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>  
>  	/* Get generic NIC reg dump */
> @@ -1225,7 +1225,7 @@ static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_reg_dump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>  
>  	/* segment 16 */
> -- 
> 2.41.0
> 
> 
