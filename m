Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994B67EE699
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbjKPSUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345447AbjKPSU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F019D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700158825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5mlpim9jcVUEdoHsiIKTmHBFlyP5301DOd2SWFWL9E=;
        b=elHhcI2m4drah3wQpcjaAT+ql/SMcpSZbA1elFkewGklsw5Pdg8bovK1iOa8M6wVySgMTl
        PHKouoK5OdKfuf6N6M8E/DUxnrAHMbttkGhNDtrTaH8qTYomskxzKxoJYyqTOVsWK6bElf
        uYYyamQNKuetr307LKSEttW8C+q7oyE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-_aEeqnH0NH6MiDAlnm771w-1; Thu, 16 Nov 2023 13:20:24 -0500
X-MC-Unique: _aEeqnH0NH6MiDAlnm771w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso82274266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158822; x=1700763622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5mlpim9jcVUEdoHsiIKTmHBFlyP5301DOd2SWFWL9E=;
        b=SMfLZbJzGAnVTrm43loEM9Hw+x4Bi2Ap4dT2g+0/+7ACRvozspfSbXz/w2Ue/9cLp8
         WJnPEaHsJxk4zsTWQQdMn5tF8W3Lh0v7+YyBPY6ORYz8Rk4VFuwG6w/sM7QBGZKTfiJp
         0WMU+yqFB0L5uc+XGwmUvnOZvsE8DP0PO8Nb8CGndBen3OT2804MYsvYc4ZcXxXOd+c4
         rAZhAUJ0RwZg7EZpSzSYI1MZcZHzqSET0adqVYRRhykDdGB6aclszD/NwHFcIlmj8ikb
         z07q0AF19U7fESV2IKvDhdct7IqFoU7TLKgWaDTQV9Wvcr87MysG6rVFrDDY9ha27wjT
         Qwfg==
X-Gm-Message-State: AOJu0YzfrJV4DN+O9bzAXf8dqxPa5acYMT337amZNzh5mgp4DOBB+f3d
        3A7UG+JCLu1Gw1StB0+ZFsGCUvPlVOf9SF8/RIy5PIsG656SNyottIW6dHy7m+mWENPGtawPuob
        R/bqScUC8Au4fjhWIfxHmEhNcWimQjStx
X-Received: by 2002:a17:906:6815:b0:9d3:8d1e:ced with SMTP id k21-20020a170906681500b009d38d1e0cedmr12564232ejr.34.1700158822624;
        Thu, 16 Nov 2023 10:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqCJ6XD/Ix9osIh3OQgLECR/SM1Us/HvHhbnyPH71N30XXq9jdoU+52d28rjEZjRtcxiXtog==
X-Received: by 2002:a17:906:6815:b0:9d3:8d1e:ced with SMTP id k21-20020a170906681500b009d38d1e0cedmr12564219ejr.34.1700158822301;
        Thu, 16 Nov 2023 10:20:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709061cd700b009d23e00a90esm8703452ejh.24.2023.11.16.10.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 10:20:21 -0800 (PST)
Message-ID: <87f753c8-924c-411b-93fe-b21525e76ae2@redhat.com>
Date:   Thu, 16 Nov 2023 19:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: xpad - add Lenovo Legion Go controllers
To:     Brenton Simpson <appsforartists@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Erica Taylor <rickytaylor26@gmail.com>,
        Vicki Pfau <vi@endrift.com>, nate@yocom.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>
References: <CAAL3-=88exVfuL1Y-kvPNbsU+d-UTfDLFViWVObFLtbC4xueeA@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAL3-=88exVfuL1Y-kvPNbsU+d-UTfDLFViWVObFLtbC4xueeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brenton,

On 11/16/23 18:45, Brenton Simpson wrote:
> When the controllers are both attached (or detached), they appear as
> 0x17ef, 0x6182.  When only one is attached, they appear as
> 0x17ef, 0x6184.
> 
> 84 (mixed attachment) is already recognized as a gamepad by Linux.  This
> patch adds 82 (both attached/detached).
> 
> These controllers have many more buttons than is typical.  With this
> patch, here's what's functional when it presents as 82:
> 
> Recognized:
> 
> - X, Y, A, B
> - both analog sticks, including L3/R3
> - D-pad
> - menu and capture buttons
> - rumble
> 
> Not yet recognized:
> 
> - start, select
> - 4 rear paddle buttons (Y1, Y2, Y3, M3)
> - gyroscope
> 
> (There are also non-functional buttons when reporting as 84 that are
> out-of-scope for this patch.)
> 
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index f5c21565bb3cec..ecfcea8740a009 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -127,6 +127,7 @@ static const struct xpad_device {
>   u8 mapping;
>   u8 xtype;
>  } xpad_device[] = {

It looks like your workflow of copy-pasting this into your
email client has turned the tabs in the patch into a single space
character.

This and possibly other issues (line-wrapping, wrong end-of-line type)
is why using git send-email is the preferred way to submit kernel
patches.

Maybe try using Brenton Simpson <appsforartists+kernel@google.com>

for both the author and signed-off-by fields and then use
git send-email ?

Regards,

Hans

p.s.

Might be best to send the next attempt just to me, until you've
figured out a working email setup. And then once we have things
working, re-submit to the right people ?





> + { 0x17ef, 0x6182, "Lenovo Legion Go Controller (unified)", 0, XTYPE_XBOX360 },
>   { 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
>   { 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
>   { 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
> @@ -459,6 +460,7 @@ static const signed short xpad_btn_paddles[] = {
> 
>  static const struct usb_device_id xpad_table[] = {
>   { USB_INTERFACE_INFO('X', 'B', 0) }, /* Xbox USB-IF not-approved class */
> + XPAD_XBOX360_VENDOR(0x17ef), /* Lenovo */
>   XPAD_XBOX360_VENDOR(0x0079), /* GPD Win 2 controller */
>   XPAD_XBOX360_VENDOR(0x03eb), /* Wooting Keyboards (Legacy) */
>   XPAD_XBOXONE_VENDOR(0x03f0), /* HP HyperX Xbox One controllers */
> 

