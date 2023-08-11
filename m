Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9D778A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHKJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjHKJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD72E30D2;
        Fri, 11 Aug 2023 02:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4280166D49;
        Fri, 11 Aug 2023 09:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67194C433CD;
        Fri, 11 Aug 2023 09:58:15 +0000 (UTC)
Message-ID: <87b8b82a-f9ff-f539-be46-a2ba8714395b@xs4all.nl>
Date:   Fri, 11 Aug 2023 11:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: usb: go7007: Fix warning: passing freed memory
 'fw'
Content-Language: en-US, nl
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
References: <20230809010026.GA4770@madhu-kernel>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230809010026.GA4770@madhu-kernel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 03:00, Madhumitha Prabakaran wrote:
> Fix smatch warning - go7007_loader_probe() warn: passing freed memory 'fw'
> 
> The 'fw' pointer is released using release_firmware(fw) and then being used
> again in another request_firmware() call without being reassigned to a new
> memory allocation. To resolve it, use separate variables for each request.

Hmm, I don't get this smatch warning. And it doesn't appear to be an actual
bug either, so that warning would be a false positive.

I wonder if you tested with an older smatch version?

Regards,

	Hans

> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/media/usb/go7007/go7007-loader.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/usb/go7007/go7007-loader.c b/drivers/media/usb/go7007/go7007-loader.c
> index 243aa0ad074c..5f5c425f4d45 100644
> --- a/drivers/media/usb/go7007/go7007-loader.c
> +++ b/drivers/media/usb/go7007/go7007-loader.c
> @@ -35,7 +35,7 @@ static int go7007_loader_probe(struct usb_interface *interface,
>  				const struct usb_device_id *id)
>  {
>  	struct usb_device *usbdev;
> -	const struct firmware *fw;
> +	const struct firmware *fw_1, *fw_2;
>  	u16 vendor, product;
>  	const char *fw1, *fw2;
>  	int ret;
> @@ -67,13 +67,13 @@ static int go7007_loader_probe(struct usb_interface *interface,
>  
>  	dev_info(&interface->dev, "loading firmware %s\n", fw1);
>  
> -	if (request_firmware(&fw, fw1, &usbdev->dev)) {
> +	if (request_firmware(&fw_1, fw1, &usbdev->dev)) {
>  		dev_err(&interface->dev,
>  			"unable to load firmware from file \"%s\"\n", fw1);
>  		goto failed2;
>  	}
> -	ret = cypress_load_firmware(usbdev, fw, CYPRESS_FX2);
> -	release_firmware(fw);
> +	ret = cypress_load_firmware(usbdev, fw_1, CYPRESS_FX2);
> +	release_firmware(fw_1);
>  	if (0 != ret) {
>  		dev_err(&interface->dev, "loader download failed\n");
>  		goto failed2;
> @@ -82,13 +82,13 @@ static int go7007_loader_probe(struct usb_interface *interface,
>  	if (fw2 == NULL)
>  		return 0;
>  
> -	if (request_firmware(&fw, fw2, &usbdev->dev)) {
> +	if (request_firmware(&fw_2, fw2, &usbdev->dev)) {
>  		dev_err(&interface->dev,
>  			"unable to load firmware from file \"%s\"\n", fw2);
>  		goto failed2;
>  	}
> -	ret = cypress_load_firmware(usbdev, fw, CYPRESS_FX2);
> -	release_firmware(fw);
> +	ret = cypress_load_firmware(usbdev, fw_2, CYPRESS_FX2);
> +	release_firmware(fw_2);
>  	if (0 != ret) {
>  		dev_err(&interface->dev, "firmware download failed\n");
>  		goto failed2;

