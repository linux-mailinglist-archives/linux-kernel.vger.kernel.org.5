Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF0774250
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjHHRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjHHRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:41:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EB4358B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:18:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B75AD21B1D;
        Tue,  8 Aug 2023 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691485767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWySdREPI5hHmHNzsFw3MuXRmrs7v8ANmnLx+oatmfQ=;
        b=zc83YCep0zi5/UZgrI7JZrCkXhjnJplzmjgMZUbbyF+0iK4Q81RRyCUIlvy3RjuHN4YxZE
        Lb8+CQWqbAJ3T3rEIlpl1DiICzG6tR3GG3fTwMXyns50bsSaw6PQ63OPjhejxGDMUeR810
        5Oeaur7O5BAYisP3FEwgcypj0CHPDys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691485767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWySdREPI5hHmHNzsFw3MuXRmrs7v8ANmnLx+oatmfQ=;
        b=JJCqGQ2R7fLgP93TPNpnGAFSXzkFPOeTsvsapWVKcpSCzjdvTQUl/S4joX2lvsQuCOEsrC
        V3bEF8kghZe5MtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9AA313451;
        Tue,  8 Aug 2023 09:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKhmKUcG0mQvEAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:09:27 +0000
Date:   Tue, 8 Aug 2023 11:09:27 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH libnvme v2 2/2] fabrics: Do not pass disable_sqflow if
 not supported
Message-ID: <u7asjmkjqxs6edpj2eg6zw6tuo6zypoyzpjcjyj722f2ol6r4h@6m6npperooul>
References: <20230808070907.18834-1-dwagner@suse.de>
 <20230808070907.18834-3-dwagner@suse.de>
 <e33c1a36-2b8e-8331-5f36-54dc47ab02d1@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33c1a36-2b8e-8331-5f36-54dc47ab02d1@grimberg.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:47:14AM +0300, Sagi Grimberg wrote:
> I think you want to check this before the initial call
> and avoid the retry altogether.
> --
> -       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
> +       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
> +           nvmf_check_option(h->r, disable_sqflow))
>                 c->cfg.disable_sqflow = true;
> +       else
> +               c->cfg.disable_sqflow = false;
> 
>         if (e->trtype == NVMF_TRTYPE_TCP &&
>             (e->treq & NVMF_TREQ_REQUIRED ||

Yep, makes sense.
