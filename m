Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92E80B62A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjLIUIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:08:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A811F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:08:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso2481084a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702152529; x=1702757329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kq9bjArdQXR4dce7uM6lkYuv3BP1L9VNM0n4N4whoow=;
        b=ZINq9vbXhMjPfeNNl9z+9dWu8JjtjY27oC7Alxiu7Qr9AdxlYdshMUo5YU9iMM9DeU
         Ijtthm0Y/ivswyL3Vx0eel4I1r90z+OOj3hbJHlmZfoAwPKVdtuGXeh4i33GUz2026r0
         y8UKnPphxw59o+hIMFEuXU8pTUG0GCkRwC9c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702152529; x=1702757329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq9bjArdQXR4dce7uM6lkYuv3BP1L9VNM0n4N4whoow=;
        b=B69aDGwrnlL6uCbAO3lBOJdc2SN8pGRwgPjNBrCZmJNZBDySv65j6QB8dOzPOPfjf+
         EZpbY2TKjNookZC9+1Jt353VD4ZjHoATWpJh69VSudpDrWqjA0aJ1QAqZuZjRrsqy9vp
         YrlHPyF7eScheDKYUwLc+0X5rtCg85SqaQ4dFloYcl9orPPEdkIdxjLhRLVTduoSNCRf
         irtNUxkKeux+Lr/6JCqMbaOXsxlfPjdsxnMsLftVZqmuA5hD+8fbybmv8HZ8Cr9/2eBs
         S2PSkSPcejM5YJhibeK63IWXgOzltIPwz4uTagf+OUT5wshWEKMy3nmZh6qIpFp4D7iT
         GZag==
X-Gm-Message-State: AOJu0YwjWftb7be9wTiC5vkWYdWu76wpAEUgXUu1I5KwaGUNfVzSDbso
        6rEOy0u/8Ko/XP1WXA7isSgqgEK71HKb7/UTqqzHGw==
X-Google-Smtp-Source: AGHT+IFxkU8JBnVT+PvBsC847PWahsG/TfVcL5s8j+G6SYW3Fw+o60uH7my7vY6g+ZAm7JU2ewOPyw==
X-Received: by 2002:a50:c2c2:0:b0:54b:2b83:9df5 with SMTP id u2-20020a50c2c2000000b0054b2b839df5mr1267872edf.28.1702152529178;
        Sat, 09 Dec 2023 12:08:49 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id cx14-20020a05640222ae00b0054cb07a17ebsm1924931edb.31.2023.12.09.12.08.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 12:08:47 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso388984166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 12:08:47 -0800 (PST)
X-Received: by 2002:a17:906:7489:b0:a1f:81df:e5f7 with SMTP id
 e9-20020a170906748900b00a1f81dfe5f7mr597708ejl.16.1702152527461; Sat, 09 Dec
 2023 12:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20231206004654.2986026-1-mhal@rbox.co> <CAMzpN2jcEGBcEKbNjwMJ+VCMc-_N1GcpVkGgAhy=XzomJP-Ogw@mail.gmail.com>
In-Reply-To: <CAMzpN2jcEGBcEKbNjwMJ+VCMc-_N1GcpVkGgAhy=XzomJP-Ogw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 9 Dec 2023 12:08:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB2FSWb0HxgzHGJKaDRCaJ6tGSc0OVvodAiZ_QU=05NQ@mail.gmail.com>
Message-ID: <CAHk-=wiB2FSWb0HxgzHGJKaDRCaJ6tGSc0OVvodAiZ_QU=05NQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: UMIP emulation leaking kernel addresses
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Michal Luczaj <mhal@rbox.co>, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        shuah@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2023 at 09:16, Brian Gerst <brgerst@gmail.com> wrote:
>
> A different way to plug this is to harden ptrace (and sigreturn) to
> verify that the segments are code or data type segments instead of
> relying on an IRET fault.

I think that is likely a good idea regardless of this particular issue.

And I don't think you need to even check the segment for any kind of
validity - all you need to check that it's a valid selector.

And we *kind* of do that already, with the x86 ptrace code checking

  static inline bool invalid_selector(u16 value)
  {
        return unlikely(value != 0 && (value & SEGMENT_RPL_MASK) != USER_RPL);
  }

but the thing is, I think we could limit that a lot more.

I think the only valid GDT entries are 0-15 (that includes the default
kernel segments, but they don't contain anything interesting), so we
could tighten that selector check to say that it has to be either a
LDT entry or a selector < 15.

So add some kind of requirement for "(value & 4) || (value < 8*16)", perhaps?

              Linus
