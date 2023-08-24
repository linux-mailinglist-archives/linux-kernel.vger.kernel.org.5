Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843177865C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbjHXDQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbjHXDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:15:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3DC10E4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:15:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a7d7e5fb03so4576998b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692846947; x=1693451747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIvH/R6duOLq1ZSU+7s2c7YByvX3U6kHe3d3coChvNg=;
        b=gdmMxC+KDAJXIiPhugCWLoAfzLN9lDq5H5VhE4XLeOQlETCB9Xz5Y5ZQuPic3ma2OD
         GsRiWOOy5i9nE9NOFZzmDcpYBcBOZovhg3diIscsZkZCZuMwx6Kiz8Drg3Xa8+UT0pI5
         zquQ3l89aUExYw6uMt4DkgKDIBf3J4HlLqxLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692846947; x=1693451747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIvH/R6duOLq1ZSU+7s2c7YByvX3U6kHe3d3coChvNg=;
        b=PG14tJHGvX0SQq8oGxFhUeI18rdp9ONPcFSh5CMCnIm5QmDm/kBSFY19e32n5A693t
         cnsVfEwlqyse8AG85uKfJy72unovu7rlKKC1ZqfhJvCx2qhJJFjiawJDudl6HXdpcNDU
         dIjhvKYCFYGb926zYdWTUO84xDNroyiZQxXRsa1VTXJ98Vlielx+fdBE63KKtQEvtY3m
         9BHH7NBj9LPY4S0OWIlRkFi5X8sSa/y98qLmbUQZr+P3cFsMFgBgIqoFU5aBDIBLNc6o
         /oA7SIT/voaFtBpl9iwrngmmMDhVou561whwZ2k8iOUb9wqhMtUiS1VLzS4iJ6+ByxVW
         LEUQ==
X-Gm-Message-State: AOJu0YzN66vtEs+kJcUXDgXUUdva3H4tXjbIMMlOJI3WFl3JX0vtB40F
        tC4goSjbKRP2R7N2Kq5n20EEhz5Jcn8SckTWyD0=
X-Google-Smtp-Source: AGHT+IGoT4EGATpr/JOD5rkhG52LxJgkZzKzwmjZ5ubTFa6vquSjDRAtG12nLn99Q07WR9DsIbO+WA==
X-Received: by 2002:a05:6870:14cf:b0:1bb:b18e:b864 with SMTP id l15-20020a05687014cf00b001bbb18eb864mr18852517oab.48.1692846946934;
        Wed, 23 Aug 2023 20:15:46 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1ece:b679:4a91:d1e])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a2a8f00b00262ca945cecsm504939pjd.54.2023.08.23.20.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:15:46 -0700 (PDT)
Date:   Thu, 24 Aug 2023 12:15:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Clark <robdclark@chromium.org>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2] dma-debug: don't call __dma_entry_alloc_check_leak()
 under free_entries_lock
Message-ID: <20230824031542.GB610023@google.com>
References: <20230816023235.3798264-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816023235.3798264-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/16 11:32), Sergey Senozhatsky wrote:
> __dma_entry_alloc_check_leak() calls into printk -> serial console
> output (qcom geni) and grabs port->lock under free_entries_lock
> spin lock, which is a reverse locking dependency chain as qcom_geni
> IRQ handler can call into dma-debug code and grab free_entries_lock
> under port->lock.
> 
> Move __dma_entry_alloc_check_leak() call out of free_entries_lock
> scope so that we don't acquire serial console's port->lock under it.

Hello folks,

Have you got a chance to take a look at the patch?
