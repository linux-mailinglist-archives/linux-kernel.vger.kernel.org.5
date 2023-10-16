Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C837CAA69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjJPNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjJPNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:49:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A1111
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:49:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso7918775a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697464145; x=1698068945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZurGwQcOXzRVXvE5dz9IMiQTTPfNEfxXKroPgnMl1w=;
        b=FVU7J7Wmy0vyGXPq3fGgMS8f18U0vfjdePks2ETAiqdDLgJEllHdMtATgxPw2EvzZ/
         IXvYg1tFSl2BVVZO25vSPCjlr2uYFARQgAbuGlS5vUKKtJe+cIjWxtqCZ8qFcTN2TjNu
         oHIzuztzro/RqMDo0U4me8PUoYDQvQW1wH0T/P/+K0kllITzr63hD5cewE0Eiqbdne87
         sLISDMr97gbf1H+dzFzMto5IWxbIFF9fv9dZ6V4f+K4VDxsHxNYfbrS+v6WENzVi8wxU
         FjtVrJBXys2o6d21nFyz1nfG4s1MCtQ7TBNVuOfuGH0iKHK2iImVmjLK6VsDkdKBORWA
         xmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464145; x=1698068945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZurGwQcOXzRVXvE5dz9IMiQTTPfNEfxXKroPgnMl1w=;
        b=tOyZXs3nTSIPn1SOrAtx6xywDo8aPLo1rtUUFNwWEyAs5onJDuaUwZRQBc67cviFlZ
         WQ4TUpIKrFWdqXjhaug2mbWDWq2HCvxtvkKxi/Bg3uAFhtVUmj5kKoUYX8zNHlJsS7CJ
         df3o4YIFutYEvJOVUvhT0J8Goi05GMPmx5ZprQI+BaZTdZPczwBfIgKHl2kSX83kdPVS
         nn+L8vr9Tm1lyNuAl+7TnNj9q7cBiAF602ol5LalaERaOBzljELITw0KNJxwSmClPBI7
         xESY0EFFvo4m6QZNCU7as6Dpo/ftz8bPu355Wz2+cnqufOe8QBSGmq/s2G/HJFxpdxTn
         t5Vw==
X-Gm-Message-State: AOJu0YzHof8gCvSlWpToP6su0GbbXz92YjorqChbGS+0pXuPXRUP3r8W
        rYq+fag0S6ETNxq+1NsDgk8ZryE5wcCivv49Y+oUVw==
X-Google-Smtp-Source: AGHT+IF9w1BuCl+MstCN2E8ouDf6BsRaZawm2U1rDw7nX+XUD/ZC6U/q27Kcxqc4jdD3OtuLVhoPZPlzlifUF4zzKws=
X-Received: by 2002:a05:6402:4308:b0:53d:983c:2672 with SMTP id
 m8-20020a056402430800b0053d983c2672mr18176063edc.38.1697464145413; Mon, 16
 Oct 2023 06:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231003131343.1324962-1-loic.poulain@linaro.org> <53348f45-f5c5-e5ba-b0a8-d004655a6053@linaro.org>
In-Reply-To: <53348f45-f5c5-e5ba-b0a8-d004655a6053@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 16 Oct 2023 15:48:28 +0200
Message-ID: <CAMZdPi8UJmxULXOsvTCJNDcvYHxBsVhK9H5_eGOhMg6TkXoQfw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: Fix possible buffer overflow on nvmem cell write
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On Sat, 7 Oct 2023 at 12:22, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks Loic for the patch,
>
> On 03/10/2023 14:13, Loic Poulain wrote:
> > Nothing prevents a nvmem consumer to try writing excessive data to a
> > given nvmem cell (except when bit_offset is 0). The allocated buffer
> > of size 'cell->bytes' in nvmem_cell_prepare_write_buffer may not be
> > large enough to host the copied 'len' bytes.
> >
> Did you hit this path?
>
>   __nvmem_cell_entry_write already has a check for (cell->bit_offset ==
> 0 && len != cell->bytes))
>
> What is the bit_offset in your case?
>
> Can you provide more details?

I hit the issue while playing with nvmem-reboot-mode driver,
allocating 2-bit of a persistent register at bit-offset 2 for the
reboot mode. nvmem-reboot-mode drivers call nvmem_cell_write() with a
32-bit len value, so we end in nvmem_cell_prepare_write_buffer
allocating a 1-byte (cell->bytes) buffer and copying a 4-byte len
value into it. You can find below the dts example.

```
{
     &snvs_lpgpr{
         #address-cells = <1>;
         #size-cells = <1>;

        something@0 {
             /* reg[2:0] */
             reg = <0x0 0x4>;
             bits = <2 2>;
        };

        reboot_mode: reboot-mode@0 {
            /* reg[4:2] */
            reg = <0x0 0x4>;
            bits = <2 2>;
        };
    };

    reboot-mode {
        compatible = "nvmem-reboot-mode";
        nvmem-cells = <&reboot_mode>;
        nvmem-cell-names = "reboot-mode";
        mode-normal = <0>;
        mode-fastboot = <1>;
        mode-recovery = <2>;
    };
};
```
