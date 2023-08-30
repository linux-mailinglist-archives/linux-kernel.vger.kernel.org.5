Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B8C78DECF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjH3T4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjH3T4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:56:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14158184D2;
        Wed, 30 Aug 2023 12:27:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7b9c04591fso1338417276.3;
        Wed, 30 Aug 2023 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693423565; x=1694028365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLfOyoUhymqRkqsZQ2G33Z7ZoxS2GkSWEMljoo/TS8U=;
        b=TkZRTATlGPOhwhOBWayYbaeXEz3oYULSsd5/atITamqjalotxdPvzxZRut2NX3ddLv
         eOXHxouN0lDWpZnITsuj86wYr6S/UmfdK4sb+ATZAEmoLKE3GPpDkTizDnGLCGbfyHXO
         ej2bsmflKEjL2bIuR4Zoaz3i+VSv2fylQUUaZGkIM1ARZ9i0xiybGHv4BEmHi9XDiUFa
         VLuRnrBjo7yCl/3w2l3V9OVOlugT+x3piDM3IsrkhjdXe4lzcCfKB0O+4HOQTuYxtXMX
         /sDuCPVRv8XzvaCCzIj+VBEtkIX4yftT+pcfjynMay989t7bPGja1H2rIAD+RFs0HMKO
         Nt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423565; x=1694028365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLfOyoUhymqRkqsZQ2G33Z7ZoxS2GkSWEMljoo/TS8U=;
        b=eXoHu1LVZrRCzEgVIGwH3TYBmzRPpkx19TaaWJfSm1271ul7P5aKUynpG7Foshg9ut
         5zKrIBFdN8f9UAeAs88H4JoH7BPxJ0AmNMzrAmtawZqQv0tUkaiwJAtPeZRtrPubbHIA
         KhDWyuiBeX7Y2pYOVz5qHp6jNcxZS/QYOrHAKpMv2pRVmxmYE2FEU8YA2JAA0RsTQMuz
         mhO51byvMQJcVLogt5q+wXhUc+6k83imY/OywKwVdsIhpqpezK/6NbLbpsLdKWH01d1m
         lt7LxSxs6yRDpKE6j5uooCITkIWM05jKFpx+WgfxMUH01LeHKEBHQW1v+8QwfgQMMep9
         NTyg==
X-Gm-Message-State: AOJu0YxOw60Kg6f+G/RN5qOQrt4dMcB5dxO2YR3bJscX6pjokvQF4CaU
        EFTxCHqhVRAInqEKtxWofWYZisFRD4+XoaaxaPg=
X-Google-Smtp-Source: AGHT+IHy64LbDf6C9FY/NVgDn1o33d4gtmP4AvBoTV3WP1sl/FKEnMnGnQfnjo6gHHZUmNPxH4UcMy3rf1e0kLLlCnA=
X-Received: by 2002:a25:e04a:0:b0:d7b:9c58:8f12 with SMTP id
 x71-20020a25e04a000000b00d7b9c588f12mr3285360ybg.34.1693423565597; Wed, 30
 Aug 2023 12:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com> <2023083035-unpadded-amulet-8c7e@gregkh>
In-Reply-To: <2023083035-unpadded-amulet-8c7e@gregkh>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 30 Aug 2023 15:25:54 -0400
Message-ID: <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 1:57=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit if
> > a source string is not NUL-terminated [1].
>
> But that's not the case here, right?  So your "potential read overflow"
> isn't relevant here.
>
> > The copy_to_user() call uses @len returned from strlcpy() directly
> > without checking its value. This could potentially lead to read
> > overflow.
>
> But can it?  How?
>

The case I was considering is when the null-terminated hardcoded
string @func_table[kb_func] has length @new_len > @len. In this case,
strlcpy() will assign @len =3D @new_len and copy_to_user() would read
@new_len from the kmalloc-ed memory of @len. This is the potential
read overflow I was referring to. Let me know if I'm mistaken.
