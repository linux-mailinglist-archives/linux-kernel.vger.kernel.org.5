Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF538061CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbjLEWhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbjLEWhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:37:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F4194
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:37:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E39C433C7;
        Tue,  5 Dec 2023 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701815860;
        bh=sREbz9DKSjqXuLOUL8jwggcX4KntV1Kh5sSgOifiQyE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=arznWVpT85zXKYCMx2p9VwmS5C5YWedRxPvFBC90LJYoCFk3NcqnIXTMZpgAbE0L1
         8wp7jgeiX6waz631/gRYN7zVbaDcPP8QwkjdU38PlAy+3VRuiNbfyvtXvGeKwHg+Og
         J25uOw2o1GNnMo7LZA0iKsqosECXODo0BStzoOOexxlzoKIBSvbC+/ez+urAlbyml0
         dWfY8OMyh2MnRrNJhF0XvPes4rJLKgirZ8+OVH7NzRvcJzKD7iCVUZWk81uihxoFlp
         jcInj9Lrxy1nNoWxu5wrMwGOVXtgG/GcCznWSH+uk9jczslHFcH18kayl6nld/vhtf
         vvjUsDOKrKJHA==
Date:   Tue, 5 Dec 2023 14:37:38 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Pry Mar <pryorm09@gmail.com>
Subject: Re: [PATCH] xen: update PV-device interface headers
In-Reply-To: <20231205115121.11627-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2312051437330.110490@ubuntu-linux-20-04-desktop>
References: <20231205115121.11627-1-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2023, Juergen Gross wrote:
> Update the Xen PV-device interface headers in order to avoid undefined
> behavior with flexible arrays being defined with one array element.
> 
> Reported-by: Pry Mar <pryorm09@gmail.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  include/xen/interface/io/displif.h | 2 +-
>  include/xen/interface/io/ring.h    | 2 +-
>  include/xen/interface/io/sndif.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/xen/interface/io/displif.h b/include/xen/interface/io/displif.h
> index 18417b017869..60e42d3b760e 100644
> --- a/include/xen/interface/io/displif.h
> +++ b/include/xen/interface/io/displif.h
> @@ -537,7 +537,7 @@ struct xendispl_dbuf_create_req {
>  
>  struct xendispl_page_directory {
>  	grant_ref_t gref_dir_next_page;
> -	grant_ref_t gref[1]; /* Variable length */
> +	grant_ref_t gref[];
>  };
>  
>  /*
> diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
> index ba4c4274b714..4fef1efcdcab 100644
> --- a/include/xen/interface/io/ring.h
> +++ b/include/xen/interface/io/ring.h
> @@ -95,7 +95,7 @@ struct __name##_sring {                                                 \
>      RING_IDX req_prod, req_event;                                       \
>      RING_IDX rsp_prod, rsp_event;                                       \
>      uint8_t __pad[48];                                                  \
> -    union __name##_sring_entry ring[1]; /* variable-length */           \
> +    union __name##_sring_entry ring[];                                  \
>  };                                                                      \
>                                                                          \
>  /* "Front" end's private variables */                                   \
> diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
> index 445657cdb1de..b818517588b5 100644
> --- a/include/xen/interface/io/sndif.h
> +++ b/include/xen/interface/io/sndif.h
> @@ -659,7 +659,7 @@ struct xensnd_open_req {
>  
>  struct xensnd_page_directory {
>  	grant_ref_t gref_dir_next_page;
> -	grant_ref_t gref[1]; /* Variable length */
> +	grant_ref_t gref[];
>  };
>  
>  /*
> -- 
> 2.35.3
> 
