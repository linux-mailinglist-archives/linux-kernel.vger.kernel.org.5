Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30F79148D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjIDJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjIDJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:15:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951FCC;
        Mon,  4 Sep 2023 02:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EFCEFCE0E26;
        Mon,  4 Sep 2023 09:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4361C433C8;
        Mon,  4 Sep 2023 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693818901;
        bh=Hk4bV/Rgx40tj5feYEnqHLgixfKcAoENzQWXVc75qiQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=G65PM8jXz76Em0qx6rHdiwroexPmMyy1EbX7PqGkkBwKGCucxHBkNEQ9l0Yn047ph
         i0p4obDh6yE6yiOcLhjbapD2SHdDKyuz1pifBe49kdvuIOAPz5e0YNY92nlc0Xxl1/
         RgZtUzvPTQ0zmmHDwDalCNo87u74W1x7E3/bV2W0/GXCIzrY4LLF883/qyujiigrQG
         p+G4dO7wI2OV8Hrcf007a5F8llm+MjbscjqQecY0leIg2IQDL9NQigPaY5vnVydG4n
         8Me9c2ATW2qqV31Iu7CwiIjeXiFUCN7FtjV1zhWuVzRCSuf3nN71CZ3kGHxu2C+s9I
         /S+It6RM9t8OQ==
Date:   Mon, 4 Sep 2023 11:14:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pascal Giard <pascal.giard@etsmtl.ca>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: sony: Fix a potential memory leak in sony_probe()
In-Reply-To: <db06095c912d6bc56bed6b7e4663c7994072a2ce.1693757011.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2309041114500.14207@cbobk.fhfr.pm>
References: <db06095c912d6bc56bed6b7e4663c7994072a2ce.1693757011.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2023, Christophe JAILLET wrote:

> If an error occurs after a successful usb_alloc_urb() call, usb_free_urb()
> should be called.
> 
> Fixes: fb1a79a6b6e1 ("HID: sony: fix freeze when inserting ghlive ps3/wii dongles")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The NULL check is not needed, but I think that it is more informative
> written this way.
> ---
>  drivers/hid/hid-sony.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index dd942061fd77..a02046a78b2d 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2155,6 +2155,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	return ret;
>  
>  err:
> +	if (sc->ghl_urb)
> +		usb_free_urb(sc->ghl_urb);
> +

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

