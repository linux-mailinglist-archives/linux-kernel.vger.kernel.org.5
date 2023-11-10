Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B07E8642
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjKJXKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjKJXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:10:15 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB6D64
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:10:12 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce322b62aeso1289925a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699657812; x=1700262612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UN5WfZbH4HRFj65BWwdm3V3ZrQp6mFTsH/WbTV4zQM=;
        b=IQGAkSfQnNPPh0n0PBMcwW1BccCBfmFnG+/2kdHE+9V1Krltl6ARBzlRGwRORbU4wT
         V50ebfjJ24+QiDUA6aJHPP745FxMbNKrD1XTfNQdENNJNyFcy84VCakU8OAkT1HjloqP
         305+qIz91Yp8gcbXUEa6WWMADYZP2n7gj7gbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699657812; x=1700262612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UN5WfZbH4HRFj65BWwdm3V3ZrQp6mFTsH/WbTV4zQM=;
        b=rwf1IJXpc+v1AsM5uguSORxtHXLlOnQFEUG1LjY5nJRIMIpJF5n1z2DWJW//JH/PC/
         HqyzgU6T06xRacTY/SqDy9hXgwejC6o2c86iNGPDgHRakyS7RjZLi1Q52EM+3nvbOaTP
         T0t7UKRF0X25A52FvkyHJSKRRqetSAKXbphPyjRU4TdMjneHq9pATHHNmcrVHIOZuw8t
         +t9yJxjng3loaN+slCaaU6vI7v6Ambf9MqJj0gmJZzm1w+pN1A2GlQrCbR+6TvU0XsxD
         EE+4NxeanVUxUbNy4yjRBFS6WKN4wz+D59WYWhOkgKNIlv8tTjbrHmtsgD5+xgxigivv
         B7zA==
X-Gm-Message-State: AOJu0Yy4hb4go7RWHM7dH6+2OMv+EUSAMfV/UbZ7/8Ifiejfz01YyFBK
        lbTw/bBYj+G31AAPylA4L6Hyd0sedr9W6gj/9AfMXA==
X-Google-Smtp-Source: AGHT+IEbhgCtAskIwRk7JxB3AKFfhNJT1eDR9JswGI5DNZN3BWmbwrSfyyQv4P+OXmj2JsxRgXI4li1v7rVpwnjByKc=
X-Received: by 2002:a9d:7509:0:b0:6b7:6e07:4951 with SMTP id
 r9-20020a9d7509000000b006b76e074951mr501906otk.25.1699657811950; Fri, 10 Nov
 2023 15:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20231023171444.322311-1-dregan@broadcom.com> <15d09a16-249b-55a9-55ab-8bfa66c7e4de@broadcom.com>
In-Reply-To: <15d09a16-249b-55a9-55ab-8bfa66c7e4de@broadcom.com>
From:   David Regan <dregan@broadcom.com>
Date:   Fri, 10 Nov 2023 15:10:01 -0800
Message-ID: <CAA_RMS4HJ--eAwUoktMZS_rVS7+RhMhaYVPLGZmsXvcX6D2Ltw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mtd: rawnand: Add destructive operation
To:     William Zhang <william.zhang@broadcom.com>
Cc:     David Regan <dregan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, Joel Peshkin <joel.peshkin@broadcom.com>,
        computersforpeace@gmail.com,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org,
        kdasu.kdev@gmail.com, JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

Can you please have a look at this update?
This patch has not received any change requests after two weeks but
let me know if you see anything that should be fixed.

Thanks!

-Dave

On Wed, Oct 25, 2023 at 5:25=E2=80=AFPM William Zhang
<william.zhang@broadcom.com> wrote:
>
>
>
> On 10/23/2023 10:14 AM, dregan@broadcom.com wrote:
> > From: Boris Brezillon <bbrezillon@kernel.org>
> >
> > Erase and program operations need the write protect (wp) pin to be
> > de-asserted to take effect. Add the concept of destructive
> > operation and pass the information to exec_op() so controllers know
> > when they should de-assert this pin without having to decode
> > the command opcode.
> >
> > Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> > Signed-off-by: David Regan <dregan@broadcom.com>
> > ---
> > Changes in v4: none
> >
> > Changes in v3: updated comments and email address
> >
> > Changes in v2: gave credit to Boris Brezillon
> > ---
> >   drivers/mtd/nand/raw/nand_base.c | 6 ++++--
> >   include/linux/mtd/rawnand.h      | 9 +++++++++
> >   2 files changed, 13 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
