Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7673F7CEB18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjJRWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:19:52 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A291113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:19:48 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0f945893so1462716d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697667587; x=1698272387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jRC9HVva9g3R+13NnFT9VqaHyccZUivRNg5/IFJX6s=;
        b=HQBMX0H4B2/9k64d3g16id6iszi3Pj0EfQgt9ElDAr55mNzyrZmLPLAgWdornsU9gc
         xGSjBAk9GGQb9bhL+oITDz+6djiHEvfGM35hEAo98i/z9ZloKb7GQHWMaHGLV0cpy84Y
         ZCQYlWX0xAeBw31SfL6OV3jPsVyHI9gxioA//ikj1tlpH38L3loO4+ENmjszM4qq1qfR
         0gFhCup4BH7ifELkbC+IHrLoYWf1dZNqDtDonNKlN7dLJvAtcYOozXPePh1oliAwnhY/
         b+Sr6ahk4ZpL5wKO1W1HrYXbb6BBv4z2zJL/hW3bjEdn5+XKsFcm4DxuWFe3eQzYCQ3S
         YR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667587; x=1698272387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jRC9HVva9g3R+13NnFT9VqaHyccZUivRNg5/IFJX6s=;
        b=Olifj/bBFETdGq1vrSBvEJ4uKU9yQshmxauZYQJ1MdwU+QaP3AiDd9fkV3+RljYmsj
         xJ33GNdUF4dC7TVDdU7LV4AiDeo+JsVY9Y2W6VT1XsyDDMLsA5UGOc6XMM+zTX7jVSdH
         WE4tfODkplMz4vrhw+l++FCzYq/2GQHJ/jCIdsLCKFHcoHyVqoIEbMOjaSuCXKv9nzgq
         uoZneH4bSViytRcPP/PIoNTZ17f0uSAVdaLTInzchzrzg8SkF6b4ljb0Au8CM3OTx+U1
         tvX/eTzSMljEqH9woozPq1iw3uyHMtZ1ONkvahE4ImUi6doQDLXDf8zjoPygdPsrvWXz
         xDDw==
X-Gm-Message-State: AOJu0YyTZLpXuV+JlZwYgm1FC/l5mrY9xZXbGGkkUvbMAkZ2Z//dmLLY
        N/GgxbjeAkkdgri4UqJ9plahTKM5JnRSW6GBG80=
X-Google-Smtp-Source: AGHT+IEEmnCxAAe9vHxUiqgxlAvnjdO1EUng0/cO66uNrmeaXVf9bLQ/iB2o960SVloWr87MMFxH8Q==
X-Received: by 2002:a0c:dd92:0:b0:65b:12bb:56cb with SMTP id v18-20020a0cdd92000000b0065b12bb56cbmr319625qvk.12.1697667587161;
        Wed, 18 Oct 2023 15:19:47 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id da12-20020a05621408cc00b0064c9f754794sm280752qvb.86.2023.10.18.15.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:19:46 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:19:43 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 1/2] riscv: Add remaining module relocations
Message-ID: <ZTBZ/0Wfz/1oBwrl@ghost>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231017-module_relocations-v4-1-937f5ef316f0@rivosinc.com>
 <871qdr938h.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qdr938h.fsf@igel.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:47:58PM +0200, Andreas Schwab wrote:
> On Okt 17 2023, Charlie Jenkins wrote:
> 
> > +static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (*location - ((u8)v & 0x3F)) & 0x3F;
> 
> I think that should use *(u8*) on both sides.

Yep, thank you.

- Charlie

> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
