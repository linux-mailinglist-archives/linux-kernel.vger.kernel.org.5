Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8787375F2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGXKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjGXKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC98A77;
        Mon, 24 Jul 2023 03:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DC361011;
        Mon, 24 Jul 2023 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781BAC433C7;
        Mon, 24 Jul 2023 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690193420;
        bh=uQf0vsvXqpgD7ViP2MvHFjhsm5mo88JZ7Z2CCyqeD5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wl7kNIj3dmBhS33zvEqNR+NBkrHGP3iK+ZR7VeoejeJrBhhnn30BsEhfjWF572xO0
         dklZLDWPq1QQGBsEadb+v2npEEwMvI5h5rG51kl6TAYQRYJhjh3kTkSXd3unbvIPwV
         UGo9sZgG7YOhaENZvZDt+CxT2+JzXgi1A02DC2EIYuKwJZ3EzI4arD9Tkuvqb/VggB
         wT1B0ekpvlb8pbu+D7dxOcvnzLsq1AUw5haSh+EXIxItInzJ3ttwW7GlNBUgJGm7gj
         oLKDPAR+ds0iK6+II2k37W9HesqowY8KL4suv1+egf16QON7tGTnwhXl9BwkqonbBM
         uhCmS5YcLyqPQ==
Date:   Mon, 24 Jul 2023 12:10:15 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     "sandeep.cs" <sandeep.cs@samsung.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        junwan.cho@samsung.com, jitender.s21@samsung.com,
        suhyun_.kim@samsung.com, ih0923.kim@samsung.com,
        gaudium.lee@samsung.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [HID Patchsets v1 2/2] HID: Removed USB Validation check
Message-ID: <np2hnhy7jcc66rsfwym42qwteqda6slszinrjqb6jg7ie4qt3e@2fllxsza544p>
References: <20230724084752.371245-1-sandeep.cs@samsung.com>
 <CGME20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5@epcas5p1.samsung.com>
 <20230724084752.371245-3-sandeep.cs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724084752.371245-3-sandeep.cs@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Jul 24 2023, sandeep.cs wrote:
> Earlier Samsung driver only handles USB HID devices and returns an error if it encounters a Bluetooth type of HID device.
> By removing this USB validation check, we allow the driver to handle other types of HID devices including Bluetooth HID devices, which were previously excluded.

Please no, not with that patch at least.

hid_is_usb() protects the kernel from making an oops if the actual
transport layer is not USB, let's say an emulated uhid device. So by
removing that check you are just allowing anybody with root access to
access random memory in the kernel.

The correct fix is to move the check where it's needed, in
samsung_kbd_mouse_input_mapping().
I'll let you decide what need should be done if it's not a USB device
there: consider the interface to be 0 or just abort the function.

Cheers,
Benjamin

> 
> This change improves driver compatibility and extends its support for a wide range of devices.
> 
> Signed-off-by: Sandeep C S<sandeep.cs@samsung.com>
> Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
> Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
> ---
>  drivers/hid/hid-samsung.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
> index 33e963303d11..3cafbf4d9dc6 100644
> --- a/drivers/hid/hid-samsung.c
> +++ b/drivers/hid/hid-samsung.c
> @@ -517,9 +517,6 @@ static int samsung_probe(struct hid_device *hdev,
>  	int ret;
>  	unsigned int cmask = HID_CONNECT_DEFAULT;
>  
> -	if (!hid_is_usb(hdev))
> -		return -EINVAL;
> -
>  	ret = hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "parse failed\n");
> -- 
> 2.25.1
> 
